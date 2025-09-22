<?php
namespace app\admin\controller;

use app\common\controller\Backend;
use think\Db;

/**
 * 代理管理
 * 
 * @icon fa fa-users
 * @remark 代理管理，包括代理信息维护及鱼苗数量统计
 */
class Daili extends Backend 
{
    // 无需登录的方法
    protected $noNeedLogin = ['getTGName'];

    // 无需鉴权的方法
    protected $noNeedRight = ['getTGName'];

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
            // 检查数据表是否存在
            $tables = Db::query("SHOW TABLES LIKE 'daili'");
            if (empty($tables)) {
                $this->createTable();
            }

            // 更新每个代理的鱼苗数量
            $this->updateFishNumbers();

            if ($this->request->isAjax()) {
                $dailiData = Db::name('daili')
                    ->order('id', 'desc')
                    ->select();
                
                return json([
                    "total" => count($dailiData),
                    "rows" => $dailiData
                ]);
            }

            // 获取代理列表
            $dailiData = Db::name('daili')
                ->order('id', 'desc')
                ->select();

            // 统计数据
            $totalDaili = count($dailiData);
            $totalFish = array_sum(array_column($dailiData, 'fishnumber'));
            $todayStart = date('Y-m-d 00:00:00');
            $todayNew = Db::name('daili')
                ->where('time', '>=', $todayStart)
                ->count() ?: 0;

            $this->assign([
                'totalDaili' => $totalDaili,
                'totalFish' => $totalFish,
                'todayNew' => $todayNew,
                'dailiData' => $dailiData,
                'title' => '代理管理'
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
        if ($this->request->isPost()) {
            $params = $this->request->post();
            
            Db::startTrans();
            try {
                $data = [
                    'tguid' => $params['tguid'],
                    'username' => $params['username'] ?: '该用户未设置用户名',
                    'fullName' => $params['fullName'],
                    'time' => $params['time'] ?: date('Y-m-d H:i:s'),
                    'remark' => isset($params['remark']) ? $params['remark'] : '',
                    'fishnumber' => 0
                ];

                Db::name('daili')->insert($data);
                Db::commit();
                return json(['code' => 1, 'msg' => '添加成功']);
            } catch (\Exception $e) {
                Db::rollback();
                return json(['code' => 0, 'msg' => '添加失败：' . $e->getMessage()]);
            }
        }
        return json(['code' => 0, 'msg' => '非法请求']);
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
            Db::name('daili')->where('id', 'in', $ids)->delete();
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
                throw new \Exception('参数不完整');
            }

            $allowFields = ['tguid', 'username', 'fullName', 'time', 'remark'];

            if (!in_array($params['field'], $allowFields)) {
                throw new \Exception('不允许更新该字段');
            }

            Db::name('daili')
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
     * 获取TG用户名
     */
    public function getTGName()
    {
        header('Access-Control-Allow-Origin: *');
        header('Access-Control-Allow-Methods: GET');
        header('Access-Control-Allow-Headers: X-Requested-With,Content-Type');
        header('Content-Type: application/json; charset=UTF-8');

        if (!$this->request->isGet()) {
            return json(['code' => 0, 'msg' => '非法请求方式']);
        }

        $uid = $this->request->param('uid');
        if (empty($uid)) {
            return json(['code' => 0, 'msg' => '参数错误']);
        }

        try {
            $daili = Db::name('daili')
                ->where('tguid', $uid)
                ->field('username')
                ->find();

            return json([
                'code' => 1,
                'data' => $daili ? $daili['username'] : '该用户未设置用户名'
            ]);
        } catch (\Exception $e) {
            return json([
                'code' => 0, 
                'msg' => '查询失败',
                'error' => $e->getMessage()
            ]);
        }
    }

    /**
     * 创建数据表
     */
    protected function createTable()
    {
        $sql = "CREATE TABLE IF NOT EXISTS `daili` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `tguid` varchar(50) NOT NULL COMMENT '电报ID',
            `username` varchar(100) DEFAULT '该用户未设置用户名' COMMENT '电报用户名',
            `fullName` varchar(100) DEFAULT NULL COMMENT '电报昵称',
            `fishnumber` int(11) DEFAULT '0' COMMENT '鱼苗数量',
            `time` varchar(255) DEFAULT NULL COMMENT '代理加入时间',
            `remark` varchar(255) DEFAULT NULL COMMENT '代理备注',
            PRIMARY KEY (`id`),
            UNIQUE KEY `uk_tguid` (`tguid`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;";

        Db::execute($sql);
    }

    /**
     * 更新鱼苗数量
     */
    protected function updateFishNumbers()
    {
        $dailiList = Db::name('daili')->select();
        
        foreach ($dailiList as $daili) {
            $fishCount = Db::name('fish')
                ->where('tguid', $daili['tguid'])
                ->count();
            
            Db::name('daili')
                ->where('id', $daili['id'])
                ->update(['fishnumber' => $fishCount]);
        }
    }
}