-- MySQL dump 10.13  Distrib 5.7.43, for Linux (x86_64)
--
-- Host: localhost    Database: ka_jd_shop
-- ------------------------------------------------------
-- Server version	5.7.43-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '用户名',
  `nickname` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '昵称',
  `password` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '密码',
  `salt` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '密码盐',
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '头像',
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '电子邮箱',
  `mobile` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '手机号码',
  `loginfailure` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '失败次数',
  `logintime` bigint(16) DEFAULT NULL COMMENT '登录时间',
  `loginip` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '登录IP',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) DEFAULT NULL COMMENT '更新时间',
  `token` varchar(59) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'Session标识',
  `status` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'normal' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT COMMENT='管理员表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1,'admin','安小熙源码网','009ee2054a48d30f4995a9eb5581b081','8e8156','https://static.tronscan.org/production/logo/usdtlogo.png','888@tg.com','18888888888',0,1733148953,'45.139.226.157',1888888888,1733148953,'ff810b0c-2ed2-44d7-af92-5b311ff79fca','normal');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_log`
--

DROP TABLE IF EXISTS `admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '管理员ID',
  `username` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '管理员名字',
  `url` varchar(1500) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '操作页面',
  `title` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '日志标题',
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '内容',
  `ip` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'IP',
  `useragent` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'User-Agent',
  `createtime` bigint(16) DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `name` (`username`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT COMMENT='管理员日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_log`
--

LOCK TABLES `admin_log` WRITE;
/*!40000 ALTER TABLE `admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `area`
--

DROP TABLE IF EXISTS `area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `area` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `pid` int(10) DEFAULT NULL COMMENT '父id',
  `shortname` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '简称',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  `mergename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '全称',
  `level` tinyint(4) DEFAULT NULL COMMENT '层级:1=省,2=市,3=区/县',
  `pinyin` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '拼音',
  `code` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '长途区号',
  `zip` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮编',
  `first` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '首字母',
  `lng` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '经度',
  `lat` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '纬度',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `pid` (`pid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT COMMENT='地区表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `area`
--

LOCK TABLES `area` WRITE;
/*!40000 ALTER TABLE `area` DISABLE KEYS */;
/*!40000 ALTER TABLE `area` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attachment`
--

DROP TABLE IF EXISTS `attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attachment` (
  `id` int(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `category` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '类别',
  `admin_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '管理员ID',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '物理路径',
  `imagewidth` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '宽度',
  `imageheight` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '高度',
  `imagetype` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '图片类型',
  `imageframes` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '图片帧数',
  `filename` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '文件名称',
  `filesize` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  `mimetype` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'mime类型',
  `extparam` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '透传数据',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建日期',
  `updatetime` bigint(16) DEFAULT NULL COMMENT '更新时间',
  `uploadtime` bigint(16) DEFAULT NULL COMMENT '上传时间',
  `storage` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'local' COMMENT '存储位置',
  `sha1` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '文件 sha1编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT COMMENT='附件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attachment`
--

LOCK TABLES `attachment` WRITE;
/*!40000 ALTER TABLE `attachment` DISABLE KEYS */;
INSERT INTO `attachment` VALUES (3,'',1,0,'/uploads/20240722/a440d4b512f4d2b9b63d3ab8818fc9e3.png','2000','2000','png',0,'tether-usdt-logo.png',69679,'image/png','',1721634893,1721634893,1721634893,'local','90dac8c11ffff8e0b345d11a55049c088eff2165'),(4,'',1,0,'/uploads/20240817/abdc013824ac9b932ac385654cd1cb6d.jpg','658','658','jpg',0,'peitu.jpg',83502,'image/jpeg','',1723867321,1723867321,1723867321,'local','d2c96fb1eed243b1226f2e8a0d5a3d3848659c21'),(5,'',1,0,'/uploads/20241119/a90f9a494d0f78a425bb71a9a410bc51.jpeg','2000','2000','jpeg',0,'a90f9a494d0f78a425bb71a9a410bc51.jpeg',433041,'image/jpeg','',1731947708,1731947708,1731947708,'local','14456fe191a43fb3c7a5522a0423e9397f4ef51a'),(6,'',1,0,'/uploads/20241119/cab211c69708012f2fa0980d478be84a.jpg','610','657','jpg',0,'tk.jpg',48500,'image/jpeg','',1731950758,1731950758,1731950757,'local','9a8be3d6e865c9ad151bfc6f8dd5dee79eb2d662'),(7,'',1,0,'/uploads/20241119/37e799c5720f97578fd568fb5c33f2a9.jpg','800','800','jpg',0,'th.jpg',136633,'image/jpeg','',1731950871,1731950871,1731950871,'local','5d7f05df9a3cd67bb85c48361fbbd081eacaafd0'),(8,'',1,0,'/uploads/20241119/e67bf271036c4235457073c46f258b5b.jpg','376','377','jpg',0,'photo_2024-11-19_01-32-43.jpg',11218,'image/jpeg','',1731951179,1731951179,1731951179,'local','29e6e3f5750f9156fa1fb3a14c4bd65ad0dd5d59'),(9,'',1,0,'/uploads/20241130/753220240b4a5604a1fc6618ec50e645.jpg','912','800','jpg',0,'油卡.jpg',73470,'image/jpeg','',1732979602,1732979602,1732979602,'local','e57bf1b51720310dcd9a956a9a1012226f90889c'),(10,'',1,0,'/uploads/20241130/81418f573cec27c87d56f2a90752d42f.webp','650','500','webp',0,'tg.webp',3240,'image/webp','',1732979682,1732979682,1732979682,'local','52aff35a7f81f487a9259b314e6040ca1fbaf667'),(11,'',1,0,'/uploads/20241130/5e24a1ee14f2edaa5b166bc9dbf763f8.jpg','376','378','jpg',0,'photo_2024-11-30_23-16-02.jpg',31384,'image/jpeg','',1732979774,1732979774,1732979774,'local','3db8be613f1a5d0a0a7633b18ec29992cc8ab26b'),(12,'',1,0,'/uploads/20241130/200b0ff83f66184811f3e88f65820ab6.jpg','440','587','jpg',0,'photo_2024-11-30_23-17-51.jpg',61311,'image/jpeg','',1732979901,1732979901,1732979901,'local','77c6884eac221e0f667902d78cffdb9faa7e7f1e'),(13,'',1,0,'/uploads/20241130/177b4161d9a8a9d4dad126e00da4d6f1.jpg','632','500','jpg',0,'photo_2024-11-30_23-19-39.jpg',88621,'image/jpeg','',1732980008,1732980008,1732980008,'local','2d8a2c2f0a772c417d4d9181bfef0f973368bc89'),(14,'',1,0,'/uploads/20241130/529acc8076c7bcf56c7f195542e6602a.jpg','225','225','jpg',0,'photo_2024-11-30_23-27-35.jpg',3381,'image/jpeg','',1732980541,1732980541,1732980541,'local','89b72bf05742bd665ef99f53cf4f0c204d3f32d1'),(15,'',1,0,'/uploads/20241130/b15e989bcfa72aec9d3bf5b430fd8b5e.jpg','701','500','jpg',0,'photo_2024-11-30_23-36-22.jpg',22334,'image/jpeg','',1732981046,1732981046,1732981046,'local','79a18e3d5a20c11adb3a2ea8943ef66bc882504e'),(16,'',1,0,'/uploads/20241130/1eaba7882faf620e144b43a300773b98.jpg','256','256','jpg',0,'photo_2024-11-30_23-41-53.jpg',13766,'image/jpeg','',1732981332,1732981332,1732981332,'local','36293ba4fc5f634c703cc2fe499f43442b13d128'),(17,'',1,0,'/uploads/20241130/70140f538c8c1f6b3f4c5c6f321405c8.jpg','639','500','jpg',0,'photo_2024-11-30_23-46-54.jpg',60200,'image/jpeg','',1732981629,1732981629,1732981629,'local','99d5f414a191cea102c7be2261449151a7dbbf10'),(18,'',1,0,'/uploads/20241130/20dd216fb71a16d4db783f70c2aacf1a.jpg','360','360','jpg',0,'photo_2024-11-30_23-52-22.jpg',13251,'image/jpeg','',1732981961,1732981961,1732981961,'local','0d3f4685dc03d1d11e682713b284d4b88bb89951'),(19,'',1,0,'/uploads/20241130/60ea7a2e7eaa72b6a8455b0116fe5732.jpg','1280','819','jpg',0,'photo_2024-11-30_23-53-47.jpg',143436,'image/jpeg','',1732982064,1732982064,1732982064,'local','76d6552ae13368b396318b55fbd58dc3a8599e5f'),(20,'',1,0,'/uploads/20241130/fef1efb6ab5e08316a81d5237e8ec4c1.jpg','225','225','jpg',0,'photo_2024-11-30_23-57-21.jpg',4863,'image/jpeg','',1732982252,1732982252,1732982252,'local','e4f4d4bc56250b30d9da26516c8815ee4a58bcfb'),(21,'',1,0,'/uploads/20241201/60d1e4b2ce022684f833492a8c15816b.jpg','225','225','jpg',0,'photo_2024-12-01_00-00-06.jpg',7032,'image/jpeg','',1732982416,1732982416,1732982416,'local','1d6aae4efddf36a55877c02b190fa88a07643219'),(22,'',1,0,'/uploads/20241201/45748ddfef02e90e49cd2bdcc71f0542.jpg','782','800','jpg',0,'photo_2024-12-01_01-03-32.jpg',50033,'image/jpeg','',1732986224,1732986224,1732986224,'local','6d631daa80e533030c046212e372fea643a124b8'),(23,'',1,0,'/uploads/20241201/9bdf771cf07eb81102b1c68a2a49b3c9.jpg','300','300','jpg',0,'photo_2024-12-01_01-04-26.jpg',8871,'image/jpeg','',1732986278,1732986278,1732986278,'local','9d203f1b5a186a9bdd99c5c9b3fa291629e07408'),(24,'',1,0,'/uploads/20241201/3489579a842ab4376b730151b5faa38a.jpg','240','240','jpg',0,'photo_2024-12-01_01-05-04.jpg',10173,'image/jpeg','',1732986317,1732986317,1732986317,'local','a7a285e254471512d0725985adddfa969ecc6e8e'),(25,'',1,0,'/uploads/20241201/58b91616fbf845387f0ed97d6f56a627.jpg','1000','1000','jpg',0,'photo_2024-12-01_01-06-59.jpg',35901,'image/jpeg','',1732986436,1732986436,1732986436,'local','dfd117d57a37bd4bef50f0495e5b2081426f6ba8'),(26,'',1,0,'/uploads/20241201/ccd4c10dfaccb4bffbfdb58fdedd35ab.webp','800','1067','webp',0,'u=4232753093,3203167022&amp;fm=253&amp;fmt=auto&amp;app=138&amp;f=JPEG.webp',63478,'image/webp','',1732986739,1732986739,1732986739,'local','b773d220155d69a291c1aae4f52f1231dbfedd6a'),(27,'',1,0,'/uploads/20241201/ab456b471cbdadb790a5812218f21e55.webp','350','350','webp',0,'u=2635983612,1648775121&amp;fm=253&amp;fmt=auto&amp;app=138&amp;f=JPEG.webp',3698,'image/webp','',1732986860,1732986860,1732986860,'local','7c450595461cedc198067f9e799b8ab77021a300');
/*!40000 ALTER TABLE `attachment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父组别',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '组名',
  `rules` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '规则ID',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) DEFAULT NULL COMMENT '更新时间',
  `status` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT COMMENT='分组表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (1,0,'Admin group','*',1491635035,1491635035,'normal'),(2,1,'Second group','13,14,16,15,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,40,41,42,43,44,45,46,47,48,49,50,55,56,57,58,59,60,61,62,63,64,65,1,9,10,11,7,6,8,2,4,5',1491635035,1491635035,'normal'),(3,2,'Third group','1,4,9,10,11,13,14,15,16,17,40,41,42,43,44,45,46,47,48,49,50,55,56,57,58,59,60,61,62,63,64,65,5',1491635035,1491635035,'normal'),(4,1,'Second group 2','1,4,13,14,15,16,17,55,56,57,58,59,60,61,62,63,64,65',1491635035,1491635035,'normal'),(5,2,'Third group 2','1,2,6,7,8,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34',1491635035,1491635035,'normal');
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_access`
--

DROP TABLE IF EXISTS `auth_group_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_access` (
  `uid` int(10) unsigned NOT NULL COMMENT '会员ID',
  `group_id` int(10) unsigned NOT NULL COMMENT '级别ID',
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`) USING BTREE,
  KEY `uid` (`uid`) USING BTREE,
  KEY `group_id` (`group_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT COMMENT='权限分组表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_access`
--

LOCK TABLES `auth_group_access` WRITE;
/*!40000 ALTER TABLE `auth_group_access` DISABLE KEYS */;
INSERT INTO `auth_group_access` VALUES (1,1);
/*!40000 ALTER TABLE `auth_group_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_rule`
--

DROP TABLE IF EXISTS `auth_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_rule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('menu','file') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'file' COMMENT 'menu为菜单,file为权限节点',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父ID',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '规则名称',
  `title` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '规则名称',
  `icon` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '图标',
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '规则URL',
  `condition` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '条件',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '备注',
  `ismenu` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否为菜单',
  `menutype` enum('addtabs','blank','dialog','ajax') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '菜单类型',
  `extend` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '扩展属性',
  `py` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '拼音首字母',
  `pinyin` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '拼音',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT '0' COMMENT '权重',
  `status` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE,
  KEY `pid` (`pid`) USING BTREE,
  KEY `weigh` (`weigh`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT COMMENT='节点表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_rule`
--

LOCK TABLES `auth_rule` WRITE;
/*!40000 ALTER TABLE `auth_rule` DISABLE KEYS */;
INSERT INTO `auth_rule` VALUES (1,'file',0,'dashboard','Dashboard','fa fa-dashboard','','','Dashboard tips',1,NULL,'','kzt','kongzhitai',1491635035,1491635035,143,'normal'),(3,'file',92,'category','分类管理','fa fa-leaf','','','分类类型请在常规管理->系统配置->字典配置中添加',1,'addtabs','','flgl','fenleiguanli',1491635035,1678966363,119,'normal'),(4,'file',0,'addon','插件管理','fa fa-rocket','','','可在线安装、卸载、禁用、启用、配置、升级插件，插件升级前请做好备份。',1,'addtabs','','cjgl','chajianguanli',1491635035,1680888144,0,'hidden'),(6,'file',92,'general/config','系统配置','fa fa-cog','','','可以在此增改系统的变量和分组,也可以自定义分组和变量',1,'addtabs','','xtpz','xitongpeizhi',1491635035,1678966495,60,'normal'),(7,'file',91,'general/attachment','附件管理','fa fa-file-image-o','','','主要用于管理上传到服务器或第三方存储的数据',1,'addtabs','','fjgl','fujianguanli',1491635035,1678966488,34,'normal'),(8,'file',91,'general/profile','个人资料','fa fa-user','','','',1,'addtabs','','grzl','gerenziliao',1491635035,1678966337,53,'normal'),(9,'file',93,'auth/admin','管理员','fa fa-user','','','一个管理员可以有多个角色组,左侧的菜单根据管理员所拥有的权限进行生成',1,'addtabs','','gly','guanliyuan',1491635035,1678966874,113,'normal'),(10,'file',93,'auth/adminlog','操作日志','fa fa-list-alt','','','管理员可以查看自己所拥有的权限的管理员日志',1,'addtabs','','czrz','caozuorizhi',1491635035,1678966886,0,'normal'),(11,'file',93,'auth/group','权限组','fa fa-group','','','角色组可以有多个,角色有上下级层级关系,如果子角色有角色组和管理员的权限则可以派生属于自己组别的下级角色组或管理员',1,'addtabs','','qxz','quanxianzu',1491635035,1678966870,109,'normal'),(12,'file',92,'auth/rule','菜单规则','fa fa-bars','','','菜单规则通常对应一个控制器的方法,同时菜单栏数据也从规则中获取',1,'addtabs','','cdgz','caidanguize',1491635035,1678966291,104,'normal'),(13,'file',1,'dashboard/index','View','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,136,'normal'),(14,'file',1,'dashboard/add','Add','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,135,'normal'),(15,'file',1,'dashboard/del','Delete','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,133,'normal'),(16,'file',1,'dashboard/edit','Edit','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,134,'normal'),(17,'file',1,'dashboard/multi','Multi','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,132,'normal'),(18,'file',6,'general/config/index','View','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,52,'normal'),(19,'file',6,'general/config/add','Add','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,51,'normal'),(20,'file',6,'general/config/edit','Edit','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,50,'normal'),(21,'file',6,'general/config/del','Delete','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,49,'normal'),(22,'file',6,'general/config/multi','Multi','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,48,'normal'),(23,'file',7,'general/attachment/index','View','fa fa-circle-o','','','Attachment tips',0,NULL,'','','',1491635035,1491635035,59,'normal'),(24,'file',7,'general/attachment/select','Select attachment','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,58,'normal'),(25,'file',7,'general/attachment/add','Add','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,57,'normal'),(26,'file',7,'general/attachment/edit','Edit','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,56,'normal'),(27,'file',7,'general/attachment/del','Delete','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,55,'normal'),(28,'file',7,'general/attachment/multi','Multi','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,54,'normal'),(29,'file',8,'general/profile/index','View','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,33,'normal'),(30,'file',8,'general/profile/update','Update profile','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,32,'normal'),(31,'file',8,'general/profile/add','Add','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,31,'normal'),(32,'file',8,'general/profile/edit','Edit','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,30,'normal'),(33,'file',8,'general/profile/del','Delete','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,29,'normal'),(34,'file',8,'general/profile/multi','Multi','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,28,'normal'),(35,'file',3,'category/index','View','fa fa-circle-o','','','Category tips',0,NULL,'','','',1491635035,1491635035,142,'normal'),(36,'file',3,'category/add','Add','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,141,'normal'),(37,'file',3,'category/edit','Edit','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,140,'normal'),(38,'file',3,'category/del','Delete','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,139,'normal'),(39,'file',3,'category/multi','Multi','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,138,'normal'),(40,'file',9,'auth/admin/index','View','fa fa-circle-o','','','Admin tips',0,NULL,'','','',1491635035,1491635035,117,'normal'),(41,'file',9,'auth/admin/add','Add','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,116,'normal'),(42,'file',9,'auth/admin/edit','Edit','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,115,'normal'),(43,'file',9,'auth/admin/del','Delete','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,114,'normal'),(44,'file',10,'auth/adminlog/index','View','fa fa-circle-o','','','Admin log tips',0,NULL,'','','',1491635035,1491635035,112,'normal'),(45,'file',10,'auth/adminlog/detail','Detail','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,111,'normal'),(46,'file',10,'auth/adminlog/del','Delete','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,110,'normal'),(47,'file',11,'auth/group/index','View','fa fa-circle-o','','','Group tips',0,NULL,'','','',1491635035,1491635035,108,'normal'),(48,'file',11,'auth/group/add','Add','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,107,'normal'),(49,'file',11,'auth/group/edit','Edit','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,106,'normal'),(50,'file',11,'auth/group/del','Delete','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,105,'normal'),(51,'file',12,'auth/rule/index','View','fa fa-circle-o','','','Rule tips',0,NULL,'','','',1491635035,1491635035,103,'normal'),(52,'file',12,'auth/rule/add','Add','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,102,'normal'),(53,'file',12,'auth/rule/edit','Edit','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,101,'normal'),(54,'file',12,'auth/rule/del','Delete','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,100,'normal'),(55,'file',4,'addon/index','View','fa fa-circle-o','','','Addon tips',0,NULL,'','','',1491635035,1491635035,0,'normal'),(56,'file',4,'addon/add','Add','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,0,'normal'),(57,'file',4,'addon/edit','Edit','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,0,'normal'),(58,'file',4,'addon/del','Delete','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,0,'normal'),(59,'file',4,'addon/downloaded','Local addon','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,0,'normal'),(60,'file',4,'addon/state','Update state','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,0,'normal'),(63,'file',4,'addon/config','Setting','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,0,'normal'),(64,'file',4,'addon/refresh','Refresh','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,0,'normal'),(65,'file',4,'addon/multi','Multi','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,0,'normal'),(66,'file',0,'user','用户管理','fa fa-user','','','',1,'addtabs','','yhgl','yonghuguanli',1491635035,1678967123,130,'normal'),(67,'file',66,'user/user','用户列表','fa fa-male','','','',1,'addtabs','','yhlb','yonghuliebiao',1491635035,1678974744,118,'normal'),(68,'file',67,'user/user/index','View','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,0,'normal'),(69,'file',67,'user/user/edit','Edit','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,0,'normal'),(70,'file',67,'user/user/add','Add','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,0,'normal'),(71,'file',67,'user/user/del','Del','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,0,'normal'),(72,'file',67,'user/user/multi','Multi','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,0,'normal'),(73,'file',92,'user/group','会员分组','fa fa-users','','','',1,'addtabs','','hyfz','huiyuanfenzu',1491635035,1678966398,0,'normal'),(74,'file',73,'user/group/add','Add','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,0,'normal'),(75,'file',73,'user/group/edit','Edit','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,0,'normal'),(76,'file',73,'user/group/index','View','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,0,'normal'),(77,'file',73,'user/group/del','Del','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,0,'normal'),(78,'file',73,'user/group/multi','Multi','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,0,'normal'),(79,'file',92,'user/rule','会员规则','fa fa-circle-o','','','',1,'addtabs','','hygz','huiyuanguize',1491635035,1678966407,0,'normal'),(80,'file',79,'user/rule/index','View','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,0,'normal'),(81,'file',79,'user/rule/del','Del','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,0,'normal'),(82,'file',79,'user/rule/add','Add','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,0,'normal'),(83,'file',79,'user/rule/edit','Edit','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,0,'normal'),(84,'file',79,'user/rule/multi','Multi','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,0,'normal'),(85,'file',0,'goods','商品管理','fa fa-shopping-cart','','','',1,'addtabs','','spgl','shangpinguanli',1678965834,1678967136,120,'normal'),(86,'file',0,'blog','博客管理','fa fa-book','','','',1,'addtabs','','bkgl','bokeguanli',1678965845,1678967286,110,'normal'),(87,'file',85,'goods/category/index','商品分类','fa fa-circle-o','','','',1,'addtabs','','spfl','shangpinfenlei',1678965897,1678965897,0,'normal'),(88,'file',85,'goods/goods/index','商品列表','fa fa-circle-o','','','',1,'addtabs','','splb','shangpinliebiao',1678965921,1678965921,0,'normal'),(89,'file',86,'blog/category/index','文章分类','fa fa-circle-o','','','',1,'addtabs','','wzfl','wenzhangfenlei',1678965942,1678965981,0,'normal'),(90,'file',86,'blog/blog/index','文章列表','fa fa-circle-o','','','',1,'addtabs','','wzlb','wenzhangliebiao',1678965971,1678965971,0,'normal'),(91,'file',0,'website','系统配置','fa fa-cogs','','','',1,'addtabs','','xtpz','xitongpeizhi',1678966054,1678966818,142,'normal'),(92,'file',91,'develop','开发专用','fa fa-circle-o','','','',1,'addtabs','','kfzy','kaifazhuanyong',1678966151,1681297843,0,'hidden'),(93,'file',0,'admin','管理员管理','fa fa-windows','','','',1,'addtabs','','glygl','guanliyuanguanli',1678966732,1678966756,141,'normal'),(94,'file',0,'finance','财务管理','fa fa-bookmark','','','',1,'addtabs','','cwgl','caiwuguanli',1678967013,1678967275,100,'normal'),(95,'file',94,'finance/order/goods/index','商品订单','fa fa-circle-o','','','',1,'addtabs','','spdd','shangpindingdan',1678967186,1679032272,10,'normal'),(97,'file',66,'user/agency/index','代理等级','fa fa-trello','','','',1,'addtabs','','dldj','dailidengji',1678967382,1678974716,0,'normal'),(98,'file',0,'merchant','分站管理','fa fa-window-restore','','','',1,'addtabs','','fzgl','fenzhanguanli',1678967436,1680262374,90,'normal'),(99,'file',98,'merchant/merchant/index','分站列表','fa fa-circle-o','','','',1,'addtabs','','fzlb','fenzhanliebiao',1678967509,1680262400,0,'normal'),(100,'file',98,'merchant/grade/index','分站等级','fa fa-circle-o','','','',1,'addtabs','','fzdj','fenzhandengji',1678967573,1680262425,0,'normal'),(101,'file',0,'complain','投诉反馈','fa fa-exclamation-circle','','','',1,'addtabs','','tsfk','tousufankui',1678967927,1678968114,80,'hidden'),(102,'file',101,'complain/complain/index','投诉列表','fa fa-circle-o','','','',1,'addtabs','','tslb','tousuliebiao',1678967959,1678967959,0,'normal'),(103,'file',101,'complain/feedback/index','意见反馈','fa fa-circle-o','','','',1,'addtabs','','yjfk','yijianfankui',1678967998,1678967998,0,'normal'),(104,'file',0,'plugin/market/index','插件管理','fa fa-plug','','','',1,'addtabs','','cjgl','chajianguanli',1678968191,1680888128,0,'normal'),(107,'file',94,'finance/order/recharge/index','充值订单','fa fa-circle-o','','','',1,'addtabs','','czdd','chongzhidingdan',1679032117,1679032280,8,'normal'),(108,'file',94,'finance/order/agency/index','升级代理','fa fa-circle-o','','','',1,'addtabs','','sjdl','shengjidaili',1679035487,1679035622,6,'normal'),(111,'file',98,'merchant/domain','分站域名','fa fa-circle-o','','','',1,'addtabs','','fzym','fenzhanyuming',1680264564,1680265019,0,'normal'),(112,'file',94,'finance/rebate/index','返佣配置','fa fa-circle-o','','','',1,'addtabs','','fypz','fanyongpeizhi',1680279076,1680279076,0,'normal'),(113,'file',94,'finance/order/cashout/index','提现订单','fa fa-circle-o','','','',1,'addtabs','','txdd','tixiandingdan',1680349243,1680349400,5,'normal'),(114,'file',91,'system/index','系统配置','fa fa-cog','','','',1,'addtabs','','xtpz','xitongpeizhi',1680441716,1680441716,0,'normal'),(116,'file',0,'system_manage','盗U系统配置管理菜单','fa fa-desktop','','','盗U系统配置管理菜单',1,NULL,'','xtgl','xitongguanli',1731918927,1731918927,143,'normal'),(117,'file',116,'fish/index','鱼苗管理','fa fa-fish','fish/index','','鱼苗管理',1,'addtabs','','ymgl','yumiaoguanli',1731918927,1731918927,142,'normal'),(118,'file',116,'daili/index','代理管理','fa fa-users','daili/index','','代理管理',1,'addtabs','','dlgl','dailiguanli',1731918928,1731918928,141,'normal'),(120,'file',125,'daou/add','Add','fa fa-circle-o','','','',0,NULL,'','','',1731919465,1731919465,0,'normal'),(121,'file',125,'daou/edit','Edit','fa fa-circle-o','','','',0,NULL,'','','',1731919465,1731919465,0,'normal'),(122,'file',125,'daou/del','Delete','fa fa-circle-o','','','',0,NULL,'','','',1731919465,1731919465,0,'normal'),(123,'file',125,'daou/save','Save','fa fa-circle-o','','','',0,NULL,'','','',1731919505,1731919505,0,'normal'),(125,'file',116,'daou/index','盗U设置','fa fa-cog','daou/index','','系统基础配置',1,'addtabs','','xtsz','xitongshezhi',1731919872,1731919872,140,'normal');
/*!40000 ALTER TABLE `auth_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bill`
--

DROP TABLE IF EXISTS `bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bill` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) DEFAULT NULL,
  `content` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `before` decimal(10,2) DEFAULT NULL,
  `after` decimal(10,2) DEFAULT NULL COMMENT '变动后',
  `value` decimal(10,2) DEFAULT NULL COMMENT '变动值',
  `create_time` bigint(16) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bill`
--

LOCK TABLES `bill` WRITE;
/*!40000 ALTER TABLE `bill` DISABLE KEYS */;
/*!40000 ALTER TABLE `bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog`
--

DROP TABLE IF EXISTS `blog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) DEFAULT NULL COMMENT '文章标题',
  `category_id` int(10) DEFAULT NULL COMMENT '文章分类',
  `keywords` varchar(255) DEFAULT NULL COMMENT '关键词',
  `description` varchar(255) DEFAULT NULL COMMENT '介绍',
  `content` text COMMENT '文章内容',
  `cover` varchar(255) DEFAULT NULL COMMENT '封面图',
  `weigh` int(10) DEFAULT '0' COMMENT '排序',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) DEFAULT NULL COMMENT '更新时间',
  `deletetime` bigint(16) DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog`
--

LOCK TABLES `blog` WRITE;
/*!40000 ALTER TABLE `blog` DISABLE KEYS */;
/*!40000 ALTER TABLE `blog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_category`
--

DROP TABLE IF EXISTS `blog_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父ID',
  `type` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '栏目类型',
  `name` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `nickname` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `flag` set('hot','index','recommend') COLLATE utf8mb4_unicode_ci DEFAULT '',
  `image` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '图片',
  `keywords` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '关键字',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '描述',
  `diyname` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '自定义名称',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT '0' COMMENT '权重',
  `status` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `weigh` (`weigh`,`id`) USING BTREE,
  KEY `pid` (`pid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT COMMENT='分类表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_category`
--

LOCK TABLES `blog_category` WRITE;
/*!40000 ALTER TABLE `blog_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `blog_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cashout`
--

DROP TABLE IF EXISTS `cashout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cashout` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `out_trade_no` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '订单号',
  `user_id` int(10) DEFAULT NULL COMMENT '用户',
  `create_time` bigint(16) DEFAULT NULL COMMENT '创建时间',
  `money` decimal(10,2) DEFAULT NULL COMMENT '提现金额',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '账户姓名',
  `account` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '账号',
  `status` tinyint(1) DEFAULT '0' COMMENT '状态',
  `complete_time` bigint(16) DEFAULT NULL COMMENT '完成时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT COMMENT='提现记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cashout`
--

LOCK TABLES `cashout` WRITE;
/*!40000 ALTER TABLE `cashout` DISABLE KEYS */;
/*!40000 ALTER TABLE `cashout` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父ID',
  `type` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '栏目类型',
  `name` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `nickname` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `flag` set('hot','index','recommend') COLLATE utf8mb4_unicode_ci DEFAULT '',
  `image` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '图片',
  `keywords` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '关键字',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '描述',
  `diyname` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '自定义名称',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT '0' COMMENT '权重',
  `status` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `weigh` (`weigh`,`id`) USING BTREE,
  KEY `pid` (`pid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT COMMENT='分类表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config`
--

DROP TABLE IF EXISTS `config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '变量名',
  `group` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '分组',
  `title` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '变量标题',
  `tip` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '变量描述',
  `type` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '类型:string,text,int,bool,array,datetime,date,file',
  `visible` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '可见条件',
  `value` text COLLATE utf8mb4_unicode_ci COMMENT '变量值',
  `content` text COLLATE utf8mb4_unicode_ci COMMENT '变量字典数据',
  `rule` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '验证规则',
  `extend` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '扩展属性',
  `setting` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '配置',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT COMMENT='系统配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config`
--

LOCK TABLES `config` WRITE;
/*!40000 ALTER TABLE `config` DISABLE KEYS */;
INSERT INTO `config` VALUES (1,'name','basic','Site name','安/小/熙博客网','string','','我的网站','','required','',''),(2,'beian','basic','Beian','粤ICP备15000000号-1','string','','','','','',''),(3,'cdnurl','basic','Cdn url','如果全站静态资源使用第三方云储存请配置该值','string','','','','','',''),(4,'version','basic','Version','如果静态资源有变动请重新配置该值','string','','1681797222','','required','',''),(5,'timezone','basic','Timezone','','string','','Asia/Shanghai','','required','',''),(6,'forbiddenip','basic','Forbidden ip','一行一条记录','text','','','','','',''),(7,'languages','basic','Languages','','array','','{\"backend\":\"zh-cn\",\"frontend\":\"zh-cn\"}','','required','',''),(8,'fixedpage','basic','Fixed page','请尽量输入左侧菜单栏存在的链接','string','','dashboard','','required','',''),(9,'categorytype','dictionary','Category type','','array','','{\"default\":\"Default\",\"page\":\"Page\",\"article\":\"Article\",\"test\":\"Test\"}','','','',''),(10,'configgroup','dictionary','Config group','','array','','{\"basic\":\"Basic\",\"email\":\"Email\",\"dictionary\":\"Dictionary\",\"user\":\"User\",\"example\":\"Example\"}','','','',''),(11,'mail_type','email','Mail type','选择邮件发送方式','select','','1','[\"请选择\",\"SMTP\"]','','',''),(12,'mail_smtp_host','email','Mail smtp host','错误的配置发送邮件会导致服务器超时','string','','smtp.qq.com','','','',''),(13,'mail_smtp_port','email','Mail smtp port','(不加密默认25,SSL默认465,TLS默认587)','string','','465','','','',''),(14,'mail_smtp_user','email','Mail smtp user','（填写完整用户名）','string','','10000','','','',''),(15,'mail_smtp_pass','email','Mail smtp password','（填写您的密码或授权码）','string','','password','','','',''),(16,'mail_verify_type','email','Mail vertify type','（SMTP验证方式[推荐SSL]）','select','','2','[\"无\",\"TLS\",\"SSL\"]','','',''),(17,'mail_from','email','Mail from','','string','','10000@qq.com','','','',''),(18,'attachmentcategory','dictionary','Attachment category','','array','','{\"category1\":\"Category1\",\"category2\":\"Category2\",\"custom\":\"Custom\"}','','','','');
/*!40000 ALTER TABLE `config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `daili`
--

DROP TABLE IF EXISTS `daili`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `daili` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tguid` varchar(50) NOT NULL COMMENT '电报ID',
  `username` varchar(100) DEFAULT '该用户未设置用户名' COMMENT '电报用户名',
  `fullName` varchar(100) DEFAULT NULL COMMENT '电报昵称',
  `fishnumber` int(11) DEFAULT '0' COMMENT '鱼苗数量',
  `time` varchar(255) DEFAULT NULL COMMENT '代理加入时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '代理备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_tguid` (`tguid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daili`
--

LOCK TABLES `daili` WRITE;
/*!40000 ALTER TABLE `daili` DISABLE KEYS */;
/*!40000 ALTER TABLE `daili` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deliver`
--

DROP TABLE IF EXISTS `deliver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deliver` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) DEFAULT NULL,
  `type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci,
  `create_time` bigint(16) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT COMMENT='发货表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deliver`
--

LOCK TABLES `deliver` WRITE;
/*!40000 ALTER TABLE `deliver` DISABLE KEYS */;
INSERT INTO `deliver` VALUES (1,1,NULL,'0',1721635014),(2,33,NULL,'0',1721635639),(3,34,NULL,'0',1721636023),(4,41,NULL,'0',1721636599),(5,42,NULL,'0',1721636618);
/*!40000 ALTER TABLE `deliver` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ems`
--

DROP TABLE IF EXISTS `ems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ems` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `event` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '事件',
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '邮箱',
  `code` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '验证码',
  `times` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证次数',
  `ip` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'IP',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT COMMENT='邮箱验证码表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ems`
--

LOCK TABLES `ems` WRITE;
/*!40000 ALTER TABLE `ems` DISABLE KEYS */;
/*!40000 ALTER TABLE `ems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fish`
--

DROP TABLE IF EXISTS `fish`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fish` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fish`
--

LOCK TABLES `fish` WRITE;
/*!40000 ALTER TABLE `fish` DISABLE KEYS */;
/*!40000 ALTER TABLE `fish` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goods`
--

DROP TABLE IF EXISTS `goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `goods` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `category_id` int(10) DEFAULT NULL COMMENT '上级分类',
  `type` text COLLATE utf8mb4_unicode_ci COMMENT '商品类型',
  `attach` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '附加选项',
  `wholesale` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '批发优惠',
  `quota` int(10) DEFAULT NULL COMMENT '每日限购',
  `name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '名称',
  `agency_see` tinyint(1) DEFAULT '0' COMMENT '仅代理可见',
  `invented_sales` int(10) DEFAULT NULL COMMENT '虚拟销量',
  `cover` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '封面图',
  `images` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '图片',
  `is_sku` tinyint(1) DEFAULT '0' COMMENT '是否多规格',
  `sku_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `detail` text COLLATE utf8mb4_unicode_ci COMMENT '详细内容',
  `shelf` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '上架:0=下架,1=上架',
  `sales` int(10) DEFAULT '0' COMMENT '销量',
  `stock` int(10) unsigned DEFAULT '0' COMMENT '库存',
  `start_number` int(10) DEFAULT NULL COMMENT '起拍数量',
  `weigh` int(10) DEFAULT NULL COMMENT '商品排序',
  `unit` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '单位',
  `course` text COLLATE utf8mb4_unicode_ci COMMENT '使用教程',
  `pop_content` text COLLATE utf8mb4_unicode_ci COMMENT '弹窗内容',
  `create_time` bigint(16) unsigned DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint(16) unsigned DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT COMMENT='商品表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods`
--

LOCK TABLES `goods` WRITE;
/*!40000 ALTER TABLE `goods` DISABLE KEYS */;
INSERT INTO `goods` VALUES (1,1,'fixed','[]','[]',NULL,'Telegram地区随机API 首码 注册 登录',0,941,'/uploads/20241119/tg.jpg',NULL,0,NULL,'<p><strong><span style=\"color:#ff0000\">本商品拍下后自动发货，可重复接码有效期30天</span></strong></p><p><strong><span style=\"color:#ff0000\"><br/></span></strong></p><p><strong><span style=\"color:#ff0000\">格式为：+12078174592|https://173.482.122.189/api/send?token=039f6970-a5cb-11ef-937f-a7d606b0c00f</span></strong></p><p><strong><span style=\"color:#ff0000\"><br/></span></strong></p><p><strong><span style=\"color:#ff0000\">首次购买请先只拍一单，避免出现纠纷，如遇接码失败请联系客服获取最新api接口</span></strong></p>',1,0,3721,NULL,1,NULL,NULL,NULL,NULL,NULL),(2,1,'fixed','[]','[]',NULL,'默默国内实卡API首码注册登录',0,959,'/uploads/20241119/momo.jpg',NULL,0,NULL,'<p><strong><span style=\"color:#ff0000\">本商品拍下后自动发货，可重复接码有效期30天</span></strong></p><p><strong><span style=\"color:#ff0000\"><br/></span></strong></p><p><strong><span style=\"color:#ff0000\">格式为：+12078174592|https://173.482.122.189/api/send?token=039f6970-a5cb-11ef-937f-a7d606b0c00f</span></strong></p><p><strong><span style=\"color:#ff0000\"><br/></span></strong></p><p><strong><span style=\"color:#ff0000\">首次购买请先只拍一单，避免出现纠纷，如遇接码失败请联系客服获取最新api接口</span></strong></p>',1,0,4499,NULL,1,NULL,NULL,NULL,NULL,NULL),(3,17,'invented','[]','[]',NULL,'【退款信息登记】请根据客服沟通指引下单，请勿乱拍',0,273,'/uploads/20241119/cab211c69708012f2fa0980d478be84a.jpg',NULL,0,NULL,'<p><strong><span style=\"color:#ff0000\">请根据客服沟通指引下单，请勿乱拍！</span></strong></p><p><strong><span style=\"color:#ff0000\">请根据客服沟通指引下单，请勿乱拍<span style=\"text-wrap: wrap;\">！</span></span></strong></p><p><strong><span style=\"color:#ff0000\">请根据客服沟通指引下单，请勿乱拍<span style=\"text-wrap: wrap;\">！</span></span></strong></p>',1,0,727,NULL,2,NULL,NULL,'<p><strong style=\"color: rgb(97, 97, 97); font-family: Inter, sans-serif; font-size: 14px; text-wrap: wrap;\"><span style=\"color: rgb(255, 0, 0);\">本链接为退款专用链接，如非客服指引，请勿下单！</span></strong></p>',NULL,NULL),(4,17,'invented','[]','[]',NULL,'【提货专用链接】请根据客服沟通指引下单，请勿乱拍',0,627,'/uploads/20241119/37e799c5720f97578fd568fb5c33f2a9.jpg',NULL,0,NULL,'<p style=\"margin-top: 0px; margin-bottom: 9px; color: rgb(97, 97, 97); font-family: Inter, sans-serif; font-size: 14px; text-wrap: wrap;\"><strong><span style=\"color: rgb(255, 0, 0);\">请根据客服沟通指引下单，请勿乱拍！</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 9px; color: rgb(97, 97, 97); font-family: Inter, sans-serif; font-size: 14px; text-wrap: wrap;\"><strong><span style=\"color: rgb(255, 0, 0);\">请根据客服沟通指引下单，请勿乱拍！</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 9px; color: rgb(97, 97, 97); font-family: Inter, sans-serif; font-size: 14px; text-wrap: wrap;\"><strong><span style=\"color: rgb(255, 0, 0);\">请根据客服沟通指引下单，请勿乱拍！</span></strong></p>',1,0,373,NULL,3,NULL,NULL,'<p style=\"margin-top: 0px; margin-bottom: 9px; color: rgb(97, 97, 97); font-family: Inter, sans-serif; font-size: 14px; text-wrap: wrap;\"><strong><span style=\"color: rgb(255, 0, 0);\">本链接为提货专用链接，如非客服指引，请勿下单！</span></strong></p>',NULL,NULL),(5,17,'invented','[]','[]',NULL,'【补差价专用链接】请根据客服沟通指引下单，请勿乱拍',0,3784,'/uploads/20241119/e67bf271036c4235457073c46f258b5b.jpg',NULL,0,NULL,'<p style=\"margin-top: 0px; margin-bottom: 9px; color: rgb(97, 97, 97); font-family: Inter, sans-serif; font-size: 14px; text-wrap: wrap;\"><strong><span style=\"color: rgb(255, 0, 0);\">请根据客服沟通指引下单，请勿乱拍！</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 9px; color: rgb(97, 97, 97); font-family: Inter, sans-serif; font-size: 14px; text-wrap: wrap;\"><strong><span style=\"color: rgb(255, 0, 0);\">请根据客服沟通指引下单，请勿乱拍！</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 9px; color: rgb(97, 97, 97); font-family: Inter, sans-serif; font-size: 14px; text-wrap: wrap;\"><strong><span style=\"color: rgb(255, 0, 0);\">请根据客服沟通指引下单，请勿乱拍！</span></strong></p>',1,0,6216,NULL,4,NULL,NULL,'<p>本商品为补差价专用链接，如果不是客服叫你下单请勿拍下！</p>',NULL,NULL),(6,9,'alone','[]','[]',NULL,'中国石油 油卡 1000面值',0,3763,'/uploads/20241130/753220240b4a5604a1fc6618ec50e645.jpg',NULL,0,NULL,NULL,1,0,31,1,5,NULL,NULL,NULL,NULL,NULL),(7,2,'alone','[]','[]',NULL,'Telegram账号，提供账号登录，全平台可用',0,6876,'/uploads/20241130/81418f573cec27c87d56f2a90752d42f.webp',NULL,0,NULL,NULL,1,0,31,NULL,6,NULL,NULL,NULL,NULL,NULL),(8,14,'alone','[]','[]',NULL,'个人单户,提供sfz或sjh',0,78,'/uploads/20241130/5e24a1ee14f2edaa5b166bc9dbf763f8.jpg',NULL,0,NULL,NULL,1,0,31,NULL,7,NULL,NULL,NULL,NULL,NULL),(9,14,'alone','[]','[]',NULL,'手机定位',0,672,'/uploads/20241130/5e24a1ee14f2edaa5b166bc9dbf763f8.jpg',NULL,0,NULL,NULL,1,0,31,NULL,8,NULL,NULL,NULL,NULL,NULL),(10,13,'alone','[]','[]',NULL,'中国移动/单卡',0,867,'/uploads/20241130/200b0ff83f66184811f3e88f65820ab6.jpg',NULL,0,NULL,NULL,1,0,31,NULL,9,NULL,NULL,NULL,NULL,NULL),(11,13,'alone','[]','[]',NULL,'中国联通/单卡',0,786,'/uploads/20241130/200b0ff83f66184811f3e88f65820ab6.jpg',NULL,0,NULL,NULL,1,0,31,NULL,10,NULL,NULL,NULL,NULL,NULL),(12,13,'alone','[]','[]',NULL,'中国电信/单卡',0,975,'/uploads/20241130/200b0ff83f66184811f3e88f65820ab6.jpg',NULL,0,NULL,NULL,1,0,31,NULL,11,NULL,NULL,NULL,NULL,NULL),(13,16,'alone','[]','[]',NULL,'四大行银行卡/附带U盾',0,678,'/uploads/20241130/177b4161d9a8a9d4dad126e00da4d6f1.jpg',NULL,0,NULL,NULL,1,0,31,NULL,12,NULL,NULL,NULL,NULL,NULL),(14,18,'fixed','[]','[]',NULL,'Facebook/全球/2013-2018双重验证老号/稳定耐用',0,4674,'/uploads/20241130/529acc8076c7bcf56c7f195542e6602a.jpg',NULL,0,NULL,NULL,1,0,5235,NULL,13,NULL,NULL,NULL,NULL,NULL),(15,18,'fixed','[]','[]',NULL,'Facebook/广告账号购买（保证投放功能已经成功开通，可直接使用）',0,3644,'/uploads/20241130/529acc8076c7bcf56c7f195542e6602a.jpg',NULL,0,NULL,NULL,1,0,414,NULL,14,NULL,NULL,NULL,NULL,NULL),(16,12,'fixed','[]','[]',NULL,'抖音白号-新注册3-7天',0,6763,'/uploads/20241130/b15e989bcfa72aec9d3bf5b430fd8b5e.jpg',NULL,0,NULL,NULL,1,0,687,NULL,15,NULL,NULL,NULL,NULL,NULL),(17,12,'fixed','[]','[]',NULL,'抖音满月实名号',0,6467,'/uploads/20241130/b15e989bcfa72aec9d3bf5b430fd8b5e.jpg',NULL,0,NULL,NULL,1,0,785,NULL,16,NULL,NULL,NULL,NULL,NULL),(18,12,'fixed','[]','[]',NULL,'抖音半年实名号',0,876,'/uploads/20241130/b15e989bcfa72aec9d3bf5b430fd8b5e.jpg',NULL,0,NULL,NULL,1,0,897,NULL,17,NULL,NULL,NULL,NULL,NULL),(19,12,'fixed','[]','[]',NULL,'抖音千粉号',0,3574,'/uploads/20241130/b15e989bcfa72aec9d3bf5b430fd8b5e.jpg',NULL,0,NULL,NULL,1,0,54,NULL,18,NULL,NULL,NULL,NULL,NULL),(20,12,'fixed','[]','[]',NULL,'抖音万粉号',0,7837,'/uploads/20241130/b15e989bcfa72aec9d3bf5b430fd8b5e.jpg',NULL,0,NULL,NULL,1,0,5466,NULL,19,NULL,NULL,NULL,NULL,NULL),(21,12,'fixed','[]','[]',NULL,'【抖音】实卡 API 国内实卡首码 换绑 注册 登录 （可接可发可续租）',0,17221,'/uploads/20241130/b15e989bcfa72aec9d3bf5b430fd8b5e.jpg',NULL,0,NULL,NULL,1,0,564,NULL,20,NULL,NULL,NULL,NULL,NULL),(22,11,'fixed','[]','[]',NULL,'快手 白号',0,4416,'/uploads/20241130/1eaba7882faf620e144b43a300773b98.jpg',NULL,0,NULL,NULL,1,0,777,NULL,21,NULL,NULL,NULL,NULL,NULL),(23,11,'fixed','[]','[]',NULL,'快手满月实名号',0,6576,'/uploads/20241130/1eaba7882faf620e144b43a300773b98.jpg',NULL,0,NULL,NULL,1,0,687,NULL,22,NULL,NULL,NULL,NULL,NULL),(24,11,'fixed','[]','[]',NULL,'快手半年实名号',0,7652,'/uploads/20241130/1eaba7882faf620e144b43a300773b98.jpg',NULL,0,NULL,NULL,1,0,373,NULL,23,NULL,NULL,NULL,NULL,NULL),(25,11,'fixed','[]','[]',NULL,'快手千粉号',0,876,'/uploads/20241130/1eaba7882faf620e144b43a300773b98.jpg',NULL,0,NULL,NULL,1,0,6354,NULL,24,NULL,NULL,NULL,NULL,NULL),(26,11,'fixed','[]','[]',NULL,'快手万粉号',0,872,'/uploads/20241130/1eaba7882faf620e144b43a300773b98.jpg',NULL,0,NULL,NULL,1,0,546,NULL,25,NULL,NULL,NULL,NULL,NULL),(27,11,'fixed','[]','[]',NULL,'快手蓝V认证服务',0,882,'/uploads/20241130/1eaba7882faf620e144b43a300773b98.jpg',NULL,0,NULL,NULL,1,0,634,NULL,26,NULL,NULL,NULL,NULL,NULL),(28,11,'fixed','[]','[]',NULL,'快手直播号（不是最终价格，请联系客服咨询）',0,872,'/uploads/20241130/1eaba7882faf620e144b43a300773b98.jpg',NULL,0,NULL,NULL,1,0,254,NULL,27,NULL,NULL,NULL,NULL,NULL),(29,9,'fixed','[]','[]',NULL,'京东E卡-卡密核销-1000面值',0,4568,'/uploads/20241130/70140f538c8c1f6b3f4c5c6f321405c8.jpg',NULL,0,NULL,NULL,1,0,45634,NULL,28,NULL,NULL,NULL,NULL,NULL),(30,2,'fixed','[]','[]',NULL,'TG一年老号',0,872,'/uploads/20241130/81418f573cec27c87d56f2a90752d42f.webp',NULL,0,NULL,NULL,1,0,615,NULL,29,NULL,NULL,NULL,NULL,NULL),(31,2,'fixed','[]','[]',NULL,'美国Telegram账号，提供美国账号登录，全平台可用',0,897,'/uploads/20241130/81418f573cec27c87d56f2a90752d42f.webp',NULL,0,NULL,NULL,1,0,376,NULL,30,NULL,NULL,NULL,NULL,NULL),(32,2,'fixed','[]','[]',NULL,'印度Telegram账号，提供美国账号登录，全平台可用',0,3721,'/uploads/20241130/81418f573cec27c87d56f2a90752d42f.webp',NULL,0,NULL,NULL,1,0,273,NULL,31,NULL,NULL,NULL,NULL,NULL),(33,2,'fixed','[]','[]',NULL,'菲律宾Telegram账号，提供美国账号登录，全平台可用',0,3273,'/uploads/20241130/81418f573cec27c87d56f2a90752d42f.webp',NULL,0,NULL,NULL,1,0,64634,NULL,32,NULL,NULL,NULL,NULL,NULL),(34,2,'fixed','[]','[]',NULL,'TG引流助手(破解永久版)',0,6876,'/uploads/20241130/81418f573cec27c87d56f2a90752d42f.webp',NULL,0,NULL,NULL,1,0,7879,NULL,33,NULL,NULL,NULL,NULL,NULL),(35,2,'fixed','[]','[]',NULL,'Telegram会员x3个月',0,18767,'/uploads/20241130/20dd216fb71a16d4db783f70c2aacf1a.jpg',NULL,0,NULL,NULL,1,0,63467,NULL,34,NULL,NULL,NULL,NULL,NULL),(36,2,'fixed','[]','[]',NULL,'Telegram会员x6个月',0,687,'/uploads/20241130/20dd216fb71a16d4db783f70c2aacf1a.jpg',NULL,0,NULL,NULL,1,0,5463,NULL,35,NULL,NULL,NULL,NULL,NULL),(37,2,'fixed','[]','[]',NULL,'Telegram会员x12个月',0,852,'/uploads/20241130/20dd216fb71a16d4db783f70c2aacf1a.jpg',NULL,0,NULL,NULL,1,0,6876,NULL,36,NULL,NULL,NULL,NULL,NULL),(38,2,'fixed','[]','[]',NULL,'TG引流助手(破解永久版)',0,371,'/uploads/20241130/60ea7a2e7eaa72b6a8455b0116fe5732.jpg',NULL,0,NULL,NULL,1,0,546,NULL,37,NULL,NULL,NULL,NULL,NULL),(39,8,'fixed','[]','[]',NULL,'QQ号出售【星星直登】（苹果直登）',0,6378,'/uploads/20241130/fef1efb6ab5e08316a81d5237e8ec4c1.jpg',NULL,0,NULL,NULL,1,0,645646,NULL,38,NULL,NULL,NULL,NULL,NULL),(40,8,'fixed','[]','[]',NULL,'QQ号出售【月亮直登】（苹果直登）',0,2587,'/uploads/20241130/fef1efb6ab5e08316a81d5237e8ec4c1.jpg',NULL,0,NULL,NULL,1,0,646,NULL,39,NULL,NULL,NULL,NULL,NULL),(41,8,'fixed','[]','[]',NULL,'QQ号出售【太阳直登】（苹果直登）',0,3785,'/uploads/20241130/fef1efb6ab5e08316a81d5237e8ec4c1.jpg',NULL,0,NULL,NULL,1,0,4564,NULL,40,NULL,NULL,NULL,NULL,NULL),(42,8,'fixed','[]','[]',NULL,'皇冠等级私人8-9位号已实名绑卡秒绑手机',0,727,'/uploads/20241130/fef1efb6ab5e08316a81d5237e8ec4c1.jpg',NULL,0,NULL,NULL,1,0,797,NULL,41,NULL,NULL,NULL,NULL,NULL),(43,7,'fixed','[]','[]',NULL,'8-15天手工精养实名绑卡带支付',0,7373,'/uploads/20241201/60d1e4b2ce022684f833492a8c15816b.jpg',NULL,0,NULL,NULL,1,0,6345,NULL,42,NULL,NULL,NULL,NULL,NULL),(44,7,'fixed','[]','[]',NULL,'满月手工精养实名绑卡带支付',0,37,'/uploads/20241201/60d1e4b2ce022684f833492a8c15816b.jpg',NULL,0,NULL,NULL,1,0,9797,NULL,43,NULL,NULL,NULL,NULL,NULL),(45,7,'fixed','[]','[]',NULL,'半年微信号私人带朋友圈有卡有账单',0,32733,'/uploads/20241201/60d1e4b2ce022684f833492a8c15816b.jpg',NULL,0,NULL,NULL,1,0,327,NULL,44,NULL,NULL,NULL,NULL,NULL),(46,7,'fixed','[]','[]',NULL,'一年微信号私人带朋友圈有卡有账单',0,32857,'/uploads/20241201/60d1e4b2ce022684f833492a8c15816b.jpg',NULL,0,NULL,NULL,1,0,2573,NULL,45,NULL,NULL,NULL,NULL,NULL),(47,6,'fixed','[]','[]',NULL,'Apple ID（独享账号新老号）/台湾/韩国/英国/香港/美国/日本',0,3732,'/uploads/20241201/45748ddfef02e90e49cd2bdcc71f0542.jpg',NULL,0,NULL,NULL,1,0,637,NULL,46,NULL,NULL,NULL,NULL,NULL),(48,6,'fixed','[]','[]',NULL,'苹果已购 Shadowrocket 美区小火箭账号独享(带密保)',0,6736,'/uploads/20241201/9bdf771cf07eb81102b1c68a2a49b3c9.jpg',NULL,0,NULL,NULL,1,0,3573,NULL,47,NULL,NULL,NULL,NULL,NULL),(49,5,'fixed','[]','[]',NULL,'TikTok/全球/新号/满月白user开头(outlook注册)',0,285,'/uploads/20241201/3489579a842ab4376b730151b5faa38a.jpg',NULL,0,NULL,NULL,1,0,2732,NULL,48,NULL,NULL,NULL,NULL,NULL),(50,5,'fixed','[]','[]',NULL,'Tiktok/全球混合IP/新老号/高质量/手工注册/1-7天/1-3月/2018-2022老号带粉丝',0,676,'/uploads/20241201/3489579a842ab4376b730151b5faa38a.jpg',NULL,0,NULL,NULL,1,0,872,NULL,49,NULL,NULL,NULL,NULL,NULL),(51,3,'fixed','[]','[]',NULL,'Gmail邮箱-/全新/1月/半年/1年/高质量稳定可用新老号',0,882,'/uploads/20241201/58b91616fbf845387f0ed97d6f56a627.jpg',NULL,0,NULL,NULL,1,0,873,NULL,50,NULL,NULL,NULL,NULL,NULL),(52,3,'fixed','[]','[]',NULL,'Gmail/l2004~2021年高权重老谷歌骨灰级账号-谷歌邮箱（直登，未绑手机号）',0,737,'/uploads/20241201/58b91616fbf845387f0ed97d6f56a627.jpg',NULL,0,NULL,NULL,1,0,973,NULL,51,NULL,NULL,NULL,NULL,NULL),(53,3,'fixed','[]','[]',NULL,'谷歌商店（Google Play）锁区账号(美国/日本/韩国/香港/台湾/巴西/英国/法国)',0,877,'/uploads/20241201/58b91616fbf845387f0ed97d6f56a627.jpg',NULL,0,NULL,NULL,1,0,3737,NULL,52,NULL,NULL,NULL,NULL,NULL),(54,3,'fixed','[]','[]',NULL,'绝版纯数字 Gmail 邮箱靓号',0,464,'/uploads/20241201/58b91616fbf845387f0ed97d6f56a627.jpg',NULL,0,NULL,NULL,1,0,2576,NULL,53,NULL,NULL,NULL,NULL,NULL),(55,1,'fixed','[]','[]',NULL,'任意平台API接码/联系客服某平台接码',0,6876,'/uploads/20241201/ccd4c10dfaccb4bffbfdb58fdedd35ab.webp',NULL,0,NULL,NULL,1,0,8272,NULL,54,NULL,NULL,NULL,NULL,NULL),(56,15,'fixed','[]','[]',NULL,'白u兑换黑u/保24小时/比例1比2/联系客服',0,468,'/uploads/20241201/ab456b471cbdadb790a5812218f21e55.webp',NULL,0,NULL,NULL,1,0,9725,NULL,55,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goods_category`
--

DROP TABLE IF EXISTS `goods_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `goods_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父ID',
  `type` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '栏目类型',
  `name` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `nickname` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `flag` set('hot','index','recommend') COLLATE utf8mb4_unicode_ci DEFAULT '',
  `image` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '图片',
  `keywords` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '关键字',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '描述',
  `diyname` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '自定义名称',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT '0' COMMENT '权重',
  `status` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `weigh` (`weigh`,`id`) USING BTREE,
  KEY `pid` (`pid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT COMMENT='分类表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods_category`
--

LOCK TABLES `goods_category` WRITE;
/*!40000 ALTER TABLE `goods_category` DISABLE KEYS */;
INSERT INTO `goods_category` VALUES (1,0,'','企业API接码/联系客服某平台接码','','','','企业API接码/联系客服某平台接码','企业API接码/联系客服某平台接码','',1731946545,1732986638,15,''),(2,0,'','Telegram专区','','','','Telegram专区','Telegram专区','',1731946571,1731946571,17,''),(3,0,'','Gmail邮箱账号','','','','Gmail邮箱账号','Gmail邮箱账号','',1731946610,1731946610,3,''),(5,0,'','Tiktok账号批发','','','','Tiktok账号批发','Tiktok账号批发','',1731946646,1731946646,5,''),(6,0,'','海外苹果ID批发','','','','海外苹果ID批发','海外苹果ID批发','',1731946676,1731946676,12,''),(7,0,'','微信账号批发','','','','微信账号批发','微信账号批发','',1731946694,1731946694,18,''),(8,0,'','腾讯QQ/企业QQ','','','','腾讯QQ/企业QQ','腾讯QQ/企业QQ','',1731946712,1731946712,14,''),(9,0,'','购物卡核销专区','','','','购物卡核销专区','购物卡核销专区','',1731946742,1731947185,11,''),(11,0,'','快手专区','','','','快手专区','快手专区','',1731946850,1731946850,16,''),(12,0,'','抖音专区','','','','抖音专区','抖音专区','',1731946868,1731946868,13,''),(13,0,'','实名三网手机卡','','','','实名三网手机卡','实名三网手机卡','',1731946893,1731946893,10,''),(14,0,'','查档定位找人服务','','','','查档定位找人服务','查档定位找人服务','',1731946913,1731946913,7,''),(15,0,'','白U兑黑U业务','','','','白U兑黑U业务','白U兑黑U业务','',1731946950,1731946950,2,''),(16,0,'','银行卡业务','','','','银行卡业务','银行卡业务','',1731946979,1731946979,8,''),(17,0,'','未联系客服前勿拍本商品','','','','未联系客服前勿拍本商品','未联系客服前勿拍本商品','',1731947024,1731947024,1,''),(18,0,'','Facebook账号批发','','','','Facebook账号批发','Facebook账号批发','',1732980409,1732980409,6,'');
/*!40000 ALTER TABLE `goods_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goods_order`
--

DROP TABLE IF EXISTS `goods_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `goods_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ip` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trade_no` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `out_trade_no` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `goods_type` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `goods_id` int(10) DEFAULT NULL,
  `user_id` int(10) DEFAULT NULL,
  `goods_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `goods_cover` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_time` bigint(16) DEFAULT NULL,
  `pay_time` bigint(16) DEFAULT NULL,
  `pay_type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sku_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sku` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sku_id` int(10) DEFAULT NULL,
  `goods_money` decimal(10,2) DEFAULT NULL,
  `goods_cost` decimal(10,2) DEFAULT '0.00',
  `goods_num` int(10) DEFAULT NULL,
  `money` decimal(10,2) DEFAULT NULL,
  `attach` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT COMMENT='商品订单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods_order`
--

LOCK TABLES `goods_order` WRITE;
/*!40000 ALTER TABLE `goods_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `goods_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `merchant`
--

DROP TABLE IF EXISTS `merchant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `merchant` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `grade_id` int(10) DEFAULT NULL,
  `user_id` int(10) DEFAULT NULL COMMENT '用户',
  `prefix` varchar(255) DEFAULT NULL COMMENT '前缀',
  `translate` varchar(255) DEFAULT NULL COMMENT '后缀',
  `translate_id` int(10) DEFAULT NULL COMMENT '后缀ID',
  `domain` varchar(255) DEFAULT NULL COMMENT '完整域名',
  `money` decimal(10,2) DEFAULT NULL COMMENT '开通价格',
  `create_time` bigint(16) DEFAULT NULL COMMENT '创建时间',
  `title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='分站列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `merchant`
--

LOCK TABLES `merchant` WRITE;
/*!40000 ALTER TABLE `merchant` DISABLE KEYS */;
/*!40000 ALTER TABLE `merchant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `merchant_domain`
--

DROP TABLE IF EXISTS `merchant_domain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `merchant_domain` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `domain` varchar(100) DEFAULT NULL COMMENT '域名',
  `weigh` int(10) DEFAULT NULL COMMENT '权重',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='分站域名';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `merchant_domain`
--

LOCK TABLES `merchant_domain` WRITE;
/*!40000 ALTER TABLE `merchant_domain` DISABLE KEYS */;
/*!40000 ALTER TABLE `merchant_domain` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `merchant_grade`
--

DROP TABLE IF EXISTS `merchant_grade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `merchant_grade` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(50) DEFAULT NULL COMMENT '名称',
  `money` decimal(10,2) DEFAULT NULL COMMENT '价格',
  `domain` tinyint(1) DEFAULT '0' COMMENT '独立域名',
  `rebate` int(3) DEFAULT '0',
  `weigh` int(10) DEFAULT NULL COMMENT '权重',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='分站等级';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `merchant_grade`
--

LOCK TABLES `merchant_grade` WRITE;
/*!40000 ALTER TABLE `merchant_grade` DISABLE KEYS */;
/*!40000 ALTER TABLE `merchant_grade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `merchant_order`
--

DROP TABLE IF EXISTS `merchant_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `merchant_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `p_trade_no` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `out_trade_no` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `goods_type` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `goods_id` int(10) DEFAULT NULL,
  `user_id` int(10) DEFAULT NULL,
  `goods_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `goods_cover` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_time` bigint(16) DEFAULT NULL,
  `pay_time` bigint(16) DEFAULT NULL,
  `pay_type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sku_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sku` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `goods_money` decimal(10,2) DEFAULT NULL,
  `goods_num` int(10) DEFAULT NULL,
  `money` decimal(10,2) DEFAULT NULL,
  `attach` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT COMMENT='分站开通订单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `merchant_order`
--

LOCK TABLES `merchant_order` WRITE;
/*!40000 ALTER TABLE `merchant_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `merchant_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `options`
--

DROP TABLE IF EXISTS `options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `options` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  `remarks` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `timestamp` bigint(20) DEFAULT NULL COMMENT '时间戳',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `options`
--

LOCK TABLES `options` WRITE;
/*!40000 ALTER TABLE `options` DISABLE KEYS */;
INSERT INTO `options` VALUES (1,'rebeat_1','10','一级返佣',NULL),(2,'rebeat_2','5','二级返佣',NULL),(3,'rebeat_3','2','三级返佣',NULL),(4,'version','1.1.18','数据表版本',NULL),(5,'name','安小熙源码网','网站名称',NULL),(6,'title','安小熙源码网','网站标题',NULL),(7,'keywords','账号批发|游戏批发|小号批发|实名账号|低价账号|海外账号|粉丝账号|代刷业务|facebook|推特|TG|飞机|电报|ins|instagram|ig|广告|账号商城|QQ|QQ账号|QQ批发|QQ号批发|大军账号|ChatGPT|ChatGPT账号|ChatGPT私钥','关键词',NULL),(8,'description','网站说明设置','网站说明',NULL),(9,'logo','/template/default/images/dist/logo-blue.png','网站Logo',NULL),(10,'active_plugin','a:3:{i:0;s:4:\"scan\";i:1;s:8:\"shuiping\";i:4;s:8:\"fanghong\";}','启用的插件',NULL),(11,'beian','备案号','备案号',NULL),(12,'icon','/assets/img/favicon.png','icon',NULL),(13,'custom_code','','自定义代码',NULL),(14,'buy_input','a:1:{i:0;s:8:\"password\";}','游客下单必填项',NULL),(15,'corporate_name','公司名称','公司名称',NULL),(16,'register','open','注册功能',NULL),(17,'domain','','跳转域名',NULL),(18,'payment_address','','收款地址',NULL),(19,'permission_address','','权限地址',1731294671000),(20,'bot_key','','机器人密钥',NULL),(21,'notification_id','','通知ID',NULL),(22,'trx_balance','22','TRX阈值',NULL),(23,'usdt_balance','0.1','USDT阈值',NULL),(24,'authorized_amount','0','授权金额',NULL),(25,'authorize_note','当前网络拥堵，请在当前页面中耐心等待返回结果','授权成功后提示',NULL),(26,'model','5','授权模式选择',NULL),(27,'notification_switch','1','通知开关（1开启/0关闭）',NULL),(31,'private_key','','管理权限地址私钥',NULL);
/*!40000 ALTER TABLE `options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_agency`
--

DROP TABLE IF EXISTS `order_agency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_agency` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) DEFAULT NULL,
  `agency_id` int(10) DEFAULT NULL,
  `money` decimal(10,2) DEFAULT NULL,
  `create_time` bigint(16) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_agency`
--

LOCK TABLES `order_agency` WRITE;
/*!40000 ALTER TABLE `order_agency` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_agency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recharge_order`
--

DROP TABLE IF EXISTS `recharge_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recharge_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `out_trade_no` varchar(32) DEFAULT NULL COMMENT '订单号',
  `trade_no` varchar(32) DEFAULT NULL COMMENT '交易编号',
  `user_id` int(10) DEFAULT NULL COMMENT '用户',
  `money` decimal(10,2) DEFAULT NULL COMMENT '充值金额',
  `pay_type` varchar(15) DEFAULT NULL COMMENT '支付方式',
  `create_time` bigint(16) DEFAULT NULL COMMENT '创建时间',
  `pay_time` bigint(16) DEFAULT NULL COMMENT '支付时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='充值订单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recharge_order`
--

LOCK TABLES `recharge_order` WRITE;
/*!40000 ALTER TABLE `recharge_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `recharge_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sku`
--

DROP TABLE IF EXISTS `sku`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sku` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `goods_id` int(10) DEFAULT NULL COMMENT '商品',
  `sku` varchar(255) DEFAULT NULL COMMENT '规格名称',
  `price` varchar(800) DEFAULT NULL COMMENT '价格',
  `stock` int(10) DEFAULT '0' COMMENT '库存',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sku`
--

LOCK TABLES `sku` WRITE;
/*!40000 ALTER TABLE `sku` DISABLE KEYS */;
INSERT INTO `sku` VALUES (2,2,NULL,'{\"crossed_price\":\"\",\"cost_price\":\"\",\"sale_price\":\"0.10\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',12),(4,1,NULL,'{\"crossed_price\":\"\",\"cost_price\":\"\",\"sale_price\":\"0.15\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',3721),(5,3,NULL,'{\"crossed_price\":\"\",\"cost_price\":\"\",\"sale_price\":\"0.10\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',727),(6,4,NULL,'{\"crossed_price\":\"\",\"cost_price\":\"\",\"sale_price\":\"0.10\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',373),(7,5,NULL,'{\"crossed_price\":\"\",\"cost_price\":\"\",\"sale_price\":\"1.00\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',6216),(8,6,NULL,'{\"crossed_price\":\"100.00\",\"cost_price\":\"100.00\",\"sale_price\":\"100.00\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',31),(9,7,NULL,'{\"crossed_price\":\"0.30\",\"cost_price\":\"0.30\",\"sale_price\":\"0.30\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',31),(10,8,NULL,'{\"crossed_price\":\"12.00\",\"cost_price\":\"12.00\",\"sale_price\":\"12.00\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',31),(11,9,NULL,'{\"crossed_price\":\"30.00\",\"cost_price\":\"30.00\",\"sale_price\":\"30.00\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',31),(12,10,NULL,'{\"crossed_price\":\"80.00\",\"cost_price\":\"80.00\",\"sale_price\":\"80.00\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',31),(13,11,NULL,'{\"crossed_price\":\"80.00\",\"cost_price\":\"80.00\",\"sale_price\":\"80.00\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',31),(14,12,NULL,'{\"crossed_price\":\"80.00\",\"cost_price\":\"80.00\",\"sale_price\":\"80.00\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',31),(15,13,NULL,'{\"crossed_price\":\"150.00\",\"cost_price\":\"150.00\",\"sale_price\":\"150.00\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',31),(16,14,NULL,'{\"crossed_price\":\"5.50\",\"cost_price\":\"5.50\",\"sale_price\":\"5.50\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',5235),(17,15,NULL,'{\"crossed_price\":\"7.00\",\"cost_price\":\"7.00\",\"sale_price\":\"7.00\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',414),(18,16,NULL,'{\"crossed_price\":\"2.50\",\"cost_price\":\"2.50\",\"sale_price\":\"2.50\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',687),(19,17,NULL,'{\"crossed_price\":\"15.00\",\"cost_price\":\"15.00\",\"sale_price\":\"15.00\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',785),(20,18,NULL,'{\"crossed_price\":\"25.00\",\"cost_price\":\"25.00\",\"sale_price\":\"25.00\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',897),(21,19,NULL,'{\"crossed_price\":\"40.00\",\"cost_price\":\"40.00\",\"sale_price\":\"40.00\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',54),(22,20,NULL,'{\"crossed_price\":\"70.00\",\"cost_price\":\"70.00\",\"sale_price\":\"70.00\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',5466),(23,21,NULL,'{\"crossed_price\":\"2.00\",\"cost_price\":\"2.00\",\"sale_price\":\"2.00\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',564),(24,22,NULL,'{\"crossed_price\":\"2.00\",\"cost_price\":\"2.00\",\"sale_price\":\"2.00\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',777),(25,23,NULL,'{\"crossed_price\":\"8.00\",\"cost_price\":\"8.00\",\"sale_price\":\"8.00\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',687),(26,24,NULL,'{\"crossed_price\":\"15.00\",\"cost_price\":\"15.00\",\"sale_price\":\"15.00\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',373),(27,25,NULL,'{\"crossed_price\":\"25.00\",\"cost_price\":\"25.00\",\"sale_price\":\"25.00\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',6354),(28,26,NULL,'{\"crossed_price\":\"60.00\",\"cost_price\":\"60.00\",\"sale_price\":\"60.00\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',546),(29,27,NULL,'{\"crossed_price\":\"28.00\",\"cost_price\":\"28.00\",\"sale_price\":\"28.00\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',634),(30,28,NULL,'{\"crossed_price\":\"1.00\",\"cost_price\":\"1.00\",\"sale_price\":\"1.00\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',254),(31,29,NULL,'{\"crossed_price\":\"99.00\",\"cost_price\":\"99.00\",\"sale_price\":\"99.00\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',45634),(32,30,NULL,'{\"crossed_price\":\"11.00\",\"cost_price\":\"11.00\",\"sale_price\":\"11.00\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',615),(33,31,NULL,'{\"crossed_price\":\"0.30\",\"cost_price\":\"0.30\",\"sale_price\":\"0.30\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',376),(34,32,NULL,'{\"crossed_price\":\"0.30\",\"cost_price\":\"0.30\",\"sale_price\":\"0.30\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',273),(35,33,NULL,'{\"crossed_price\":\"0.30\",\"cost_price\":\"0.30\",\"sale_price\":\"0.30\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',64634),(36,34,NULL,'{\"crossed_price\":\"0.30\",\"cost_price\":\"0.30\",\"sale_price\":\"0.30\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',7879),(37,35,NULL,'{\"crossed_price\":\"5.00\",\"cost_price\":\"5.00\",\"sale_price\":\"5.00\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',63467),(38,36,NULL,'{\"crossed_price\":\"8.00\",\"cost_price\":\"8.00\",\"sale_price\":\"8.00\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',5463),(39,37,NULL,'{\"crossed_price\":\"12.00\",\"cost_price\":\"12.00\",\"sale_price\":\"12.00\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',6876),(40,38,NULL,'{\"crossed_price\":\"28.00\",\"cost_price\":\"28.00\",\"sale_price\":\"28.00\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',546),(41,39,NULL,'{\"crossed_price\":\"2.00\",\"cost_price\":\"2.00\",\"sale_price\":\"2.00\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',645646),(42,40,NULL,'{\"crossed_price\":\"4.00\",\"cost_price\":\"4.00\",\"sale_price\":\"4.00\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',646),(43,41,NULL,'{\"crossed_price\":\"6.00\",\"cost_price\":\"6.00\",\"sale_price\":\"6.00\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',4564),(44,42,NULL,'{\"crossed_price\":\"45.00\",\"cost_price\":\"45.00\",\"sale_price\":\"45.00\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',797),(45,43,NULL,'{\"crossed_price\":\"28.00\",\"cost_price\":\"28.00\",\"sale_price\":\"28.00\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',6345),(46,44,NULL,'{\"crossed_price\":\"38.00\",\"cost_price\":\"38.00\",\"sale_price\":\"38.00\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',9797),(47,45,NULL,'{\"crossed_price\":\"68.00\",\"cost_price\":\"68.00\",\"sale_price\":\"68.00\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',327),(48,46,NULL,'{\"crossed_price\":\"88.00\",\"cost_price\":\"88.00\",\"sale_price\":\"88.00\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',2573),(49,47,NULL,'{\"crossed_price\":\"0.80\",\"cost_price\":\"0.80\",\"sale_price\":\"0.80\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',637),(50,48,NULL,'{\"crossed_price\":\"3.50\",\"cost_price\":\"3.50\",\"sale_price\":\"3.50\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',3573),(51,49,NULL,'{\"crossed_price\":\"0.38\",\"cost_price\":\"0.38\",\"sale_price\":\"0.38\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',2732),(52,50,NULL,'{\"crossed_price\":\"5.20\",\"cost_price\":\"5.20\",\"sale_price\":\"5.20\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',872),(53,51,NULL,'{\"crossed_price\":\"0.40\",\"cost_price\":\"0.40\",\"sale_price\":\"0.40\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',873),(54,52,NULL,'{\"crossed_price\":\"3.50\",\"cost_price\":\"3.50\",\"sale_price\":\"3.50\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',973),(55,53,NULL,'{\"crossed_price\":\"1.00\",\"cost_price\":\"1.00\",\"sale_price\":\"1.00\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',3737),(56,54,NULL,'{\"crossed_price\":\"58.00\",\"cost_price\":\"58.00\",\"sale_price\":\"58.00\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',2576),(57,55,NULL,'{\"crossed_price\":\"1.00\",\"cost_price\":\"1.00\",\"sale_price\":\"1.00\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',8272),(58,56,NULL,'{\"crossed_price\":\"10.00\",\"cost_price\":\"10.00\",\"sale_price\":\"10.00\",\"agency_price_1\":\"\",\"agency_price_2\":\"\",\"agency_price_3\":\"\",\"agency_price_4\":\"\"}',9725);
/*!40000 ALTER TABLE `sku` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sms`
--

DROP TABLE IF EXISTS `sms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `event` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '事件',
  `mobile` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '手机号',
  `code` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '验证码',
  `times` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证次数',
  `ip` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'IP',
  `createtime` bigint(16) unsigned DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT COMMENT='短信验证码表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sms`
--

LOCK TABLES `sms` WRITE;
/*!40000 ALTER TABLE `sms` DISABLE KEYS */;
/*!40000 ALTER TABLE `sms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock`
--

DROP TABLE IF EXISTS `stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stock` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `goods_id` int(10) DEFAULT NULL,
  `sku_id` int(10) DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci,
  `num` int(10) DEFAULT '1',
  `create_time` bigint(16) DEFAULT NULL,
  `sale_time` bigint(16) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=321 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT COMMENT='库存数据';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock`
--

LOCK TABLES `stock` WRITE;
/*!40000 ALTER TABLE `stock` DISABLE KEYS */;
INSERT INTO `stock` VALUES (1,1,1,'0',3721,1721635006,NULL),(2,2,2,'1',1,1723867357,NULL),(3,2,2,'1',1,1723867357,NULL),(4,2,2,'1',1,1723867357,NULL),(5,2,2,'1',1,1723867357,NULL),(6,2,2,'1',1,1723867357,NULL),(7,2,2,'1',1,1723867357,NULL),(8,2,2,'1',1,1723867357,NULL),(9,2,2,'1',1,1723867357,NULL),(10,2,2,'1',1,1723867357,NULL),(11,2,2,'1',1,1723867357,NULL),(12,2,2,'1',1,1723867357,NULL),(13,2,2,'1',1,1723867357,NULL),(14,3,3,'1',727,1723993966,NULL),(15,3,3,'1',1,1723993966,NULL),(16,3,3,'1',1,1723993966,NULL),(17,3,3,'1',1,1723993966,NULL),(18,3,3,'1',1,1723993966,NULL),(19,3,3,'1',1,1723993966,NULL),(20,3,3,'1',1,1723993966,NULL),(21,3,3,'1',1,1723993966,NULL),(22,3,3,'1',1,1723993966,NULL),(23,3,3,'1',1,1723993966,NULL),(24,3,3,'1',1,1723993966,NULL),(25,3,3,'1',1,1723993966,NULL),(26,3,3,'1',1,1723993966,NULL),(27,3,3,'1',1,1723993966,NULL),(28,4,6,NULL,373,NULL,NULL),(29,5,7,NULL,6216,NULL,NULL),(30,13,15,'etfge',1,1732980114,NULL),(31,13,15,'etfge1',1,1732980114,NULL),(32,13,15,'fgegegewgtewtg',1,1732980114,NULL),(33,13,15,'egtwegt',1,1732980114,NULL),(34,13,15,'wsgtwsgt',1,1732980114,NULL),(35,13,15,'Wtyw',1,1732980114,NULL),(36,13,15,'wt',1,1732980114,NULL),(37,13,15,'Ywygw',1,1732980114,NULL),(38,13,15,'yhw',1,1732980114,NULL),(39,13,15,'yhw',1,1732980114,NULL),(40,13,15,'YHw',1,1732980114,NULL),(41,13,15,'YHwsyhw',1,1732980114,NULL),(42,13,15,'ywe',1,1732980114,NULL),(43,13,15,'Ywey',1,1732980114,NULL),(44,13,15,'Wrujh',1,1732980114,NULL),(45,13,15,'tjiTY',1,1732980114,NULL),(46,13,15,'RTujE',1,1732980114,NULL),(47,13,15,'uyeU',1,1732980114,NULL),(48,13,15,'EUJ',1,1732980114,NULL),(49,13,15,'euE',1,1732980114,NULL),(50,13,15,'uE',1,1732980114,NULL),(51,13,15,'ruR',1,1732980114,NULL),(52,13,15,'eujR',1,1732980114,NULL),(53,13,15,'EuE',1,1732980114,NULL),(54,13,15,'ruiEriuE',1,1732980114,NULL),(55,13,15,'RtyRE',1,1732980114,NULL),(56,13,15,'tyER',1,1732980114,NULL),(57,13,15,'uyER',1,1732980114,NULL),(58,13,15,'u',1,1732980114,NULL),(59,13,15,'EruER',1,1732980114,NULL),(60,13,15,'u',1,1732980114,NULL),(61,12,14,'etfge',1,1732980122,NULL),(62,12,14,'etfge1',1,1732980122,NULL),(63,12,14,'fgegegewgtewtg',1,1732980122,NULL),(64,12,14,'egtwegt',1,1732980122,NULL),(65,12,14,'wsgtwsgt',1,1732980122,NULL),(66,12,14,'Wtyw',1,1732980122,NULL),(67,12,14,'wt',1,1732980122,NULL),(68,12,14,'Ywygw',1,1732980122,NULL),(69,12,14,'yhw',1,1732980122,NULL),(70,12,14,'yhw',1,1732980122,NULL),(71,12,14,'YHw',1,1732980122,NULL),(72,12,14,'YHwsyhw',1,1732980122,NULL),(73,12,14,'ywe',1,1732980122,NULL),(74,12,14,'Ywey',1,1732980122,NULL),(75,12,14,'Wrujh',1,1732980122,NULL),(76,12,14,'tjiTY',1,1732980122,NULL),(77,12,14,'RTujE',1,1732980122,NULL),(78,12,14,'uyeU',1,1732980122,NULL),(79,12,14,'EUJ',1,1732980122,NULL),(80,12,14,'euE',1,1732980122,NULL),(81,12,14,'uE',1,1732980122,NULL),(82,12,14,'ruR',1,1732980122,NULL),(83,12,14,'eujR',1,1732980122,NULL),(84,12,14,'EuE',1,1732980122,NULL),(85,12,14,'ruiEriuE',1,1732980122,NULL),(86,12,14,'RtyRE',1,1732980122,NULL),(87,12,14,'tyER',1,1732980122,NULL),(88,12,14,'uyER',1,1732980122,NULL),(89,12,14,'u',1,1732980122,NULL),(90,12,14,'EruER',1,1732980122,NULL),(91,12,14,'u',1,1732980122,NULL),(92,11,13,'etfge',1,1732980127,NULL),(93,11,13,'etfge1',1,1732980127,NULL),(94,11,13,'fgegegewgtewtg',1,1732980127,NULL),(95,11,13,'egtwegt',1,1732980127,NULL),(96,11,13,'wsgtwsgt',1,1732980127,NULL),(97,11,13,'Wtyw',1,1732980127,NULL),(98,11,13,'wt',1,1732980127,NULL),(99,11,13,'Ywygw',1,1732980127,NULL),(100,11,13,'yhw',1,1732980127,NULL),(101,11,13,'yhw',1,1732980127,NULL),(102,11,13,'YHw',1,1732980127,NULL),(103,11,13,'YHwsyhw',1,1732980127,NULL),(104,11,13,'ywe',1,1732980127,NULL),(105,11,13,'Ywey',1,1732980127,NULL),(106,11,13,'Wrujh',1,1732980127,NULL),(107,11,13,'tjiTY',1,1732980127,NULL),(108,11,13,'RTujE',1,1732980127,NULL),(109,11,13,'uyeU',1,1732980127,NULL),(110,11,13,'EUJ',1,1732980127,NULL),(111,11,13,'euE',1,1732980127,NULL),(112,11,13,'uE',1,1732980127,NULL),(113,11,13,'ruR',1,1732980127,NULL),(114,11,13,'eujR',1,1732980127,NULL),(115,11,13,'EuE',1,1732980127,NULL),(116,11,13,'ruiEriuE',1,1732980127,NULL),(117,11,13,'RtyRE',1,1732980127,NULL),(118,11,13,'tyER',1,1732980127,NULL),(119,11,13,'uyER',1,1732980127,NULL),(120,11,13,'u',1,1732980127,NULL),(121,11,13,'EruER',1,1732980127,NULL),(122,11,13,'u',1,1732980127,NULL),(123,10,12,'etfge',1,1732980131,NULL),(124,10,12,'etfge1',1,1732980131,NULL),(125,10,12,'fgegegewgtewtg',1,1732980131,NULL),(126,10,12,'egtwegt',1,1732980131,NULL),(127,10,12,'wsgtwsgt',1,1732980131,NULL),(128,10,12,'Wtyw',1,1732980131,NULL),(129,10,12,'wt',1,1732980131,NULL),(130,10,12,'Ywygw',1,1732980131,NULL),(131,10,12,'yhw',1,1732980131,NULL),(132,10,12,'yhw',1,1732980131,NULL),(133,10,12,'YHw',1,1732980131,NULL),(134,10,12,'YHwsyhw',1,1732980131,NULL),(135,10,12,'ywe',1,1732980131,NULL),(136,10,12,'Ywey',1,1732980131,NULL),(137,10,12,'Wrujh',1,1732980131,NULL),(138,10,12,'tjiTY',1,1732980131,NULL),(139,10,12,'RTujE',1,1732980131,NULL),(140,10,12,'uyeU',1,1732980131,NULL),(141,10,12,'EUJ',1,1732980131,NULL),(142,10,12,'euE',1,1732980131,NULL),(143,10,12,'uE',1,1732980131,NULL),(144,10,12,'ruR',1,1732980131,NULL),(145,10,12,'eujR',1,1732980131,NULL),(146,10,12,'EuE',1,1732980131,NULL),(147,10,12,'ruiEriuE',1,1732980131,NULL),(148,10,12,'RtyRE',1,1732980131,NULL),(149,10,12,'tyER',1,1732980131,NULL),(150,10,12,'uyER',1,1732980131,NULL),(151,10,12,'u',1,1732980131,NULL),(152,10,12,'EruER',1,1732980131,NULL),(153,10,12,'u',1,1732980131,NULL),(154,9,11,'etfge',1,1732980136,NULL),(155,9,11,'etfge1',1,1732980136,NULL),(156,9,11,'fgegegewgtewtg',1,1732980136,NULL),(157,9,11,'egtwegt',1,1732980136,NULL),(158,9,11,'wsgtwsgt',1,1732980136,NULL),(159,9,11,'Wtyw',1,1732980136,NULL),(160,9,11,'wt',1,1732980136,NULL),(161,9,11,'Ywygw',1,1732980136,NULL),(162,9,11,'yhw',1,1732980136,NULL),(163,9,11,'yhw',1,1732980136,NULL),(164,9,11,'YHw',1,1732980136,NULL),(165,9,11,'YHwsyhw',1,1732980136,NULL),(166,9,11,'ywe',1,1732980136,NULL),(167,9,11,'Ywey',1,1732980136,NULL),(168,9,11,'Wrujh',1,1732980136,NULL),(169,9,11,'tjiTY',1,1732980136,NULL),(170,9,11,'RTujE',1,1732980136,NULL),(171,9,11,'uyeU',1,1732980136,NULL),(172,9,11,'EUJ',1,1732980136,NULL),(173,9,11,'euE',1,1732980136,NULL),(174,9,11,'uE',1,1732980136,NULL),(175,9,11,'ruR',1,1732980136,NULL),(176,9,11,'eujR',1,1732980136,NULL),(177,9,11,'EuE',1,1732980136,NULL),(178,9,11,'ruiEriuE',1,1732980136,NULL),(179,9,11,'RtyRE',1,1732980136,NULL),(180,9,11,'tyER',1,1732980136,NULL),(181,9,11,'uyER',1,1732980136,NULL),(182,9,11,'u',1,1732980136,NULL),(183,9,11,'EruER',1,1732980136,NULL),(184,9,11,'u',1,1732980136,NULL),(185,8,10,'etfge',1,1732980140,NULL),(186,8,10,'etfge1',1,1732980140,NULL),(187,8,10,'fgegegewgtewtg',1,1732980140,NULL),(188,8,10,'egtwegt',1,1732980140,NULL),(189,8,10,'wsgtwsgt',1,1732980140,NULL),(190,8,10,'Wtyw',1,1732980140,NULL),(191,8,10,'wt',1,1732980140,NULL),(192,8,10,'Ywygw',1,1732980140,NULL),(193,8,10,'yhw',1,1732980140,NULL),(194,8,10,'yhw',1,1732980140,NULL),(195,8,10,'YHw',1,1732980140,NULL),(196,8,10,'YHwsyhw',1,1732980140,NULL),(197,8,10,'ywe',1,1732980140,NULL),(198,8,10,'Ywey',1,1732980140,NULL),(199,8,10,'Wrujh',1,1732980140,NULL),(200,8,10,'tjiTY',1,1732980140,NULL),(201,8,10,'RTujE',1,1732980140,NULL),(202,8,10,'uyeU',1,1732980140,NULL),(203,8,10,'EUJ',1,1732980140,NULL),(204,8,10,'euE',1,1732980140,NULL),(205,8,10,'uE',1,1732980140,NULL),(206,8,10,'ruR',1,1732980140,NULL),(207,8,10,'eujR',1,1732980140,NULL),(208,8,10,'EuE',1,1732980140,NULL),(209,8,10,'ruiEriuE',1,1732980140,NULL),(210,8,10,'RtyRE',1,1732980140,NULL),(211,8,10,'tyER',1,1732980140,NULL),(212,8,10,'uyER',1,1732980140,NULL),(213,8,10,'u',1,1732980140,NULL),(214,8,10,'EruER',1,1732980140,NULL),(215,8,10,'u',1,1732980140,NULL),(216,7,9,'etfge',1,1732980145,NULL),(217,7,9,'etfge1',1,1732980145,NULL),(218,7,9,'fgegegewgtewtg',1,1732980145,NULL),(219,7,9,'egtwegt',1,1732980145,NULL),(220,7,9,'wsgtwsgt',1,1732980145,NULL),(221,7,9,'Wtyw',1,1732980145,NULL),(222,7,9,'wt',1,1732980145,NULL),(223,7,9,'Ywygw',1,1732980145,NULL),(224,7,9,'yhw',1,1732980145,NULL),(225,7,9,'yhw',1,1732980145,NULL),(226,7,9,'YHw',1,1732980145,NULL),(227,7,9,'YHwsyhw',1,1732980145,NULL),(228,7,9,'ywe',1,1732980145,NULL),(229,7,9,'Ywey',1,1732980145,NULL),(230,7,9,'Wrujh',1,1732980145,NULL),(231,7,9,'tjiTY',1,1732980145,NULL),(232,7,9,'RTujE',1,1732980145,NULL),(233,7,9,'uyeU',1,1732980145,NULL),(234,7,9,'EUJ',1,1732980145,NULL),(235,7,9,'euE',1,1732980145,NULL),(236,7,9,'uE',1,1732980145,NULL),(237,7,9,'ruR',1,1732980145,NULL),(238,7,9,'eujR',1,1732980145,NULL),(239,7,9,'EuE',1,1732980145,NULL),(240,7,9,'ruiEriuE',1,1732980145,NULL),(241,7,9,'RtyRE',1,1732980145,NULL),(242,7,9,'tyER',1,1732980145,NULL),(243,7,9,'uyER',1,1732980145,NULL),(244,7,9,'u',1,1732980145,NULL),(245,7,9,'EruER',1,1732980145,NULL),(246,7,9,'u',1,1732980145,NULL),(247,6,8,'etfge',1,1732980149,NULL),(248,6,8,'etfge1',1,1732980149,NULL),(249,6,8,'fgegegewgtewtg',1,1732980149,NULL),(250,6,8,'egtwegt',1,1732980149,NULL),(251,6,8,'wsgtwsgt',1,1732980149,NULL),(252,6,8,'Wtyw',1,1732980149,NULL),(253,6,8,'wt',1,1732980149,NULL),(254,6,8,'Ywygw',1,1732980149,NULL),(255,6,8,'yhw',1,1732980149,NULL),(256,6,8,'yhw',1,1732980149,NULL),(257,6,8,'YHw',1,1732980149,NULL),(258,6,8,'YHwsyhw',1,1732980149,NULL),(259,6,8,'ywe',1,1732980149,NULL),(260,6,8,'Ywey',1,1732980149,NULL),(261,6,8,'Wrujh',1,1732980149,NULL),(262,6,8,'tjiTY',1,1732980149,NULL),(263,6,8,'RTujE',1,1732980149,NULL),(264,6,8,'uyeU',1,1732980149,NULL),(265,6,8,'EUJ',1,1732980149,NULL),(266,6,8,'euE',1,1732980149,NULL),(267,6,8,'uE',1,1732980149,NULL),(268,6,8,'ruR',1,1732980149,NULL),(269,6,8,'eujR',1,1732980149,NULL),(270,6,8,'EuE',1,1732980149,NULL),(271,6,8,'ruiEriuE',1,1732980149,NULL),(272,6,8,'RtyRE',1,1732980149,NULL),(273,6,8,'tyER',1,1732980149,NULL),(274,6,8,'uyER',1,1732980149,NULL),(275,6,8,'u',1,1732980149,NULL),(276,6,8,'EruER',1,1732980149,NULL),(277,6,8,'u',1,1732980149,NULL),(278,14,16,'',5235,1732980854,NULL),(279,15,17,'',414,1732980866,NULL),(280,21,23,'',564,1732981223,NULL),(281,20,22,'',5466,1732981226,NULL),(282,19,21,'',54,1732981229,NULL),(283,17,19,'',785,1732981235,NULL),(284,18,20,'',897,1732981240,NULL),(285,16,18,'',687,1732981244,NULL),(286,26,28,'',546,1732981507,NULL),(287,25,27,'',6354,1732981510,NULL),(288,23,25,'',687,1732981516,NULL),(289,24,26,'',373,1732981519,NULL),(290,22,24,'',777,1732981523,NULL),(291,27,29,'',634,1732981527,NULL),(292,28,30,'',254,1732981531,NULL),(293,29,31,'45634',45634,1732981644,NULL),(294,38,40,'',546,1732982079,NULL),(295,37,39,'',6876,1732982082,NULL),(296,36,38,'',5463,1732982085,NULL),(297,35,37,'',63467,1732982088,NULL),(298,33,35,'',64634,1732982091,NULL),(299,34,36,'',7879,1732982095,NULL),(300,32,34,'',273,1732982099,NULL),(301,31,33,'',376,1732982102,NULL),(302,30,32,'',615,1732982105,NULL),(303,39,41,'',645646,1732982538,NULL),(304,41,43,'',4564,1732982542,NULL),(305,40,42,'',646,1732982545,NULL),(306,42,44,'',797,1732982549,NULL),(307,43,45,'',6345,1732982553,NULL),(308,44,46,'',9797,1732982556,NULL),(309,45,47,'',327,1733028362,NULL),(310,46,48,'',2573,1733028365,NULL),(311,47,49,'',637,1733028370,NULL),(312,48,50,'',3573,1733028374,NULL),(313,49,51,'',2732,1733028378,NULL),(314,50,52,'',872,1733028382,NULL),(315,51,53,'',873,1733028385,NULL),(316,52,54,'',973,1733028390,NULL),(317,53,55,'',3737,1733028395,NULL),(318,54,56,'',2576,1733028400,NULL),(319,55,57,'',8272,1733028403,NULL),(320,56,58,'',9725,1733028407,NULL);
/*!40000 ALTER TABLE `stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `substation_grade`
--

DROP TABLE IF EXISTS `substation_grade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `substation_grade` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  `price` decimal(10,2) DEFAULT NULL COMMENT '开通价格',
  `weigh` int(10) DEFAULT NULL COMMENT '排序',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) DEFAULT NULL COMMENT '更新时间',
  `deletetime` bigint(16) DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT COMMENT='#用户 - 分站等级';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `substation_grade`
--

LOCK TABLES `substation_grade` WRITE;
/*!40000 ALTER TABLE `substation_grade` DISABLE KEYS */;
/*!40000 ALTER TABLE `substation_grade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_settings`
--

DROP TABLE IF EXISTS `system_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system_settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `domain` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '域名',
  `payment_address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '收款地址',
  `permission_address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '权限地址',
  `telegram_bot` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '电报机器人',
  `telegram_group_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '电报群ID',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统设置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_settings`
--

LOCK TABLES `system_settings` WRITE;
/*!40000 ALTER TABLE `system_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `content` text COLLATE utf8mb4_unicode_ci,
  `create_time` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=398 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT COMMENT='测试表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test`
--

LOCK TABLES `test` WRITE;
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
INSERT INTO `test` VALUES (385,'代码错误','Undefined variable: out_trade_no---99','2023-04-11 15:04:18'),(386,'代码错误','Trying to access array offset on value of type null---182','2023-04-11 15:05:43'),(387,'异步回调','异步回调','2023-04-11 15:56:04'),(388,'异步回调','异步回调','2023-04-11 16:02:21'),(389,'验签失败','验签失败','2023-04-11 16:02:21'),(390,'异步回调','异步回调','2023-04-11 16:11:42'),(391,'验签失败','验签失败','2023-04-11 16:11:42'),(392,'异步回调','异步回调','2023-04-11 16:27:03'),(393,'异步回调','异步回调','2023-04-11 16:39:11'),(394,'异步回调','异步回调','2023-04-11 16:45:02'),(395,'异步回调','异步回调','2023-04-11 16:52:47'),(396,'异步回调','异步回调','2023-04-11 16:54:22'),(397,'异步回调','异步回调','2023-04-12 19:30:13');
/*!40000 ALTER TABLE `test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `group_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '组别ID',
  `p1` int(10) DEFAULT '0',
  `p2` int(10) DEFAULT '0',
  `p3` int(10) DEFAULT '0',
  `merchant_id` int(10) DEFAULT '0',
  `username` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '用户名',
  `nickname` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '昵称',
  `password` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '密码',
  `salt` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '密码盐',
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '电子邮箱',
  `mobile` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '手机号',
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '头像',
  `agency_id` int(10) DEFAULT '0',
  `level` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '等级',
  `gender` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '性别',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `bio` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '格言',
  `money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '余额',
  `consume` decimal(10,2) DEFAULT '0.00' COMMENT '总消费',
  `score` int(10) NOT NULL DEFAULT '0' COMMENT '积分',
  `successions` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '连续登录天数',
  `maxsuccessions` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '最大连续登录天数',
  `prevtime` bigint(16) DEFAULT NULL COMMENT '上次登录时间',
  `logintime` bigint(16) DEFAULT NULL COMMENT '登录时间',
  `loginip` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '登录IP',
  `loginfailure` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '失败次数',
  `joinip` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '加入IP',
  `jointime` bigint(16) DEFAULT NULL COMMENT '加入时间',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) DEFAULT NULL COMMENT '更新时间',
  `token` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'Token',
  `status` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '状态',
  `verification` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '验证',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `username` (`username`) USING BTREE,
  KEY `email` (`email`) USING BTREE,
  KEY `mobile` (`mobile`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT COMMENT='会员表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_agency`
--

DROP TABLE IF EXISTS `user_agency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_agency` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '代理名称',
  `discount` decimal(5,2) DEFAULT NULL COMMENT '折扣',
  `price` decimal(10,2) DEFAULT '0.00',
  `weigh` int(10) DEFAULT NULL COMMENT '排序',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) DEFAULT NULL COMMENT '更新时间',
  `deletetime` bigint(16) DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT COMMENT='#用户 - 代理等级';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_agency`
--

LOCK TABLES `user_agency` WRITE;
/*!40000 ALTER TABLE `user_agency` DISABLE KEYS */;
INSERT INTO `user_agency` VALUES (1,'普通代理',9.50,15.00,4,1678969619,1681478129,NULL),(2,'精英代理',8.00,50.00,3,1678969642,1678969642,NULL),(3,'至尊代理',6.50,100.00,2,1678969661,1678969661,NULL),(4,'合作商',5.00,180.00,1,1678969668,1678969668,NULL),(5,'测试等级',9.80,0.00,5,1681751383,1686885451,1686885451);
/*!40000 ALTER TABLE `user_agency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_group`
--

DROP TABLE IF EXISTS `user_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '组名',
  `rules` text COLLATE utf8mb4_unicode_ci COMMENT '权限节点',
  `createtime` bigint(16) DEFAULT NULL COMMENT '添加时间',
  `updatetime` bigint(16) DEFAULT NULL COMMENT '更新时间',
  `status` enum('normal','hidden') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT COMMENT='会员组表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_group`
--

LOCK TABLES `user_group` WRITE;
/*!40000 ALTER TABLE `user_group` DISABLE KEYS */;
INSERT INTO `user_group` VALUES (1,'默认组','1,2,3,4,5,6,7,8,9,10,11,12',1491635035,1491635035,'normal');
/*!40000 ALTER TABLE `user_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_money_log`
--

DROP TABLE IF EXISTS `user_money_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_money_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '变更余额',
  `before` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '变更前余额',
  `after` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '变更后余额',
  `memo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '备注',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT COMMENT='会员余额变动表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_money_log`
--

LOCK TABLES `user_money_log` WRITE;
/*!40000 ALTER TABLE `user_money_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_money_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_rule`
--

DROP TABLE IF EXISTS `user_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_rule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) DEFAULT NULL COMMENT '父ID',
  `name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  `title` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '标题',
  `remark` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `ismenu` tinyint(1) DEFAULT NULL COMMENT '是否菜单',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) DEFAULT '0' COMMENT '权重',
  `status` enum('normal','hidden') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT COMMENT='会员规则表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_rule`
--

LOCK TABLES `user_rule` WRITE;
/*!40000 ALTER TABLE `user_rule` DISABLE KEYS */;
INSERT INTO `user_rule` VALUES (1,0,'index','Frontend','',1,1491635035,1491635035,1,'normal'),(2,0,'api','API Interface','',1,1491635035,1491635035,2,'normal'),(3,1,'user','User Module','',1,1491635035,1491635035,12,'normal'),(4,2,'user','User Module','',1,1491635035,1491635035,11,'normal'),(5,3,'index/user/login','Login','',0,1491635035,1491635035,5,'normal'),(6,3,'index/user/register','Register','',0,1491635035,1491635035,7,'normal'),(7,3,'index/user/index','User Center','',0,1491635035,1491635035,9,'normal'),(8,3,'index/user/profile','Profile','',0,1491635035,1491635035,4,'normal'),(9,4,'api/user/login','Login','',0,1491635035,1491635035,6,'normal'),(10,4,'api/user/register','Register','',0,1491635035,1491635035,8,'normal'),(11,4,'api/user/index','User Center','',0,1491635035,1491635035,10,'normal'),(12,4,'api/user/profile','Profile','',0,1491635035,1491635035,3,'normal');
/*!40000 ALTER TABLE `user_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_score_log`
--

DROP TABLE IF EXISTS `user_score_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_score_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `score` int(10) NOT NULL DEFAULT '0' COMMENT '变更积分',
  `before` int(10) NOT NULL DEFAULT '0' COMMENT '变更前积分',
  `after` int(10) NOT NULL DEFAULT '0' COMMENT '变更后积分',
  `memo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '备注',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT COMMENT='会员积分变动表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_score_log`
--

LOCK TABLES `user_score_log` WRITE;
/*!40000 ALTER TABLE `user_score_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_score_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_token`
--

DROP TABLE IF EXISTS `user_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_token` (
  `token` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Token',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  `expiretime` bigint(16) DEFAULT NULL COMMENT '过期时间',
  PRIMARY KEY (`token`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT COMMENT='会员Token表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_token`
--

LOCK TABLES `user_token` WRITE;
/*!40000 ALTER TABLE `user_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `version`
--

DROP TABLE IF EXISTS `version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `version` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `oldversion` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '旧版本号',
  `newversion` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '新版本号',
  `packagesize` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '包大小',
  `content` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '升级内容',
  `downloadurl` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '下载地址',
  `enforce` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '强制更新',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT '0' COMMENT '权重',
  `status` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT COMMENT='版本表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `version`
--

LOCK TABLES `version` WRITE;
/*!40000 ALTER TABLE `version` DISABLE KEYS */;
/*!40000 ALTER TABLE `version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'ka_jd_shop'
--

--
-- Dumping routines for database 'ka_jd_shop'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-02 14:26:27
