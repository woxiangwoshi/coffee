/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50562
Source Host           : localhost:3306
Source Database       : coffee

Target Server Type    : MYSQL
Target Server Version : 50562
File Encoding         : 65001

Date: 2020-11-13 12:44:08
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for coffee
-- ----------------------------
DROP TABLE IF EXISTS `coffee`;
CREATE TABLE `coffee` (
  `coffeeId` int(11) NOT NULL,
  `coffeeName` varchar(20) NOT NULL,
  `coffeeKinds` varchar(255) DEFAULT NULL,
  `coffeeDiscount` varchar(10) NOT NULL,
  `newPrice` int(11) NOT NULL,
  `oldPrice` int(11) NOT NULL,
  `coffeeImage` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`coffeeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of coffee
-- ----------------------------
INSERT INTO `coffee` VALUES ('1', '意式', '口味清淡，有回甘', '7.5折', '6', '20', '1234567891.jpg');
INSERT INTO `coffee` VALUES ('2', '美式', '口味浓郁，有韵味', '8.0折', '8', '20', '1234567892.jpg');
INSERT INTO `coffee` VALUES ('3', '拿铁', '口味浓郁', '9.5折', '9', '20', '1234567893.jpg');
INSERT INTO `coffee` VALUES ('4', '卡布', '口味浓郁，很苦', '9.0折', '11', '18', '1234567894.jpg');
INSERT INTO `coffee` VALUES ('5', '牛奶', '经典有机奶', '8折', '10', '18', '1234567895.jpg');
INSERT INTO `coffee` VALUES ('6', '热水', '直男专属饮品', '9.0折', '10', '18', '1234567896.jpg');
INSERT INTO `coffee` VALUES ('7', 'Doppio', '浓缩咖啡之一', '9.0折', '10', '18', '1234567897.jpg');
INSERT INTO `coffee` VALUES ('8', 'Ristro', '浓缩咖啡之二', '9.0折', '10', '18', '1234567898.jpg');
INSERT INTO `coffee` VALUES ('9', 'Lungo', '浓缩咖啡之三', '9.0折', '10', '18', '1234567899.jpg');
INSERT INTO `coffee` VALUES ('10', 'Flat milk', '平牛奶？', '9.0折', '10', '18', '12345678910.jpg');
INSERT INTO `coffee` VALUES ('11', 'With milk', '牛奶咖啡', '9.0折', '10', '18', '12345678911.jpg');
INSERT INTO `coffee` VALUES ('12', '拿铁 + 玛奇朵', '拿铁玛奇朵，幸福一加一', '9.0折', '10', '18', '12345678912.jpg');
INSERT INTO `coffee` VALUES ('13', '卡布奇诺Mix', '卡布卡布', '9.0折', '10', '18', '12345678913.jpg');
INSERT INTO `coffee` VALUES ('14', 'inver 玛奇朵', '*****玛奇朵', '9.0折', '10', '18', '12345678914.jpg');
INSERT INTO `coffee` VALUES ('15', '白茶', '中国的茶之一', '9.0折', '10', '18', '12345678915.jpg');
INSERT INTO `coffee` VALUES ('16', '红茶', '中国的茶之二', '9.0折', '10', '18', '12345678916.jpg');
INSERT INTO `coffee` VALUES ('17', '黑茶', '中国的茶之三', '9.0折', '10', '18', '12345678917.jpg');
INSERT INTO `coffee` VALUES ('18', '绿茶', '中国的茶之四', '9.0折', '10', '18', '12345678918.jpg');
INSERT INTO `coffee` VALUES ('19', 'Roobios', '很不懂的咖啡', '9.0折', '10', '18', '12345678919.jpg');
INSERT INTO `coffee` VALUES ('20', 'infs', '我怀疑它在乱打', '9.0折', '10', '18', '12345678920.jpg');

-- ----------------------------
-- Table structure for coffeemachine
-- ----------------------------
DROP TABLE IF EXISTS `coffeemachine`;
CREATE TABLE `coffeemachine` (
  `machineId` int(11) NOT NULL,
  `coffeemachine` varchar(255) NOT NULL,
  `machineKinds` varchar(255) NOT NULL,
  `state` int(1) NOT NULL,
  `machinePrice` int(11) NOT NULL,
  `note` varchar(255) DEFAULT NULL,
  `menuId` int(11) DEFAULT NULL,
  `serialnumber` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`machineId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of coffeemachine
-- ----------------------------
INSERT INTO `coffeemachine` VALUES ('1', '咖啡机1号', '方便实用', '1', '100', '无', '2', '320101000008');
INSERT INTO `coffeemachine` VALUES ('2', '咖啡机2号', '222333', '0', '200', '咖啡机2号', '3', null);

-- ----------------------------
-- Table structure for coffeemessage
-- ----------------------------
DROP TABLE IF EXISTS `coffeemessage`;
CREATE TABLE `coffeemessage` (
  `coffeeName` varchar(255) NOT NULL,
  `local` varchar(255) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`coffeeName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of coffeemessage
-- ----------------------------
INSERT INTO `coffeemessage` VALUES ('Doppio', '意大利', '苦的想吃糖');
INSERT INTO `coffeemessage` VALUES ('Flat milk', '荷兰', '很甜');
INSERT INTO `coffeemessage` VALUES ('infs', '俄罗斯', '苦的想吃糖');
INSERT INTO `coffeemessage` VALUES ('inver 玛奇朵', '印度', '香香的');
INSERT INTO `coffeemessage` VALUES ('Lungo', '美国', '苦的想吃糖');
INSERT INTO `coffeemessage` VALUES ('Ristro', '意大利', '苦的想吃糖');
INSERT INTO `coffeemessage` VALUES ('Roobios', '俄罗斯', '苦的想吃糖');
INSERT INTO `coffeemessage` VALUES ('With milk', '日本', 'sweet');
INSERT INTO `coffeemessage` VALUES ('卡布', ' 英国', '很苦');
INSERT INTO `coffeemessage` VALUES ('卡布奇诺Mix', '巴西', '甜sweet');
INSERT INTO `coffeemessage` VALUES ('意式', '意大利', '还挺香的');
INSERT INTO `coffeemessage` VALUES ('拿铁', '美国', '苦苦苦');
INSERT INTO `coffeemessage` VALUES ('拿铁 + 玛奇朵', '加拿大', 'sweet+happy');
INSERT INTO `coffeemessage` VALUES ('热水', '全世界直男', '最有用的药品');
INSERT INTO `coffeemessage` VALUES ('牛奶', '全世界', '甜甜的');
INSERT INTO `coffeemessage` VALUES ('白茶', '中国', '懂得都懂');
INSERT INTO `coffeemessage` VALUES ('红茶', '中国', '懂得都懂');
INSERT INTO `coffeemessage` VALUES ('绿茶', '中国', '懂得都懂');
INSERT INTO `coffeemessage` VALUES ('美式', '美国', '比意式不苦一点');
INSERT INTO `coffeemessage` VALUES ('黑茶', '中国', '懂得都懂');

-- ----------------------------
-- Table structure for machinestate
-- ----------------------------
DROP TABLE IF EXISTS `machinestate`;
CREATE TABLE `machinestate` (
  `machineId` int(11) NOT NULL AUTO_INCREMENT,
  `state` int(1) NOT NULL,
  `reason` int(11) NOT NULL,
  PRIMARY KEY (`machineId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of machinestate
-- ----------------------------
INSERT INTO `machinestate` VALUES ('1', '3', '20');

-- ----------------------------
-- Table structure for mcprice
-- ----------------------------
DROP TABLE IF EXISTS `mcprice`;
CREATE TABLE `mcprice` (
  `goodsId` int(11) NOT NULL AUTO_INCREMENT,
  `menuId` int(11) NOT NULL,
  `coffeeId` int(11) NOT NULL,
  `coffeePrice` int(11) NOT NULL,
  PRIMARY KEY (`goodsId`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mcprice
-- ----------------------------
INSERT INTO `mcprice` VALUES ('14', '4', '12', '16');
INSERT INTO `mcprice` VALUES ('23', '2', '3', '17');
INSERT INTO `mcprice` VALUES ('33', '1', '1', '14');
INSERT INTO `mcprice` VALUES ('34', '1', '14', '14');
INSERT INTO `mcprice` VALUES ('35', '4', '5', '18');
INSERT INTO `mcprice` VALUES ('38', '3', '2', '19');
INSERT INTO `mcprice` VALUES ('39', '3', '13', '18');
INSERT INTO `mcprice` VALUES ('47', '2', '2', '11');
INSERT INTO `mcprice` VALUES ('59', '5', '12', '14');
INSERT INTO `mcprice` VALUES ('60', '5', '3', '15');
INSERT INTO `mcprice` VALUES ('61', '5', '15', '11');
INSERT INTO `mcprice` VALUES ('64', '3', '4', '18');
INSERT INTO `mcprice` VALUES ('65', '4', '7', '11');
INSERT INTO `mcprice` VALUES ('66', '4', '17', '11');
INSERT INTO `mcprice` VALUES ('67', '2', '1', '11');

-- ----------------------------
-- Table structure for menudetail
-- ----------------------------
DROP TABLE IF EXISTS `menudetail`;
CREATE TABLE `menudetail` (
  `menuId` int(11) NOT NULL,
  `menuName` varchar(255) DEFAULT NULL,
  `menuNote` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`menuId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of menudetail
-- ----------------------------
INSERT INTO `menudetail` VALUES ('1', '经典套餐', '经典中的经典');
INSERT INTO `menudetail` VALUES ('2', '青春套餐', '青春中的青春');
INSERT INTO `menudetail` VALUES ('3', '创新套餐', '创新中的创新');
INSERT INTO `menudetail` VALUES ('4', '祥和套餐', '祥和中的祥和');
INSERT INTO `menudetail` VALUES ('5', '科技套餐', '科技中的科技');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', '123', '123');

-- ----------------------------
-- Table structure for willtodo
-- ----------------------------
DROP TABLE IF EXISTS `willtodo`;
CREATE TABLE `willtodo` (
  `logId` int(11) NOT NULL AUTO_INCREMENT,
  `openId` varchar(100) NOT NULL,
  `coffeeId` int(11) NOT NULL,
  `machineId` int(11) NOT NULL,
  `coffeePrice` int(11) NOT NULL,
  `outTradeNo` varchar(50) NOT NULL COMMENT '商品号',
  `time` datetime NOT NULL,
  PRIMARY KEY (`logId`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of willtodo
-- ----------------------------
INSERT INTO `willtodo` VALUES ('53', 'o991I47Z29SNafNTzXZp4KLmd-y0', '1', '0', '6', '1597457237128', '2020-08-15 10:07:17');
SET FOREIGN_KEY_CHECKS=1;
