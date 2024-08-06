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

 Date: 06/08/2024 15:14:02
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
) ENGINE = InnoDB AUTO_INCREMENT = 53 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tr_order_items
-- ----------------------------
INSERT INTO `tr_order_items` VALUES (1, 1, 1, 1);
INSERT INTO `tr_order_items` VALUES (2, 1, 6, 1);
INSERT INTO `tr_order_items` VALUES (3, 1, 3, 1);
INSERT INTO `tr_order_items` VALUES (4, 1, 8, 1);
INSERT INTO `tr_order_items` VALUES (5, 6, 1, 1);
INSERT INTO `tr_order_items` VALUES (6, 6, 6, 1);
INSERT INTO `tr_order_items` VALUES (7, 6, 3, 1);
INSERT INTO `tr_order_items` VALUES (8, 6, 8, 1);
INSERT INTO `tr_order_items` VALUES (9, 7, 1, 1);
INSERT INTO `tr_order_items` VALUES (10, 7, 6, 1);
INSERT INTO `tr_order_items` VALUES (11, 7, 3, 1);
INSERT INTO `tr_order_items` VALUES (12, 7, 8, 1);
INSERT INTO `tr_order_items` VALUES (13, 8, 1, 1);
INSERT INTO `tr_order_items` VALUES (14, 8, 6, 1);
INSERT INTO `tr_order_items` VALUES (15, 8, 3, 1);
INSERT INTO `tr_order_items` VALUES (16, 8, 8, 1);
INSERT INTO `tr_order_items` VALUES (41, 15, 1, 1);
INSERT INTO `tr_order_items` VALUES (42, 15, 6, 1);
INSERT INTO `tr_order_items` VALUES (43, 15, 3, 1);
INSERT INTO `tr_order_items` VALUES (44, 15, 8, 1);
INSERT INTO `tr_order_items` VALUES (45, 16, 1, 1);
INSERT INTO `tr_order_items` VALUES (46, 16, 6, 1);
INSERT INTO `tr_order_items` VALUES (47, 16, 3, 1);
INSERT INTO `tr_order_items` VALUES (48, 16, 8, 1);
INSERT INTO `tr_order_items` VALUES (49, 17, 1, 2);
INSERT INTO `tr_order_items` VALUES (50, 17, 6, 10);
INSERT INTO `tr_order_items` VALUES (51, 17, 3, 11);
INSERT INTO `tr_order_items` VALUES (52, 17, 8, 12);

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
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tr_order_promotions
-- ----------------------------
INSERT INTO `tr_order_promotions` VALUES (1, 1, 1, 2);
INSERT INTO `tr_order_promotions` VALUES (2, 6, 1, 2);
INSERT INTO `tr_order_promotions` VALUES (3, 7, 1, 2);
INSERT INTO `tr_order_promotions` VALUES (4, 8, 1, 2);
INSERT INTO `tr_order_promotions` VALUES (9, 15, 1, 2);
INSERT INTO `tr_order_promotions` VALUES (10, 17, 1, 3);

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
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tr_orders
-- ----------------------------
INSERT INTO `tr_orders` VALUES (1, 1, '2024-08-06 09:59:02');
INSERT INTO `tr_orders` VALUES (2, 1, '2024-08-06 04:46:13');
INSERT INTO `tr_orders` VALUES (3, 1, '2024-08-06 04:48:14');
INSERT INTO `tr_orders` VALUES (4, 1, '2024-08-06 04:48:28');
INSERT INTO `tr_orders` VALUES (5, 1, '2024-08-06 04:50:55');
INSERT INTO `tr_orders` VALUES (6, 1, '2024-08-06 04:52:54');
INSERT INTO `tr_orders` VALUES (7, 1, '2024-08-06 05:21:58');
INSERT INTO `tr_orders` VALUES (8, 2, '2024-08-06 05:22:17');
INSERT INTO `tr_orders` VALUES (15, 2, '2024-08-06 06:49:43');
INSERT INTO `tr_orders` VALUES (16, 2, '2024-08-06 06:49:48');
INSERT INTO `tr_orders` VALUES (17, 2, '2024-08-06 08:03:07');

SET FOREIGN_KEY_CHECKS = 1;
