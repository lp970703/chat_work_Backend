-- --------------------------------------------------------
-- 主机:                           10.86.9.78
-- 服务器版本:                        8.0.30 - MySQL Community Server - GPL
-- 服务器操作系统:                      Win64
-- HeidiSQL 版本:                  12.0.0.6468
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- 导出 chat_work 的数据库结构
CREATE DATABASE IF NOT EXISTS `chat_work` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `chat_work`;

-- 导出  表 chat_work.authcode 结构
CREATE TABLE IF NOT EXISTS `authcode` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '授权码',
  `expiresAt` timestamp NULL DEFAULT NULL COMMENT '授权码有效期',
  `redirectUri` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '客户端回调URL',
  `scope` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '授权范围',
  `clientId` varchar(200) DEFAULT NULL,
  `userId` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb3;

-- 正在导出表  chat_work.authcode 的数据：~0 rows (大约)

-- 导出  表 chat_work.client 结构
CREATE TABLE IF NOT EXISTS `client` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `clientId` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '原来是唯一的，但是我觉得一个客户端可以创建多个user，所以不能做成唯一',
  `userId` varchar(200) DEFAULT NULL,
  `clientSecret` varchar(200) DEFAULT NULL,
  `redirectUri` varchar(200) DEFAULT NULL COMMENT '客户端的回调 URL',
  `grants` varchar(200) DEFAULT NULL COMMENT '授权模式，比如授权码模式',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;

-- 正在导出表  chat_work.client 的数据：~7 rows (大约)
INSERT INTO `client` (`id`, `clientId`, `userId`, `clientSecret`, `redirectUri`, `grants`) VALUES
	(1, 'clientadmin', 'useradmin', '131002', 'http://127.0.0.1:7001/ouath2', 'authorization_code,refresh_token,password'),
	(4, 'clientPasswordAdmin', 'passwordLoginAdmin', '131002', 'http://127.0.0.1:7001/ouath2', 'password'),
	(5, 'ffmepg_demo', 'd16ed9b0dcca4083ada0461b3298bacc', 'DCAQDHZV', 'http://127.0.0.1:7001/ouath2', 'password'),
	(7, NULL, '8508f6232c74486db29c5fc8ad9467f0', 'DCAQDHZV', 'http://127.0.0.1:7001/ouath2', 'password'),
	(8, 'ffmepg_demo', '7b34dc0a050841a68aa218bbabaae246', 'DCAQDHZV', 'http://127.0.0.1:7001/ouath2', 'password'),
	(9, 'ffmepg_demo', '6d9c5f07b9534baeba14af7b36b9f59a', 'DCAQDHZV', 'http://127.0.0.1:7001/ouath2', NULL),
	(10, 'ffmepg_demo', '8e570bdd6a8c46c49f9c66cdf97663b8', 'DCAQDHZV', 'http://127.0.0.1:7001/ouath2', NULL),
	(11, 'ffmepg_demo', '2d51e3d782804d6080baa9710e5ef05d', 'DCAQDHZV', 'http://127.0.0.1:7001/ouath2', NULL);

-- 导出  表 chat_work.refreshtoken 结构
CREATE TABLE IF NOT EXISTS `refreshtoken` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `token` varchar(200) DEFAULT NULL,
  `expiresAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `scope` varchar(200) DEFAULT NULL COMMENT '授权范围',
  `clientId` varchar(200) DEFAULT NULL,
  `userId` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb3;

-- 正在导出表  chat_work.refreshtoken 的数据：~79 rows (大约)
INSERT INTO `refreshtoken` (`id`, `token`, `expiresAt`, `scope`, `clientId`, `userId`) VALUES
	(10, '279fbd399addec45d13b128a0a4b8a729f3ac47b', '2023-04-07 06:34:19', 'write', 'clientadmin', 'useradmin'),
	(11, '0bbd8ba1d18b04adc448b80acffe84d4513098d7', '2023-04-07 06:45:24', 'write', 'clientadmin', 'useradmin'),
	(12, 'bf84c5495b95666b12a106212f624278d95cad4a', '2023-04-07 08:09:42', 'write', 'clientadmin', 'useradmin'),
	(13, 'd3a5aa657732fea2f3577446c9cea0ced08899c7', '2023-04-07 08:12:14', 'write', 'clientadmin', 'useradmin'),
	(14, 'bf4d2561593bdd3e8d2af357484a328e641c6e49', '2023-04-07 09:16:50', 'write', 'clientadmin', 'useradmin'),
	(15, '6f653e0a0cb823e4a5b8c8c60cc6525ab82fe29c', '2023-04-07 09:17:09', 'write', 'clientadmin', 'useradmin'),
	(16, '9ecda082630f64110588351b6a86006d979eca93', '2023-04-07 09:17:57', 'write', 'clientadmin', 'useradmin'),
	(17, 'f49cffb98bdfcfe6ee6c7c95f895cbff472be8a4', '2023-04-10 03:03:09', '', 'clientadmin', 'passwordLoginAdmin'),
	(18, '0fe5f8d86028f64bd6a79e068fa759944234de27', '2023-04-10 03:04:19', '', 'clientadmin', 'passwordLoginAdmin'),
	(19, 'd93cfceddfffa35368901ceb6aa24de5988e4581', '2023-04-10 03:16:03', 'write', 'clientadmin', 'useradmin'),
	(20, '63578c99115c262f749d3db07768aae40f8a0344', '2023-04-10 05:47:21', 'write', 'clientadmin', 'useradmin'),
	(21, '7f366c8a4ad7db9c9ec1ceea7fc8891d74306fb7', '2023-04-10 05:49:00', 'write', 'clientadmin', 'useradmin'),
	(22, '389e4a083cf33a580b75dc603b27503128f47cd3', '2023-04-10 05:53:08', 'write', 'clientadmin', 'useradmin'),
	(23, 'ccfb7e13a4de58c51efdf69275a09f7d0090b674', '2023-04-10 05:53:22', 'write', 'clientadmin', 'useradmin'),
	(24, '642652cf402b775bf42c88e3be3ac1d2a1a89708', '2023-04-10 05:58:11', 'write', 'clientadmin', 'useradmin'),
	(25, 'ee2b5445b549244def070aa8e584e03fcfd8f78c', '2023-04-10 05:58:27', 'write', 'clientadmin', 'useradmin'),
	(26, '96cf4db3656e6c736883c1ac7c885b2ebe568459', '2023-04-10 05:58:38', 'write', 'clientadmin', 'useradmin'),
	(27, 'c3134bf8faaac20f603ee2392b9b95293eed4f1a', '2023-04-10 05:59:08', 'write', 'clientadmin', 'useradmin'),
	(28, '401db3d193ba58d61ab86323d8faac13b25c0664', '2023-04-10 05:59:22', 'write', 'clientadmin', 'useradmin'),
	(29, 'd3db04ef8974ab9484285a95720fff8ee72d0b2d', '2023-04-10 06:36:16', 'write', 'clientadmin', 'useradmin'),
	(30, '94efde87b457331fde77a6083759fe8b9d194f73', '2023-04-10 06:45:50', '', 'clientadmin', 'passwordLoginAdmin'),
	(31, '3497d7b42d596642ea0f46cafda8e3e6443f6606', '2023-04-10 08:56:23', '', 'clientadmin', 'passwordLoginAdmin'),
	(32, 'fc3ff1e6455906d4f1ac943fb1f5af13bdff0a95', '2023-04-11 05:51:25', '', 'clientadmin', 'passwordLoginAdmin'),
	(33, 'f160f08dbd55bd2b0813a85bed027b23f0eeb30b', '2023-04-11 05:54:02', '', 'clientadmin', 'passwordLoginAdmin'),
	(34, '29058fd75a56fa7f52008446dca08034060d3967', '2023-04-11 05:55:39', '', 'clientadmin', 'passwordLoginAdmin'),
	(35, '2ec2830d493960e330cc78e5b7d709a39c85d971', '2023-04-11 06:24:31', '', 'clientadmin', 'passwordLoginAdmin'),
	(36, '5dbb585a9667bc5d5ca44605874c9f263d8ba97c', '2023-04-11 06:25:17', '', 'clientadmin', 'passwordLoginAdmin'),
	(37, '7a6f998e17436ee143552b613ba14cf8ed3fc40a', '2023-04-11 06:25:17', '', 'clientadmin', 'passwordLoginAdmin'),
	(38, '14f9b45255661871a26616b33fab2daf23dc3981', '2023-04-11 06:25:17', '', 'clientadmin', 'passwordLoginAdmin'),
	(39, '190f8f17643b68c6bf1d7e1a6969649fbb04b700', '2023-04-11 06:25:17', '', 'clientadmin', 'passwordLoginAdmin'),
	(40, 'ef7e5935c2516a732257239a810d21d6de2cbec1', '2023-04-11 06:25:17', '', 'clientadmin', 'passwordLoginAdmin'),
	(41, '98901c8ce652a1c6e54b9bec1b8b95d5af903017', '2023-04-11 06:25:17', '', 'clientadmin', 'passwordLoginAdmin'),
	(42, '9349d198dbf390f6a4b72b0a49b597fa1be14c53', '2023-04-11 06:25:17', '', 'clientadmin', 'passwordLoginAdmin'),
	(43, 'e965c77b4e4a03584b0482504b36fc42a7c234ee', '2023-04-11 06:25:18', '', 'clientadmin', 'passwordLoginAdmin'),
	(44, 'b013008b1bcdbf364a859e905274b5d4ff595247', '2023-04-11 06:25:18', '', 'clientadmin', 'passwordLoginAdmin'),
	(45, 'ed452ffe2900cabb1e03e8f7b6d94adb5ecac0b6', '2023-04-11 06:25:18', '', 'clientadmin', 'passwordLoginAdmin'),
	(46, '9c08d77c0d89a577c0b2c0bc2316d2839eb9471c', '2023-04-11 06:27:11', '', 'clientadmin', 'passwordLoginAdmin'),
	(47, 'dde4b126779a4532cb8096c813d4f7dc76eb83bd', '2023-04-11 06:27:11', '', 'clientadmin', 'passwordLoginAdmin'),
	(48, '6bf8f9abe32e437eae4533c302d2600b9e2e4af7', '2023-04-11 06:27:11', '', 'clientadmin', 'passwordLoginAdmin'),
	(49, 'fd9536aa4c3ae507a95171869b4596c7e1a465c4', '2023-04-11 06:27:11', '', 'clientadmin', 'passwordLoginAdmin'),
	(50, '0d92cbd6d4450a6d673c72940f4a4b7a811b670a', '2023-04-11 06:27:11', '', 'clientadmin', 'passwordLoginAdmin'),
	(51, 'fb290f13c59cefeafd07fc3c7716a78303263689', '2023-04-11 06:27:11', '', 'clientadmin', 'passwordLoginAdmin'),
	(52, 'f3695182303268902934a5025a768383e1dd1218', '2023-04-11 06:27:11', '', 'clientadmin', 'passwordLoginAdmin'),
	(53, '23a2fe2511bbbb52721f68888bc652a08eb2d2f9', '2023-04-11 06:27:11', '', 'clientadmin', 'passwordLoginAdmin'),
	(54, '5536d14a1cac3fbd44d5e92a940ed8ee4655cde8', '2023-04-11 06:27:11', '', 'clientadmin', 'passwordLoginAdmin'),
	(55, '0551755d4dc4d1d4758a800e8de92cd85fad1e13', '2023-04-11 06:28:43', '', 'clientadmin', 'passwordLoginAdmin'),
	(56, '7033135a693705a28a4c3dd178db152dec9e5166', '2023-04-11 06:28:43', '', 'clientadmin', 'passwordLoginAdmin'),
	(57, '4983910a45decad48751c81de8458ff494830b27', '2023-04-11 06:28:43', '', 'clientadmin', 'passwordLoginAdmin'),
	(58, 'd98a0437d04100c16d5b973b4253896e1eb26847', '2023-04-11 06:28:43', '', 'clientadmin', 'passwordLoginAdmin'),
	(59, 'b9d6ff95bae5d8b1b966999bc4d1a8d9240397a9', '2023-04-11 06:28:43', '', 'clientadmin', 'passwordLoginAdmin'),
	(60, 'fd56795ed64796a1e72fdbcdb3ab34ea508f8b9e', '2023-04-11 06:28:43', '', 'clientadmin', 'passwordLoginAdmin'),
	(61, '45e6f132fc28d8c99403c1e7a51e9a433f3b78ca', '2023-04-11 06:28:43', '', 'clientadmin', 'passwordLoginAdmin'),
	(62, '48afd3129fee6fff69c5e25d082bd4a35051ecb6', '2023-04-11 06:28:43', '', 'clientadmin', 'passwordLoginAdmin'),
	(63, '657c8735b4051e5d3912f256a3965356ad7b0d10', '2023-04-11 06:28:43', '', 'clientadmin', 'passwordLoginAdmin'),
	(64, '86fc469d6db68a9130f74d2136e9023d3b3ae680', '2023-04-11 06:28:43', '', 'clientadmin', 'passwordLoginAdmin'),
	(65, '100fb0351b009287ad5f91e62d9ca5bd51da24a5', '2023-04-11 07:29:09', '', 'clientadmin', 'passwordLoginAdmin'),
	(66, '86aa62e27e004ce26c95b652784e370bcf7f97e2', '2023-04-11 10:17:54', '', 'clientadmin', 'passwordLoginAdmin'),
	(67, 'a8311b52047d6efa5d387b07dd0462b0d67ff3fc', '2023-04-12 00:56:51', '', 'clientadmin', 'passwordLoginAdmin'),
	(68, '4b1a239561101b51387ac36a9ff77a275cd392b9', '2023-04-12 03:19:47', '', 'clientadmin', 'passwordLoginAdmin'),
	(69, 'a8c846bedc6044d41d819701572fda5046fe074c', '2023-04-12 05:35:36', '', 'clientadmin', 'passwordLoginAdmin'),
	(70, '1cfa9e9ebc302920203697741c2f8dab8b528d10', '2023-04-12 06:37:07', '', 'clientadmin', 'passwordLoginAdmin'),
	(71, '060c3b47823b7092e38d71751966154c2d27c381', '2023-04-12 07:46:00', '', 'clientadmin', 'passwordLoginAdmin'),
	(72, '43b6eae4c9eaebed560dc658682b003d19d8fe68', '2023-04-12 08:03:09', '', 'clientadmin', 'passwordLoginAdmin'),
	(73, '1a47ac66bef4b5f7d5205758c5e1dca9064383b1', '2023-04-17 09:36:49', '', 'clientadmin', 'passwordLoginAdmin'),
	(74, 'ee5722cd4d5e2f764d5aa043738814149deb1de9', '2023-04-21 01:40:00', '', 'clientadmin', 'passwordLoginAdmin'),
	(75, '47b8c5918416d4c3ebe0dbe99874fe5f14522328', '2023-04-21 01:47:18', '', 'clientadmin', 'passwordLoginAdmin'),
	(76, '1ecbf4132d2a3fc71b9a1389be22623375a44fcb', '2023-05-20 07:57:40', '', 'clientadmin', 'useradmin'),
	(77, '0c2bc9955a39ba546b5c86f90049b677f2e07f22', '2023-05-22 07:46:45', '', 'clientadmin', 'useradmin'),
	(78, '9493e2b59970ea40de3aaed3a78c5f443d220675', '2023-05-22 08:39:16', '', 'clientadmin', 'useradmin'),
	(79, '3f71dccd00d0c33aa0033b10a2ed8057b2a4a400', '2023-05-22 09:48:40', '', 'clientadmin', 'useradmin'),
	(80, 'c69a44f361ec5b70feca52553db8409100558721', '2023-05-22 10:04:41', '', 'clientadmin', 'useradmin'),
	(81, 'e60d3fb982838a82ad830377e169a0d0700e28ef', '2023-05-22 10:09:55', '', 'clientadmin', 'useradmin'),
	(82, '25570dccf5c3576e4ce42267ff0f70ceeef2e815', '2023-05-23 08:52:37', 'write', 'clientadmin', 'useradmin'),
	(83, 'a3f1209497a6fb6c760dc3d8429325624d00ec77', '2023-05-23 09:44:24', 'write', 'clientadmin', 'useradmin'),
	(84, '640db85e71e743ed09a73a68d93910aa8b094ef2', '2023-05-24 09:35:27', '', 'clientadmin', 'useradmin'),
	(85, '9521b888f55523bbe2c7d30c6a79af2988474738', '2023-05-25 09:36:17', '', 'ffmepg_demo', 'd16ed9b0dcca4083ada0461b3298bacc'),
	(86, '63ff7467b076a08a8ab5d1abe1056142b83c0e99', '2023-05-26 01:49:03', '', 'ffmepg_demo', 'd16ed9b0dcca4083ada0461b3298bacc'),
	(87, 'cb6c4e440b3570eecb139c0a6bf7567e23c32df3', '2023-05-26 02:10:44', '', 'ffmepg_demo', 'd16ed9b0dcca4083ada0461b3298bacc'),
	(88, 'af36c0fe2babd3ee7ca7e32724bc6596f12f74a5', '2023-05-26 09:20:10', '', 'ffmepg_demo', 'd16ed9b0dcca4083ada0461b3298bacc');

-- 导出  表 chat_work.token 结构
CREATE TABLE IF NOT EXISTS `token` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `token` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '访问令牌',
  `expiresAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '访问令牌有效期',
  `scope` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '授权范围',
  `clientId` varchar(200) DEFAULT NULL,
  `userId` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb3;

-- 正在导出表  chat_work.token 的数据：~79 rows (大约)
INSERT INTO `token` (`id`, `token`, `expiresAt`, `scope`, `clientId`, `userId`) VALUES
	(10, 'c316dea1084243e9daf5b59bbef55485563ac589', '2023-03-24 07:34:19', 'write', 'clientadmin', 'useradmin'),
	(11, '5f1f2c0370dd295697501e49e975573997b43e9a', '2023-03-24 07:45:24', 'write', 'clientadmin', 'useradmin'),
	(12, 'b12dc86d6a9e2dc8159b5636fe172c0866f7c513', '2023-03-24 09:09:42', 'write', 'clientadmin', 'useradmin'),
	(13, '276f94d614edabc0fe98c749d586e32a30d1bfc7', '2023-03-24 09:12:14', 'write', 'clientadmin', 'useradmin'),
	(14, 'e0882c7ec0c9ac419d77a00612cc4dfd000804f8', '2023-03-24 10:16:50', 'write', 'clientadmin', 'useradmin'),
	(15, 'd6095ccfbdaa8c0b7497907fb94d5c8ac4df6ccc', '2023-03-24 10:17:09', 'write', 'clientadmin', 'useradmin'),
	(16, '740a51cebad615cbb595e3169077edbcde88e372', '2023-03-24 10:17:57', 'write', 'clientadmin', 'useradmin'),
	(17, '86a666e371b963c172b73b76c59163ef7e988cba', '2023-03-27 04:03:09', '', 'clientadmin', 'passwordLoginAdmin'),
	(18, 'b7fce4bd0bb2fbec8e01843395584fe239cbb921', '2023-03-27 04:04:19', '', 'clientadmin', 'passwordLoginAdmin'),
	(19, 'c0f5bb68121b424dca0db739130d4a730d6115da', '2023-03-27 04:16:03', 'write', 'clientadmin', 'useradmin'),
	(20, 'effe9a39e47e7488f69e612a4e9438b0a8b35e26', '2023-03-27 06:47:21', 'write', 'clientadmin', 'useradmin'),
	(21, '54d1308c4d303584068a4a038698e63057a9574a', '2023-03-27 06:49:00', 'write', 'clientadmin', 'useradmin'),
	(22, 'f6ce3ebe2c20854e6e38db256366db42aa3b4565', '2023-03-27 06:53:08', 'write', 'clientadmin', 'useradmin'),
	(23, 'b2c6267a824ae7d279f4812639aa746a772db09f', '2023-03-27 06:53:22', 'write', 'clientadmin', 'useradmin'),
	(24, '520d944d9fe33cde948d877cada0420013933643', '2023-03-27 06:58:11', 'write', 'clientadmin', 'useradmin'),
	(25, 'b8f236d565ec03403c87a616bc8ff4e0052ec880', '2023-03-27 06:58:27', 'write', 'clientadmin', 'useradmin'),
	(26, '8bd2266969f1971ee9197875540f34e3256d7fb9', '2023-03-27 06:58:38', 'write', 'clientadmin', 'useradmin'),
	(27, 'dd5dadc3bebcfa42994ab46985c53a09b404d1b5', '2023-03-27 06:59:08', 'write', 'clientadmin', 'useradmin'),
	(28, '2d56b213642f4f6114ea9cdac3b5414a3a68795c', '2023-03-27 06:59:22', 'write', 'clientadmin', 'useradmin'),
	(29, '3bd45f476ea094238b35a5b7828270f990f48a77', '2023-03-27 07:36:16', 'write', 'clientadmin', 'useradmin'),
	(30, 'f5eef6b2e57da103f8378be320e80b7451efc5f3', '2023-03-27 07:45:50', '', 'clientadmin', 'passwordLoginAdmin'),
	(31, 'd40f40d934c099988c3e042e117684aa2828419f', '2023-03-27 09:56:23', '', 'clientadmin', 'passwordLoginAdmin'),
	(32, 'f71612ad5f3f24708d7440a715bd9e1fd408e9a1', '2023-03-28 06:51:25', '', 'clientadmin', 'passwordLoginAdmin'),
	(33, '004cc0aa2904a9b68c019a4314e7eef661c220d5', '2023-03-28 06:54:02', '', 'clientadmin', 'passwordLoginAdmin'),
	(34, 'd90b1b2f5249d96bb951ea464cc10073e156e5fd', '2023-03-28 06:55:39', '', 'clientadmin', 'passwordLoginAdmin'),
	(35, 'd67a2d4047a97ae4b017a52fea4a507e55d7f126', '2023-03-28 07:24:31', '', 'clientadmin', 'passwordLoginAdmin'),
	(36, '64a397c4a5f744b364dd3a6589687b64b5cb6c34', '2023-03-28 07:25:17', '', 'clientadmin', 'passwordLoginAdmin'),
	(37, '49d6df1c2e0c36207f9ec8798cec5feb9e96ff65', '2023-03-28 07:25:17', '', 'clientadmin', 'passwordLoginAdmin'),
	(38, '5df3a3410f48ea23f439bd913520e09fd9617c58', '2023-03-28 07:25:17', '', 'clientadmin', 'passwordLoginAdmin'),
	(39, 'fc8594c970df8e4d8446e6677b9a9bbf64674632', '2023-03-28 07:25:17', '', 'clientadmin', 'passwordLoginAdmin'),
	(40, '56801c7472975849f084aad635783a019cdcfa7f', '2023-03-28 07:25:17', '', 'clientadmin', 'passwordLoginAdmin'),
	(41, 'cb506b787ae19727917423f3738266ea39f17cf1', '2023-03-28 07:25:17', '', 'clientadmin', 'passwordLoginAdmin'),
	(42, '6181a937e54e21d8998841cf7f932dac7dcbb0a4', '2023-03-28 07:25:17', '', 'clientadmin', 'passwordLoginAdmin'),
	(43, '53ba8e9466134068baa2e899302585f7284bbd05', '2023-03-28 07:25:18', '', 'clientadmin', 'passwordLoginAdmin'),
	(44, '2624a3e1eca06d1df90f425681ea0e0c927772bb', '2023-03-28 07:25:18', '', 'clientadmin', 'passwordLoginAdmin'),
	(45, 'f3b57292712184b071062b50ca8d56e718db1bd7', '2023-03-28 07:25:18', '', 'clientadmin', 'passwordLoginAdmin'),
	(46, '36b2aa7207a689a49ddd8dcf4d9e457c57dd024c', '2023-03-28 07:27:11', '', 'clientadmin', 'passwordLoginAdmin'),
	(47, '53049677201b3cd78f632e898c308bb2d4e34919', '2023-03-28 07:27:11', '', 'clientadmin', 'passwordLoginAdmin'),
	(48, '7c2d94b5ab5953a904e1360e34f9c1d188c9b0a5', '2023-03-28 07:27:11', '', 'clientadmin', 'passwordLoginAdmin'),
	(49, '56b2ca381c18353d36b070abc59d5e88dd8591e7', '2023-03-28 07:27:11', '', 'clientadmin', 'passwordLoginAdmin'),
	(50, '4d31cfa8b1e30892984c80a74b64faff909ac04b', '2023-03-28 07:27:11', '', 'clientadmin', 'passwordLoginAdmin'),
	(51, '5d1cc820180b3505a93fadd8bca1180cab74b22b', '2023-03-28 07:27:11', '', 'clientadmin', 'passwordLoginAdmin'),
	(52, '76cbac389d1fc726790c39d60dd0baf49c930341', '2023-03-28 07:27:11', '', 'clientadmin', 'passwordLoginAdmin'),
	(53, '23ebff8ba60ed0ea36c6650908f91bb95dd6f66a', '2023-03-28 07:27:11', '', 'clientadmin', 'passwordLoginAdmin'),
	(54, 'c3072a5657696d874ebe69c917da12482e1e7063', '2023-03-28 07:27:11', '', 'clientadmin', 'passwordLoginAdmin'),
	(55, 'b11e180c95a53eb4ee33547aff129910e20a0985', '2023-03-28 07:28:43', '', 'clientadmin', 'passwordLoginAdmin'),
	(56, '8b1e560224aeae29e6cdd45ca910e540e075d878', '2023-03-28 07:28:43', '', 'clientadmin', 'passwordLoginAdmin'),
	(57, 'c48352879d4efea758662623b6fd95725cd863bb', '2023-03-28 07:28:43', '', 'clientadmin', 'passwordLoginAdmin'),
	(58, 'a9dbe64c1ddf50231d8b1ed8e569d3ebbae8ae41', '2023-03-28 07:28:43', '', 'clientadmin', 'passwordLoginAdmin'),
	(59, '8a3c0c80de9e3a39a332a3923c0aada1276fe335', '2023-03-28 07:28:43', '', 'clientadmin', 'passwordLoginAdmin'),
	(60, 'b751f428e2c9c271b175100ce6e742f2ebf97f8b', '2023-03-28 07:28:43', '', 'clientadmin', 'passwordLoginAdmin'),
	(61, 'bfa66b52ad75d30c836790c6aa9007817d6b1041', '2023-03-28 07:28:43', '', 'clientadmin', 'passwordLoginAdmin'),
	(62, '6edeba3919e51cebbca57614d0c75ea8c03b8844', '2023-03-28 07:28:43', '', 'clientadmin', 'passwordLoginAdmin'),
	(63, '0ea7d7a2bd3f84d4032734303f9da0d09f35baa1', '2023-03-28 07:28:43', '', 'clientadmin', 'passwordLoginAdmin'),
	(64, 'f4782594a80179a6db2201dec3d7dce1a8abec87', '2023-03-28 07:28:43', '', 'clientadmin', 'passwordLoginAdmin'),
	(65, 'c0c8a99e64d81cacdde92c57f8b31f5183d78d17', '2023-03-28 08:29:09', '', 'clientadmin', 'passwordLoginAdmin'),
	(66, 'cc54f90db86488fd5265ad1597a5f28de53d3920', '2023-03-28 11:17:54', '', 'clientadmin', 'passwordLoginAdmin'),
	(67, '0a5f0440d0bf52ed8970a19f80078bef5304e95c', '2023-03-29 01:56:51', '', 'clientadmin', 'passwordLoginAdmin'),
	(68, 'b67c7b2b27c53551034a1afd537161c3b8a14efd', '2023-03-29 04:19:47', '', 'clientadmin', 'passwordLoginAdmin'),
	(69, 'a556f8afa888bb2dd94ebf41ffab475749be6f5d', '2023-03-29 06:35:36', '', 'clientadmin', 'passwordLoginAdmin'),
	(70, '8a5875f041442ad945b538b27b48ce76045252a1', '2023-03-29 07:37:07', '', 'clientadmin', 'passwordLoginAdmin'),
	(71, 'eff4498d3680ad55db69ff3f57480a52af0918da', '2023-03-29 08:46:00', '', 'clientadmin', 'passwordLoginAdmin'),
	(72, '2c2680442f1e723ca9c6c4c1fd568bcb42fe5e43', '2023-03-29 09:03:09', '', 'clientadmin', 'passwordLoginAdmin'),
	(73, '8d32cccac9766a6268326d1b1273d3263e180bd3', '2023-04-03 10:36:49', '', 'clientadmin', 'passwordLoginAdmin'),
	(74, '1c8fa4b414ea7f319877dde7c468227b32aac5a1', '2023-04-07 02:40:00', '', 'clientadmin', 'passwordLoginAdmin'),
	(75, 'b1ec7db144c3963df02bd078ec8f2cb134783de0', '2023-04-07 02:47:18', '', 'clientadmin', 'passwordLoginAdmin'),
	(76, '469c466ceaedbb10681114fd207d35505a8823b3', '2023-05-06 08:57:40', '', 'clientadmin', 'useradmin'),
	(77, 'afa1a1a5b437df008eb681954cc806a73c5be307', '2023-05-08 08:46:45', '', 'clientadmin', 'useradmin'),
	(78, 'b9cf97b8269804f153c04fa85dffdb90622f74e3', '2023-05-08 09:39:16', '', 'clientadmin', 'useradmin'),
	(79, '1281897dec24da481fc64055bab8d46c5b2d7961', '2023-05-08 10:48:40', '', 'clientadmin', 'useradmin'),
	(80, 'be55bcff680b209dec505aafe264042126208531', '2023-05-08 11:04:41', '', 'clientadmin', 'useradmin'),
	(81, '28f5ebc608caa6fd440c762fd0f1fa429ac379e6', '2023-05-08 11:09:55', '', 'clientadmin', 'useradmin'),
	(82, '0675e62dd6b772d1395df0e755fc7607a645acec', '2023-05-09 09:52:37', 'write', 'clientadmin', 'useradmin'),
	(83, 'cd6aa7e0a17edd05ff826883839ae01076ccd3a3', '2023-05-09 10:44:24', 'write', 'clientadmin', 'useradmin'),
	(84, '06aaec26486cd6a15f065127900eeb831d8b7b2b', '2023-05-10 10:35:27', '', 'clientadmin', 'useradmin'),
	(85, '325beadea835dc064814dccbebc949eb4ff8d6f4', '2023-05-11 10:36:17', '', 'ffmepg_demo', 'd16ed9b0dcca4083ada0461b3298bacc'),
	(86, 'cace93c3ddd1c05babfea1ee1bd286ec3fcaf242', '2023-05-12 02:49:03', '', 'ffmepg_demo', 'd16ed9b0dcca4083ada0461b3298bacc'),
	(87, 'f9914a31cacad15a76c082d5f3f0cfdbf699ba3a', '2023-05-12 03:10:44', '', 'ffmepg_demo', 'd16ed9b0dcca4083ada0461b3298bacc'),
	(88, 'a1f640adfc224f7ee1b172275d01154b48cd7a68', '2023-05-12 10:20:10', '', 'ffmepg_demo', 'd16ed9b0dcca4083ada0461b3298bacc');

-- 导出  表 chat_work.user 结构
CREATE TABLE IF NOT EXISTS `user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `userId` varchar(50) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `createAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `phone` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3;

-- 正在导出表  chat_work.user 的数据：~7 rows (大约)
INSERT INTO `user` (`id`, `userId`, `username`, `password`, `createAt`, `phone`, `email`) VALUES
	(1, 'useradmin', 'lopez', 'Lupeng0703', '2023-03-20 03:14:29', NULL, NULL),
	(6, 'passwordLoginAdmin', 'lopezPassword', 'Lupeng0703', '2023-03-27 02:17:46', NULL, NULL),
	(7, 'd16ed9b0dcca4083ada0461b3298bacc', 'lopez1', 'lopez1', '2023-05-10 09:32:05', '15649872645', '1277838445@qq.com'),
	(9, '8508f6232c74486db29c5fc8ad9467f0', 'lopez2', 'lopez2', '2023-05-10 10:06:26', '15534001373', '1277838445@qq.com'),
	(10, '7b34dc0a050841a68aa218bbabaae246', 'lopez3', 'lopez3', '2023-05-10 10:07:45', '15534002373', '1277838445@qq.com'),
	(11, '6d9c5f07b9534baeba14af7b36b9f59a', 'lopez166', 'lopez166', '2023-05-15 09:24:20', '15364824675', '14561@qq.com'),
	(12, '8e570bdd6a8c46c49f9c66cdf97663b8', 'lopez', 'Lupeng0703', '2023-05-15 09:31:54', '15534001372', '1277838445@qq.com'),
	(13, '2d51e3d782804d6080baa9710e5ef05d', '1', '1', '2023-05-15 10:11:45', '15534001322', '1277838445@qq.com');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
