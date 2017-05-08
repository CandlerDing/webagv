/*
Navicat MySQL Data Transfer

Source Server         : loclahost
Source Server Version : 50096
Source Host           : localhost:3306
Source Database       : agv

Target Server Type    : MYSQL
Target Server Version : 50096
File Encoding         : 65001

Date: 2017-01-08 20:32:53
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for area_code
-- ----------------------------
DROP TABLE IF EXISTS `area_code`;
CREATE TABLE `area_code` (
  `id` int(11) NOT NULL auto_increment,
  `pid` int(11) default NULL,
  `name` varchar(50) default NULL,
  `code` varchar(50) default NULL,
  `remark` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of area_code
-- ----------------------------

-- ----------------------------
-- Table structure for broad
-- ----------------------------
DROP TABLE IF EXISTS `broad`;
CREATE TABLE `broad` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(60) default NULL,
  `classid` int(11) default NULL,
  `classids` varchar(100) default NULL,
  `set_year` varchar(4) default NULL,
  `set_date` varchar(10) default NULL,
  `user_id` int(11) default NULL,
  `user_type` int(11) default NULL,
  `user_name` varchar(10) default NULL,
  `unit_id` int(11) NOT NULL,
  `unit_name` varchar(50) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of broad
-- ----------------------------

-- ----------------------------
-- Table structure for broad_content
-- ----------------------------
DROP TABLE IF EXISTS `broad_content`;
CREATE TABLE `broad_content` (
  `id` int(11) NOT NULL auto_increment,
  `affix` text,
  `content_b` longblob,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of broad_content
-- ----------------------------

-- ----------------------------
-- Table structure for car
-- ----------------------------
DROP TABLE IF EXISTS `car`;
CREATE TABLE `car` (
  `id` int(11) NOT NULL auto_increment,
  `Uuid` varchar(50) default NULL,
  `code` varchar(50) default NULL,
  `name` varchar(50) default NULL,
  `pid` int(11) default NULL,
  `Jd` varchar(50) default NULL,
  `Dcdy` varchar(50) default NULL,
  `Zxsd` double(16,2) default NULL,
  `Gwsd` double(16,2) default NULL,
  `Jiasd` double(16,2) default NULL,
  `Jiansd` double(16,2) default NULL,
  `Slfs` varchar(50) default NULL,
  `Sd` double(16,2) default NULL COMMENT '速度',
  `Dyfs` varchar(50) default NULL,
  `Wxcc` varchar(50) default NULL,
  `Fz` varchar(50) default NULL,
  `Dwjd` varchar(50) default NULL,
  `Qdxs` varchar(50) default NULL,
  `Lxtime` varchar(50) default NULL,
  `Cdfs` varchar(50) default NULL,
  `Zwlj` varchar(50) default NULL,
  `Aqgyfw` varchar(50) default NULL,
  `Ljsb` varchar(50) default NULL,
  `Xzts` varchar(50) default NULL,
  `Gzbj` varchar(50) default NULL,
  `Aqfh` varchar(50) default NULL,
  `Zdfz` varchar(50) default NULL,
  `Zdzxxc` varchar(50) default NULL,
  `Cddy` varchar(50) default NULL,
  `Zddy` varchar(50) default NULL,
  `Cd` varchar(50) default NULL,
  `Kd` varchar(50) default NULL,
  `Txfs` varchar(50) default NULL,
  `Hwsl` int(11) default NULL,
  `Hwzl` int(11) default NULL,
  `Ipaddress` varchar(100) default NULL,
  `port` varchar(20) default NULL,
  `WifiIpaddress` varchar(100) default NULL,
  `WifiPort` varchar(20) default NULL,
  `Handnum` int(11) default NULL,
  `Ionum` int(11) default NULL,
  `AddressId` int(11) default NULL,
  `Isuse` int(11) default NULL COMMENT '是否在用0空置1在用',
  `Flag` int(11) default NULL,
  `TxFlag` int(11) default NULL,
  `dqlj` varchar(200) default NULL COMMENT '当前路径（存储当前到达的位置）',
  `wzbfb` double(16,2) default NULL COMMENT '位置百分比',
  `yczt` varchar(20) default NULL COMMENT '异常状态',
  PRIMARY KEY  (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of car
-- ----------------------------
INSERT INTO `car` VALUES ('1', null, '0001', '惯性导航', '0', '', '', '0.00', '0.00', '0.00', '0.00', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '-1', '-1', null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `car` VALUES ('2', null, '0002', '磁导航', '0', '', '', '0.00', '0.00', '0.00', '0.00', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '-1', '-1', null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `car` VALUES ('8', 'b36524d6-5e90-44b7-813b-6cd3c920dda3', '00020001', '1#AGV', '2', '', '0.0v', '0.00', '0.00', '0.00', '0.00', '', '0.00', '', '', '', '', '', '', '', '', '', 'a7664d96-fcfa-4b24-8551-c4e5604f00b7', '', '', '', '', '', '', '', '', '', '', '-1', '-1', '192.168.127.101', '4001', '', '', '-1', '-1', '1', '1', '0', '1', '4e813492-9609-42c1-a7ed-85e530a700cdb11780e8-8036-49a9-91ff-e000196abdf7', null, null);
INSERT INTO `car` VALUES ('9', 'db8bce73-9ec3-42da-b668-fa569d4eeb15', '00020002', '2#AGV', '2', '', '0.0v', '0.00', '0.00', '0.00', '0.00', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '-1', '-1', '192.168.127.102', '4001', '', '', '-1', '-1', '1', '0', '0', '0', '6c44a292-2704-41dd-8f21-456f5b58187e038e37bf-77b9-435a-82c7-54014a0196ac', null, null);

-- ----------------------------
-- Table structure for carpath
-- ----------------------------
DROP TABLE IF EXISTS `carpath`;
CREATE TABLE `carpath` (
  `id` int(11) NOT NULL auto_increment,
  `Carid` int(11) default NULL,
  `Taskid` int(11) default NULL,
  `Yxzt` int(11) default NULL,
  `Qd` varchar(50) default NULL,
  `Zd` varchar(50) default NULL,
  `Yxtime` varchar(50) default NULL,
  `TaskRemark` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=622 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of carpath
-- ----------------------------

-- ----------------------------
-- Table structure for carscheduling
-- ----------------------------
DROP TABLE IF EXISTS `carscheduling`;
CREATE TABLE `carscheduling` (
  `id` int(11) NOT NULL auto_increment,
  `Carid` int(11) default NULL,
  `Taskid` int(11) default NULL,
  `Dqsd` varchar(50) default NULL,
  `Dqdy` varchar(50) default NULL,
  `Fzzt` int(11) default NULL,
  `Yxzt` int(11) default NULL,
  `Qd` varchar(50) default NULL,
  `Zd` varchar(50) default NULL,
  `Yxtime` varchar(50) default NULL,
  `TaskRemark` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of carscheduling
-- ----------------------------

-- ----------------------------
-- Table structure for commands
-- ----------------------------
DROP TABLE IF EXISTS `commands`;
CREATE TABLE `commands` (
  `id` int(11) NOT NULL auto_increment,
  `code` varchar(50) default NULL,
  `name` varchar(50) default NULL,
  `pid` int(11) default NULL,
  `Type` varchar(50) default NULL,
  `Speed` double(16,2) default NULL,
  `Commandcode` text,
  `StartTime` datetime default NULL,
  `orderno` int(11) default NULL,
  `remark` varchar(50) default NULL,
  PRIMARY KEY  (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of commands
-- ----------------------------
INSERT INTO `commands` VALUES ('1', '0001', '前进', '-1', '', '0.00', '', '2015-10-23 18:39:04', '-1', '');
INSERT INTO `commands` VALUES ('2', '0002', '后退', '-1', '', '0.00', '', '2015-10-23 18:39:20', '-1', '');
INSERT INTO `commands` VALUES ('3', '0003', '左转', '-1', '', '0.00', '', '2015-10-23 18:39:28', '-1', '');
INSERT INTO `commands` VALUES ('4', '0004', '右转', '-1', '', '0.00', '', '2015-10-23 18:39:36', '-1', '');
INSERT INTO `commands` VALUES ('5', '0005', '停止', '-1', '', '0.00', '', '2015-10-23 18:39:44', '-1', '');

-- ----------------------------
-- Table structure for controltype
-- ----------------------------
DROP TABLE IF EXISTS `controltype`;
CREATE TABLE `controltype` (
  `id` int(11) NOT NULL auto_increment,
  `code` varchar(50) default NULL,
  `name` varchar(50) default NULL,
  `pid` int(11) default NULL,
  `Retvalue` varchar(50) default NULL,
  `Type` varchar(50) default NULL,
  `Priority` int(11) default NULL,
  `orderno` int(11) default NULL,
  `remark` varchar(50) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=56 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of controltype
-- ----------------------------
INSERT INTO `controltype` VALUES ('1', '0001', '数据来源', '0', '', '', '1', '1', '');
INSERT INTO `controltype` VALUES ('2', '0002', '车体行驶方向', '0', '', '', '1', '1', '');
INSERT INTO `controltype` VALUES ('3', '0003', '车辆总体状态', '0', '', '', '1', '1', '');
INSERT INTO `controltype` VALUES ('4', '0004', '车辆控制权', '0', '', '', '1', '1', '');
INSERT INTO `controltype` VALUES ('5', '0005', '车辆运行模式', '0', '', '', '1', '1', '');
INSERT INTO `controltype` VALUES ('6', '0006', '地标点方向设定', '0', '', '', '1', '1', '');
INSERT INTO `controltype` VALUES ('7', '0007', '车辆上下货动作', '0', '', '', '1', '1', '');
INSERT INTO `controltype` VALUES ('8', '0008', 'RFID卡', '0', '', '', '1', '1', '');
INSERT INTO `controltype` VALUES ('9', '00010001', '由后台至AGV车辆', '1', '00', '', '1', '1', 'ServertoAgv');
INSERT INTO `controltype` VALUES ('10', '00010002', '由AGV车辆至后台', '1', '01', '', '1', '1', 'AgvtoServer');
INSERT INTO `controltype` VALUES ('11', '00010003', '由手机APP至AGV车辆', '1', '02', '', '1', '1', 'PhonetoAgv');
INSERT INTO `controltype` VALUES ('12', '00010004', '由AGV车辆至手机APP', '1', '03', '', '1', '1', 'AgvtoPhone');
INSERT INTO `controltype` VALUES ('13', '00020001', '车辆停止，无方向', '2', '00', '', '1', '1', '');
INSERT INTO `controltype` VALUES ('14', '00020002', '车辆前进直行', '2', '01', '', '1', '1', '');
INSERT INTO `controltype` VALUES ('15', '00020003', '车辆前进左转', '2', '02', '', '1', '1', '');
INSERT INTO `controltype` VALUES ('16', '00020004', '车辆前进右转', '2', '03', '', '1', '1', '');
INSERT INTO `controltype` VALUES ('17', '00020005', '车辆后退直行', '2', '04', '', '1', '1', '');
INSERT INTO `controltype` VALUES ('18', '00020006', '车辆后退左转', '2', '05', '', '1', '1', '');
INSERT INTO `controltype` VALUES ('19', '00020007', '车辆后退右转', '2', '06', '', '1', '1', '');
INSERT INTO `controltype` VALUES ('20', '00030001', '严重故障中，等待处理中', '3', '00', '', '1', '1', '');
INSERT INTO `controltype` VALUES ('21', '00030002', '任务运送中', '3', '01', '', '1', '1', '');
INSERT INTO `controltype` VALUES ('22', '00030003', '空车返回待命区中', '3', '02', '', '1', '1', '');
INSERT INTO `controltype` VALUES ('23', '00030004', '在待命区待命中', '3', '03', '', '1', '1', '');
INSERT INTO `controltype` VALUES ('24', '00030005', '在路径上，任务被清空，停止中', '3', '04', '', '1', '1', '');
INSERT INTO `controltype` VALUES ('25', '00030006', '充电中', '3', '05', '', '1', '1', '');
INSERT INTO `controltype` VALUES ('26', '00030007', '维修中（触摸屏设置）', '3', '06', '', '1', '1', '');
INSERT INTO `controltype` VALUES ('27', '00040001', '车辆控制权为空', '4', '00', '', '1', '1', 'empty');
INSERT INTO `controltype` VALUES ('28', '00040002', '本地控制', '4', '01', '', '1', '1', 'local');
INSERT INTO `controltype` VALUES ('29', '00040003', '手机APP控制', '4', '02', '', '1', '1', 'phone');
INSERT INTO `controltype` VALUES ('30', '00040004', '后台控制', '4', '03', '', '1', '1', 'Server');
INSERT INTO `controltype` VALUES ('31', '00050001', '连续运行模式', '5', '00', '', '1', '1', '');
INSERT INTO `controltype` VALUES ('32', '00050002', '调试模式', '5', '01', '', '1', '1', '');
INSERT INTO `controltype` VALUES ('33', '00050003', '点动模式', '5', '02', '', '1', '1', '');
INSERT INTO `controltype` VALUES ('34', '00070001', '停止车辆上下货动作', '7', '00', '', '1', '1', '');
INSERT INTO `controltype` VALUES ('35', '00070002', 'A通道上货', '7', '01', '', '1', '1', '');
INSERT INTO `controltype` VALUES ('36', '00070003', 'A通道下货', '7', '02', '', '1', '1', '');
INSERT INTO `controltype` VALUES ('37', '00070004', 'B通道上货', '7', '03', '', '1', '1', '');
INSERT INTO `controltype` VALUES ('38', '00070005', 'B通道下货', '7', '04', '', '1', '1', '');
INSERT INTO `controltype` VALUES ('39', '00080001', '当AGV由非RFID点出发时', '8', '00', '', '1', '1', '');
INSERT INTO `controltype` VALUES ('40', '00080002', '仓库区', '8', '01', '', '1', '1', '');
INSERT INTO `controltype` VALUES ('41', '00080003', '待命区', '8', '02', '', '1', '1', '');
INSERT INTO `controltype` VALUES ('42', '00080004', '维修区', '8', '03', '', '1', '1', '');
INSERT INTO `controltype` VALUES ('43', '00080005', '充电区', '8', '04', '', '1', '1', '');
INSERT INTO `controltype` VALUES ('44', '00080006', '生产车间工位上，可以上下货', '8', '05', '', '1', '1', '');
INSERT INTO `controltype` VALUES ('45', '00080007', '直线区行驶路径上', '8', '06', '', '1', '1', '');
INSERT INTO `controltype` VALUES ('46', '00080008', '转弯区行驶路径上', '8', '07', '', '1', '1', '');
INSERT INTO `controltype` VALUES ('47', '00080009', '避让区', '8', '08', '', '1', '1', '');
INSERT INTO `controltype` VALUES ('48', '00060001', '车辆停止，无方向', '6', '00', '', '1', '1', '');
INSERT INTO `controltype` VALUES ('49', '00060002', '车辆前进直行', '6', '01', '', '1', '1', '');
INSERT INTO `controltype` VALUES ('50', '00060003', '车辆前进左转', '6', '02', '', '1', '1', '');
INSERT INTO `controltype` VALUES ('51', '00060004', '车辆前进右转', '6', '03', '', '1', '1', '');
INSERT INTO `controltype` VALUES ('52', '00060005', '车辆后退直行', '6', '04', '', '1', '1', '');
INSERT INTO `controltype` VALUES ('53', '00060006', '车辆后退左转', '6', '05', '', '1', '1', '');
INSERT INTO `controltype` VALUES ('54', '00060007', '车辆后退右转', '6', '06', '', '1', '1', '');
INSERT INTO `controltype` VALUES ('55', '00080010', '当AGV在路径上行驶时，非地标RFDI点的卡使用类型', '8', 'FF', '', '1', '1', '');

-- ----------------------------
-- Table structure for datasource
-- ----------------------------
DROP TABLE IF EXISTS `datasource`;
CREATE TABLE `datasource` (
  `id` int(11) NOT NULL auto_increment,
  `code` varchar(50) default NULL,
  `name` varchar(50) default NULL,
  `pid` int(11) default NULL,
  `Retvalue` varchar(50) default NULL,
  `Type` varchar(50) default NULL,
  `orderno` int(11) default NULL,
  `remark` varchar(50) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of datasource
-- ----------------------------
INSERT INTO `datasource` VALUES ('1', '0001', '由后台至AGV车辆', '0', '00', 'HostToAgv', '1', '');
INSERT INTO `datasource` VALUES ('2', '0002', '由AGV车辆至后台', '0', '01', 'AgvToHost', '1', '');
INSERT INTO `datasource` VALUES ('3', '0003', '由手机APP至AGV车辆', '0', '02', 'AppToAgv', '1', '');
INSERT INTO `datasource` VALUES ('4', '0004', '由AGV车辆至手机APP', '0', '03', 'AgvToApp', '1', '');

-- ----------------------------
-- Table structure for degree1_code
-- ----------------------------
DROP TABLE IF EXISTS `degree1_code`;
CREATE TABLE `degree1_code` (
  `id` int(11) NOT NULL auto_increment,
  `pid` int(11) default NULL,
  `pcode` varchar(50) default NULL,
  `name` varchar(50) default NULL,
  `code` varchar(50) default NULL,
  `remark` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of degree1_code
-- ----------------------------

-- ----------------------------
-- Table structure for logs
-- ----------------------------
DROP TABLE IF EXISTS `logs`;
CREATE TABLE `logs` (
  `Id` int(11) NOT NULL auto_increment,
  `Userid` int(11) NOT NULL,
  `name` varchar(50) default NULL,
  `officename` varchar(50) default NULL,
  `officeid` varchar(50) default NULL,
  `Style` varchar(50) default NULL,
  `Keyid` varchar(100) default NULL,
  `subKeyid` varchar(100) default NULL,
  `Logs` varchar(255) default NULL,
  `ctime` datetime default NULL,
  PRIMARY KEY  (`Id`),
  KEY `Style` (`Style`)
) ENGINE=MyISAM DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of logs
-- ----------------------------

-- ----------------------------
-- Table structure for opeorder
-- ----------------------------
DROP TABLE IF EXISTS `opeorder`;
CREATE TABLE `opeorder` (
  `id` int(11) NOT NULL auto_increment,
  `code` varchar(50) default NULL,
  `name` varchar(50) default NULL,
  `pid` int(11) default NULL,
  `Retvalue` varchar(50) default NULL,
  `Lenvalue` varchar(50) default NULL,
  `LenRetvalue` varchar(50) default NULL,
  `Type` varchar(50) default NULL,
  `orderno` int(11) default NULL,
  `remark` varchar(50) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=60 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of opeorder
-- ----------------------------
INSERT INTO `opeorder` VALUES ('1', '0001', '查询/上报车辆', '0', '', null, null, '', '1', '');
INSERT INTO `opeorder` VALUES ('2', '0002', '查询/监控路径', '0', 'B1', null, null, '', '1', 'B1');
INSERT INTO `opeorder` VALUES ('3', '0003', '命令车辆', '0', 'C1', null, null, '', '1', 'C1');
INSERT INTO `opeorder` VALUES ('4', '0004', '强制控制车辆', '0', 'D1', null, null, '', '1', 'D1');
INSERT INTO `opeorder` VALUES ('5', '0005', '调试、点动控制车辆', '0', 'D1', null, null, '', '1', 'D1');
INSERT INTO `opeorder` VALUES ('6', '0006', '车辆喂狗', '0', 'D1', null, null, '', '1', 'D1');
INSERT INTO `opeorder` VALUES ('7', '00010001', '车辆是否故障', '1', 'A1', null, null, '', '1', 'A1');
INSERT INTO `opeorder` VALUES ('8', '00010002', '车辆实时状态', '1', 'A2', null, null, '', '1', 'A2');
INSERT INTO `opeorder` VALUES ('9', '00010003', '车辆当前时间', '1', 'A3', null, null, '', '1', 'A3');
INSERT INTO `opeorder` VALUES ('10', '000100010001', '查询车辆详细故障信息', '7', 'A1,00', '00,09', '00,10', '0', '1', 'A1.00');
INSERT INTO `opeorder` VALUES ('11', '000100010002', '查询车辆总故障标识指令', '7', 'A1,01', '00,09', '00,0A', '0', '2', 'A1.01');
INSERT INTO `opeorder` VALUES ('13', '000100010004', '查询车体前侧超声蔽障雷达故障标识', '7', 'A1,04', '00,09', '00,0A', '0', '4', 'A1.04');
INSERT INTO `opeorder` VALUES ('14', '000100010005', '查询车体后侧超声蔽障雷达故障标识', '7', 'A1,05', '00,09', '00,0A', '0', '6', 'A1.05');
INSERT INTO `opeorder` VALUES ('15', '000100010006', '查询车体左侧右侧超声蔽障雷达故障标识', '7', 'A1,06', '00,09', '00,0A', '0', '1', 'A1.06');
INSERT INTO `opeorder` VALUES ('16', '000100010007', '查询车体外围故障标识', '7', 'A1,07', '00,09', '00,0A', '0', '1', 'A1.07');
INSERT INTO `opeorder` VALUES ('17', '000100010008', '查询车体外围、货物故障标识', '7', 'A1,08', '00,09', '00,0A', '0', '1', 'A1.08');
INSERT INTO `opeorder` VALUES ('36', '00020002', '查询路径状态信息总标识指令', '2', 'B1,01', '00,09', '', '0', '1', 'B1.01');
INSERT INTO `opeorder` VALUES ('12', '000100010003', '查询车体本身故障标识', '7', 'A1,02', '00,09', '00,0A', '0', '3', 'A1.02');
INSERT INTO `opeorder` VALUES ('35', '00020001', '查询详细路径状态信息指令', '2', 'B1,00', '00,09', '00,13', '0', '1', 'B1.00');
INSERT INTO `opeorder` VALUES ('23', '000100020001', '查询车辆详细实时状态信息指令', '8', 'A2,00', '00,09', '00,1C', '0', '1', 'A2.00');
INSERT INTO `opeorder` VALUES ('24', '000100020002', '查询车体电池电压指令', '8', 'A2,01', '00,09', '00,0B', '0', '1', 'A2.01');
INSERT INTO `opeorder` VALUES ('25', '000100020003', '查询车体行驶方向指令', '8', 'A2.02', '00,09', '00,0B', '0', '1', 'A2.02');
INSERT INTO `opeorder` VALUES ('26', '000100020004', '查询车体行驶速度指令', '8', 'A2,03', '00,09', '00,0B', '0', '1', 'A2.03');
INSERT INTO `opeorder` VALUES ('27', '000100020005', '查询车辆位置信息指令', '8', 'A2,04', '00,09', '', '0', '1', 'A2.04');
INSERT INTO `opeorder` VALUES ('28', '000100020006', '查询车体通道载货状态指令', '8', 'A2,05', '00,09', '', '0', '1', 'A2.05');
INSERT INTO `opeorder` VALUES ('29', '000100020007', '查询车辆上下货动作状态指令', '8', 'A2,06', '00,09', '', '0', '1', 'A2.06');
INSERT INTO `opeorder` VALUES ('30', '000100020008', '查询车辆总体状态指令', '8', 'A2,07', '00,09', '', '0', '1', 'A2.07');
INSERT INTO `opeorder` VALUES ('31', '000100020009', '查询车辆控制权指令', '8', 'A2,08', '00,09', '', '0', '1', 'A2.08');
INSERT INTO `opeorder` VALUES ('32', '000100020010', '查询车辆运行模式指令', '8', 'A2,09', '00,09', '', '0', '1', 'A2.09');
INSERT INTO `opeorder` VALUES ('33', '000100030001', '查询车辆日历+时间信息指令', '9', 'A3,00', '00,09', '', '0', '1', 'A3.00');
INSERT INTO `opeorder` VALUES ('34', '000100030002', '查询车辆时间信息指令', '9', 'A3,01', '00,09', '', '0', '1', 'A3.01');
INSERT INTO `opeorder` VALUES ('37', '00020003', '查询路径磁条丢失指令', '2', 'B1,02', '00,09', '', '0', '1', 'B1.02');
INSERT INTO `opeorder` VALUES ('38', '00020004', '查询路径地标RFID点丢失指令', '2', 'B1,03', '00,09', '', '0', '1', 'B1.03');
INSERT INTO `opeorder` VALUES ('39', '00040001', '强制修改车辆控制权指令', '4', 'D1,00', '00,0A', '00,0A', '0', '1', 'D1.00');
INSERT INTO `opeorder` VALUES ('40', '00040002', '强制车辆启停指令', '4', 'D1,01', '00,0A', '00,09', '0', '1', 'D1.01');
INSERT INTO `opeorder` VALUES ('41', '00040003', '强制取消车辆任务指令', '4', 'D1,02', '00,09', '00,09', '0', '1', 'D1.02');
INSERT INTO `opeorder` VALUES ('42', '00040004', '强制修改车辆日历+时间指令', '4', 'D1,03', '00,10', '00,09', '0', '1', 'D1.03');
INSERT INTO `opeorder` VALUES ('43', '00050001', '修改车辆运行模式指令', '5', 'D2,00', '00,0A', '00,09', '0', '1', 'D2.00');
INSERT INTO `opeorder` VALUES ('44', '00050002', '调试模式操作指令', '5', 'D2,01', '00,09', '00,09', '0', '1', 'D2.01');
INSERT INTO `opeorder` VALUES ('45', '00060001', '后台主动喂狗AGV车辆指令', '6', 'E1,00', '00,09', '00,09', '0', '1', 'E1.00');
INSERT INTO `opeorder` VALUES ('46', '00060002', 'AGV车辆主动请求后台喂狗指令', '6', 'E1,01', '00,09', '00,09', '0', '1', 'E1.01');
INSERT INTO `opeorder` VALUES ('47', '00050003', '点动模式操作指令-车辆行驶动作', '5', 'D2,02', '00,0B', '00,09', '0', '1', 'D2.02');
INSERT INTO `opeorder` VALUES ('48', '00050004', '点动模式操作指令-车辆上下货动作', '5', 'D2,03', '00,0A', '00,09', '0', '1', 'D2.03');
INSERT INTO `opeorder` VALUES ('49', '00030001', '命令车辆的任务指令', '3', 'C1,00', '00,20', '00,09', '0', '1', 'C1.00');
INSERT INTO `opeorder` VALUES ('58', '000100010009', '查询车体驱动板外围故障标识指令', '7', 'A1,03', '00,09', '00,0A', '0', '1', 'A1.03');
INSERT INTO `opeorder` VALUES ('59', '000100020011', '查询车体电池电量指令', '8', 'A2,10', '00,09 ', '', '0', '1', 'A2.10');

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `id` int(11) NOT NULL auto_increment,
  `Ddh` varchar(50) default NULL,
  `Qd` varchar(50) default NULL,
  `Zd` varchar(50) default NULL,
  `Yxj` varchar(50) default NULL,
  `Ddzt` varchar(50) default NULL,
  `Yhbh` varchar(50) default NULL,
  `Kybz` int(11) default NULL,
  `CreateTime` varchar(50) default NULL,
  `StartTime` varchar(50) default NULL,
  `EndTime` varchar(50) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of order
-- ----------------------------

-- ----------------------------
-- Table structure for pathbs
-- ----------------------------
DROP TABLE IF EXISTS `pathbs`;
CREATE TABLE `pathbs` (
  `id` int(11) NOT NULL auto_increment,
  `code` varchar(50) default NULL,
  `name` varchar(50) default NULL,
  `pid` int(11) default NULL,
  `OnlyId` varchar(50) default NULL,
  `orderno` int(11) default NULL,
  `remark` varchar(50) default NULL,
  PRIMARY KEY  (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=37 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of pathbs
-- ----------------------------
INSERT INTO `pathbs` VALUES ('3', '00040001', 'A', '-1', '4e813492-9609-42c1-a7ed-85e530a700cd', '1', '');
INSERT INTO `pathbs` VALUES ('4', '00040002', 'B', '-1', 'b11780e8-8036-49a9-91ff-e000196abdf7', '2', '');
INSERT INTO `pathbs` VALUES ('5', '00040003', 'C', '-1', 'a7664d96-fcfa-4b24-8551-c4e5604f00b7', '3', '');
INSERT INTO `pathbs` VALUES ('6', '00040004', 'D', '-1', '6c44a292-2704-41dd-8f21-456f5b58187e', '4', '');
INSERT INTO `pathbs` VALUES ('7', '00040005', 'E', '-1', '038e37bf-77b9-435a-82c7-54014a0196ac', '5', '');
INSERT INTO `pathbs` VALUES ('8', '00040006', 'F', '-1', '8f343508-5037-46f8-8642-51a360b15d68', '6', '');
INSERT INTO `pathbs` VALUES ('9', '00040007', 'G', '-1', '06961c3f-e972-4ef8-8176-3ec865f80987', '7', '');
INSERT INTO `pathbs` VALUES ('10', '00040008', 'H', '-1', '09859102-b881-4457-a7d0-9655c0bf75fe', '8', '');
INSERT INTO `pathbs` VALUES ('23', '00040009', 'I', '-1', '1bcbb3b8-b057-4aab-b21b-a4f9be14ea5b', '9', '');
INSERT INTO `pathbs` VALUES ('24', '00040010', 'J', '-1', '1ad0c983-55ed-4245-a795-990c62d30100', '10', '');
INSERT INTO `pathbs` VALUES ('25', '00040011', 'K', '-1', '904b4395-a59f-4143-aed5-7e1f016c6661', '11', '');
INSERT INTO `pathbs` VALUES ('26', '00040012', 'L', '-1', '8fd55fbe-df86-45dd-9197-34be8307aed2', '12', '');
INSERT INTO `pathbs` VALUES ('27', '00040013', 'M', '-1', '2b31f071-dc71-4d93-8c3c-b2911ca7e801', '13', '');
INSERT INTO `pathbs` VALUES ('28', '00040014', 'R', '-1', '9d81b5d0-13ac-4b96-a379-9d6afe4d97d5', '14', '');
INSERT INTO `pathbs` VALUES ('29', '00040015', 'S', '-1', 'b5f38612-a8a1-4e82-8df2-86f8254b966c', '15', '');
INSERT INTO `pathbs` VALUES ('30', '00040016', 'T', '-1', '1c9962ec-fc9d-4708-bb1b-23514f98a10c', '16', '');
INSERT INTO `pathbs` VALUES ('31', '00040017', 'N', '-1', '018d2539-f45d-4816-8284-03ab6345e0cd', '17', '');
INSERT INTO `pathbs` VALUES ('32', '00040018', 'O', '-1', 'cced0c0e-c850-4504-a7fd-84d80d902eb2', '18', '');
INSERT INTO `pathbs` VALUES ('33', '00040019', 'P', '-1', '7a7d9690-33f4-49b9-8279-6801fd77bfd6', '19', '');
INSERT INTO `pathbs` VALUES ('34', '00040020', 'Q', '-1', '1da83ec8-7771-4507-966d-b672f4f59b3c', '20', '');
INSERT INTO `pathbs` VALUES ('35', '00040021', 'U', '-1', 'e4036451-5291-42e8-9875-df5207b2a681', '21', '');
INSERT INTO `pathbs` VALUES ('36', '00040022', 'V', '-1', 'aa7fd80d-475a-4f9e-84a1-59d705c787f0', '22', '');

-- ----------------------------
-- Table structure for pathbs_copy
-- ----------------------------
DROP TABLE IF EXISTS `pathbs_copy`;
CREATE TABLE `pathbs_copy` (
  `id` int(11) NOT NULL auto_increment,
  `code` varchar(50) default NULL,
  `name` varchar(50) default NULL,
  `pid` int(11) default NULL,
  `OnlyId` varchar(50) default NULL,
  `orderno` int(11) default NULL,
  `remark` varchar(50) default NULL,
  PRIMARY KEY  (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of pathbs_copy
-- ----------------------------
INSERT INTO `pathbs_copy` VALUES ('3', '', 'A', '-1', 'a93aa0b0-6c0d-4986-b5ae-06a32837917c', '1', '');
INSERT INTO `pathbs_copy` VALUES ('4', '', 'B', '-1', 'c7fa05bc-7b01-43be-b5e2-4c4ffa817d02', '2', '');
INSERT INTO `pathbs_copy` VALUES ('5', '', 'C', '-1', 'cf3ce7d8-2e92-4e20-a5d5-b23917315c0d', '3', '');
INSERT INTO `pathbs_copy` VALUES ('6', '', 'D', '-1', 'ac81a132-4005-4be7-927b-0adfed130520', '4', '');
INSERT INTO `pathbs_copy` VALUES ('7', '', 'E', '-1', '963fd358-1045-4e08-98a2-b821b1c4176c', '5', '');
INSERT INTO `pathbs_copy` VALUES ('8', '', 'F', '-1', 'dc69a59a-3283-41ec-86eb-b5e4be29fa2f', '6', '');
INSERT INTO `pathbs_copy` VALUES ('9', '', 'G', '-1', '779804cb-6473-42f1-9d68-492ebfa2c5c3', '7', '');
INSERT INTO `pathbs_copy` VALUES ('10', '', 'H', '-1', 'a93aa0b0-6c0d-4986-b5ae-06a32837917c', '8', '');

-- ----------------------------
-- Table structure for paths
-- ----------------------------
DROP TABLE IF EXISTS `paths`;
CREATE TABLE `paths` (
  `id` int(11) NOT NULL auto_increment,
  `code` varchar(50) default NULL,
  `name` varchar(50) default NULL,
  `Start` varchar(50) default NULL,
  `pid` int(11) default NULL,
  `End` varchar(50) default NULL,
  `Len` varchar(50) default NULL,
  `Dire` varchar(50) default NULL,
  `Type` varchar(50) default NULL,
  `FxType` varchar(50) default NULL,
  `Isuse` int(11) default NULL,
  `Isct` int(11) default NULL,
  `Isbr` int(11) default NULL,
  `Braddress` varchar(50) default NULL,
  `orderno` int(11) default NULL,
  `remark` varchar(50) default NULL,
  PRIMARY KEY  (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of paths
-- ----------------------------
INSERT INTO `paths` VALUES ('1', '0001', '路径1', 'G', '-1', 'H', '10', '', '', '', '1', '1', '1', null, '-1', '');

-- ----------------------------
-- Table structure for rfid
-- ----------------------------
DROP TABLE IF EXISTS `rfid`;
CREATE TABLE `rfid` (
  `id` int(11) NOT NULL auto_increment,
  `code` varchar(50) default NULL,
  `name` varchar(50) default NULL,
  `pid` int(11) default NULL,
  `Flag` int(11) default NULL,
  `Pathid` int(11) default NULL,
  `orderno` int(11) default NULL,
  `remark` varchar(50) default NULL,
  `Type` varchar(50) default NULL,
  `Wladdress` varchar(200) default NULL,
  `PathbsUuId` varchar(100) default NULL,
  `Rfid` varchar(200) default NULL,
  PRIMARY KEY  (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of rfid
-- ----------------------------
INSERT INTO `rfid` VALUES ('1', '0001', '充电区', '0', '1', '-1', '-1', '', null, null, null, null);
INSERT INTO `rfid` VALUES ('2', '0002', '维修区', '0', '1', '-1', '-1', '', null, null, null, null);
INSERT INTO `rfid` VALUES ('3', '0003', '待命区', '0', '1', '-1', '-1', '', null, null, null, null);
INSERT INTO `rfid` VALUES ('4', '0004', '路径区', '0', '1', '-1', '-1', '', null, null, null, null);
INSERT INTO `rfid` VALUES ('5', '00010001', '充电点1', '1', '0', '-1', '-1', '', null, null, null, null);
INSERT INTO `rfid` VALUES ('6', '00040001', 'A', '4', '1', '1', '-1', '', null, '', '4e813492-9609-42c1-a7ed-85e530a700cd', '02 30 30 30 30 30 30 30 30 30 31 0D 0A 03');
INSERT INTO `rfid` VALUES ('7', '0005', '库位区', '0', '0', '1', '-1', '', null, '', null, null);
INSERT INTO `rfid` VALUES ('8', '0006', '设备区', '0', '0', '1', '-1', '', null, '', null, null);
INSERT INTO `rfid` VALUES ('9', '00050001', '1号库', '7', '0', '1', '-1', '', null, '', null, null);
INSERT INTO `rfid` VALUES ('10', '00060001', '设备1', '8', '0', '1', '-1', '', null, '', null, null);
INSERT INTO `rfid` VALUES ('11', '00040002', 'B', '4', '1', '-1', '-1', '', '', '', 'b11780e8-8036-49a9-91ff-e000196abdf7', '02 30 30 30 30 30 30 30 30 30 32 0D 0A 03');
INSERT INTO `rfid` VALUES ('12', '00040003', 'C', '4', '1', '-1', '-1', '', '', '', 'a7664d96-fcfa-4b24-8551-c4e5604f00b7', '02 30 30 30 30 30 30 30 30 30 33 0D 0A 03');
INSERT INTO `rfid` VALUES ('13', '00040004', 'D', '4', '0', '-1', '-1', '', '', '', '6c44a292-2704-41dd-8f21-456f5b58187e', '02 30 30 30 30 30 30 30 30 30 34 0D 0A 03');
INSERT INTO `rfid` VALUES ('14', '00040005', 'E', '4', '1', '-1', '-1', '', '', '', '038e37bf-77b9-435a-82c7-54014a0196ac', '02 30 30 30 30 30 30 30 30 30 35 0D 0A 03');
INSERT INTO `rfid` VALUES ('15', '00040006', 'F', '4', '1', '-1', '-1', '', '', '', '8f343508-5037-46f8-8642-51a360b15d68', '02 30 30 30 30 30 30 30 30 30 36 0D 0A 03');
INSERT INTO `rfid` VALUES ('16', '00040007', 'G', '4', '1', '-1', '-1', '', '', '', '06961c3f-e972-4ef8-8176-3ec865f80987', '02 30 30 30 30 30 30 30 30 30 37 0D 0A 03');
INSERT INTO `rfid` VALUES ('17', '00040008', 'H', '4', '1', '-1', '-1', '', '', '', '09859102-b881-4457-a7d0-9655c0bf75fe', '02 30 30 30 30 30 30 30 30 30 38 0D 0A 03');
INSERT INTO `rfid` VALUES ('18', '00040009', 'I', '4', '1', '-1', '-1', '', '', '', '1bcbb3b8-b057-4aab-b21b-a4f9be14ea5b', '02 30 30 30 30 30 30 30 30 30 39 0D 0A 03');
INSERT INTO `rfid` VALUES ('19', '00040010', 'J', '4', '1', '-1', '-1', '', '', '', '1ad0c983-55ed-4245-a795-990c62d30100', '02 30 30 30 30 30 30 30 30 30 41 0D 0A 03');
INSERT INTO `rfid` VALUES ('20', '00040011', 'K', '4', '1', '-1', '-1', '', '', '', '904b4395-a59f-4143-aed5-7e1f016c6661', '02 30 30 30 30 30 30 30 30 30 42 0D 0A 03');
INSERT INTO `rfid` VALUES ('21', '00040012', 'L', '4', '1', '-1', '-1', '', '', '', '8fd55fbe-df86-45dd-9197-34be8307aed2', '02 30 30 30 30 30 30 30 30 30 43 0D 0A 03');
INSERT INTO `rfid` VALUES ('22', '00040013', 'M', '4', '1', '-1', '-1', '', '', '', '2b31f071-dc71-4d93-8c3c-b2911ca7e801', '02 30 30 30 30 30 30 30 30 30 44 0D 0A 03');
INSERT INTO `rfid` VALUES ('23', '00040014', 'R', '4', '1', '-1', '-1', '', '', '', '9d81b5d0-13ac-4b96-a379-9d6afe4d97d5', '02 30 30 30 30 30 30 30 30 30 45 0D 0A 03');
INSERT INTO `rfid` VALUES ('24', '00040015', 'S', '4', '1', '-1', '-1', '', '', '', 'b5f38612-a8a1-4e82-8df2-86f8254b966c', '02 30 30 30 30 30 30 30 30 30 46 0D 0A 03');
INSERT INTO `rfid` VALUES ('25', '00040016', 'T', '4', '1', '-1', '-1', '', '', '', '1c9962ec-fc9d-4708-bb1b-23514f98a10c', '02 30 30 30 30 30 30 30 30 31 30 0D 0A 03');
INSERT INTO `rfid` VALUES ('26', '00040017', 'N', '4', '1', '-1', '-1', '', '', '', '018d2539-f45d-4816-8284-03ab6345e0cd', '02 30 30 30 30 30 30 30 30 31 31 0D 0A 03');
INSERT INTO `rfid` VALUES ('27', '00040018', 'O', '4', '1', '-1', '-1', '', '', '', 'cced0c0e-c850-4504-a7fd-84d80d902eb2', '02 30 30 30 30 30 30 30 30 31 32 0D 0A 03');
INSERT INTO `rfid` VALUES ('28', '00040019', 'P', '4', '1', '-1', '-1', '', '', '', '7a7d9690-33f4-49b9-8279-6801fd77bfd6', '02 30 30 30 30 30 30 30 30 31 33 0D 0A 03');
INSERT INTO `rfid` VALUES ('29', '00040020', 'Q', '4', '1', '-1', '-1', '', '', '', '1da83ec8-7771-4507-966d-b672f4f59b3c', '02 30 30 30 30 30 30 30 30 31 34 0D 0A 03');
INSERT INTO `rfid` VALUES ('30', '00040021', 'U', '4', '1', '-1', '-1', '', '', '', 'e4036451-5291-42e8-9875-df5207b2a681', '02 30 30 30 30 30 30 30 30 31 35 0D 0A 03');
INSERT INTO `rfid` VALUES ('31', '00040022', 'V', '4', '1', '-1', '-1', '', '', '', 'aa7fd80d-475a-4f9e-84a1-59d705c787f0', '02 30 30 30 30 30 30 30 30 31 36 0D 0A 03');

-- ----------------------------
-- Table structure for rfid_copy
-- ----------------------------
DROP TABLE IF EXISTS `rfid_copy`;
CREATE TABLE `rfid_copy` (
  `id` int(11) NOT NULL auto_increment,
  `code` varchar(50) default NULL,
  `name` varchar(50) default NULL,
  `pid` int(11) default NULL,
  `Flag` int(11) default NULL,
  `Pathid` int(11) default NULL,
  `orderno` int(11) default NULL,
  `remark` varchar(50) default NULL,
  `Type` varchar(50) default NULL,
  `Wladdress` varchar(200) default NULL,
  `PathbsUuId` varchar(100) default NULL,
  `Rfid` varchar(200) default NULL,
  PRIMARY KEY  (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=52 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of rfid_copy
-- ----------------------------
INSERT INTO `rfid_copy` VALUES ('1', '0001', '充电区', '0', '1', '-1', '-1', '', null, null, null, null);
INSERT INTO `rfid_copy` VALUES ('2', '0002', '维修区', '0', '1', '-1', '-1', '', null, null, null, null);
INSERT INTO `rfid_copy` VALUES ('3', '0003', '待命区', '0', '1', '-1', '-1', '', null, null, null, null);
INSERT INTO `rfid_copy` VALUES ('5', '00010001', '充电点1', '1', '0', '-1', '-1', '', null, null, null, null);
INSERT INTO `rfid_copy` VALUES ('7', '0005', '库位区', '0', '0', '1', '-1', '', null, '', null, null);
INSERT INTO `rfid_copy` VALUES ('8', '0006', '设备区', '0', '0', '1', '-1', '', null, '', null, null);
INSERT INTO `rfid_copy` VALUES ('9', '00050001', '1号库', '7', '0', '1', '-1', '', null, '', null, null);
INSERT INTO `rfid_copy` VALUES ('10', '00060001', '设备1', '8', '0', '1', '-1', '', null, '', null, null);
INSERT INTO `rfid_copy` VALUES ('42', '0004', '路径区', '0', '0', '-1', '-1', '', '', '', '', '');
INSERT INTO `rfid_copy` VALUES ('51', '00040001', 'A', '42', '1', '-1', '-1', '', '', '', 'a93aa0b0-6c0d-4986-b5ae-06a32837917c', '02 30 30 30 30 30 30 30 30 30 32 0D 0A 03');
INSERT INTO `rfid_copy` VALUES ('44', '00040002', 'B', '42', '1', '-1', '-1', '', '', '', 'cc95ed99-1d8d-48fe-aa3b-4ad0d92356d9', '02 30 30 30 30 30 30 30 30 30 33 0D 0A 03');
INSERT INTO `rfid_copy` VALUES ('45', '00040003', 'C', '42', '1', '-1', '-1', '', '', '', 'c7fa05bc-7b01-43be-b5e2-4c4ffa817d02', '02 30 30 30 30 30 30 30 30 30 34 0D 0A 03');
INSERT INTO `rfid_copy` VALUES ('46', '00040004', 'D', '42', '0', '-1', '-1', '', '', '', 'cf3ce7d8-2e92-4e20-a5d5-b23917315c0d', '02 30 30 30 30 30 30 30 30 30 35 0D 0A 03');
INSERT INTO `rfid_copy` VALUES ('47', '00040005', 'E', '42', '0', '-1', '-1', '', '', '', 'ac81a132-4005-4be7-927b-0adfed130520', '02 30 30 30 30 30 30 30 30 30 37 0D 0A 03');
INSERT INTO `rfid_copy` VALUES ('48', '00040006', 'F', '42', '0', '-1', '-1', '', '', '', '963fd358-1045-4e08-98a2-b821b1c4176c', '02 30 30 30 30 30 30 30 30 30 39 0D 0A 03');
INSERT INTO `rfid_copy` VALUES ('49', '00040007', 'G', '42', '0', '-1', '-1', '', '', '', 'dc69a59a-3283-41ec-86eb-b5e4be29fa2f', '02 30 30 30 30 30 30 30 30 30 41 0D 0A 03');
INSERT INTO `rfid_copy` VALUES ('50', '00040008', 'H', '42', '1', '-1', '-1', '', '', '', '779804cb-6473-42f1-9d68-492ebfa2c5c3', '02 30 30 30 30 30 30 30 30 30 42 0D 0A 03');

-- ----------------------------
-- Table structure for special_code
-- ----------------------------
DROP TABLE IF EXISTS `special_code`;
CREATE TABLE `special_code` (
  `id` int(11) NOT NULL auto_increment,
  `pid` int(11) default NULL,
  `pcode` varchar(50) default NULL,
  `name` varchar(50) default NULL,
  `code` varchar(50) default NULL,
  `remark` varchar(255) default NULL,
  `enabled` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of special_code
-- ----------------------------

-- ----------------------------
-- Table structure for s_office
-- ----------------------------
DROP TABLE IF EXISTS `s_office`;
CREATE TABLE `s_office` (
  `id` int(11) NOT NULL auto_increment,
  `code` varchar(50) default NULL,
  `name` varchar(50) default NULL,
  `FULLNAME` varchar(50) default NULL,
  `pid` int(11) default NULL,
  `ZhengZhiName` varchar(50) default NULL,
  `ZhengZhiid` varchar(50) default NULL,
  `flag` int(11) default NULL,
  `STATE` varchar(10) default NULL,
  `OFTYPE` varchar(50) default NULL,
  `OrderNum` int(11) default NULL,
  `KaoQinflag` int(11) default NULL,
  `remark` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of s_office
-- ----------------------------
INSERT INTO `s_office` VALUES ('1', '0001', '临时', '临时', '0', null, null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for s_user
-- ----------------------------
DROP TABLE IF EXISTS `s_user`;
CREATE TABLE `s_user` (
  `id` int(11) NOT NULL auto_increment,
  `code` varchar(50) default NULL,
  `name` varchar(50) default NULL,
  `CnName` varchar(50) default NULL,
  `OFFICEID` int(11) NOT NULL,
  `LOGID` varchar(50) default NULL,
  `LOGPASS` varchar(50) default NULL,
  `phone` varchar(50) default NULL,
  `subphone` varchar(30) default NULL,
  `Address` varchar(100) default NULL,
  `E_MAIL` varchar(50) default NULL,
  `Jguan` varchar(100) default NULL,
  `XB` varchar(50) default NULL,
  `CSRQ` varchar(50) default NULL,
  `MZ` varchar(50) default NULL,
  `Sfzhm` varchar(50) default NULL,
  `Zzmm` varchar(50) default NULL,
  `marryflag` int(11) default NULL,
  `DegreeCode` int(11) default NULL,
  `WorkStart` varchar(20) default NULL,
  `TechPostCode` varchar(50) default NULL,
  `zhiwu` varchar(50) default NULL,
  `Photo` varchar(100) default NULL,
  `Ip` varchar(50) default NULL,
  `OrderNum` int(11) default NULL,
  `STATE` varchar(50) default NULL,
  `Delflag` int(11) default NULL,
  `ErrorNum` int(11) default NULL,
  `remark` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of s_user
-- ----------------------------
INSERT INTO `s_user` VALUES ('1', '0001', 'admin', '管理员', '1', 'admin', 'fEqNCco3Yq9h5ZUglD3CZJT4lBs=', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for task
-- ----------------------------
DROP TABLE IF EXISTS `task`;
CREATE TABLE `task` (
  `id` int(11) NOT NULL auto_increment,
  `Uuid` varchar(50) default NULL,
  `code` varchar(50) default NULL,
  `name` varchar(50) default NULL,
  `pid` int(11) default NULL,
  `Carid` int(11) default NULL,
  `Sd` double(16,2) default NULL,
  `Pathid` int(11) default NULL,
  `Yxj` varchar(50) default NULL,
  `Rwzt` varchar(50) default NULL,
  `Qd` varchar(50) default NULL,
  `Zd` varchar(50) default NULL,
  `QdId` int(11) default NULL,
  `ZdId` int(11) default NULL,
  `Commands` int(11) default NULL,
  `ComandsCode` varchar(50) default NULL,
  `Currfid` varchar(50) default NULL,
  `Length` double(16,2) default NULL,
  `Weigh` double(16,2) default NULL,
  `Kybz` int(11) default NULL,
  `Hwzl` varchar(50) default NULL,
  `Hwbm` varchar(50) default NULL,
  `Hwmc` varchar(50) default NULL,
  `Hwrfid` varchar(50) default NULL,
  `Hwsl` int(11) default NULL,
  `Dwssl` double(16,2) default NULL,
  `Fhl` double(16,2) default NULL,
  `CreateTime` varchar(50) default NULL,
  `XfTime` varchar(50) default NULL,
  `StartTime` varchar(50) default NULL,
  `EndTime` varchar(50) default NULL,
  `Type` int(11) default NULL,
  `Endflag` varchar(50) default NULL,
  `Userid` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of task
-- ----------------------------
INSERT INTO `task` VALUES ('23', '167cfcc9-e303-4e56-a153-f673767a127d', '', '任务调度', '-1', '-1', '0.00', '-1', '1', '', '', '', '13', '17', '-1', '', '', '0.00', '0.00', '1', '', '', '', '', '100', '100.00', '100.00', '2016-12-05 09:17:21', '', '', '', '1', '1', '-1');
INSERT INTO `task` VALUES ('28', 'a0927c67-2b1c-4e30-b1e4-b4ccf95ff8aa', '', 'asd', '-1', '-1', '0.00', '-1', '', '', '', '', '6', '17', '-1', '', '', '0.00', '0.00', '1', '', '', '', '', '100', '100.00', '100.00', '2016-12-29 17:47:41', '', '', '', '1', '1', '-1');
INSERT INTO `task` VALUES ('25', 'f8829495-b068-4d53-b47c-0757180f3159', '', '测试1', '-1', '-1', '0.00', '-1', '1', '', '', '', '6', '15', '-1', '', '', '0.00', '0.00', '-1', '根据具体内容填写', '', '根据具体内容填写', '', '100', '100.00', '100.00', '2016-12-13 17:22:10', '', '', '', '1', '1', '-1');
INSERT INTO `task` VALUES ('27', 'bbd835e8-1bc7-4fd2-9d02-baeebe133320', '', '1', '-1', '-1', '0.00', '-1', '1', '', 'A', 'B', '6', '11', '-1', '', '', '0.00', '0.00', '1', '', '', '', '', '1111', '1111.00', '1111.00', '2016-12-25 14:09:57', '', '', '', '1', '1', '-1');

-- ----------------------------
-- Table structure for taskquene
-- ----------------------------
DROP TABLE IF EXISTS `taskquene`;
CREATE TABLE `taskquene` (
  `id` int(11) NOT NULL auto_increment,
  `Uuid` varchar(50) default NULL,
  `name` varchar(50) default NULL,
  `TaskId` int(11) default NULL,
  `Carid` int(11) default NULL,
  `CarUUId` varchar(500) default NULL,
  `Yxj` varchar(50) default NULL,
  `Rwzt` varchar(50) default NULL,
  `Qd` varchar(50) default NULL,
  `Zd` varchar(50) default NULL,
  `QdId` int(11) default NULL,
  `ZdId` int(11) default NULL,
  `QdUUId` varchar(50) default NULL,
  `ZdUUId` varchar(50) default NULL,
  `Flow` text,
  `His_itemids` text,
  `Cur_itemsids` text,
  `Cur_dates` varchar(50) default NULL,
  `Flow_logs` text,
  `endFlag` int(11) default NULL,
  `Kybz` int(11) default NULL,
  `Hwzl` varchar(50) default NULL,
  `Hwbm` varchar(50) default NULL,
  `Hwmc` varchar(50) default NULL,
  `Hwrfid` varchar(50) default NULL,
  `Fhl` double(16,2) default NULL,
  `CreateTime` varchar(50) default NULL,
  `XfTime` varchar(50) default NULL,
  `StartTime` varchar(50) default NULL,
  `EndTime` varchar(50) default NULL,
  `Type` int(11) default NULL,
  `orderno` int(11) default NULL,
  `Userid` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `TaskId` (`TaskId`),
  KEY `endFlag` (`endFlag`)
) ENGINE=MyISAM AUTO_INCREMENT=728537 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of taskquene
-- ----------------------------
INSERT INTO `taskquene` VALUES ('728535', 'd158a859-c3b4-4f1b-ad54-79103bee96b3', '1_1', '27', '8', '', '0', '1', 'A', 'B', '6', '11', '4e813492-9609-42c1-a7ed-85e530a700cd', 'b11780e8-8036-49a9-91ff-e000196abdf7', '', '', '', '', '', '0', '-1', '', '', '', '', '1111.00', '2016-12-28 20:38:38', '2016-12-28 20:38:38', '2017-01-05 15:06:01', '', '1', '-1', '-1');
INSERT INTO `taskquene` VALUES ('728536', 'aabe3186-e12c-4e5d-95f9-8d61a692bea9', 'asd_1', '28', null, '', '0', '0', 'A', 'H', '6', '17', '4e813492-9609-42c1-a7ed-85e530a700cd', '09859102-b881-4457-a7d0-9655c0bf75fe', '', '', '', '', '', '0', '-1', '', '', '', '', '100.00', '2016-12-29 17:47:56', '2016-12-29 17:47:56', '2017-01-04 18:45:21', '', '1', '-1', '-1');

-- ----------------------------
-- Table structure for taskstate
-- ----------------------------
DROP TABLE IF EXISTS `taskstate`;
CREATE TABLE `taskstate` (
  `id` int(11) NOT NULL auto_increment,
  `code` varchar(10) default NULL,
  `name` varchar(50) default NULL,
  `orderno` int(11) default NULL,
  `remark` varchar(50) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of taskstate
-- ----------------------------
INSERT INTO `taskstate` VALUES ('1', '1', '待命区', '1', '');
INSERT INTO `taskstate` VALUES ('2', '2', '缓冲区', '2', '');
INSERT INTO `taskstate` VALUES ('3', '3', '执行区', '3', '');

-- ----------------------------
-- Table structure for tasktype
-- ----------------------------
DROP TABLE IF EXISTS `tasktype`;
CREATE TABLE `tasktype` (
  `id` int(11) NOT NULL auto_increment,
  `code` varchar(10) default NULL,
  `name` varchar(50) default NULL,
  `orderno` int(11) default NULL,
  `remark` varchar(50) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of tasktype
-- ----------------------------
INSERT INTO `tasktype` VALUES ('1', '1', '运货', '1', '');
INSERT INTO `tasktype` VALUES ('2', '2', '充电', '2', '');
INSERT INTO `tasktype` VALUES ('3', '3', '维修', '3', '');

-- ----------------------------
-- Table structure for tbl_asso
-- ----------------------------
DROP TABLE IF EXISTS `tbl_asso`;
CREATE TABLE `tbl_asso` (
  `id` varchar(50) NOT NULL,
  `username` varchar(60) NOT NULL,
  `ip` varchar(30) NOT NULL,
  `createtime` datetime default NULL,
  `updatetime` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of tbl_asso
-- ----------------------------
INSERT INTO `tbl_asso` VALUES ('DFF16BD0C7BB51E385ADD39932B55B5D', 'admin', '0:0:0:0:0:0:0:1', '2017-01-08 19:49:48', '2017-01-08 18:28:37');

-- ----------------------------
-- Table structure for tbl_channel
-- ----------------------------
DROP TABLE IF EXISTS `tbl_channel`;
CREATE TABLE `tbl_channel` (
  `id` int(11) NOT NULL auto_increment,
  `code` varchar(60) default NULL,
  `name` varchar(60) default NULL,
  `dept_id` int(11) NOT NULL,
  `pid` int(11) default NULL,
  `isstop` int(11) default NULL,
  `islist` int(11) default NULL,
  `remark` varchar(200) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of tbl_channel
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_dictcode
-- ----------------------------
DROP TABLE IF EXISTS `tbl_dictcode`;
CREATE TABLE `tbl_dictcode` (
  `id` int(11) NOT NULL auto_increment,
  `code` varchar(50) default NULL,
  `name` varchar(50) default NULL,
  `pid` int(11) default NULL,
  `showname` varchar(50) default NULL,
  `ordernum` int(11) default NULL,
  `Active` varchar(60) default NULL,
  `remark` varchar(60) default NULL,
  `flag` varchar(60) default NULL,
  `flagmc` varchar(60) default NULL,
  PRIMARY KEY  (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of tbl_dictcode
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_flashset
-- ----------------------------
DROP TABLE IF EXISTS `tbl_flashset`;
CREATE TABLE `tbl_flashset` (
  `id` int(11) NOT NULL auto_increment,
  `Xh` int(11) default NULL,
  `ImgUrl` varchar(100) default NULL,
  `Flag` varchar(50) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of tbl_flashset
-- ----------------------------
INSERT INTO `tbl_flashset` VALUES ('1', '1', 'images/201502252154471.jpg', '1');
INSERT INTO `tbl_flashset` VALUES ('2', '2', 'images/201502252130571.jpg', '1');
INSERT INTO `tbl_flashset` VALUES ('3', '3', 'images/201502252130271.jpg', '1');
INSERT INTO `tbl_flashset` VALUES ('4', '4', 'images/201502252156501.jpg', '1');

-- ----------------------------
-- Table structure for tbl_nation
-- ----------------------------
DROP TABLE IF EXISTS `tbl_nation`;
CREATE TABLE `tbl_nation` (
  `id` int(11) NOT NULL auto_increment,
  `code` varchar(60) default NULL,
  `name` varchar(60) default NULL,
  `remark` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of tbl_nation
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_sysset
-- ----------------------------
DROP TABLE IF EXISTS `tbl_sysset`;
CREATE TABLE `tbl_sysset` (
  `id` int(11) NOT NULL auto_increment,
  `Qzh` varchar(50) default NULL,
  `Onlinenum` int(11) default NULL,
  `dispnum` int(11) default NULL,
  `Expand1` varchar(50) default NULL,
  `Expand2` varchar(50) default NULL,
  `Expand3` varchar(50) default NULL,
  `Expand4` varchar(50) default NULL,
  `Expand5` varchar(50) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of tbl_sysset
-- ----------------------------
INSERT INTO `tbl_sysset` VALUES ('1', null, null, '20', null, null, null, null, null);

-- ----------------------------
-- Table structure for tbl_userlogin_logs
-- ----------------------------
DROP TABLE IF EXISTS `tbl_userlogin_logs`;
CREATE TABLE `tbl_userlogin_logs` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) default NULL,
  `userid` varchar(50) default NULL,
  `officename` varchar(50) default NULL,
  `officeid` varchar(50) default NULL,
  `Ssid` varchar(50) default NULL,
  `Log_date` datetime NOT NULL,
  `LogIP` varchar(50) default NULL,
  `last_Log_date` datetime default NULL,
  `Last_LogIP` varchar(50) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=379 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of tbl_userlogin_logs
-- ----------------------------
INSERT INTO `tbl_userlogin_logs` VALUES ('1', 'admin', '1', '', '1', 'A7801D161150AC79F9AB3B1B0468FC01', '2015-10-05 12:39:40', '127.0.0.1', '2015-10-05 12:39:40', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('2', 'admin', '1', '', '1', 'A7801D161150AC79F9AB3B1B0468FC01', '2015-10-05 12:41:33', '127.0.0.1', '2015-10-05 12:41:33', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('3', 'admin', '1', '', '1', 'A7801D161150AC79F9AB3B1B0468FC01', '2015-10-05 12:42:04', '127.0.0.1', '2015-10-05 12:42:04', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('4', 'admin', '1', '', '1', 'A7801D161150AC79F9AB3B1B0468FC01', '2015-10-05 13:23:49', '127.0.0.1', '2015-10-05 13:23:49', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('5', 'admin', '1', '', '1', '7D272ED82FDC107C627D6950F8809BFA', '2015-10-05 13:47:59', '127.0.0.1', '2015-10-05 13:47:59', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('6', 'admin', '1', '', '1', '6C6E42803AC99C8CBEEF3C7E1E5E784F', '2015-10-05 14:13:53', '127.0.0.1', '2015-10-05 14:13:53', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('7', 'admin', '1', '', '1', '441DDA647CFB11A8A0B829E89111CC70', '2015-10-11 19:34:47', '127.0.0.1', '2015-10-11 19:34:47', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('8', 'admin', '1', '', '1', 'E421B60668FF748313EB28A7C46C6DD0', '2015-10-17 21:35:43', '127.0.0.1', '2015-10-17 21:35:43', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('9', 'admin', '1', '临时', '1', '9B155764527B1F1538DD9963FA9CE6C2', '2015-10-17 22:04:34', '127.0.0.1', '2015-10-17 22:04:34', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('10', 'admin', '1', '临时', '1', '04D51F4F52B753F026674A4801D00CBD', '2015-10-17 22:26:05', '127.0.0.1', '2015-10-17 22:26:05', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('11', 'admin', '1', '临时', '1', 'FDA2E4F8E31A01EB58DB665321EAFDEE', '2015-10-18 09:46:25', '127.0.0.1', '2015-10-18 09:46:25', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('12', 'admin', '1', '临时', '1', 'C2B816FA06CE2ACB193A413495E9C3AE', '2015-10-18 15:46:28', '127.0.0.1', '2015-10-18 15:46:28', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('13', 'admin', '1', '临时', '1', 'A5494CB1173B213E2AE766D9B00CD0BC', '2015-10-18 16:03:10', '127.0.0.1', '2015-10-18 16:03:10', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('14', 'admin', '1', '临时', '1', '94CF36294D23ECB290AF6EDB4D54D53E', '2015-10-22 21:49:45', '127.0.0.1', '2015-10-22 21:49:45', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('15', 'admin', '1', '临时', '1', 'A81B921E1FAF8958FFCBACF37CC7FF51', '2015-10-22 22:04:33', '127.0.0.1', '2015-10-22 22:04:33', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('16', 'admin', '1', '临时', '1', '90001C77B7D83614EB1EF59449EFC6F9', '2015-10-23 18:27:35', '127.0.0.1', '2015-10-23 18:27:35', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('17', 'admin', '1', '临时', '1', '833C494221C2799E687BE2567D95A551', '2015-10-23 20:41:43', '127.0.0.1', '2015-10-23 20:41:43', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('18', 'admin', '1', '临时', '1', 'EEDA23D344603A50DF460D5FCEE7AF4D', '2015-10-24 09:40:03', '127.0.0.1', '2015-10-24 09:40:03', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('19', 'admin', '1', '临时', '1', 'EEDA23D344603A50DF460D5FCEE7AF4D', '2015-10-24 09:45:37', '127.0.0.1', '2015-10-24 09:45:37', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('20', 'admin', '1', '临时', '1', 'D5A322B6491C66043E364DEB9E0752DE', '2015-10-24 17:17:54', '127.0.0.1', '2015-10-24 17:17:54', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('21', 'admin', '1', '临时', '1', 'D5A322B6491C66043E364DEB9E0752DE', '2015-10-24 17:18:00', '127.0.0.1', '2015-10-24 17:18:00', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('22', 'admin', '1', '临时', '1', '0C18BA832D4CC92E2EA3B87A841F7B1E', '2015-10-24 20:26:01', '127.0.0.1', '2015-10-24 20:26:01', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('23', 'admin', '1', '临时', '1', '4F1F37CFF99BCF9149D642E29ED47EF0', '2015-10-25 15:44:03', '127.0.0.1', '2015-10-25 15:44:03', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('24', 'admin', '1', '临时', '1', '6AB7C07D9FAD66301558E6DC6584EA82', '2015-10-31 21:26:05', '127.0.0.1', '2015-10-31 21:26:05', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('25', 'admin', '1', '临时', '1', 'EA2A398107E17D890A333F1C35178026', '2015-11-01 16:48:52', '127.0.0.1', '2015-11-01 16:48:52', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('26', 'admin', '1', '临时', '1', '9855B2B77BD69DBCBF1D6F61964B38F7', '2015-11-08 16:17:30', '127.0.0.1', '2015-11-08 16:17:30', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('27', 'admin', '1', '临时', '1', '29E1E4BA1243A7B8EC189F258A3BE9A3', '2015-12-06 14:26:05', '127.0.0.1', '2015-12-06 14:26:05', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('28', 'admin', '1', '临时', '1', '658C308FD2A8DC4CBECC689FFBE317C5', '2015-12-06 17:54:02', '127.0.0.1', '2015-12-06 17:54:02', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('29', 'admin', '1', '临时', '1', 'BE3994E60FE0953553BE5B59D7C2D056', '2015-12-06 18:08:03', '127.0.0.1', '2015-12-06 18:08:03', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('30', 'admin', '1', '临时', '1', 'CBC97565A1ECFA2D38BD71AC4E7D5895', '2016-01-12 19:08:02', '127.0.0.1', '2016-01-12 19:08:02', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('31', 'admin', '1', '临时', '1', 'BD6054DC77C0CA21C2E1195F158570E6', '2016-01-12 20:43:47', '127.0.0.1', '2016-01-12 20:43:47', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('32', 'admin', '1', '临时', '1', 'A848EDB1DE99805A9159F4C93175F252', '2016-01-13 20:13:58', '192.168.1.113', '2016-01-13 20:13:58', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('33', 'admin', '1', '临时', '1', 'EAFA02391F068CC8AD6A30A0B5AE56A2', '2016-01-13 20:20:57', '192.168.1.109', '2016-01-13 20:20:57', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('34', 'admin', '1', '临时', '1', 'EAFA02391F068CC8AD6A30A0B5AE56A2', '2016-01-13 20:37:55', '192.168.1.109', '2016-01-13 20:37:55', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('35', 'admin', '1', '临时', '1', '5482AC6D27D80B1561493D8FB6616706', '2016-01-14 08:34:59', '192.168.1.109', '2016-01-14 08:34:59', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('36', 'admin', '1', '临时', '1', '5482AC6D27D80B1561493D8FB6616706', '2016-01-14 10:48:13', '192.168.1.109', '2016-01-14 10:48:13', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('37', 'admin', '1', '临时', '1', '7DA54C3D3D4C479A6863DE96C241F1DE', '2016-01-14 13:37:00', '192.168.1.109', '2016-01-14 13:37:00', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('38', 'admin', '1', '临时', '1', '78E9D839650FC166AD15B39F248576A5', '2016-01-15 13:45:15', '192.168.1.107', '2016-01-15 13:45:15', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('39', 'admin', '1', '临时', '1', 'E38C91A0185A8BD4FA0EE5B1B6C06E39', '2016-01-16 16:39:58', '192.168.1.106', '2016-01-16 16:39:58', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('40', 'admin', '1', '临时', '1', 'E38C91A0185A8BD4FA0EE5B1B6C06E39', '2016-01-16 17:03:20', '192.168.1.106', '2016-01-16 17:03:20', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('41', 'admin', '1', '临时', '1', '3665871BE58287A84261930B0528EFB3', '2016-01-16 17:11:08', '192.168.1.106', '2016-01-16 17:11:08', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('42', 'admin', '1', '临时', '1', '392A1E5828FFFE0F270FA4000E455C87', '2016-01-16 21:19:54', '192.168.1.106', '2016-01-16 21:19:54', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('43', 'admin', '1', '临时', '1', '06E6B3B67E0081AD106B6813E3546C93', '2016-01-17 09:06:44', '192.168.1.106', '2016-01-17 09:06:44', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('44', 'admin', '1', '临时', '1', '53815CE38BC83134E2C3C8413553716D', '2016-01-17 13:05:24', '192.168.1.106', '2016-01-17 13:05:24', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('45', 'admin', '1', '临时', '1', '2C6B88A2826BFCB026D693779C0C0E17', '2016-01-17 13:54:54', '192.168.1.106', '2016-01-17 13:54:54', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('46', 'admin', '1', '临时', '1', '820543A28E86BD5A3075163D00091468', '2016-01-19 21:51:23', '192.168.1.104', '2016-01-19 21:51:23', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('47', 'admin', '1', '临时', '1', 'C9F667FFA51DE76B2F046CA2CC2CCC15', '2016-01-20 18:11:45', '192.168.1.108', '2016-01-20 18:11:45', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('48', 'admin', '1', '临时', '1', 'DF7B47F4D14720476856D498FC9B8286', '2016-01-21 21:32:02', '192.168.1.114', '2016-01-21 21:32:02', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('49', 'admin', '1', '临时', '1', 'D70855000AA26727ED52002D2F30F6F7', '2016-01-24 14:01:15', '192.168.1.111', '2016-01-24 14:01:15', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('50', 'admin', '1', '临时', '1', '326C893FE84B061EA26BA815DE8102BF', '2016-01-24 21:15:55', '192.168.1.111', '2016-01-24 21:15:55', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('51', 'admin', '1', '临时', '1', '3ACC1D3FA0A4F727629D8F275689955C', '2016-01-24 21:45:44', '192.168.1.111', '2016-01-24 21:45:44', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('52', 'admin', '1', '临时', '1', '6B7103EF031596A566816CF7685E3403', '2016-01-31 15:11:12', '192.168.1.115', '2016-01-31 15:11:12', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('53', 'admin', '1', '临时', '1', 'F427133C960BEF265FE22C8E7B9D6597', '2016-01-31 15:12:45', '192.168.1.115', '2016-01-31 15:12:45', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('54', 'admin', '1', '临时', '1', '31C87C051342A6C59742D8CC8C336B1E', '2016-01-31 15:21:20', '192.168.1.101', '2016-01-31 15:21:20', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('55', 'admin', '1', '临时', '1', 'C28084780D6C53294FE1B9A31392405E', '2016-01-31 15:35:24', '192.168.1.101', '2016-01-31 15:35:24', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('56', 'admin', '1', '临时', '1', '086AC62F6153B55E2D3C7AC9EDB6F897', '2016-01-31 19:55:34', '192.168.1.101', '2016-01-31 19:55:34', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('57', 'admin', '1', '临时', '1', '84F038DD94E3FECD9F4259DED4F11933', '2016-01-31 20:59:06', '192.168.1.115', '2016-01-31 20:59:06', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('58', 'admin', '1', '临时', '1', 'FA981096A573083A3E6363599709F154', '2016-02-14 18:58:57', '192.168.1.113', '2016-02-14 18:58:57', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('59', 'admin', '1', '临时', '1', '0C14D78AF317EB5E7AD833748AB62B70', '2016-02-18 19:01:29', '192.168.1.112', '2016-02-18 19:01:29', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('60', 'admin', '1', '临时', '1', 'FCDCAE5ABCCF486F5C2ED1BB8E733DB6', '2016-02-18 19:50:17', '192.168.1.112', '2016-02-18 19:50:17', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('61', 'admin', '1', '临时', '1', '04B307602F8A37014F5C3FE66B24A4F4', '2016-02-19 19:27:06', '192.168.1.112', '2016-02-19 19:27:06', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('62', 'admin', '1', '临时', '1', '22ED0846BBDB5746EF201F19899560A2', '2016-02-19 19:28:16', '192.168.1.112', '2016-02-19 19:28:16', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('63', 'admin', '1', '临时', '1', '22ED0846BBDB5746EF201F19899560A2', '2016-02-19 19:32:35', '192.168.1.112', '2016-02-19 19:32:35', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('64', 'admin', '1', '临时', '1', '1F1D142FE38795FDD36657A4354D2B72', '2016-02-20 10:16:48', '192.168.1.112', '2016-02-20 10:16:48', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('65', 'admin', '1', '临时', '1', 'B073CCCDD334BF73E75B39485F3234C8', '2016-02-20 11:02:22', '192.168.1.112', '2016-02-20 11:02:22', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('66', 'admin', '1', '临时', '1', '096596FC9277DE21AA106B3D1E73CDFB', '2016-02-20 14:43:36', '192.168.1.112', '2016-02-20 14:43:36', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('67', 'admin', '1', '临时', '1', '54A7EC21011BD7F2D1C23E94D6D63AA1', '2016-02-20 14:51:11', '192.168.1.112', '2016-02-20 14:51:11', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('68', 'admin', '1', '临时', '1', 'B029750E789E92FE476E169367FDF928', '2016-02-20 15:08:23', '192.168.1.113', '2016-02-20 15:08:23', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('69', 'admin', '1', '临时', '1', 'F8A3BCE7C64F2E0C905AE108FDE9EAC8', '2016-02-20 15:31:33', '192.168.1.112', '2016-02-20 15:31:33', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('70', 'admin', '1', '临时', '1', 'F8A3BCE7C64F2E0C905AE108FDE9EAC8', '2016-02-20 16:01:38', '192.168.1.112', '2016-02-20 16:01:38', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('71', 'admin', '1', '临时', '1', 'A0F4A21C8AE503909E02FFFCD9517050', '2016-02-21 10:23:59', '192.168.1.112', '2016-02-21 10:23:59', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('72', 'admin', '1', '临时', '1', '4BA95FB6CC7F7AC3009B4F29536BB82F', '2016-02-21 19:21:23', '192.168.1.122', '2016-02-21 19:21:23', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('73', 'admin', '1', '临时', '1', '654BB9D2240D99CC54F8316648477A63', '2016-02-22 20:04:44', '192.168.1.112', '2016-02-22 20:04:44', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('74', 'admin', '1', '临时', '1', '906DF28394E5E8C6146E72BBC972BEF2', '2016-02-23 19:34:10', '192.168.1.122', '2016-02-23 19:34:10', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('75', 'admin', '1', '临时', '1', '904DF5994D194E4E407676318280852E', '2016-02-23 19:36:53', '192.168.1.102', '2016-02-23 19:36:53', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('76', 'admin', '1', '临时', '1', '1927819B385A5397C2845611C7A0C4BE', '2016-02-23 19:50:57', '192.168.1.102', '2016-02-23 19:50:57', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('77', 'admin', '1', '临时', '1', '0CBA548D9CBF4F44CB1F35E7D8E8D107', '2016-02-23 21:33:53', '192.168.1.102', '2016-02-23 21:33:53', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('78', 'admin', '1', '临时', '1', '33F3B875072B164BA93365E045BFC2A2', '2016-02-25 21:58:55', '192.168.1.102', '2016-02-25 21:58:55', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('79', 'admin', '1', '临时', '1', '61B0B0231BCE210CBB39212733BC8986', '2016-02-28 14:21:47', '192.168.1.102', '2016-02-28 14:21:47', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('80', 'admin', '1', '临时', '1', '12BCD0B029FC7D1189E909DC9D63874D', '2016-03-19 14:09:46', '127.0.0.1', '2016-03-19 14:09:46', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('81', 'admin', '1', '临时', '1', 'E70BD2AA73001EFD65B491BE6E0E4479', '2016-03-19 20:10:36', '127.0.0.1', '2016-03-19 20:10:36', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('82', 'admin', '1', '临时', '1', 'F90472BF86DC8A6E15FA7B0369FD38CD', '2016-03-19 20:50:52', '127.0.0.1', '2016-03-19 20:50:52', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('83', 'admin', '1', '临时', '1', 'C305BC9B5BA3E2F5FE0FE17A4211C7B8', '2016-03-26 15:11:45', '127.0.0.1', '2016-03-26 15:11:45', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('84', 'admin', '1', '临时', '1', '0425CBF63C733BC56140F5921F209E73', '2016-03-26 21:58:52', '127.0.0.1', '2016-03-26 21:58:52', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('85', 'admin', '1', '临时', '1', '5E70C04FBBCFA35875DCD35B82DFF7ED', '2016-03-27 10:12:15', '127.0.0.1', '2016-03-27 10:12:15', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('86', 'admin', '1', '临时', '1', '6F4F0F1FB66CDEC65486B137006DC58E', '2016-03-27 13:56:16', '127.0.0.1', '2016-03-27 13:56:16', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('87', 'admin', '1', '临时', '1', '8AEC6EAB5CA2D4E29D74DDDA2007ACFB', '2016-03-27 21:21:18', '127.0.0.1', '2016-03-27 21:21:18', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('88', 'admin', '1', '临时', '1', '4CF7A40B9B3898C07BD468AE40DBF4D0', '2016-03-28 19:30:08', '127.0.0.1', '2016-03-28 19:30:08', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('89', 'admin', '1', '临时', '1', '4CF7A40B9B3898C07BD468AE40DBF4D0', '2016-03-28 19:31:50', '127.0.0.1', '2016-03-28 19:31:50', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('90', 'admin', '1', '临时', '1', 'A45F54984DF74CD57B2060FBA18F75BD', '2016-03-28 19:33:31', '127.0.0.1', '2016-03-28 19:33:31', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('91', 'admin', '1', '临时', '1', 'AD812F01225D2AECBEEF18C1FA61BD93', '2016-05-07 18:55:36', '127.0.0.1', '2016-05-07 18:55:36', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('92', 'admin', '1', '临时', '1', '78D6491065845A43770A8E4E1D96B7DA', '2016-05-09 21:19:43', '127.0.0.1', '2016-05-09 21:19:43', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('93', 'admin', '1', '临时', '1', 'B50FD547D50D9A827CAB59F648D1E7E1', '2016-05-10 19:53:35', '127.0.0.1', '2016-05-10 19:53:35', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('94', 'admin', '1', '临时', '1', 'EAD5AFA86A15FB2D06D106531C915130', '2016-05-11 20:18:26', '127.0.0.1', '2016-05-11 20:18:26', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('95', 'admin', '1', '临时', '1', 'BB0BB3D1E3F521C3070455E295A7FCBE', '2016-05-11 21:35:40', '127.0.0.1', '2016-05-11 21:35:40', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('96', 'admin', '1', '临时', '1', '1C42C178A44852036A2A57F335A64C24', '2016-05-13 20:49:37', '127.0.0.1', '2016-05-13 20:49:37', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('97', 'admin', '1', '临时', '1', '69EB1299B80C2A38C560568F728902C0', '2016-05-13 21:18:26', '127.0.0.1', '2016-05-13 21:18:26', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('98', 'admin', '1', '临时', '1', '69EB1299B80C2A38C560568F728902C0', '2016-05-13 21:20:05', '127.0.0.1', '2016-05-13 21:20:05', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('99', 'admin', '1', '临时', '1', '69EB1299B80C2A38C560568F728902C0', '2016-05-13 21:23:24', '127.0.0.1', '2016-05-13 21:23:24', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('100', 'admin', '1', '临时', '1', '69EB1299B80C2A38C560568F728902C0', '2016-05-13 21:23:39', '127.0.0.1', '2016-05-13 21:23:39', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('101', 'admin', '1', '临时', '1', '3E5E8CEB4356CC78E6443AC2CFE9DFE0', '2016-05-15 10:07:42', '127.0.0.1', '2016-05-15 10:07:42', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('102', 'admin', '1', '临时', '1', '1691B33472B030090B2EF8D4E00AB975', '2016-05-15 19:37:07', '127.0.0.1', '2016-05-15 19:37:07', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('103', 'admin', '1', '临时', '1', '1691B33472B030090B2EF8D4E00AB975', '2016-05-15 19:40:48', '127.0.0.1', '2016-05-15 19:40:48', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('104', 'admin', '1', '临时', '1', '344368BDE32DDCBE4857A538B1088E16', '2016-05-15 19:44:37', '127.0.0.1', '2016-05-15 19:44:37', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('105', 'admin', '1', '临时', '1', 'B5EA0C5FDFB4174BB057A703EE36856A', '2016-05-16 20:24:51', '127.0.0.1', '2016-05-16 20:24:51', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('106', 'admin', '1', '临时', '1', 'F42CE89C81728CB561CA088F67F8A574', '2016-05-18 20:19:31', '127.0.0.1', '2016-05-18 20:19:31', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('107', 'admin', '1', '临时', '1', '5962FA4355ABFF8956FEEB6DFE5C0468', '2016-05-18 22:04:20', '127.0.0.1', '2016-05-18 22:04:20', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('108', 'admin', '1', '临时', '1', '6A23FF3F323FF36BCA75545C346F98A8', '2016-05-19 19:53:54', '127.0.0.1', '2016-05-19 19:53:54', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('109', 'admin', '1', '临时', '1', '2ACC52073E6EA1DD7D36D4E33F029596', '2016-05-19 20:13:43', '127.0.0.1', '2016-05-19 20:13:43', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('110', 'admin', '1', '临时', '1', '4561EB92EB69C25CD6A665F9B886BC6C', '2016-05-26 20:50:22', '127.0.0.1', '2016-05-26 20:50:22', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('111', 'admin', '1', '临时', '1', '2E32AC35B9BA21BACE287562E767ADFE', '2016-05-28 10:03:55', '127.0.0.1', '2016-05-28 10:03:55', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('112', 'admin', '1', '临时', '1', '8AB08A6E8CC9869F5B1A08E939026F26', '2016-05-28 10:48:15', '127.0.0.1', '2016-05-28 10:48:15', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('113', 'admin', '1', '临时', '1', '12375B28DC849897EB7FA84FD70C7059', '2016-05-28 14:08:54', '127.0.0.1', '2016-05-28 14:08:54', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('114', 'admin', '1', '临时', '1', 'FD23C1E729B1258F1D6C4F167B750D5A', '2016-05-28 15:21:47', '127.0.0.1', '2016-05-28 15:21:47', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('115', 'admin', '1', '临时', '1', '835C1B15A3E80E31E881AC576F079854', '2016-05-28 19:48:06', '127.0.0.1', '2016-05-28 19:48:06', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('116', 'admin', '1', '临时', '1', '9353E7C23896A98676FAD124AE3E9108', '2016-05-30 21:29:19', '127.0.0.1', '2016-05-30 21:29:19', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('117', 'admin', '1', '临时', '1', '98193E8ECA1D5AACDD42808F0D2F5865', '2016-06-04 11:09:11', '127.0.0.1', '2016-06-04 11:09:11', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('118', 'admin', '1', '临时', '1', 'C24CF59C00AEB3005FA0390AC0B170D4', '2016-06-04 14:33:04', '127.0.0.1', '2016-06-04 14:33:04', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('119', 'admin', '1', '临时', '1', '9C3D89603CA79432A7804C06E38D7319', '2016-06-04 20:25:40', '127.0.0.1', '2016-06-04 20:25:40', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('120', 'admin', '1', '临时', '1', 'D871F92410673645928CBF9FEE9BDC71', '2016-06-04 21:56:34', '127.0.0.1', '2016-06-04 21:56:34', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('121', 'admin', '1', '临时', '1', '25A4233C497353260920263FEC625A4B', '2016-06-05 10:38:06', '127.0.0.1', '2016-06-05 10:38:06', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('122', 'admin', '1', '临时', '1', 'FBCE21A05FB6294FB247BC28467C5C71', '2016-06-05 13:19:29', '127.0.0.1', '2016-06-05 13:19:29', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('123', 'admin', '1', '临时', '1', 'E393E3C287F2E3B739ED06CA72E29B5E', '2016-06-07 20:33:29', '127.0.0.1', '2016-06-07 20:33:29', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('124', 'admin', '1', '临时', '1', '3B04DDE8C1B18B651654129A94B6A8A1', '2016-06-07 22:12:27', '127.0.0.1', '2016-06-07 22:12:27', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('125', 'admin', '1', '临时', '1', '6F31E8E4499ED3D47C00C8E7FB5D7384', '2016-06-10 16:32:34', '127.0.0.1', '2016-06-10 16:32:34', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('126', 'admin', '1', '临时', '1', 'DC8E87A9779E73C3BF1F479CF8DB019F', '2016-06-18 19:51:12', '127.0.0.1', '2016-06-18 19:51:12', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('127', 'admin', '1', '临时', '1', '1BA2899237D35D5D92AFC2C2A5ED3575', '2016-06-19 10:29:17', '127.0.0.1', '2016-06-19 10:29:17', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('128', 'admin', '1', '临时', '1', '744D792085DCEC4C629220B552B20148', '2016-06-19 16:56:05', '127.0.0.1', '2016-06-19 16:56:05', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('129', 'admin', '1', '临时', '1', 'A44C9A4A032B19E9AA709D0B13B00F6A', '2016-06-26 20:47:39', '127.0.0.1', '2016-06-26 20:47:39', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('130', 'admin', '1', '临时', '1', '2020910EDD7C313BEC6A73E56F2F9440', '2016-06-26 21:43:10', '127.0.0.1', '2016-06-26 21:43:10', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('131', 'admin', '1', '临时', '1', '84395291CAAD8C869486F2249B7043ED', '2016-06-27 19:41:05', '127.0.0.1', '2016-06-27 19:41:05', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('132', 'admin', '1', '临时', '1', 'D2480350EB48B64D2C6661BEE03A7245', '2016-06-28 19:59:10', '127.0.0.1', '2016-06-28 19:59:10', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('133', 'admin', '1', '临时', '1', 'DFE4FFEFCB2ED055C14EDBC8550746C1', '2016-06-29 18:16:43', '127.0.0.1', '2016-06-29 18:16:43', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('134', 'admin', '1', '临时', '1', 'F975CB46A7FDB19F277D540014B86428', '2016-06-29 22:26:27', '127.0.0.1', '2016-06-29 22:26:27', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('135', 'admin', '1', '临时', '1', 'C3C864CED1ECEAA977D59A612A2DDDB0', '2016-06-30 13:57:25', '127.0.0.1', '2016-06-30 13:57:25', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('136', 'admin', '1', '临时', '1', '6984510F57215B7522CDEE8739A66198', '2016-07-01 11:15:42', '127.0.0.1', '2016-07-01 11:15:42', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('137', 'admin', '1', '临时', '1', '7BD9AD64FCD5F69F93C61576A155960D', '2016-07-02 09:45:00', '127.0.0.1', '2016-07-02 09:45:00', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('138', 'admin', '1', '临时', '1', '4BDAAA46551C0871C5CD42E3CAE93B20', '2016-07-02 14:10:15', '127.0.0.1', '2016-07-02 14:10:15', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('139', 'admin', '1', '临时', '1', 'CFFE6F023424F2027A379D4BCD9B80F9', '2016-07-02 20:44:53', '127.0.0.1', '2016-07-02 20:44:53', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('140', 'admin', '1', '临时', '1', '5DBED4B315D65BFFD871793A3F6EAF1D', '2016-07-03 13:54:46', '127.0.0.1', '2016-07-03 13:54:46', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('141', 'admin', '1', '临时', '1', '055898FFF71689E6750B9CA16A471985', '2016-07-03 20:22:02', '127.0.0.1', '2016-07-03 20:22:02', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('142', 'admin', '1', '临时', '1', '69EDCF4391CAD7F97124320C5521BFFB', '2016-07-08 10:00:47', '127.0.0.1', '2016-07-08 10:00:47', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('143', 'admin', '1', '临时', '1', '447A6765642909C1B6511AEBC6577922', '2016-07-20 19:06:06', '127.0.0.1', '2016-07-20 19:06:06', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('144', 'admin', '1', '临时', '1', '73F1B54D43AF91C68CB11D60CB9BEA53', '2016-07-21 09:01:09', '127.0.0.1', '2016-07-21 09:01:09', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('145', 'admin', '1', '临时', '1', '73F1B54D43AF91C68CB11D60CB9BEA53', '2016-07-21 09:01:09', '127.0.0.1', '2016-07-21 09:01:09', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('146', 'admin', '1', '临时', '1', '22DA9389AC764B8E2162DE005C8108EC', '2016-08-03 09:07:33', '127.0.0.1', '2016-08-03 09:07:33', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('147', 'admin', '1', '临时', '1', '710CC132C5BC453D4AD5632961A5EB4D', '2016-08-03 12:52:29', '127.0.0.1', '2016-08-03 12:52:29', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('148', 'admin', '1', '临时', '1', '9F8E6DDF32FEF61398D4E3E64C4E7B06', '2016-08-04 10:27:30', '127.0.0.1', '2016-08-04 10:27:30', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('149', 'admin', '1', '临时', '1', 'F55B171222E9A4204EC045962BDBE05B', '2016-08-05 09:29:57', '127.0.0.1', '2016-08-05 09:29:57', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('150', 'admin', '1', '临时', '1', 'CE0CA6A6F0EB30C83519EC77B148ACC1', '2016-08-05 15:49:56', '127.0.0.1', '2016-08-05 15:49:56', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('151', 'admin', '1', '临时', '1', 'A5DA693E1A2DC678137BD3B112EF2E9A', '2016-08-08 08:42:56', '127.0.0.1', '2016-08-08 08:42:56', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('152', 'admin', '1', '临时', '1', '21F0D1BDDA3C1854039D53B35AD69FEB', '2016-08-08 14:26:53', '127.0.0.1', '2016-08-08 14:26:53', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('153', 'admin', '1', '临时', '1', 'F6D36DCD91C04BE0D86B538765D3A532', '2016-08-09 08:33:27', '127.0.0.1', '2016-08-09 08:33:27', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('154', 'admin', '1', '临时', '1', '87634B3F4BF2B69626340D8CAE8F1232', '2016-08-09 11:49:04', '127.0.0.1', '2016-08-09 11:49:04', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('155', 'admin', '1', '临时', '1', '5D0A16DFCC7B2EC5C1EA6137F865DE64', '2016-08-09 14:19:21', '127.0.0.1', '2016-08-09 14:19:21', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('156', 'admin', '1', '临时', '1', '9B098647C79D202CAC1A9C01593E45F2', '2016-08-10 08:36:50', '127.0.0.1', '2016-08-10 08:36:50', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('157', 'admin', '1', '临时', '1', '3D4C1C8C1540C43286CFA8C21CE4407A', '2016-08-10 12:01:21', '127.0.0.1', '2016-08-10 12:01:21', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('158', 'admin', '1', '临时', '1', 'C41D99303C69068B780DF48956AA55F9', '2016-08-11 09:08:22', '127.0.0.1', '2016-08-11 09:08:22', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('159', 'admin', '1', '临时', '1', 'E35CF39DBF0D774CEAFC580DF3FC424B', '2016-08-12 10:38:11', '127.0.0.1', '2016-08-12 10:38:11', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('160', 'admin', '1', '临时', '1', '81EADC7CE7B84FB90C7E7FF9F0EA6963', '2016-08-12 11:42:06', '127.0.0.1', '2016-08-12 11:42:06', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('161', 'admin', '1', '临时', '1', 'DD0778109E3F236210FF642989B72460', '2016-08-12 13:40:23', '127.0.0.1', '2016-08-12 13:40:23', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('162', 'admin', '1', '临时', '1', 'EAA06547F6A06C28E5433CF2A87200AD', '2016-08-15 08:34:00', '127.0.0.1', '2016-08-15 08:34:00', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('163', 'admin', '1', '临时', '1', '7B3E2730CAE53832541DF4BED2E4C401', '2016-08-15 09:19:26', '127.0.0.1', '2016-08-15 09:19:26', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('164', 'admin', '1', '临时', '1', 'B846E4BDC070138AB140B99CD3430AB2', '2016-08-15 10:36:52', '127.0.0.1', '2016-08-15 10:36:52', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('165', 'admin', '1', '临时', '1', 'E0C23E26E5A9C78511C31172A87EDABD', '2016-08-15 11:02:55', '127.0.0.1', '2016-08-15 11:02:55', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('166', 'admin', '1', '临时', '1', '8745AF2F243CE9C1D1C9B584FFB777C4', '2016-08-15 12:48:46', '127.0.0.1', '2016-08-15 12:48:46', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('167', 'admin', '1', '临时', '1', '65339457DE3A4775AF754CD23AA69305', '2016-08-15 13:28:53', '127.0.0.1', '2016-08-15 13:28:53', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('168', 'admin', '1', '临时', '1', '29F71481402397012372F6FCBAB454CC', '2016-08-15 14:36:40', '127.0.0.1', '2016-08-15 14:36:40', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('169', 'admin', '1', '临时', '1', '53C4E256DBD459D923CCA4642CB07DD7', '2016-08-16 08:44:56', '127.0.0.1', '2016-08-16 08:44:56', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('170', 'admin', '1', '临时', '1', '9097E0B30ED6B611B26C0BAA29694371', '2016-08-16 09:01:32', '127.0.0.1', '2016-08-16 09:01:32', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('171', 'admin', '1', '临时', '1', '14780EDC106FFF13691809EE7C4DAE89', '2016-08-16 09:15:02', '127.0.0.1', '2016-08-16 09:15:02', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('172', 'admin', '1', '临时', '1', '97DE5C6CE7AB63AF440E0D988C61247E', '2016-08-16 09:28:21', '127.0.0.1', '2016-08-16 09:28:21', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('173', 'admin', '1', '临时', '1', '304AFE00D7D5ACA688DDA9A8CEEE6648', '2016-08-16 10:21:17', '127.0.0.1', '2016-08-16 10:21:17', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('174', 'admin', '1', '临时', '1', '8F9E05C23AE899AA3E76D9AC4B721B2D', '2016-08-16 10:26:05', '127.0.0.1', '2016-08-16 10:26:05', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('175', 'admin', '1', '临时', '1', 'D490344CB71A6597DF2414C6366F5210', '2016-08-16 10:27:04', '127.0.0.1', '2016-08-16 10:27:04', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('176', 'admin', '1', '临时', '1', '9DB8A83DEA836AB6F02AA4CB6A6F51BE', '2016-08-16 10:36:11', '127.0.0.1', '2016-08-16 10:36:11', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('177', 'admin', '1', '临时', '1', 'BB38261DCD05D6E214117A1EC3E9DA28', '2016-08-16 11:22:10', '127.0.0.1', '2016-08-16 11:22:10', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('178', 'admin', '1', '临时', '1', '44A29571737267BF2698EDC32DD2603E', '2016-08-16 11:38:09', '127.0.0.1', '2016-08-16 11:38:09', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('179', 'admin', '1', '临时', '1', 'D59700AE331E1084E68907B53DE39855', '2016-08-16 15:06:36', '127.0.0.1', '2016-08-16 15:06:36', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('180', 'admin', '1', '临时', '1', 'EBA68A8A43F8294AF9AB0AFFBA55B02E', '2016-08-16 15:22:12', '127.0.0.1', '2016-08-16 15:22:12', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('181', 'admin', '1', '临时', '1', 'EBA68A8A43F8294AF9AB0AFFBA55B02E', '2016-08-16 15:22:13', '127.0.0.1', '2016-08-16 15:22:13', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('182', 'admin', '1', '临时', '1', '29E2C60784FE41120009D70D04FDA684', '2016-08-16 21:30:50', '127.0.0.1', '2016-08-16 21:30:50', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('183', 'admin', '1', '临时', '1', '29E2C60784FE41120009D70D04FDA684', '2016-08-16 21:30:50', '127.0.0.1', '2016-08-16 21:30:50', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('184', 'admin', '1', '临时', '1', '272C458734CEC1A050502642E3A45355', '2016-08-19 19:44:54', '127.0.0.1', '2016-08-19 19:44:54', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('185', 'admin', '1', '临时', '1', '88ECE1CE100432BFE27967DAEBA0F179', '2016-08-20 09:53:59', '127.0.0.1', '2016-08-20 09:53:59', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('186', 'admin', '1', '临时', '1', 'F49676F6E08B91FFAE8A49CB66E65FD0', '2016-08-20 10:08:13', '127.0.0.1', '2016-08-20 10:08:13', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('187', 'admin', '1', '临时', '1', '677FD108A06411774A35596B60729464', '2016-08-20 10:18:52', '127.0.0.1', '2016-08-20 10:18:52', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('188', 'admin', '1', '临时', '1', '7790D90282D77A66B784C2119FF53DF8', '2016-08-20 11:00:05', '127.0.0.1', '2016-08-20 11:00:05', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('189', 'admin', '1', '临时', '1', 'C60502D10E60143F41F5C72A717CE175', '2016-08-20 11:10:24', '127.0.0.1', '2016-08-20 11:10:24', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('190', 'admin', '1', '临时', '1', '8763B45E549DE162C952442F642C7EE0', '2016-08-20 11:25:12', '127.0.0.1', '2016-08-20 11:25:12', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('191', 'admin', '1', '临时', '1', 'EE814736A98E2E020BBBBA1AAD99C556', '2016-08-20 14:05:54', '127.0.0.1', '2016-08-20 14:05:54', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('192', 'admin', '1', '临时', '1', 'B47705FD2415292A5F55E7EE0789DE02', '2016-08-20 15:19:41', '127.0.0.1', '2016-08-20 15:19:41', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('193', 'admin', '1', '临时', '1', '3DF8CAF3CFBC869172C3AF3F91C2A107', '2016-08-20 16:06:55', '127.0.0.1', '2016-08-20 16:06:55', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('194', 'admin', '1', '临时', '1', '7246E50A5F151C6CE605647DF2F10A22', '2016-08-20 16:22:27', '127.0.0.1', '2016-08-20 16:22:27', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('195', 'admin', '1', '临时', '1', '23E2D2F0238EA6DB3E0EDE5247C78905', '2016-08-21 09:14:58', '127.0.0.1', '2016-08-21 09:14:58', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('196', 'admin', '1', '临时', '1', '9FB4B5A04C3F494DC5418E5F2B63F270', '2016-08-21 14:26:16', '127.0.0.1', '2016-08-21 14:26:16', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('197', 'admin', '1', '临时', '1', '20077857AE80A6C5703F0EDDEA8CA7AF', '2016-08-22 09:11:41', '127.0.0.1', '2016-08-22 09:11:41', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('198', 'admin', '1', '临时', '1', '13344E38FAFD888B6846DA551FD89BC2', '2016-08-22 11:26:29', '127.0.0.1', '2016-08-22 11:26:29', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('199', 'admin', '1', '临时', '1', '946D27B680569850DFC39AAF3F0C8116', '2016-08-22 11:51:50', '127.0.0.1', '2016-08-22 11:51:50', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('200', 'admin', '1', '临时', '1', '1AF6C97827CECAA17B250391C8CD5564', '2016-08-22 16:11:29', '127.0.0.1', '2016-08-22 16:11:29', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('201', 'admin', '1', '临时', '1', '34A9648456B6E90369B3B36C975FEC46', '2016-08-23 08:28:56', '127.0.0.1', '2016-08-23 08:28:56', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('202', 'admin', '1', '临时', '1', '7650ABF50CD53E6255B385565075163D', '2016-08-23 19:26:29', '127.0.0.1', '2016-08-23 19:26:29', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('203', 'admin', '1', '临时', '1', '4213526DDAB90F5ECD93F98CA757E349', '2016-08-24 08:35:50', '127.0.0.1', '2016-08-24 08:35:50', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('204', 'admin', '1', '临时', '1', '6C44839857AB3A4FCFB4A8AD3B4C8E12', '2016-08-25 08:56:58', '127.0.0.1', '2016-08-25 08:56:58', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('205', 'admin', '1', '临时', '1', 'A0127BBB348E06CBAA747CC3F451DF7C', '2016-08-26 08:30:51', '127.0.0.1', '2016-08-26 08:30:51', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('206', 'admin', '1', '??', '1', 'C5924851AD41AFB8DA5C098B93CE7859', '2016-08-28 10:39:23', '0:0:0:0:0:0:0:1', '2016-08-28 10:39:23', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('207', 'admin', '1', '??', '1', '53751823750DCB5BA8DAC01361C2C3EF', '2016-08-28 15:57:26', '0:0:0:0:0:0:0:1', '2016-08-28 15:57:26', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('208', 'admin', '1', '??', '1', 'FC9913FAF53B34AB49B1BF80F13A7FA9', '2016-08-28 16:29:53', '0:0:0:0:0:0:0:1', '2016-08-28 16:29:53', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('209', 'admin', '1', '??', '1', '6BB82C0751101F51F3B6C592F74A9E0B', '2016-08-28 16:33:41', '0:0:0:0:0:0:0:1', '2016-08-28 16:33:41', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('210', 'admin', '1', '??', '1', '2D9A8349BD2F6EDEEF9A445AEF0E055F', '2016-08-28 16:41:42', '0:0:0:0:0:0:0:1', '2016-08-28 16:41:42', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('211', 'admin', '1', '??', '1', '749EBC0712ABC5B0E0C17F3283C0AA26', '2016-08-28 17:03:05', '0:0:0:0:0:0:0:1', '2016-08-28 17:03:05', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('212', 'admin', '1', '??', '1', 'B52EE0FF84782291D264AD4ECD1A3CDB', '2016-08-28 17:35:28', '0:0:0:0:0:0:0:1', '2016-08-28 17:35:28', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('213', 'admin', '1', '??', '1', 'D2309920DE339866C83AB2AD38AD512E', '2016-08-29 08:17:14', '0:0:0:0:0:0:0:1', '2016-08-29 08:17:14', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('214', 'admin', '1', '??', '1', 'D2309920DE339866C83AB2AD38AD512E', '2016-08-29 08:51:47', '0:0:0:0:0:0:0:1', '2016-08-29 08:51:47', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('215', 'admin', '1', '??', '1', '3A57BF3CA20BD7161D5703B75F70F3F7', '2016-08-29 17:30:56', '0:0:0:0:0:0:0:1', '2016-08-29 17:30:56', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('216', 'admin', '1', '??', '1', '3A57BF3CA20BD7161D5703B75F70F3F7', '2016-08-29 17:30:56', '0:0:0:0:0:0:0:1', '2016-08-29 17:30:56', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('217', 'admin', '1', '??', '1', 'A4EBF729F36B68CB498D7C7F30E9E0A9', '2016-08-29 17:37:19', '0:0:0:0:0:0:0:1', '2016-08-29 17:37:19', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('218', 'admin', '1', '??', '1', '5B2CEDC738FBD91BADDF2F63EC739ACD', '2016-08-29 17:40:22', '0:0:0:0:0:0:0:1', '2016-08-29 17:40:22', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('219', 'admin', '1', '??', '1', '569B8580B6C98136B69A8119196A2CDC', '2016-08-29 17:42:52', '0:0:0:0:0:0:0:1', '2016-08-29 17:42:52', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('220', 'admin', '1', '??', '1', 'F30C9064BEB5464047DE84061AC3CBE0', '2016-08-29 17:49:23', '0:0:0:0:0:0:0:1', '2016-08-29 17:49:23', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('221', 'admin', '1', '??', '1', 'F20549FA446C1887255B4BCC4429047E', '2016-09-04 10:15:16', '0:0:0:0:0:0:0:1', '2016-09-04 10:15:16', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('222', 'admin', '1', '??', '1', 'F20549FA446C1887255B4BCC4429047E', '2016-09-04 10:31:32', '0:0:0:0:0:0:0:1', '2016-09-04 10:31:32', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('223', 'admin', '1', '??', '1', 'E17A8E29DC806BACC5753740A8F3080C', '2016-09-04 15:16:53', '0:0:0:0:0:0:0:1', '2016-09-04 15:16:53', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('224', 'admin', '1', '??', '1', 'FFFB3ED328E2F53131A4A6D13630BC6A', '2016-09-17 14:49:53', '0:0:0:0:0:0:0:1', '2016-09-17 14:49:53', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('225', 'admin', '1', '临时', '1', '9B20778432FCBC604B80AF4B643A1BC8', '2016-09-17 17:38:19', '0:0:0:0:0:0:0:1', '2016-09-17 17:38:19', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('226', 'admin', '1', '临时', '1', 'F8A4FEBD9BDD7F843DD237E310765D29', '2016-09-17 17:45:44', '0:0:0:0:0:0:0:1', '2016-09-17 17:45:44', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('227', 'admin', '1', '临时', '1', 'C712A52A640E096F5DF1E00912A17423', '2016-09-17 17:54:12', '0:0:0:0:0:0:0:1', '2016-09-17 17:54:12', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('228', 'admin', '1', '临时', '1', 'BEF9D7D0C53AAE3BD8B62780B986D91C', '2016-09-17 18:07:51', '0:0:0:0:0:0:0:1', '2016-09-17 18:07:51', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('229', 'admin', '1', '临时', '1', '8ECA3583F1F222B7557F1BAA36AFDB1C', '2016-09-20 17:48:12', '0:0:0:0:0:0:0:1', '2016-09-20 17:48:12', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('230', 'admin', '1', '临时', '1', '98AA2471E83BECE2D53EF962C1B58A58', '2016-09-21 21:33:44', '0:0:0:0:0:0:0:1', '2016-09-21 21:33:44', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('231', 'admin', '1', '临时', '1', '2D4D247BDD5DA88F4F0236E1FB03FEE3', '2016-09-29 16:42:16', '0:0:0:0:0:0:0:1', '2016-09-29 16:42:16', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('232', 'admin', '1', '临时', '1', '2CBE01DED20A89B657CCED7FB1299C6E', '2016-09-29 17:08:28', '0:0:0:0:0:0:0:1', '2016-09-29 17:08:28', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('233', 'admin', '1', '临时', '1', 'BA1642D2DA7E2D11EC513A717DC2ECBF', '2016-09-29 17:19:33', '0:0:0:0:0:0:0:1', '2016-09-29 17:19:33', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('234', 'admin', '1', '临时', '1', '3E6F532236A803E868F027147A37B225', '2016-10-05 08:43:37', '0:0:0:0:0:0:0:1', '2016-10-05 08:43:37', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('235', 'admin', '1', '临时', '1', 'F1F7207D2F1E51DDE21BFB16E183A697', '2016-10-05 10:25:53', '0:0:0:0:0:0:0:1', '2016-10-05 10:25:53', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('236', 'admin', '1', '临时', '1', 'BEF8E360B2F9CE890E0ED37AF7AD39D3', '2016-10-05 10:37:32', '0:0:0:0:0:0:0:1', '2016-10-05 10:37:32', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('237', 'admin', '1', '临时', '1', '5F8DBD0CD141469BC48DCA4F111D3390', '2016-10-05 10:43:14', '0:0:0:0:0:0:0:1', '2016-10-05 10:43:14', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('238', 'admin', '1', '临时', '1', '86A807992092B8D0EC09016ABBDBBC49', '2016-10-05 11:00:28', '0:0:0:0:0:0:0:1', '2016-10-05 11:00:28', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('239', 'admin', '1', '临时', '1', '9C9951C76C56DC128A9858EA110790D1', '2016-10-05 11:05:57', '0:0:0:0:0:0:0:1', '2016-10-05 11:05:57', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('240', 'admin', '1', '临时', '1', '22DBA601E8B8DE1F515AF1F91F107769', '2016-10-05 11:15:34', '0:0:0:0:0:0:0:1', '2016-10-05 11:15:34', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('241', 'admin', '1', '临时', '1', '4EBD6F279F7BB6C98C1C04323624FD71', '2016-10-05 11:26:41', '0:0:0:0:0:0:0:1', '2016-10-05 11:26:41', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('242', 'admin', '1', '临时', '1', '214D04BE14EE625B26211F88BA444CFE', '2016-10-05 12:40:59', '0:0:0:0:0:0:0:1', '2016-10-05 12:40:59', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('243', 'admin', '1', '临时', '1', '87AD263F3D1F58FC505B0B91C6C49BE7', '2016-10-05 15:35:22', '0:0:0:0:0:0:0:1', '2016-10-05 15:35:22', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('244', 'admin', '1', '临时', '1', '25AEF57F054863E05D7D1AA74CED115D', '2016-10-05 16:34:43', '0:0:0:0:0:0:0:1', '2016-10-05 16:34:43', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('245', 'admin', '1', '临时', '1', '17603BE5408793CFAFF7869CBDC45C0E', '2016-10-05 16:37:28', '0:0:0:0:0:0:0:1', '2016-10-05 16:37:28', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('246', 'admin', '1', '临时', '1', 'ED047F38975F34B242E39335900D7699', '2016-10-05 17:24:08', '0:0:0:0:0:0:0:1', '2016-10-05 17:24:08', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('247', 'admin', '1', '临时', '1', '4E36ED9DD13D9F294C5966D28733C6CD', '2016-10-06 14:43:30', '0:0:0:0:0:0:0:1', '2016-10-06 14:43:30', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('248', 'admin', '1', '临时', '1', '40D1C38DF6072A49386DDDD18B59D516', '2016-10-07 09:24:32', '0:0:0:0:0:0:0:1', '2016-10-07 09:24:32', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('249', 'admin', '1', '临时', '1', '5B0201B8AF5AD41B1D6817F5E853365C', '2016-10-07 14:25:01', '0:0:0:0:0:0:0:1', '2016-10-07 14:25:01', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('250', 'admin', '1', '临时', '1', '8FA032C2E3CCDE23FCDBEFD3AB3A4121', '2016-10-07 17:59:14', '0:0:0:0:0:0:0:1', '2016-10-07 17:59:14', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('251', 'admin', '1', '临时', '1', '977D59B016BD05BDFC93A9A324D5D987', '2016-10-08 21:13:30', '0:0:0:0:0:0:0:1', '2016-10-08 21:13:30', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('252', 'admin', '1', '临时', '1', '3FFF571BF7181AB986EDCA9FBEA4B788', '2016-10-09 08:06:36', '0:0:0:0:0:0:0:1', '2016-10-09 08:06:36', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('253', 'admin', '1', '临时', '1', '43EB5C8E20B16674532C88FBDF8CCF8C', '2016-10-09 12:39:10', '0:0:0:0:0:0:0:1', '2016-10-09 12:39:10', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('254', 'admin', '1', '临时', '1', '4703F8587887F96A54934EEC005D7003', '2016-10-09 20:40:58', '0:0:0:0:0:0:0:1', '2016-10-09 20:40:58', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('255', 'admin', '1', '临时', '1', '329E349DAD0C91C9A05DA608FE81E557', '2016-10-10 18:10:13', '0:0:0:0:0:0:0:1', '2016-10-10 18:10:13', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('256', 'admin', '1', '临时', '1', '34DD7C55BA12F0A794FE34312F28F23E', '2016-10-10 20:50:38', '0:0:0:0:0:0:0:1', '2016-10-10 20:50:38', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('257', 'admin', '1', '临时', '1', '94219311255E7C4DEA094C9E7A59F996', '2016-10-11 11:19:22', '172.16.10.69', '2016-10-11 11:19:22', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('258', 'admin', '1', '临时', '1', '94219311255E7C4DEA094C9E7A59F996', '2016-10-11 11:26:30', '172.16.10.69', '2016-10-11 11:26:30', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('259', 'admin', '1', '临时', '1', 'A656173DCD65C56AFA4D6E9B373D12CE', '2016-10-11 11:33:23', '172.16.10.69', '2016-10-11 11:33:23', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('260', 'admin', '1', '临时', '1', '6DDB7B172067070018C4E85ED3C9AAF5', '2016-10-11 11:42:56', '172.16.10.69', '2016-10-11 11:42:56', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('261', 'admin', '1', '临时', '1', 'B536C3F39ACF522E78D966604232F087', '2016-10-12 21:18:59', '0:0:0:0:0:0:0:1', '2016-10-12 21:18:59', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('262', 'admin', '1', '临时', '1', 'B2317DEB9EEAEDF90FAD1860016235B0', '2016-10-13 20:32:37', '0:0:0:0:0:0:0:1', '2016-10-13 20:32:37', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('263', 'admin', '1', '临时', '1', '82B44A5FDD11800380040191CF44C3E2', '2016-10-13 20:38:44', '0:0:0:0:0:0:0:1', '2016-10-13 20:38:44', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('264', 'admin', '1', '临时', '1', 'CEC430802CC5592ADA8F9FFDECD55E14', '2016-10-13 20:40:23', '0:0:0:0:0:0:0:1', '2016-10-13 20:40:23', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('265', 'admin', '1', '临时', '1', 'EDEE639CFC419E2103C27A0924C1660A', '2016-10-16 10:34:09', '0:0:0:0:0:0:0:1', '2016-10-16 10:34:09', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('266', 'admin', '1', '临时', '1', '2CD6845F3B1DF5F45745FFB9A6BD4684', '2016-10-16 11:12:50', '0:0:0:0:0:0:0:1', '2016-10-16 11:12:50', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('267', 'admin', '1', '临时', '1', '52F2631E3D30E3D8A1A76BD283A414A5', '2016-10-16 11:40:03', '0:0:0:0:0:0:0:1', '2016-10-16 11:40:03', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('268', 'admin', '1', '临时', '1', 'DE90C6B88352D6396E07D553D9231249', '2016-10-16 14:17:00', '0:0:0:0:0:0:0:1', '2016-10-16 14:17:00', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('269', 'admin', '1', '临时', '1', 'F297877E1F22E2C152EAD5986493AA64', '2016-10-16 14:29:22', '0:0:0:0:0:0:0:1', '2016-10-16 14:29:22', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('270', 'admin', '1', '临时', '1', 'D500EDD95D24EDA9A8B1E7789197184C', '2016-10-18 12:34:04', '0:0:0:0:0:0:0:1', '2016-10-18 12:34:04', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('271', 'admin', '1', '临时', '1', '9B5C8D7E85D11DDD0E42976E81FE66F5', '2016-10-18 21:27:14', '0:0:0:0:0:0:0:1', '2016-10-18 21:27:14', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('272', 'admin', '1', '临时', '1', 'C1E435836B2DE3BF442550529AA82CCD', '2016-10-19 20:23:15', '0:0:0:0:0:0:0:1', '2016-10-19 20:23:15', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('273', 'admin', '1', '临时', '1', '2C9118CB8AF71D9C9F4952644F618DB7', '2016-10-20 14:40:53', '0:0:0:0:0:0:0:1', '2016-10-20 14:40:53', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('274', 'admin', '1', '临时', '1', '909E2B1D75688D5D2A30E9AB2CB266E0', '2016-10-20 14:50:30', '0:0:0:0:0:0:0:1', '2016-10-20 14:50:30', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('275', 'admin', '1', '临时', '1', 'DB00395180275BF597F5DC1C85FFF1BA', '2016-10-20 15:30:31', '0:0:0:0:0:0:0:1', '2016-10-20 15:30:31', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('276', 'admin', '1', '临时', '1', '1EA7BC1731B2A984653FCB0A21159480', '2016-10-20 15:32:20', '0:0:0:0:0:0:0:1', '2016-10-20 15:32:20', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('277', 'admin', '1', '临时', '1', '5512B0E415E909BD5D98818471A35747', '2016-10-20 20:37:16', '0:0:0:0:0:0:0:1', '2016-10-20 20:37:16', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('278', 'admin', '1', '临时', '1', 'DB5491ECC0ECC753E472AC2D231A43DF', '2016-10-21 08:28:56', '0:0:0:0:0:0:0:1', '2016-10-21 08:28:56', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('279', 'admin', '1', '临时', '1', 'A5E43D5DEAC568A0FEA65A801C478056', '2016-10-21 18:09:02', '0:0:0:0:0:0:0:1', '2016-10-21 18:09:02', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('280', 'admin', '1', '临时', '1', '3912AB988B0731780B742C5A6E20E65E', '2016-10-21 20:27:44', '0:0:0:0:0:0:0:1', '2016-10-21 20:27:44', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('281', 'admin', '1', '临时', '1', '5CF0F9AA1DB2B529F4AF77255DF58991', '2016-10-23 09:35:28', '0:0:0:0:0:0:0:1', '2016-10-23 09:35:28', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('282', 'admin', '1', '临时', '1', '1EB7F137174DBC36CB158D8ADED1E283', '2016-10-23 09:44:38', '0:0:0:0:0:0:0:1', '2016-10-23 09:44:38', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('283', 'admin', '1', '临时', '1', '261BF17D6D9337EE28789E6344725227', '2016-10-23 11:41:40', '0:0:0:0:0:0:0:1', '2016-10-23 11:41:40', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('284', 'admin', '1', '临时', '1', 'D96A90A9E6C4C6C48F08A2EB10BF45BB', '2016-10-23 11:46:30', '0:0:0:0:0:0:0:1', '2016-10-23 11:46:30', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('285', 'admin', '1', '临时', '1', '315191EAFB25F06121BD4F6A1E714CAA', '2016-10-23 12:53:58', '0:0:0:0:0:0:0:1', '2016-10-23 12:53:58', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('286', 'admin', '1', '临时', '1', 'B006A1BC38D12CC184B37179BC944433', '2016-10-23 15:22:15', '0:0:0:0:0:0:0:1', '2016-10-23 15:22:15', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('287', 'admin', '1', '临时', '1', 'DED15D48726D713F31CE1016DBEB1BAD', '2016-10-23 15:41:34', '0:0:0:0:0:0:0:1', '2016-10-23 15:41:34', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('288', 'admin', '1', '临时', '1', 'C99B04845CFEA8C372ADD1AB3849646F', '2016-10-23 18:07:00', '0:0:0:0:0:0:0:1', '2016-10-23 18:07:00', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('289', 'admin', '1', '临时', '1', '897913FED86A0E01B6E543A720F93C2A', '2016-10-23 18:21:10', '0:0:0:0:0:0:0:1', '2016-10-23 18:21:10', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('290', 'admin', '1', '临时', '1', '5D27AC45A14EFC2048765B479721CD42', '2016-10-24 20:23:40', '0:0:0:0:0:0:0:1', '2016-10-24 20:23:40', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('291', 'admin', '1', '临时', '1', 'BE8B27027E41395931EBB95E81BBCC08', '2016-10-24 22:27:53', '0:0:0:0:0:0:0:1', '2016-10-24 22:27:53', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('292', 'admin', '1', '临时', '1', '31730D3E04AC49063E48ECB6C313F184', '2016-10-25 20:53:14', '0:0:0:0:0:0:0:1', '2016-10-25 20:53:14', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('293', 'admin', '1', '临时', '1', 'CF5AB2A82A2690DE6E2F31C05527B453', '2016-10-26 21:15:01', '0:0:0:0:0:0:0:1', '2016-10-26 21:15:01', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('294', 'admin', '1', '临时', '1', 'A93DCE032CE6ADDD7E7926D8D73BCF4A', '2016-10-26 21:30:59', '0:0:0:0:0:0:0:1', '2016-10-26 21:30:59', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('295', 'admin', '1', '临时', '1', '98622414F01021B9F5CAABCAA03E7DCE', '2016-10-26 21:42:48', '0:0:0:0:0:0:0:1', '2016-10-26 21:42:48', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('296', 'admin', '1', '临时', '1', '083C1AE5B30C8AE7540D74ED63D4D001', '2016-10-26 21:55:50', '0:0:0:0:0:0:0:1', '2016-10-26 21:55:50', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('297', 'admin', '1', '临时', '1', 'FC71508186ABE91EA6E79AABB480290E', '2016-10-27 20:01:40', '0:0:0:0:0:0:0:1', '2016-10-27 20:01:40', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('298', 'admin', '1', '临时', '1', '813B467A2B11ABA986F2EE64410EE562', '2016-10-28 08:55:05', '0:0:0:0:0:0:0:1', '2016-10-28 08:55:05', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('299', 'admin', '1', '临时', '1', 'F7CD29147350CF8F4596C2873981A80C', '2016-10-28 19:15:56', '0:0:0:0:0:0:0:1', '2016-10-28 19:15:56', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('300', 'admin', '1', '临时', '1', '74B8E43E5C80FA5A8B2746E8FD030CDB', '2016-10-28 21:14:12', '0:0:0:0:0:0:0:1', '2016-10-28 21:14:12', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('301', 'admin', '1', '临时', '1', 'A512F45BCFB8D7265AEC84A916A0E675', '2016-10-28 23:23:53', '0:0:0:0:0:0:0:1', '2016-10-28 23:23:53', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('302', 'admin', '1', '临时', '1', '4AF2FF9D4947F7349843B498063F9410', '2016-10-30 10:15:15', '0:0:0:0:0:0:0:1', '2016-10-30 10:15:15', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('303', 'admin', '1', '临时', '1', 'F2551D86E26034105F049FC0171C8819', '2016-10-30 13:10:08', '0:0:0:0:0:0:0:1', '2016-10-30 13:10:08', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('304', 'admin', '1', '临时', '1', 'F1545BF253183D943EDC0BD073FD27D0', '2016-10-30 17:53:05', '0:0:0:0:0:0:0:1', '2016-10-30 17:53:05', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('305', 'admin', '1', '临时', '1', '3B23755AD24BFAA2D20C84B333003E11', '2016-10-30 18:05:38', '0:0:0:0:0:0:0:1', '2016-10-30 18:05:38', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('306', 'admin', '1', '临时', '1', '444678A1F2F742AFE5CC96E03ED25CEF', '2016-10-30 18:09:18', '0:0:0:0:0:0:0:1', '2016-10-30 18:09:18', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('307', 'admin', '1', '临时', '1', '1C14C7B9083861032F23F4311A942240', '2016-10-30 18:11:41', '0:0:0:0:0:0:0:1', '2016-10-30 18:11:41', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('308', 'admin', '1', '临时', '1', '9144D3884178076E501064E357DBA9AE', '2016-10-30 18:14:10', '0:0:0:0:0:0:0:1', '2016-10-30 18:14:10', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('309', 'admin', '1', '临时', '1', 'E0B7BB51DE3F84F7C1CEA803847EA369', '2016-10-30 18:18:36', '0:0:0:0:0:0:0:1', '2016-10-30 18:18:36', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('310', 'admin', '1', '临时', '1', '61B0EDD36816E324659FC4E767E2DB2A', '2016-10-30 18:24:13', '0:0:0:0:0:0:0:1', '2016-10-30 18:24:13', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('311', 'admin', '1', '临时', '1', '97CBC9777BD95471D6D9900FD09E5184', '2016-10-30 18:32:01', '0:0:0:0:0:0:0:1', '2016-10-30 18:32:01', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('312', 'admin', '1', '临时', '1', 'E359281A756936F5172A70C666CB57E2', '2016-10-30 18:36:06', '0:0:0:0:0:0:0:1', '2016-10-30 18:36:06', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('313', 'admin', '1', '临时', '1', '1875424A1964568E69457F82AC392BDA', '2016-10-30 18:42:12', '0:0:0:0:0:0:0:1', '2016-10-30 18:42:12', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('314', 'admin', '1', '临时', '1', '90FCDA96ABF7E9F1017E1BF68A94EAEF', '2016-10-30 18:56:52', '0:0:0:0:0:0:0:1', '2016-10-30 18:56:52', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('315', 'admin', '1', '临时', '1', '28AE669A77BB22B0E7F4B1ACF7BB6DFF', '2016-10-30 19:00:24', '0:0:0:0:0:0:0:1', '2016-10-30 19:00:24', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('316', 'admin', '1', '临时', '1', '35EE28DC1DAA81ADA85927FD28347347', '2016-10-30 19:03:07', '0:0:0:0:0:0:0:1', '2016-10-30 19:03:07', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('317', 'admin', '1', '临时', '1', '6699696215C3BD96D2A4E3ECA979DA6F', '2016-10-30 19:09:44', '0:0:0:0:0:0:0:1', '2016-10-30 19:09:44', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('318', 'admin', '1', '临时', '1', '26A74B8D4F6CDC515BFA92C1694AFA6E', '2016-10-30 19:17:07', '0:0:0:0:0:0:0:1', '2016-10-30 19:17:07', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('319', 'admin', '1', '临时', '1', 'EE2C693318DEAF91A23BBC60B3B2FBD1', '2016-10-30 19:19:30', '0:0:0:0:0:0:0:1', '2016-10-30 19:19:30', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('320', 'admin', '1', '临时', '1', '6AB34EC3588BFEC0F80CA25B5C3152A0', '2016-10-30 19:27:53', '0:0:0:0:0:0:0:1', '2016-10-30 19:27:53', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('321', 'admin', '1', '临时', '1', '1AD30872679B1D6601CB3F62FE72ECA9', '2016-10-30 19:32:19', '0:0:0:0:0:0:0:1', '2016-10-30 19:32:19', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('322', 'admin', '1', '临时', '1', 'A1528E8861840E3FBCB8DD0D8247669D', '2016-10-30 19:34:50', '0:0:0:0:0:0:0:1', '2016-10-30 19:34:50', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('323', 'admin', '1', '临时', '1', 'BFD0D628B865D207EE75F715F76549AB', '2016-10-30 19:36:54', '0:0:0:0:0:0:0:1', '2016-10-30 19:36:54', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('324', 'admin', '1', '临时', '1', '905BD021D6A82BE67A735D05298FB67C', '2016-10-30 19:41:40', '0:0:0:0:0:0:0:1', '2016-10-30 19:41:40', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('325', 'admin', '1', '临时', '1', '54B941AE2FDE335CAE48FC73B8836A68', '2016-10-30 19:46:26', '0:0:0:0:0:0:0:1', '2016-10-30 19:46:26', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('326', 'admin', '1', '临时', '1', 'D7AFE6517FCDF2D1F50EA12632D24E20', '2016-10-30 19:49:36', '0:0:0:0:0:0:0:1', '2016-10-30 19:49:36', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('327', 'admin', '1', '临时', '1', 'F32EA46B3C0B101FF6BE215B5DBE1F9F', '2016-10-30 19:54:57', '0:0:0:0:0:0:0:1', '2016-10-30 19:54:57', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('328', 'admin', '1', '临时', '1', '99A7D8F0BC91D74BAD857AEC622D92D2', '2016-10-30 19:58:47', '0:0:0:0:0:0:0:1', '2016-10-30 19:58:47', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('329', 'admin', '1', '临时', '1', '9A632214CC7CADB2A38EFFAB946619E6', '2016-10-30 20:05:16', '0:0:0:0:0:0:0:1', '2016-10-30 20:05:16', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('330', 'admin', '1', '临时', '1', '4E2B314862DA57DBC9B770E3BA8F1BDD', '2016-10-30 20:21:05', '0:0:0:0:0:0:0:1', '2016-10-30 20:21:05', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('331', 'admin', '1', '临时', '1', 'C8EB05F81EA137D54735A767C119DACF', '2016-10-30 20:24:18', '0:0:0:0:0:0:0:1', '2016-10-30 20:24:18', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('332', 'admin', '1', '临时', '1', 'B33E2CB05B840122DD640DBDF729BE58', '2016-10-30 20:27:50', '0:0:0:0:0:0:0:1', '2016-10-30 20:27:50', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('333', 'admin', '1', '临时', '1', '4683802F6A686CCDF619B5249FF3B37A', '2016-10-30 20:38:55', '0:0:0:0:0:0:0:1', '2016-10-30 20:38:55', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('334', 'admin', '1', '临时', '1', '2CC64091881EDB14D49990EFDB66AB41', '2016-10-31 09:03:27', '0:0:0:0:0:0:0:1', '2016-10-31 09:03:27', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('335', 'admin', '1', '临时', '1', '2CC64091881EDB14D49990EFDB66AB41', '2016-10-31 09:03:27', '0:0:0:0:0:0:0:1', '2016-10-31 09:03:27', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('336', 'admin', '1', '临时', '1', '87DEE7CE55418200ED946CAE496F6B84', '2016-10-31 09:27:02', '0:0:0:0:0:0:0:1', '2016-10-31 09:27:02', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('337', 'admin', '1', '临时', '1', '1447F6C7B8A62166F6BD790ED389DC18', '2016-10-31 18:13:06', '0:0:0:0:0:0:0:1', '2016-10-31 18:13:06', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('338', 'admin', '1', '临时', '1', '1C7C4091B86A972CD8CC6335BABFDD25', '2016-11-01 08:48:08', '0:0:0:0:0:0:0:1', '2016-11-01 08:48:08', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('339', 'admin', '1', '??', '1', '3C2F4122ECC8E43BFAF81EA4B51A9A60', '2016-11-01 17:54:20', '0:0:0:0:0:0:0:1', '2016-11-01 17:54:20', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('340', 'admin', '1', '??', '1', 'C441AE7FB1A3AFC0B9E68450A1038937', '2016-11-01 18:08:12', '0:0:0:0:0:0:0:1', '2016-11-01 18:08:12', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('341', 'admin', '1', '??', '1', '0F8B64851D5F0F03998041EA1FB18EB9', '2016-11-01 18:47:25', '0:0:0:0:0:0:0:1', '2016-11-01 18:47:25', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('342', 'admin', '1', '??', '1', '744CCAD5550644B158D256E56FF0F6C0', '2016-11-01 23:04:06', '0:0:0:0:0:0:0:1', '2016-11-01 23:04:06', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('343', 'admin', '1', '临时', '1', '6EFFBE434B65ACD9F55F2D0A4F98F493', '2016-11-06 09:51:51', '0:0:0:0:0:0:0:1', '2016-11-06 09:51:51', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('344', 'admin', '1', '临时', '1', '292BC9231CBDDAB8A5DC50414766450F', '2016-11-07 17:44:15', '0:0:0:0:0:0:0:1', '2016-11-07 17:44:15', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('345', 'admin', '1', '临时', '1', '18DFBE9BA797A52FC8F0DED336CC695A', '2016-11-07 17:56:05', '0:0:0:0:0:0:0:1', '2016-11-07 17:56:05', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('346', 'admin', '1', '临时', '1', '2744814978A9D8C1AFB3FA17C962A603', '2016-11-08 17:00:03', '0:0:0:0:0:0:0:1', '2016-11-08 17:00:03', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('347', 'admin', '1', '临时', '1', '7027C4667837E1EFB5975F8E103FC0CC', '2016-11-08 17:03:44', '0:0:0:0:0:0:0:1', '2016-11-08 17:03:44', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('348', 'admin', '1', '临时', '1', '018B7832007EFC1214B9F4328A95A829', '2016-11-16 21:40:27', '0:0:0:0:0:0:0:1', '2016-11-16 21:40:27', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('349', 'admin', '1', '临时', '1', '7C2AE9EC6810033E4021965BC1F1AEE6', '2016-11-17 18:14:44', '0:0:0:0:0:0:0:1', '2016-11-17 18:14:44', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('350', 'admin', '1', '临时', '1', '2C1097DAF863EA1F9FEC3B72D43A72F6', '2016-11-22 17:54:50', '0:0:0:0:0:0:0:1', '2016-11-22 17:54:50', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('351', 'admin', '1', '临时', '1', '2512D1B893F26E32F3ADC60355EFA94E', '2016-11-24 18:10:35', '0:0:0:0:0:0:0:1', '2016-11-24 18:10:35', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('352', 'admin', '1', '临时', '1', 'FF148FBF5FF1E273F88E08482C3E1847', '2016-11-24 18:21:06', '0:0:0:0:0:0:0:1', '2016-11-24 18:21:06', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('353', 'admin', '1', '临时', '1', '965D006BDE1DC9A7FAB9B9C7AC014EC5', '2016-11-24 18:33:19', '0:0:0:0:0:0:0:1', '2016-11-24 18:33:19', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('354', 'admin', '1', '临时', '1', '8F8111D305D8803517960C7F634D1299', '2016-11-24 18:39:01', '0:0:0:0:0:0:0:1', '2016-11-24 18:39:01', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('355', 'admin', '1', '临时', '1', 'B7FF33019DDD5FE3ADE4727D0D14D192', '2016-11-24 18:44:44', '0:0:0:0:0:0:0:1', '2016-11-24 18:44:44', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('356', 'admin', '1', '临时', '1', 'D7DE5050184C17E7F16770DF4DC3A5D5', '2016-11-24 19:06:54', '0:0:0:0:0:0:0:1', '2016-11-24 19:06:54', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('357', 'admin', '1', '临时', '1', '9310BA47080E52F4E48A1B67B242D9A3', '2016-11-24 19:38:16', '0:0:0:0:0:0:0:1', '2016-11-24 19:38:16', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('358', 'admin', '1', '临时', '1', 'B815464EE71CA2D395FFA96E3D2320BB', '2016-11-27 09:36:44', '0:0:0:0:0:0:0:1', '2016-11-27 09:36:44', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('359', 'admin', '1', '临时', '1', 'D412F46BCD120CCB1BD58B53E89DB86B', '2016-12-05 08:42:15', '0:0:0:0:0:0:0:1', '2016-12-05 08:42:15', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('360', 'admin', '1', '临时', '1', '9D4916FB4CBD803D369447E369D4665E', '2016-12-05 09:14:21', '0:0:0:0:0:0:0:1', '2016-12-05 09:14:21', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('361', 'admin', '1', '临时', '1', '6FFE87C5CDCB2A7F17DA44134C815041', '2016-12-08 11:33:14', '0:0:0:0:0:0:0:1', '2016-12-08 11:33:14', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('362', 'admin', '1', '临时', '1', '9DBA8AF1DF167F38410C05A577F57449', '2016-12-08 12:35:33', '0:0:0:0:0:0:0:1', '2016-12-08 12:35:33', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('363', 'admin', '1', '临时', '1', '42BBEFEAEB41B751A614F72875291488', '2016-12-13 16:59:20', '0:0:0:0:0:0:0:1', '2016-12-13 16:59:20', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('364', 'admin', '1', '临时', '1', '520EC956F57C89DD0075C0D9C530623B', '2016-12-13 17:04:07', '127.0.0.1', '2016-12-13 17:04:07', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('365', 'admin', '1', '临时', '1', '839F3A8810763F4DCEF4D9C3A2DD4F8E', '2016-12-22 08:37:05', '0:0:0:0:0:0:0:1', '2016-12-22 08:37:05', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('366', 'admin', '1', '??', '1', 'DF0D285BBC18E557438A34CA09FCEE69', '2016-12-25 10:40:01', '0:0:0:0:0:0:0:1', '2016-12-25 10:40:01', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('367', 'admin', '1', '临时', '1', 'A494D3BE096F640FEDFA555E90280569', '2016-12-28 20:38:07', '0:0:0:0:0:0:0:1', '2016-12-28 20:38:07', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('368', 'admin', '1', '临时', '1', '62817D679D9DE322EC6C3304E39F1775', '2016-12-29 17:46:57', '0:0:0:0:0:0:0:1', '2016-12-29 17:46:57', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('369', 'admin', '1', '临时', '1', 'C7772C86695C744964A9EFFBFED8E9B4', '2017-01-03 11:21:52', '0:0:0:0:0:0:0:1', '2017-01-03 11:21:52', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('370', 'admin', '1', '临时', '1', '822D0CBF7B182CF0A2051551473263C8', '2017-01-03 14:53:28', '0:0:0:0:0:0:0:1', '2017-01-03 14:53:28', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('371', 'admin', '1', '临时', '1', '9529CB0F3BC065DAF442506F31496C83', '2017-01-04 13:51:54', '0:0:0:0:0:0:0:1', '2017-01-04 13:51:54', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('372', 'admin', '1', '临时', '1', 'BFC22545217CEFCA061664D5774C7B02', '2017-01-04 18:30:48', '0:0:0:0:0:0:0:1', '2017-01-04 18:30:48', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('373', 'admin', '1', '临时', '1', 'C1D96DE42EDA7FA1E6FA5256E0766557', '2017-01-04 20:41:01', '0:0:0:0:0:0:0:1', '2017-01-04 20:41:01', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('374', 'admin', '1', '临时', '1', 'D902C60D907B10506F9A8E2201D17FCB', '2017-01-05 15:02:28', '0:0:0:0:0:0:0:1', '2017-01-05 15:02:28', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('375', 'admin', '1', '临时', '1', 'DC08C923F1815F298555AD88CFBB6F2A', '2017-01-06 19:07:12', '0:0:0:0:0:0:0:1', '2017-01-06 19:07:12', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('376', 'admin', '1', '临时', '1', 'DFF16BD0C7BB51E385ADD39932B55B5D', '2017-01-08 18:28:37', '0:0:0:0:0:0:0:1', '2017-01-08 18:28:37', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('377', 'admin', '1', '临时', '1', 'DFF16BD0C7BB51E385ADD39932B55B5D', '2017-01-08 18:28:37', '0:0:0:0:0:0:0:1', '2017-01-08 18:28:37', '');
INSERT INTO `tbl_userlogin_logs` VALUES ('378', 'admin', '1', '临时', '1', 'DFF16BD0C7BB51E385ADD39932B55B5D', '2017-01-08 19:49:48', '0:0:0:0:0:0:0:1', '2017-01-08 19:49:48', '');

-- ----------------------------
-- Table structure for t_article
-- ----------------------------
DROP TABLE IF EXISTS `t_article`;
CREATE TABLE `t_article` (
  `Id` int(11) NOT NULL auto_increment,
  `classid` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `subtitle` varchar(250) default NULL,
  `summary` text,
  `img` text,
  `author` varchar(50) default NULL,
  `fromwhere` varchar(50) default NULL,
  `KeyWords` varchar(200) default NULL,
  `readLevel` varchar(100) default NULL,
  `pubdate` varchar(50) default NULL,
  `pagenum` int(11) NOT NULL,
  `hits` int(11) NOT NULL,
  `istop` int(11) NOT NULL,
  `ishot` int(11) NOT NULL,
  `isrecommend` int(11) NOT NULL,
  `isdel` int(11) NOT NULL,
  `ischeck` int(11) NOT NULL,
  `do_time` datetime default NULL,
  `userid` varchar(50) default NULL,
  `username` varchar(50) default NULL,
  `siteurl` varchar(50) default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of t_article
-- ----------------------------

-- ----------------------------
-- Table structure for t_article_contents
-- ----------------------------
DROP TABLE IF EXISTS `t_article_contents`;
CREATE TABLE `t_article_contents` (
  `Id` int(11) NOT NULL auto_increment,
  `ArticleId` int(11) NOT NULL,
  `contents` text,
  `pagenum` int(11) NOT NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of t_article_contents
-- ----------------------------

-- ----------------------------
-- Table structure for t_channel_article
-- ----------------------------
DROP TABLE IF EXISTS `t_channel_article`;
CREATE TABLE `t_channel_article` (
  `Id` int(11) NOT NULL auto_increment,
  `ArticleId` int(11) NOT NULL,
  `classid` int(11) NOT NULL,
  `istop` int(11) NOT NULL,
  `ishot` int(11) NOT NULL,
  `isrecommend` int(11) NOT NULL,
  `isdel` int(11) NOT NULL,
  `ischeck` int(11) NOT NULL,
  `pubdate` varchar(30) NOT NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of t_channel_article
-- ----------------------------

-- ----------------------------
-- Table structure for user_jiaose
-- ----------------------------
DROP TABLE IF EXISTS `user_jiaose`;
CREATE TABLE `user_jiaose` (
  `id` int(11) NOT NULL auto_increment,
  `code` varchar(50) default NULL,
  `name` varchar(50) default NULL,
  `pid` int(11) default NULL,
  `module` text,
  `remark` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of user_jiaose
-- ----------------------------

-- ----------------------------
-- Table structure for user_jiaoselist
-- ----------------------------
DROP TABLE IF EXISTS `user_jiaoselist`;
CREATE TABLE `user_jiaoselist` (
  `id` int(11) NOT NULL auto_increment,
  `jiaoseid` int(11) default NULL,
  `jiaosename` varchar(50) default NULL,
  `userId` varchar(50) default NULL,
  `userName` varchar(50) default NULL,
  `deptId` varchar(50) default NULL,
  `deptName` varchar(50) default NULL,
  `userType` varchar(50) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of user_jiaoselist
-- ----------------------------

-- ----------------------------
-- Table structure for user_module
-- ----------------------------
DROP TABLE IF EXISTS `user_module`;
CREATE TABLE `user_module` (
  `id` int(11) NOT NULL auto_increment,
  `code` varchar(50) default NULL,
  `name` varchar(50) default NULL,
  `pid` int(11) default NULL,
  `filename` text,
  `canshu` text,
  `remark` varchar(255) default NULL,
  `ModuleType` varchar(35) default NULL,
  `openFlag` varchar(10) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=45 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of user_module
-- ----------------------------
INSERT INTO `user_module` VALUES ('1', '0001', '车辆管理', '0', null, '*', '3', '数据中心', null);
INSERT INTO `user_module` VALUES ('2', '0002', '任务管理', '0', null, '*', '1', '数据中心', null);
INSERT INTO `user_module` VALUES ('3', '00010001', '车辆管理', '1', 'admin/index_tree.jsp?cmd=CarCode', '*', null, '数据中心', null);
INSERT INTO `user_module` VALUES ('6', '00010004', '车辆运行记录', '1', 'agv/CarSchedulingAction.jsp?cmd=list', '*', '3', '数据中心', null);
INSERT INTO `user_module` VALUES ('7', '00020001', '任务管理', '2', 'agv/TaskAction.jsp', '*', '1', '数据中心', null);
INSERT INTO `user_module` VALUES ('16', '0005', '权限管理', '0', '', '', '6', '数据中心', '');
INSERT INTO `user_module` VALUES ('14', '00040001', '部门管理', '13', 'admin/role_index_tree.jsp?cmd=OfficeInfo', '', '', '数据中心', '');
INSERT INTO `user_module` VALUES ('13', '0004', '用户管理', '0', '', '', '5', '数据中心', '');
INSERT INTO `user_module` VALUES ('15', '00040002', '用户管理', '13', 'admin/role_index_tree.jsp?cmd=userBaseInfo', '', '', '数据中心', '');
INSERT INTO `user_module` VALUES ('10', '0003', '数据字典', '0', '', '*', '4', '数据中心', '');
INSERT INTO `user_module` VALUES ('11', '00030001', '站点管理', '10', 'admin/role_index_tree.jsp?cmd=RfidCode', '*', '4', '数据中心', '');
INSERT INTO `user_module` VALUES ('12', '00030002', '命令管理', '10', 'agv/CommandsAction.jsp?cmd=list', '*', '3', '数据中心', '');
INSERT INTO `user_module` VALUES ('17', '00050001', '模块管理', '16', 'admin/role_index_tree.jsp?cmd=UserModule', '', '', '数据中心', '');
INSERT INTO `user_module` VALUES ('18', '00050002', '角色管理', '16', 'admin/role_index_tree.jsp?cmd=JiaoSe', '', '', '数据中心', '');
INSERT INTO `user_module` VALUES ('37', '00030008', '任务状态', '10', 'agv/TaskStateAction.jsp', '*', '5', '数据中心', '');
INSERT INTO `user_module` VALUES ('19', '00030003', '路径管理', '10', 'agv/PathsAction.jsp?cmd=list', '*', '1', '数据中心', '');
INSERT INTO `user_module` VALUES ('20', '0006', '统计管理', '0', '', '*', '4', '数据中心', '');
INSERT INTO `user_module` VALUES ('21', '00060001', '任务统计', '20', '', '*', '', '数据中心', '');
INSERT INTO `user_module` VALUES ('22', '00060002', '路径利用统计', '20', '', '*', '', '数据中心', '');
INSERT INTO `user_module` VALUES ('23', '00060003', '车辆利用统计', '20', '', '*', '', '数据中心', '');
INSERT INTO `user_module` VALUES ('24', '00060004', '充电统计', '20', '', '*', '', '数据中心', '');
INSERT INTO `user_module` VALUES ('25', '00060005', '维修统计', '20', '', '*', '', '数据中心', '');
INSERT INTO `user_module` VALUES ('26', '0007', '任务队列', '0', '执行区', '*', '2', '数据中心', '');
INSERT INTO `user_module` VALUES ('27', '00070001', '执行区', '26', 'agv/TaskQueneAction.jsp', '*', '3', '数据中心', '');
INSERT INTO `user_module` VALUES ('28', '00070002', '缓冲区', '26', 'agv/TaskQueneAction.jsp', '*', '2', '数据中心', '');
INSERT INTO `user_module` VALUES ('29', '00070003', '待命区', '26', 'agv/TaskQueneAction.jsp', '*', '1', '数据中心', '');
INSERT INTO `user_module` VALUES ('30', '00010005', '车辆运行信息', '1', 'agv/CarAction.jsp?cmd=list', '*', '2', '数据中心', '');
INSERT INTO `user_module` VALUES ('34', '00010006', '命令车辆', '1', 'agv/test2.jsp', '*', '4', '数据中心', '');
INSERT INTO `user_module` VALUES ('32', '00030005', '通信操作指令', '10', 'admin/role_index_tree.jsp?cmd=Opeorder', '*', '7', '数据中心', '');
INSERT INTO `user_module` VALUES ('33', '00030006', '车辆控制参数', '10', 'admin/role_index_tree.jsp?cmd=Controlcar', '*', '8', '数据中心', '');
INSERT INTO `user_module` VALUES ('35', '00030007', '路径标识点', '10', 'agv/PathBsAction.jsp', '*', '2', '数据中心', '');
INSERT INTO `user_module` VALUES ('36', '00010007', '通讯管理', '1', 'agv/Commucation.jsp', '*', '', '数据中心', '');
INSERT INTO `user_module` VALUES ('38', '00030009', '任务类型', '10', 'agv/TaskTypeAction.jsp', '*', '6', '数据中心', '');
INSERT INTO `user_module` VALUES ('39', '00020002', '任务执行', '2', 'agv/rwzx.jsp', '', '2', '数据中心', '');
INSERT INTO `user_module` VALUES ('40', '00020003', '任务控制', '2', 'agv/rwjk.jsp', '*', '3', '数据中心', '');
INSERT INTO `user_module` VALUES ('41', '00020004', '服务管理', '2', 'agv/fwgl.jsp', '', '0', '数据中心', '');
INSERT INTO `user_module` VALUES ('44', '00020005', '图像监控', '2', 'agv/txjk.jsp', '*', '99', '数据中心', '');

-- ----------------------------
-- Table structure for user_modulelist
-- ----------------------------
DROP TABLE IF EXISTS `user_modulelist`;
CREATE TABLE `user_modulelist` (
  `id` int(11) NOT NULL auto_increment,
  `usertype` varchar(20) default NULL,
  `userid` varchar(50) default NULL,
  `userName` varchar(50) default NULL,
  `deptId` varchar(50) default NULL,
  `deptName` varchar(50) default NULL,
  `moduleId` int(11) default NULL,
  `moduleCode` varchar(20) default NULL,
  `moduleName` varchar(50) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of user_modulelist
-- ----------------------------
INSERT INTO `user_modulelist` VALUES ('9', '', '1', 'admin', '1', '临时', '13', '0004', '用户管理');
INSERT INTO `user_modulelist` VALUES ('13', '', '1', 'admin', '1', '临时', '39', '00020002', '任务执行');
INSERT INTO `user_modulelist` VALUES ('3', '', '1', 'admin', '1', '临时', '15', '00040002', '用户管理');
INSERT INTO `user_modulelist` VALUES ('10', '', '1', 'admin', '1', '临时', '16', '0005', '权限管理');
INSERT INTO `user_modulelist` VALUES ('5', '', '1', 'admin', '1', '临时', '17', '00050001', '模块管理');
INSERT INTO `user_modulelist` VALUES ('6', '', '1', 'admin', '1', '临时', '18', '00050002', '角色管理');
INSERT INTO `user_modulelist` VALUES ('14', '', '1', 'admin', '1', '临时', '40', '00020003', '任务监控');
INSERT INTO `user_modulelist` VALUES ('15', '', '1', 'admin', '1', '临时', '41', '00020004', '服务管理');

-- ----------------------------
-- Table structure for zhiwei_code
-- ----------------------------
DROP TABLE IF EXISTS `zhiwei_code`;
CREATE TABLE `zhiwei_code` (
  `id` int(11) NOT NULL auto_increment,
  `pid` int(11) default NULL,
  `pcode` varchar(50) default NULL,
  `name` varchar(50) default NULL,
  `code` varchar(50) default NULL,
  `remark` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of zhiwei_code
-- ----------------------------
