/*
 Navicat MySQL Data Transfer

 Source Server         : 127.0.0.1 LOCALHOST
 Source Server Type    : MySQL
 Source Server Version : 80030 (8.0.30)
 Source Host           : localhost:3306
 Source Schema         : restaurant

 Target Server Type    : MySQL
 Target Server Version : 80030 (8.0.30)
 File Encoding         : 65001

 Date: 07/08/2024 09:38:28
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for ref_categories
-- ----------------------------
DROP TABLE IF EXISTS `ref_categories`;
CREATE TABLE `ref_categories`  (
  `id_category` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id_category`) USING BTREE,
  UNIQUE INDEX `id_category`(`id_category` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ref_categories
-- ----------------------------
INSERT INTO `ref_categories` VALUES (1, 'Minuman');
INSERT INTO `ref_categories` VALUES (2, 'Makanan');
INSERT INTO `ref_categories` VALUES (3, 'Promo');

-- ----------------------------
-- Table structure for ref_printers
-- ----------------------------
DROP TABLE IF EXISTS `ref_printers`;
CREATE TABLE `ref_printers`  (
  `id_printer` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `printer_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id_printer`) USING BTREE,
  UNIQUE INDEX `id_printer`(`id_printer` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ref_printers
-- ----------------------------
INSERT INTO `ref_printers` VALUES (1, 'Printer Kasir');
INSERT INTO `ref_printers` VALUES (2, 'Printer Dapur');
INSERT INTO `ref_printers` VALUES (3, 'Printer Bar');

-- ----------------------------
-- Table structure for ref_products
-- ----------------------------
DROP TABLE IF EXISTS `ref_products`;
CREATE TABLE `ref_products`  (
  `id_product` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `variant` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `price` decimal(10, 2) NOT NULL,
  `id_category` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_product`) USING BTREE,
  UNIQUE INDEX `id_product`(`id_product` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ref_products
-- ----------------------------
INSERT INTO `ref_products` VALUES (1, 'Jeruk', 'DINGIN', 12000.00, 1);
INSERT INTO `ref_products` VALUES (2, 'Jeruk', 'PANAS', 10000.00, 1);
INSERT INTO `ref_products` VALUES (3, 'Teh', 'MANIS', 8000.00, 1);
INSERT INTO `ref_products` VALUES (4, 'Teh', 'TAWAR', 5000.00, 1);
INSERT INTO `ref_products` VALUES (5, 'Kopi', 'DINGIN', 8000.00, 1);
INSERT INTO `ref_products` VALUES (6, 'Kopi', 'PANAS', 6000.00, 1);
INSERT INTO `ref_products` VALUES (7, 'Extra Es Batu', NULL, 2000.00, 1);
INSERT INTO `ref_products` VALUES (8, 'Mie', 'GORENG', 15000.00, 2);
INSERT INTO `ref_products` VALUES (9, 'Mie', 'KUAH', 15000.00, 2);
INSERT INTO `ref_products` VALUES (10, 'Nasi Goreng', NULL, 15000.00, 2);

-- ----------------------------
-- Table structure for ref_promotion_items
-- ----------------------------
DROP TABLE IF EXISTS `ref_promotion_items`;
CREATE TABLE `ref_promotion_items`  (
  `id_promotion` int NOT NULL,
  `id_product` int NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`id_promotion`, `id_product`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ref_promotion_items
-- ----------------------------
INSERT INTO `ref_promotion_items` VALUES (1, 1, 1);
INSERT INTO `ref_promotion_items` VALUES (1, 10, 1);

-- ----------------------------
-- Table structure for ref_promotions
-- ----------------------------
DROP TABLE IF EXISTS `ref_promotions`;
CREATE TABLE `ref_promotions`  (
  `id_promotion` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `promotion_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `price` decimal(10, 2) NOT NULL,
  PRIMARY KEY (`id_promotion`) USING BTREE,
  UNIQUE INDEX `id_promotion`(`id_promotion` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ref_promotions
-- ----------------------------
INSERT INTO `ref_promotions` VALUES (1, 'Nasi Goreng + Jeruk Dingin', 'Combo Nasi Goreng dan Jeruk Dingin', 23000.00);

-- ----------------------------
-- Table structure for ref_table
-- ----------------------------
DROP TABLE IF EXISTS `ref_table`;
CREATE TABLE `ref_table`  (
  `id_table` int NOT NULL AUTO_INCREMENT,
  `table_number` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_table`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ref_table
-- ----------------------------
INSERT INTO `ref_table` VALUES (1, 'Meja No 1');
INSERT INTO `ref_table` VALUES (2, 'Meja No 2');
INSERT INTO `ref_table` VALUES (3, 'Meja No 3');

-- ----------------------------
-- Table structure for tr_order_items
-- ----------------------------
DROP TABLE IF EXISTS `tr_order_items`;
CREATE TABLE `tr_order_items`  (
  `id_order_items` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_order` int NULL DEFAULT NULL,
  `id_product` int NULL DEFAULT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`id_order_items`) USING BTREE,
  UNIQUE INDEX `id_order_items`(`id_order_items` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tr_order_items
-- ----------------------------
INSERT INTO `tr_order_items` VALUES (1, 1, 1, 2);
INSERT INTO `tr_order_items` VALUES (2, 1, 6, 10);
INSERT INTO `tr_order_items` VALUES (3, 1, 3, 11);
INSERT INTO `tr_order_items` VALUES (4, 1, 8, 12);

-- ----------------------------
-- Table structure for tr_order_promotions
-- ----------------------------
DROP TABLE IF EXISTS `tr_order_promotions`;
CREATE TABLE `tr_order_promotions`  (
  `id_order_promotion` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_order` int NULL DEFAULT NULL,
  `id_promotion` int NULL DEFAULT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`id_order_promotion`) USING BTREE,
  UNIQUE INDEX `id_order_promotion`(`id_order_promotion` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tr_order_promotions
-- ----------------------------
INSERT INTO `tr_order_promotions` VALUES (1, 1, 1, 3);

-- ----------------------------
-- Table structure for tr_orders
-- ----------------------------
DROP TABLE IF EXISTS `tr_orders`;
CREATE TABLE `tr_orders`  (
  `id_order` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_table` int NOT NULL,
  `order_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_order`) USING BTREE,
  UNIQUE INDEX `id_order`(`id_order` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tr_orders
-- ----------------------------
INSERT INTO `tr_orders` VALUES (1, 2, '2024-08-07 02:37:52');

SET FOREIGN_KEY_CHECKS = 1;
