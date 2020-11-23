/*
 Navicat Premium Data Transfer

 Source Server         : 139.159.248.60
 Source Server Type    : MySQL
 Source Server Version : 50731
 Source Host           : 139.159.248.60:3306
 Source Schema         : xd_blog

 Target Server Type    : MySQL
 Target Server Version : 50731
 File Encoding         : 65001

 Date: 03/11/2020 08:57:06
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for test
-- ----------------------------
DROP TABLE IF EXISTS `test`;
CREATE TABLE `test`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `x` double NULL DEFAULT NULL,
  `y` double NULL DEFAULT NULL,
  `create_date` datetime(0) NULL DEFAULT NULL,
  `modify_date` datetime(0) NULL DEFAULT NULL,
  `content1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '风速',
  `color` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `bridge_status` tinyint(1) NULL DEFAULT NULL,
  `bridge_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `content2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '桥梁纵向变化',
  `content3` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '桥梁横向变化',
  `content4` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '风向',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of test
-- ----------------------------
INSERT INTO `test` VALUES (9, 113.279265, 23.11264, '2020-10-29 22:22:33', NULL, '[120, 132, 101, 134, 90, 230, 210,245,68,71,89]', NULL, 1, '江湾大桥', '[220, 182, 191, 234, 290, 330, 310,66]', '[120, 382,2191, 234, 290, 330, 310]', '[620, 782, 991, 234, 190, 230, 410]');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `head_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'slw', 'e00907428df6d016772dfcdf0d881172', 'slw', 'http://139.159.248.60:3000\\uploads\\20201013\\1602576157764.jpg');
INSERT INTO `user` VALUES ('2', 'slj', '54e5a8ebb77ed591a3b648418627f194', 'slj', NULL);

SET FOREIGN_KEY_CHECKS = 1;
