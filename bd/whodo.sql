-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.4.6-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para whodo
CREATE DATABASE IF NOT EXISTS `whodo` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `whodo`;

-- Volcando estructura para tabla whodo.clie_calificacion
CREATE TABLE IF NOT EXISTS `clie_calificacion` (
  `id_calificacion` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_usuario` bigint(20) DEFAULT NULL,
  `calificacion` double DEFAULT NULL,
  PRIMARY KEY (`id_calificacion`),
  KEY `FK_clie_calificacion_conf_usuarios` (`id_usuario`),
  CONSTRAINT `FK_clie_calificacion_conf_usuarios` FOREIGN KEY (`id_usuario`) REFERENCES `conf_usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla whodo.clie_calificacion: ~8 rows (aproximadamente)
/*!40000 ALTER TABLE `clie_calificacion` DISABLE KEYS */;
INSERT INTO `clie_calificacion` (`id_calificacion`, `id_usuario`, `calificacion`) VALUES
	(1, 1, 5),
	(2, 13, 4),
	(3, 12, 2),
	(4, 14, 4),
	(5, 16, 3),
	(6, 13, 4),
	(7, 12, 4),
	(8, 16, 3);
/*!40000 ALTER TABLE `clie_calificacion` ENABLE KEYS */;

-- Volcando estructura para tabla whodo.clie_carrito
CREATE TABLE IF NOT EXISTS `clie_carrito` (
  `id_carrito` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_cliente` bigint(20) DEFAULT NULL,
  `id_proveedor` bigint(20) DEFAULT NULL,
  `id_producto` bigint(20) DEFAULT NULL,
  `id_solicitud` bigint(20) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL COMMENT '1:pendiente 2:enviado 3:gestionado',
  PRIMARY KEY (`id_carrito`),
  KEY `FK_clie_carrito_prov_productos` (`id_producto`),
  KEY `FK_clie_carrito_clie_solicitud` (`id_solicitud`),
  KEY `FK_clie_carrito_conf_usuarios` (`id_cliente`),
  KEY `FK_clie_carrito_conf_usuarios_2` (`id_proveedor`),
  CONSTRAINT `FK_clie_carrito_clie_solicitud` FOREIGN KEY (`id_solicitud`) REFERENCES `clie_solicitud` (`id_solicitud`),
  CONSTRAINT `FK_clie_carrito_conf_usuarios` FOREIGN KEY (`id_cliente`) REFERENCES `conf_usuarios` (`id_usuario`),
  CONSTRAINT `FK_clie_carrito_conf_usuarios_2` FOREIGN KEY (`id_proveedor`) REFERENCES `conf_usuarios` (`id_usuario`),
  CONSTRAINT `FK_clie_carrito_prov_productos` FOREIGN KEY (`id_producto`) REFERENCES `prov_productos` (`id_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla whodo.clie_carrito: ~18 rows (aproximadamente)
/*!40000 ALTER TABLE `clie_carrito` DISABLE KEYS */;
INSERT INTO `clie_carrito` (`id_carrito`, `id_cliente`, `id_proveedor`, `id_producto`, `id_solicitud`, `cantidad`, `estado`) VALUES
	(29, 1, 11, 9, 29, 4, 2),
	(31, 1, 12, 3, 29, 4, 2),
	(32, 1, 12, 4, 29, 4, 2),
	(33, 1, 12, 5, 29, 4, 2),
	(34, 1, 12, 2, 29, 4, 2),
	(35, 1, 12, 3, 29, 4, 2),
	(36, 1, 11, 4, 29, 4, 2),
	(37, 1, 12, 5, 29, 4, 2),
	(38, 1, 12, 3, 29, 2, 2),
	(39, 1, 12, 4, 29, 1, 2),
	(40, 1, 12, 4, 29, 2, 2),
	(41, 1, 12, 6, 29, 3, 2),
	(42, 1, 12, 9, 29, 5, 2),
	(43, 1, 12, 2, 29, 4, 2),
	(44, 1, 12, 5, 29, 4, 2),
	(45, 1, 12, 7, 29, 4, 2),
	(46, 1, 12, 2, 29, 5, 2),
	(47, 1, 12, 5, 29, 5, 2);
/*!40000 ALTER TABLE `clie_carrito` ENABLE KEYS */;

-- Volcando estructura para tabla whodo.clie_pedido
CREATE TABLE IF NOT EXISTS `clie_pedido` (
  `id_pedido` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_solicitud` bigint(20) DEFAULT NULL,
  `id_usuario` bigint(20) DEFAULT NULL,
  `pedido` varchar(225) DEFAULT NULL,
  `descripcion` longtext DEFAULT NULL,
  `fecha_entrega` date DEFAULT NULL,
  `estado` varchar(225) DEFAULT NULL,
  `activo` enum('Y','N') DEFAULT NULL,
  `creacion` timestamp NULL DEFAULT NULL,
  `actualizacion` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_pedido`),
  KEY `FK_clie_pedido_clie_solicitud` (`id_solicitud`),
  KEY `FK_clie_pedido_conf_usuarios` (`id_usuario`),
  CONSTRAINT `FK_clie_pedido_clie_solicitud` FOREIGN KEY (`id_solicitud`) REFERENCES `clie_solicitud` (`id_solicitud`),
  CONSTRAINT `FK_clie_pedido_conf_usuarios` FOREIGN KEY (`id_usuario`) REFERENCES `conf_usuarios` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla whodo.clie_pedido: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `clie_pedido` DISABLE KEYS */;
/*!40000 ALTER TABLE `clie_pedido` ENABLE KEYS */;

-- Volcando estructura para tabla whodo.clie_solicitud
CREATE TABLE IF NOT EXISTS `clie_solicitud` (
  `id_solicitud` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_usuario` bigint(20) DEFAULT NULL,
  `tipo` varchar(50) DEFAULT NULL COMMENT '1:cotizacion 2:pedido',
  `estado` varchar(50) DEFAULT NULL COMMENT '1:recibido 2:gestionado',
  `activo` enum('Y','N') DEFAULT NULL,
  `creacion` timestamp NULL DEFAULT NULL,
  `actualizacion` timestamp NULL DEFAULT NULL,
  `observacion` varchar(5000) DEFAULT NULL,
  PRIMARY KEY (`id_solicitud`),
  KEY `FK_clie_solicitud_conf_usuarios` (`id_usuario`),
  CONSTRAINT `FK_clie_solicitud_conf_usuarios` FOREIGN KEY (`id_usuario`) REFERENCES `conf_usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla whodo.clie_solicitud: ~5 rows (aproximadamente)
/*!40000 ALTER TABLE `clie_solicitud` DISABLE KEYS */;
INSERT INTO `clie_solicitud` (`id_solicitud`, `id_usuario`, `tipo`, `estado`, `activo`, `creacion`, `actualizacion`, `observacion`) VALUES
	(24, 1, '1', '2', 'Y', '2020-04-10 01:15:03', NULL, 'f'),
	(25, 1, '2', '2', 'Y', '2020-04-10 02:26:37', NULL, 'pedido'),
	(26, 1, '1', '1', 'N', '2020-04-10 02:30:16', NULL, 'cotizacion pruebas'),
	(27, 1, '1', '1', 'Y', '2020-04-10 02:30:29', NULL, 'cotizacion pruebas'),
	(28, 1, '2', '1', 'Y', '2020-04-10 02:32:00', NULL, 'PRUEBA 1'),
	(29, 1, '1', '1', 'Y', '2020-04-10 20:59:14', NULL, 'esto es una cotizacion');
/*!40000 ALTER TABLE `clie_solicitud` ENABLE KEYS */;

-- Volcando estructura para tabla whodo.conf_ciudad
CREATE TABLE IF NOT EXISTS `conf_ciudad` (
  `id_ciudad` bigint(20) NOT NULL AUTO_INCREMENT,
  `ciudad` varchar(100) DEFAULT NULL,
  `pais` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_ciudad`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla whodo.conf_ciudad: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `conf_ciudad` DISABLE KEYS */;
INSERT INTO `conf_ciudad` (`id_ciudad`, `ciudad`, `pais`) VALUES
	(1, 'medellin', 'colombia'),
	(2, 'bogota', 'colombia');
/*!40000 ALTER TABLE `conf_ciudad` ENABLE KEYS */;

-- Volcando estructura para tabla whodo.conf_recuperarclave
CREATE TABLE IF NOT EXISTS `conf_recuperarclave` (
  `id_recuperarclave` bigint(20) NOT NULL AUTO_INCREMENT,
  `token` varchar(300) DEFAULT NULL,
  `creacion` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_recuperarclave`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla whodo.conf_recuperarclave: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `conf_recuperarclave` DISABLE KEYS */;
/*!40000 ALTER TABLE `conf_recuperarclave` ENABLE KEYS */;

-- Volcando estructura para tabla whodo.conf_roles
CREATE TABLE IF NOT EXISTS `conf_roles` (
  `id_rol` bigint(20) NOT NULL AUTO_INCREMENT,
  `rol` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla whodo.conf_roles: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `conf_roles` DISABLE KEYS */;
INSERT INTO `conf_roles` (`id_rol`, `rol`) VALUES
	(1, 'cliente'),
	(2, 'proveedor'),
	(3, 'admin'),
	(4, 'super');
/*!40000 ALTER TABLE `conf_roles` ENABLE KEYS */;

-- Volcando estructura para tabla whodo.conf_sugerircategorias
CREATE TABLE IF NOT EXISTS `conf_sugerircategorias` (
  `id_sugerircategoria` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_usuario` bigint(20) DEFAULT NULL,
  `categoria` varchar(100) DEFAULT NULL,
  `creacion` timestamp NULL DEFAULT NULL,
  `activo` enum('Y','N') DEFAULT NULL,
  PRIMARY KEY (`id_sugerircategoria`),
  KEY `FK_conf_sugerircategorias_conf_usuarios` (`id_usuario`),
  CONSTRAINT `FK_conf_sugerircategorias_conf_usuarios` FOREIGN KEY (`id_usuario`) REFERENCES `conf_usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla whodo.conf_sugerircategorias: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `conf_sugerircategorias` DISABLE KEYS */;
INSERT INTO `conf_sugerircategorias` (`id_sugerircategoria`, `id_usuario`, `categoria`, `creacion`, `activo`) VALUES
	(1, 1, 'categoria1', '2020-04-01 00:07:41', 'Y'),
	(2, 1, 'categoria2', '2020-04-01 00:07:50', 'Y'),
	(3, 1, 'fafa', '2020-04-02 17:22:18', 'Y'),
	(4, 1, 'fa', '2020-04-02 17:26:12', 'Y');
/*!40000 ALTER TABLE `conf_sugerircategorias` ENABLE KEYS */;

-- Volcando estructura para tabla whodo.conf_usuarios
CREATE TABLE IF NOT EXISTS `conf_usuarios` (
  `id_usuario` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_rol` bigint(20) NOT NULL,
  `id_ciudad` bigint(20) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `clave` varchar(300) DEFAULT NULL,
  `nombres` varchar(300) DEFAULT NULL,
  `apellidos` varchar(100) DEFAULT NULL,
  `cc` varchar(100) DEFAULT NULL,
  `fechan` date DEFAULT NULL,
  `telefono` varchar(100) DEFAULT NULL,
  `direccion` varchar(300) DEFAULT NULL,
  `descripcion` longtext DEFAULT NULL,
  `activo` enum('Y','N') DEFAULT NULL,
  `creacion` timestamp NULL DEFAULT NULL,
  `actualizacion` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `email` (`email`),
  KEY `FK_conf_usuarios_conf_ciudad` (`id_ciudad`),
  KEY `FK_conf_usuarios_conf_roles` (`id_rol`),
  CONSTRAINT `FK_conf_usuarios_conf_ciudad` FOREIGN KEY (`id_ciudad`) REFERENCES `conf_ciudad` (`id_ciudad`),
  CONSTRAINT `FK_conf_usuarios_conf_roles` FOREIGN KEY (`id_rol`) REFERENCES `conf_roles` (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla whodo.conf_usuarios: ~7 rows (aproximadamente)
/*!40000 ALTER TABLE `conf_usuarios` DISABLE KEYS */;
INSERT INTO `conf_usuarios` (`id_usuario`, `id_rol`, `id_ciudad`, `email`, `clave`, `nombres`, `apellidos`, `cc`, `fechan`, `telefono`, `direccion`, `descripcion`, `activo`, `creacion`, `actualizacion`) VALUES
	(1, 4, 1, 'leoesleo1111@gmail.com', '8535e86c8118bbbb0a18ac72d15d3a2b37b18d1bce1611fc60165f322cf57386', 'desarrollo', NULL, NULL, NULL, NULL, NULL, NULL, 'Y', NULL, NULL),
	(11, 1, 1, 'cliente@gmail.com', NULL, 'Cliente1', 'apellido', '100', '2020-04-01', '', NULL, NULL, 'Y', NULL, NULL),
	(12, 2, 2, 'proveedor@gmail.com', 'leo', 'proveedor', 'apellido', '100', '2020-04-01', NULL, NULL, NULL, 'Y', '2020-04-01 00:03:30', NULL),
	(13, 2, 1, NULL, NULL, 'proveedor 2', NULL, NULL, '2020-04-04', '30049715', NULL, 'soy un roveedor nuevo', 'Y', NULL, NULL),
	(14, 2, 1, NULL, NULL, 'proveedor3', NULL, NULL, NULL, NULL, NULL, NULL, 'Y', NULL, NULL),
	(16, 2, 1, NULL, NULL, 'proveedor4', NULL, NULL, NULL, NULL, NULL, NULL, 'Y', NULL, NULL),
	(17, 1, 1, 'leopr@hotmail.es', '34b3dec660fec7420fc7e5625109163729343ebfa88f0fb8d13da6ef1385623d', 'Leonardo', 'Patiño Rodriguez', '1017186651', '1990-11-11', '', '', '', 'Y', '2020-04-12 02:14:43', NULL);
/*!40000 ALTER TABLE `conf_usuarios` ENABLE KEYS */;

-- Volcando estructura para tabla whodo.prov_categorias
CREATE TABLE IF NOT EXISTS `prov_categorias` (
  `id_categoria` bigint(20) NOT NULL AUTO_INCREMENT,
  `categoria` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id_categoria`),
  UNIQUE KEY `categoria` (`categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla whodo.prov_categorias: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `prov_categorias` DISABLE KEYS */;
INSERT INTO `prov_categorias` (`id_categoria`, `categoria`) VALUES
	(1, 'Categoria1'),
	(2, 'Categoria2'),
	(3, 'Categoria3');
/*!40000 ALTER TABLE `prov_categorias` ENABLE KEYS */;

-- Volcando estructura para tabla whodo.prov_portafolio
CREATE TABLE IF NOT EXISTS `prov_portafolio` (
  `id_portafolio` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_usuario` bigint(20) DEFAULT NULL,
  `portafolio` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_portafolio`),
  UNIQUE KEY `portafolio` (`portafolio`),
  KEY `FK_prov_portafolio_conf_usuarios` (`id_usuario`),
  CONSTRAINT `FK_prov_portafolio_conf_usuarios` FOREIGN KEY (`id_usuario`) REFERENCES `conf_usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla whodo.prov_portafolio: ~10 rows (aproximadamente)
/*!40000 ALTER TABLE `prov_portafolio` DISABLE KEYS */;
INSERT INTO `prov_portafolio` (`id_portafolio`, `id_usuario`, `portafolio`) VALUES
	(1, 12, 'portafolio1'),
	(2, 13, 'portafolio2'),
	(3, 14, 'portafolio3'),
	(4, 13, 'prueba'),
	(5, 12, 'pepe'),
	(9, 1, 'leo'),
	(10, 1, 'leo2'),
	(12, 13, 'fadfadf'),
	(15, 1, 'leo3'),
	(16, 1, 'leo4'),
	(17, 1, 'T');
/*!40000 ALTER TABLE `prov_portafolio` ENABLE KEYS */;

-- Volcando estructura para tabla whodo.prov_portafoliocategoria
CREATE TABLE IF NOT EXISTS `prov_portafoliocategoria` (
  `id_portafoliocategoria` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_categoria` bigint(20) DEFAULT NULL,
  `id_portafolio` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id_portafoliocategoria`),
  KEY `FK__prov_categorias` (`id_categoria`),
  KEY `FK_prov_portafoliocategoria_prov_portafolio` (`id_portafolio`),
  CONSTRAINT `FK__prov_categorias` FOREIGN KEY (`id_categoria`) REFERENCES `prov_categorias` (`id_categoria`),
  CONSTRAINT `FK_prov_portafoliocategoria_prov_portafolio` FOREIGN KEY (`id_portafolio`) REFERENCES `prov_portafolio` (`id_portafolio`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla whodo.prov_portafoliocategoria: ~9 rows (aproximadamente)
/*!40000 ALTER TABLE `prov_portafoliocategoria` DISABLE KEYS */;
INSERT INTO `prov_portafoliocategoria` (`id_portafoliocategoria`, `id_categoria`, `id_portafolio`) VALUES
	(1, 1, 1),
	(2, 1, 2),
	(3, 1, 3),
	(4, 1, 5),
	(8, 1, 9),
	(9, 1, 10),
	(11, 3, 12),
	(14, 1, 15),
	(15, 1, 16),
	(16, 1, 17);
/*!40000 ALTER TABLE `prov_portafoliocategoria` ENABLE KEYS */;

-- Volcando estructura para tabla whodo.prov_portafolioproductos
CREATE TABLE IF NOT EXISTS `prov_portafolioproductos` (
  `id_portafolioproductos` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_portafolio` bigint(20) DEFAULT NULL,
  `id_producto` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id_portafolioproductos`),
  KEY `FK_prov_portafolioproductos_prov_portafolio` (`id_portafolio`),
  KEY `FK_prov_portafolioproductos_prov_productos` (`id_producto`),
  CONSTRAINT `FK_prov_portafolioproductos_prov_portafolio` FOREIGN KEY (`id_portafolio`) REFERENCES `prov_portafolio` (`id_portafolio`),
  CONSTRAINT `FK_prov_portafolioproductos_prov_productos` FOREIGN KEY (`id_producto`) REFERENCES `prov_productos` (`id_producto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla whodo.prov_portafolioproductos: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `prov_portafolioproductos` DISABLE KEYS */;
/*!40000 ALTER TABLE `prov_portafolioproductos` ENABLE KEYS */;

-- Volcando estructura para tabla whodo.prov_productos
CREATE TABLE IF NOT EXISTS `prov_productos` (
  `id_producto` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_portafolio_productos` bigint(20) DEFAULT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `precio` varchar(100) DEFAULT NULL,
  `descripcion` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `productos` varchar(1000) DEFAULT NULL,
  `activo` enum('Y','N') DEFAULT NULL,
  `creacion` timestamp NULL DEFAULT NULL,
  `actualizacion` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=420 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla whodo.prov_productos: ~332 rows (aproximadamente)
/*!40000 ALTER TABLE `prov_productos` DISABLE KEYS */;
INSERT INTO `prov_productos` (`id_producto`, `id_portafolio_productos`, `nombre`, `precio`, `descripcion`, `productos`, `activo`, `creacion`, `actualizacion`) VALUES
	(2, 0, 'Televisor', '941', '141', '[{"lote":509,"fecha vencimiento":105,"gramos":703,"des1":691,"des2":613,"des3":855,"des4":30}]', 'Y', '2020-04-04 20:55:36', NULL),
	(3, 5, 'Televisor2', '28', '331', '[{"lote":207,"fecha vencimiento":512,"gramos":412,"des1":982,"des2":119,"des3":594,"des4":320}]', 'Y', '2020-04-04 20:55:36', NULL),
	(4, 5, 'Televisor3', '345', '887', '[{"lote":637,"fecha vencimiento":874,"gramos":110,"des1":980,"des2":148,"des3":983,"des4":604}]', 'Y', '2020-04-04 20:55:36', NULL),
	(5, 5, 'Televisor4', '100', '901', '[{"lote":288,"fecha vencimiento":10,"gramos":707,"des1":874,"des2":194,"des3":172,"des4":583}]', 'Y', '2020-04-04 20:55:36', NULL),
	(6, 5, 'Televisor5', '24', '928', '[{"lote":476,"fecha vencimiento":161,"gramos":982,"des1":704,"des2":963,"des3":317,"des4":471}]', 'Y', '2020-04-04 20:55:36', NULL),
	(7, 5, 'Televisor6', '604', '487', '[{"lote":587,"fecha vencimiento":633,"gramos":929,"des1":162,"des2":914,"des3":989,"des4":568}]', 'Y', '2020-04-04 20:55:36', NULL),
	(8, 5, 'Televisor7', '724', '792', '[{"lote":581,"fecha vencimiento":196,"gramos":444,"des1":963,"des2":974,"des3":171,"des4":190}]', 'Y', '2020-04-04 20:55:36', NULL),
	(9, 5, 'Televisor8', '976', '85', '[{"lote":716,"fecha vencimiento":997,"gramos":461,"des1":407,"des2":396,"des3":619,"des4":314}]', 'Y', '2020-04-04 20:55:36', NULL),
	(10, 5, 'Televisor9', '427', '130', '[{"lote":325,"fecha vencimiento":670,"gramos":21,"des1":396,"des2":860,"des3":226,"des4":515}]', 'Y', '2020-04-04 20:55:36', NULL),
	(11, 5, 'Televisor10', '855', '584', '[{"lote":906,"fecha vencimiento":905,"gramos":424,"des1":409,"des2":777,"des3":156,"des4":642}]', 'Y', '2020-04-04 20:55:36', NULL),
	(12, 5, 'Televisor11', '483', '619', '[{"lote":106,"fecha vencimiento":691,"gramos":573,"des1":429,"des2":697,"des3":814,"des4":584}]', 'Y', '2020-04-04 20:55:36', NULL),
	(13, 5, 'Televisor12', '266', '734', '[{"lote":457,"fecha vencimiento":561,"gramos":252,"des1":59,"des2":344,"des3":783,"des4":271}]', 'Y', '2020-04-04 20:55:36', NULL),
	(14, 5, 'Televisor13', '174', '261', '[{"lote":296,"fecha vencimiento":161,"gramos":224,"des1":38,"des2":968,"des3":452,"des4":505}]', 'Y', '2020-04-04 20:55:36', NULL),
	(15, 5, 'Televisor14', '824', '209', '[{"lote":564,"fecha vencimiento":788,"gramos":601,"des1":812,"des2":432,"des3":222,"des4":206}]', 'Y', '2020-04-04 20:55:36', NULL),
	(16, 5, 'Televisor15', '536', '283', '[{"lote":675,"fecha vencimiento":900,"gramos":186,"des1":485,"des2":442,"des3":894,"des4":508}]', 'Y', '2020-04-04 20:55:36', NULL),
	(17, 5, 'Televisor16', '811', '223', '[{"lote":783,"fecha vencimiento":76,"gramos":931,"des1":685,"des2":546,"des3":160,"des4":659}]', 'Y', '2020-04-04 20:55:36', NULL),
	(18, 5, 'Televisor17', '751', '649', '[{"lote":631,"fecha vencimiento":350,"gramos":155,"des1":813,"des2":777,"des3":695,"des4":744}]', 'Y', '2020-04-04 20:55:36', NULL),
	(19, 5, 'Televisor18', '589', '150', '[{"lote":791,"fecha vencimiento":988,"gramos":471,"des1":202,"des2":827,"des3":195,"des4":329}]', 'Y', '2020-04-04 20:55:36', NULL),
	(40, 12, 'Televisor', '941', '141', '[{"lote":509,"fecha vencimiento":105,"gramos":703,"des1":691,"des2":613,"des3":855,"des4":30}]', 'Y', '2020-04-12 04:15:02', NULL),
	(41, 12, 'Televisor2', '28', '331', '[{"lote":207,"fecha vencimiento":512,"gramos":412,"des1":982,"des2":119,"des3":594,"des4":320}]', 'Y', '2020-04-12 04:15:02', NULL),
	(42, 12, 'Televisor3', '345', '887', '[{"lote":637,"fecha vencimiento":874,"gramos":110,"des1":980,"des2":148,"des3":983,"des4":604}]', 'Y', '2020-04-12 04:15:02', NULL),
	(43, 12, 'Televisor4', '100', '901', '[{"lote":288,"fecha vencimiento":10,"gramos":707,"des1":874,"des2":194,"des3":172,"des4":583}]', 'Y', '2020-04-12 04:15:02', NULL),
	(44, 12, 'Televisor5', '24', '928', '[{"lote":476,"fecha vencimiento":161,"gramos":982,"des1":704,"des2":963,"des3":317,"des4":471}]', 'Y', '2020-04-12 04:15:02', NULL),
	(45, 12, 'Televisor6', '604', '487', '[{"lote":587,"fecha vencimiento":633,"gramos":929,"des1":162,"des2":914,"des3":989,"des4":568}]', 'Y', '2020-04-12 04:15:02', NULL),
	(46, 12, 'Televisor7', '724', '792', '[{"lote":581,"fecha vencimiento":196,"gramos":444,"des1":963,"des2":974,"des3":171,"des4":190}]', 'Y', '2020-04-12 04:15:02', NULL),
	(47, 12, 'Televisor8', '976', '85', '[{"lote":716,"fecha vencimiento":997,"gramos":461,"des1":407,"des2":396,"des3":619,"des4":314}]', 'Y', '2020-04-12 04:15:02', NULL),
	(48, 12, 'Televisor9', '427', '130', '[{"lote":325,"fecha vencimiento":670,"gramos":21,"des1":396,"des2":860,"des3":226,"des4":515}]', 'Y', '2020-04-12 04:15:02', NULL),
	(49, 12, 'Televisor10', '855', '584', '[{"lote":906,"fecha vencimiento":905,"gramos":424,"des1":409,"des2":777,"des3":156,"des4":642}]', 'Y', '2020-04-12 04:15:02', NULL),
	(50, 12, 'Televisor11', '483', '619', '[{"lote":106,"fecha vencimiento":691,"gramos":573,"des1":429,"des2":697,"des3":814,"des4":584}]', 'Y', '2020-04-12 04:15:02', NULL),
	(51, 12, 'Televisor12', '266', '734', '[{"lote":457,"fecha vencimiento":561,"gramos":252,"des1":59,"des2":344,"des3":783,"des4":271}]', 'Y', '2020-04-12 04:15:02', NULL),
	(52, 12, 'Televisor13', '174', '261', '[{"lote":296,"fecha vencimiento":161,"gramos":224,"des1":38,"des2":968,"des3":452,"des4":505}]', 'Y', '2020-04-12 04:15:02', NULL),
	(53, 12, 'Televisor14', '824', '209', '[{"lote":564,"fecha vencimiento":788,"gramos":601,"des1":812,"des2":432,"des3":222,"des4":206}]', 'Y', '2020-04-12 04:15:02', NULL),
	(54, 12, 'Televisor15', '536', '283', '[{"lote":675,"fecha vencimiento":900,"gramos":186,"des1":485,"des2":442,"des3":894,"des4":508}]', 'Y', '2020-04-12 04:15:02', NULL),
	(55, 12, 'Televisor16', '811', '223', '[{"lote":783,"fecha vencimiento":76,"gramos":931,"des1":685,"des2":546,"des3":160,"des4":659}]', 'Y', '2020-04-12 04:15:02', NULL),
	(56, 12, 'Televisor17', '751', '649', '[{"lote":631,"fecha vencimiento":350,"gramos":155,"des1":813,"des2":777,"des3":695,"des4":744}]', 'Y', '2020-04-12 04:15:02', NULL),
	(57, 12, 'Televisor18', '589', '150', '[{"lote":791,"fecha vencimiento":988,"gramos":471,"des1":202,"des2":827,"des3":195,"des4":329}]', 'Y', '2020-04-12 04:15:02', NULL),
	(58, 12, 'Televisor19', '120', '907', '[{"lote":924,"fecha vencimiento":888,"gramos":281,"des1":315,"des2":889,"des3":682,"des4":262}]', 'Y', '2020-04-12 04:15:02', NULL),
	(59, 12, 'Televisor', '941', '141', '[{"lote":509,"fecha vencimiento":105,"gramos":703,"des1":691,"des2":613,"des3":855,"des4":30}]', 'Y', '2020-04-12 04:17:15', NULL),
	(60, 12, 'Televisor2', '28', '331', '[{"lote":207,"fecha vencimiento":512,"gramos":412,"des1":982,"des2":119,"des3":594,"des4":320}]', 'Y', '2020-04-12 04:17:15', NULL),
	(61, 12, 'Televisor3', '345', '887', '[{"lote":637,"fecha vencimiento":874,"gramos":110,"des1":980,"des2":148,"des3":983,"des4":604}]', 'Y', '2020-04-12 04:17:15', NULL),
	(62, 12, 'Televisor4', '100', '901', '[{"lote":288,"fecha vencimiento":10,"gramos":707,"des1":874,"des2":194,"des3":172,"des4":583}]', 'Y', '2020-04-12 04:17:15', NULL),
	(63, 12, 'Televisor5', '24', '928', '[{"lote":476,"fecha vencimiento":161,"gramos":982,"des1":704,"des2":963,"des3":317,"des4":471}]', 'Y', '2020-04-12 04:17:15', NULL),
	(64, 12, 'Televisor6', '604', '487', '[{"lote":587,"fecha vencimiento":633,"gramos":929,"des1":162,"des2":914,"des3":989,"des4":568}]', 'Y', '2020-04-12 04:17:15', NULL),
	(65, 12, 'Televisor7', '724', '792', '[{"lote":581,"fecha vencimiento":196,"gramos":444,"des1":963,"des2":974,"des3":171,"des4":190}]', 'Y', '2020-04-12 04:17:15', NULL),
	(66, 12, 'Televisor8', '976', '85', '[{"lote":716,"fecha vencimiento":997,"gramos":461,"des1":407,"des2":396,"des3":619,"des4":314}]', 'Y', '2020-04-12 04:17:15', NULL),
	(67, 12, 'Televisor9', '427', '130', '[{"lote":325,"fecha vencimiento":670,"gramos":21,"des1":396,"des2":860,"des3":226,"des4":515}]', 'Y', '2020-04-12 04:17:15', NULL),
	(68, 12, 'Televisor10', '855', '584', '[{"lote":906,"fecha vencimiento":905,"gramos":424,"des1":409,"des2":777,"des3":156,"des4":642}]', 'Y', '2020-04-12 04:17:15', NULL),
	(69, 12, 'Televisor11', '483', '619', '[{"lote":106,"fecha vencimiento":691,"gramos":573,"des1":429,"des2":697,"des3":814,"des4":584}]', 'Y', '2020-04-12 04:17:15', NULL),
	(70, 12, 'Televisor12', '266', '734', '[{"lote":457,"fecha vencimiento":561,"gramos":252,"des1":59,"des2":344,"des3":783,"des4":271}]', 'Y', '2020-04-12 04:17:15', NULL),
	(71, 12, 'Televisor13', '174', '261', '[{"lote":296,"fecha vencimiento":161,"gramos":224,"des1":38,"des2":968,"des3":452,"des4":505}]', 'Y', '2020-04-12 04:17:15', NULL),
	(72, 12, 'Televisor14', '824', '209', '[{"lote":564,"fecha vencimiento":788,"gramos":601,"des1":812,"des2":432,"des3":222,"des4":206}]', 'Y', '2020-04-12 04:17:15', NULL),
	(73, 12, 'Televisor15', '536', '283', '[{"lote":675,"fecha vencimiento":900,"gramos":186,"des1":485,"des2":442,"des3":894,"des4":508}]', 'Y', '2020-04-12 04:17:15', NULL),
	(74, 12, 'Televisor16', '811', '223', '[{"lote":783,"fecha vencimiento":76,"gramos":931,"des1":685,"des2":546,"des3":160,"des4":659}]', 'Y', '2020-04-12 04:17:15', NULL),
	(75, 12, 'Televisor17', '751', '649', '[{"lote":631,"fecha vencimiento":350,"gramos":155,"des1":813,"des2":777,"des3":695,"des4":744}]', 'Y', '2020-04-12 04:17:15', NULL),
	(76, 12, 'Televisor18', '589', '150', '[{"lote":791,"fecha vencimiento":988,"gramos":471,"des1":202,"des2":827,"des3":195,"des4":329}]', 'Y', '2020-04-12 04:17:15', NULL),
	(77, 12, 'Televisor19', '120', '907', '[{"lote":924,"fecha vencimiento":888,"gramos":281,"des1":315,"des2":889,"des3":682,"des4":262}]', 'Y', '2020-04-12 04:17:15', NULL),
	(78, 10, 'Televisor', '941', '141', '[{"lote":509,"fecha vencimiento":105,"gramos":703,"des1":691,"des2":613,"des3":855,"des4":30}]', 'Y', '2020-04-12 15:08:24', NULL),
	(79, 10, 'Televisor2', '28', '331', '[{"lote":207,"fecha vencimiento":512,"gramos":412,"des1":982,"des2":119,"des3":594,"des4":320}]', 'Y', '2020-04-12 15:08:24', NULL),
	(80, 10, 'Televisor3', '345', '887', '[{"lote":637,"fecha vencimiento":874,"gramos":110,"des1":980,"des2":148,"des3":983,"des4":604}]', 'Y', '2020-04-12 15:08:24', NULL),
	(81, 10, 'Televisor4', '100', '901', '[{"lote":288,"fecha vencimiento":10,"gramos":707,"des1":874,"des2":194,"des3":172,"des4":583}]', 'Y', '2020-04-12 15:08:24', NULL),
	(82, 10, 'Televisor5', '24', '928', '[{"lote":476,"fecha vencimiento":161,"gramos":982,"des1":704,"des2":963,"des3":317,"des4":471}]', 'Y', '2020-04-12 15:08:24', NULL),
	(83, 10, 'Televisor6', '604', '487', '[{"lote":587,"fecha vencimiento":633,"gramos":929,"des1":162,"des2":914,"des3":989,"des4":568}]', 'Y', '2020-04-12 15:08:24', NULL),
	(84, 10, 'Televisor7', '724', '792', '[{"lote":581,"fecha vencimiento":196,"gramos":444,"des1":963,"des2":974,"des3":171,"des4":190}]', 'Y', '2020-04-12 15:08:24', NULL),
	(85, 10, 'Televisor8', '976', '85', '[{"lote":716,"fecha vencimiento":997,"gramos":461,"des1":407,"des2":396,"des3":619,"des4":314}]', 'Y', '2020-04-12 15:08:24', NULL),
	(86, 10, 'Televisor9', '427', '130', '[{"lote":325,"fecha vencimiento":670,"gramos":21,"des1":396,"des2":860,"des3":226,"des4":515}]', 'Y', '2020-04-12 15:08:24', NULL),
	(87, 10, 'Televisor10', '855', '584', '[{"lote":906,"fecha vencimiento":905,"gramos":424,"des1":409,"des2":777,"des3":156,"des4":642}]', 'Y', '2020-04-12 15:08:24', NULL),
	(88, 10, 'Televisor11', '483', '619', '[{"lote":106,"fecha vencimiento":691,"gramos":573,"des1":429,"des2":697,"des3":814,"des4":584}]', 'Y', '2020-04-12 15:08:24', NULL),
	(90, 10, 'Televisor13', '174', '261', '[{"lote":296,"fecha vencimiento":161,"gramos":224,"des1":38,"des2":968,"des3":452,"des4":505}]', 'Y', '2020-04-12 15:08:24', NULL),
	(91, 10, 'Televisor14', '824', '209', '[{"lote":564,"fecha vencimiento":788,"gramos":601,"des1":812,"des2":432,"des3":222,"des4":206}]', 'Y', '2020-04-12 15:08:24', NULL),
	(92, 10, 'Televisor15', '536', '283', '[{"lote":675,"fecha vencimiento":900,"gramos":186,"des1":485,"des2":442,"des3":894,"des4":508}]', 'Y', '2020-04-12 15:08:24', NULL),
	(93, 10, 'Televisor16', '811', '223', '[{"lote":783,"fecha vencimiento":76,"gramos":931,"des1":685,"des2":546,"des3":160,"des4":659}]', 'Y', '2020-04-12 15:08:24', NULL),
	(94, 10, 'Televisor17', '751', '649', '[{"lote":631,"fecha vencimiento":350,"gramos":155,"des1":813,"des2":777,"des3":695,"des4":744}]', 'Y', '2020-04-12 15:08:24', NULL),
	(95, 10, 'Televisor18', '589', '150', '[{"lote":791,"fecha vencimiento":988,"gramos":471,"des1":202,"des2":827,"des3":195,"des4":329}]', 'Y', '2020-04-12 15:08:24', NULL),
	(96, 10, 'Televisor19', '120', '907', '[{"lote":924,"fecha vencimiento":888,"gramos":281,"des1":315,"des2":889,"des3":682,"des4":262}]', 'Y', '2020-04-12 15:08:24', NULL),
	(97, 1, 'Televisor', '941', '141', '[{"lote":509,"fecha vencimiento":105,"gramos":703,"des1":691,"des2":613,"des3":855,"des4":30}]', 'Y', '2020-04-12 15:11:35', NULL),
	(98, 1, 'Televisor2', '28', '331', '[{"lote":207,"fecha vencimiento":512,"gramos":412,"des1":982,"des2":119,"des3":594,"des4":320}]', 'Y', '2020-04-12 15:11:35', NULL),
	(99, 1, 'Televisor3', '345', '887', '[{"lote":637,"fecha vencimiento":874,"gramos":110,"des1":980,"des2":148,"des3":983,"des4":604}]', 'Y', '2020-04-12 15:11:35', NULL),
	(100, 1, 'Televisor4', '100', '901', '[{"lote":288,"fecha vencimiento":10,"gramos":707,"des1":874,"des2":194,"des3":172,"des4":583}]', 'Y', '2020-04-12 15:11:35', NULL),
	(101, 1, 'Televisor5', '24', '928', '[{"lote":476,"fecha vencimiento":161,"gramos":982,"des1":704,"des2":963,"des3":317,"des4":471}]', 'Y', '2020-04-12 15:11:35', NULL),
	(102, 1, 'Televisor6', '604', '487', '[{"lote":587,"fecha vencimiento":633,"gramos":929,"des1":162,"des2":914,"des3":989,"des4":568}]', 'Y', '2020-04-12 15:11:35', NULL),
	(103, 1, 'Televisor7', '724', '792', '[{"lote":581,"fecha vencimiento":196,"gramos":444,"des1":963,"des2":974,"des3":171,"des4":190}]', 'Y', '2020-04-12 15:11:35', NULL),
	(104, 1, 'Televisor8', '976', '85', '[{"lote":716,"fecha vencimiento":997,"gramos":461,"des1":407,"des2":396,"des3":619,"des4":314}]', 'Y', '2020-04-12 15:11:35', NULL),
	(105, 1, 'Televisor9', '427', '130', '[{"lote":325,"fecha vencimiento":670,"gramos":21,"des1":396,"des2":860,"des3":226,"des4":515}]', 'Y', '2020-04-12 15:11:35', NULL),
	(106, 1, 'Televisor10', '855', '584', '[{"lote":906,"fecha vencimiento":905,"gramos":424,"des1":409,"des2":777,"des3":156,"des4":642}]', 'Y', '2020-04-12 15:11:35', NULL),
	(107, 1, 'Televisor11', '483', '619', '[{"lote":106,"fecha vencimiento":691,"gramos":573,"des1":429,"des2":697,"des3":814,"des4":584}]', 'Y', '2020-04-12 15:11:35', NULL),
	(108, 1, 'Televisor12', '266', '734', '[{"lote":457,"fecha vencimiento":561,"gramos":252,"des1":59,"des2":344,"des3":783,"des4":271}]', 'Y', '2020-04-12 15:11:35', NULL),
	(109, 1, 'Televisor13', '174', '261', '[{"lote":296,"fecha vencimiento":161,"gramos":224,"des1":38,"des2":968,"des3":452,"des4":505}]', 'Y', '2020-04-12 15:11:35', NULL),
	(110, 1, 'Televisor14', '824', '209', '[{"lote":564,"fecha vencimiento":788,"gramos":601,"des1":812,"des2":432,"des3":222,"des4":206}]', 'Y', '2020-04-12 15:11:35', NULL),
	(111, 1, 'Televisor15', '536', '283', '[{"lote":675,"fecha vencimiento":900,"gramos":186,"des1":485,"des2":442,"des3":894,"des4":508}]', 'Y', '2020-04-12 15:11:35', NULL),
	(112, 1, 'Televisor16', '811', '223', '[{"lote":783,"fecha vencimiento":76,"gramos":931,"des1":685,"des2":546,"des3":160,"des4":659}]', 'Y', '2020-04-12 15:11:35', NULL),
	(113, 1, 'Televisor17', '751', '649', '[{"lote":631,"fecha vencimiento":350,"gramos":155,"des1":813,"des2":777,"des3":695,"des4":744}]', 'Y', '2020-04-12 15:11:35', NULL),
	(114, 1, 'Televisor18', '589', '150', '[{"lote":791,"fecha vencimiento":988,"gramos":471,"des1":202,"des2":827,"des3":195,"des4":329}]', 'Y', '2020-04-12 15:11:35', NULL),
	(115, 1, 'Televisor19', '120', '907', '[{"lote":924,"fecha vencimiento":888,"gramos":281,"des1":315,"des2":889,"des3":682,"des4":262}]', 'Y', '2020-04-12 15:11:35', NULL),
	(116, 12, 'Televisor', '941', '141', '[{"lote":509,"fecha vencimiento":105,"gramos":703,"des1":691,"des2":613,"des3":855,"des4":30}]', 'Y', '2020-04-12 15:13:05', NULL),
	(117, 12, 'Televisor2', '28', '331', '[{"lote":207,"fecha vencimiento":512,"gramos":412,"des1":982,"des2":119,"des3":594,"des4":320}]', 'Y', '2020-04-12 15:13:05', NULL),
	(118, 12, 'Televisor3', '345', '887', '[{"lote":637,"fecha vencimiento":874,"gramos":110,"des1":980,"des2":148,"des3":983,"des4":604}]', 'Y', '2020-04-12 15:13:05', NULL),
	(119, 12, 'Televisor4', '100', '901', '[{"lote":288,"fecha vencimiento":10,"gramos":707,"des1":874,"des2":194,"des3":172,"des4":583}]', 'Y', '2020-04-12 15:13:05', NULL),
	(120, 12, 'Televisor5', '24', '928', '[{"lote":476,"fecha vencimiento":161,"gramos":982,"des1":704,"des2":963,"des3":317,"des4":471}]', 'Y', '2020-04-12 15:13:05', NULL),
	(121, 12, 'Televisor6', '604', '487', '[{"lote":587,"fecha vencimiento":633,"gramos":929,"des1":162,"des2":914,"des3":989,"des4":568}]', 'Y', '2020-04-12 15:13:05', NULL),
	(122, 12, 'Televisor7', '724', '792', '[{"lote":581,"fecha vencimiento":196,"gramos":444,"des1":963,"des2":974,"des3":171,"des4":190}]', 'Y', '2020-04-12 15:13:05', NULL),
	(123, 12, 'Televisor8', '976', '85', '[{"lote":716,"fecha vencimiento":997,"gramos":461,"des1":407,"des2":396,"des3":619,"des4":314}]', 'Y', '2020-04-12 15:13:05', NULL),
	(124, 12, 'Televisor9', '427', '130', '[{"lote":325,"fecha vencimiento":670,"gramos":21,"des1":396,"des2":860,"des3":226,"des4":515}]', 'Y', '2020-04-12 15:13:05', NULL),
	(125, 12, 'Televisor10', '855', '584', '[{"lote":906,"fecha vencimiento":905,"gramos":424,"des1":409,"des2":777,"des3":156,"des4":642}]', 'Y', '2020-04-12 15:13:05', NULL),
	(126, 12, 'Televisor11', '483', '619', '[{"lote":106,"fecha vencimiento":691,"gramos":573,"des1":429,"des2":697,"des3":814,"des4":584}]', 'Y', '2020-04-12 15:13:05', NULL),
	(127, 12, 'Televisor12', '266', '734', '[{"lote":457,"fecha vencimiento":561,"gramos":252,"des1":59,"des2":344,"des3":783,"des4":271}]', 'Y', '2020-04-12 15:13:05', NULL),
	(128, 12, 'Televisor13', '174', '261', '[{"lote":296,"fecha vencimiento":161,"gramos":224,"des1":38,"des2":968,"des3":452,"des4":505}]', 'Y', '2020-04-12 15:13:05', NULL),
	(129, 12, 'Televisor14', '824', '209', '[{"lote":564,"fecha vencimiento":788,"gramos":601,"des1":812,"des2":432,"des3":222,"des4":206}]', 'Y', '2020-04-12 15:13:05', NULL),
	(130, 12, 'Televisor15', '536', '283', '[{"lote":675,"fecha vencimiento":900,"gramos":186,"des1":485,"des2":442,"des3":894,"des4":508}]', 'Y', '2020-04-12 15:13:05', NULL),
	(131, 12, 'Televisor16', '811', '223', '[{"lote":783,"fecha vencimiento":76,"gramos":931,"des1":685,"des2":546,"des3":160,"des4":659}]', 'Y', '2020-04-12 15:13:05', NULL),
	(132, 12, 'Televisor17', '751', '649', '[{"lote":631,"fecha vencimiento":350,"gramos":155,"des1":813,"des2":777,"des3":695,"des4":744}]', 'Y', '2020-04-12 15:13:05', NULL),
	(133, 12, 'Televisor18', '589', '150', '[{"lote":791,"fecha vencimiento":988,"gramos":471,"des1":202,"des2":827,"des3":195,"des4":329}]', 'Y', '2020-04-12 15:13:05', NULL),
	(134, 12, 'Televisor19', '120', '907', '[{"lote":924,"fecha vencimiento":888,"gramos":281,"des1":315,"des2":889,"des3":682,"des4":262}]', 'Y', '2020-04-12 15:13:05', NULL),
	(135, 12, 'Televisor', '941', '141', '[{"lote":509,"fecha vencimiento":105,"gramos":703,"des1":691,"des2":613,"des3":855,"des4":30}]', 'Y', '2020-04-12 15:13:55', NULL),
	(136, 12, 'Televisor2', '28', '331', '[{"lote":207,"fecha vencimiento":512,"gramos":412,"des1":982,"des2":119,"des3":594,"des4":320}]', 'Y', '2020-04-12 15:13:55', NULL),
	(137, 12, 'Televisor3', '345', '887', '[{"lote":637,"fecha vencimiento":874,"gramos":110,"des1":980,"des2":148,"des3":983,"des4":604}]', 'Y', '2020-04-12 15:13:55', NULL),
	(138, 12, 'Televisor4', '100', '901', '[{"lote":288,"fecha vencimiento":10,"gramos":707,"des1":874,"des2":194,"des3":172,"des4":583}]', 'Y', '2020-04-12 15:13:55', NULL),
	(139, 12, 'Televisor5', '24', '928', '[{"lote":476,"fecha vencimiento":161,"gramos":982,"des1":704,"des2":963,"des3":317,"des4":471}]', 'Y', '2020-04-12 15:13:55', NULL),
	(140, 12, 'Televisor6', '604', '487', '[{"lote":587,"fecha vencimiento":633,"gramos":929,"des1":162,"des2":914,"des3":989,"des4":568}]', 'Y', '2020-04-12 15:13:55', NULL),
	(141, 12, 'Televisor7', '724', '792', '[{"lote":581,"fecha vencimiento":196,"gramos":444,"des1":963,"des2":974,"des3":171,"des4":190}]', 'Y', '2020-04-12 15:13:55', NULL),
	(142, 12, 'Televisor8', '976', '85', '[{"lote":716,"fecha vencimiento":997,"gramos":461,"des1":407,"des2":396,"des3":619,"des4":314}]', 'Y', '2020-04-12 15:13:55', NULL),
	(143, 12, 'Televisor9', '427', '130', '[{"lote":325,"fecha vencimiento":670,"gramos":21,"des1":396,"des2":860,"des3":226,"des4":515}]', 'Y', '2020-04-12 15:13:55', NULL),
	(144, 12, 'Televisor10', '855', '584', '[{"lote":906,"fecha vencimiento":905,"gramos":424,"des1":409,"des2":777,"des3":156,"des4":642}]', 'Y', '2020-04-12 15:13:55', NULL),
	(145, 12, 'Televisor11', '483', '619', '[{"lote":106,"fecha vencimiento":691,"gramos":573,"des1":429,"des2":697,"des3":814,"des4":584}]', 'Y', '2020-04-12 15:13:55', NULL),
	(146, 12, 'Televisor12', '266', '734', '[{"lote":457,"fecha vencimiento":561,"gramos":252,"des1":59,"des2":344,"des3":783,"des4":271}]', 'Y', '2020-04-12 15:13:55', NULL),
	(147, 12, 'Televisor13', '174', '261', '[{"lote":296,"fecha vencimiento":161,"gramos":224,"des1":38,"des2":968,"des3":452,"des4":505}]', 'Y', '2020-04-12 15:13:55', NULL),
	(148, 12, 'Televisor14', '824', '209', '[{"lote":564,"fecha vencimiento":788,"gramos":601,"des1":812,"des2":432,"des3":222,"des4":206}]', 'Y', '2020-04-12 15:13:55', NULL),
	(149, 12, 'Televisor15', '536', '283', '[{"lote":675,"fecha vencimiento":900,"gramos":186,"des1":485,"des2":442,"des3":894,"des4":508}]', 'Y', '2020-04-12 15:13:55', NULL),
	(150, 12, 'Televisor16', '811', '223', '[{"lote":783,"fecha vencimiento":76,"gramos":931,"des1":685,"des2":546,"des3":160,"des4":659}]', 'Y', '2020-04-12 15:13:55', NULL),
	(151, 12, 'Televisor17', '751', '649', '[{"lote":631,"fecha vencimiento":350,"gramos":155,"des1":813,"des2":777,"des3":695,"des4":744}]', 'Y', '2020-04-12 15:13:55', NULL),
	(152, 12, 'Televisor18', '589', '150', '[{"lote":791,"fecha vencimiento":988,"gramos":471,"des1":202,"des2":827,"des3":195,"des4":329}]', 'Y', '2020-04-12 15:13:55', NULL),
	(153, 12, 'Televisor19', '120', '907', '[{"lote":924,"fecha vencimiento":888,"gramos":281,"des1":315,"des2":889,"des3":682,"des4":262}]', 'Y', '2020-04-12 15:13:55', NULL),
	(154, 3, 'Televisor', '941', '141', '[{"lote":509,"fecha vencimiento":105,"gramos":703,"des1":691,"des2":613,"des3":855,"des4":30}]', 'Y', '2020-04-12 15:48:24', NULL),
	(155, 3, 'Televisor2', '28', '331', '[{"lote":207,"fecha vencimiento":512,"gramos":412,"des1":982,"des2":119,"des3":594,"des4":320}]', 'Y', '2020-04-12 15:48:24', NULL),
	(156, 3, 'Televisor3', '345', '887', '[{"lote":637,"fecha vencimiento":874,"gramos":110,"des1":980,"des2":148,"des3":983,"des4":604}]', 'Y', '2020-04-12 15:48:24', NULL),
	(157, 3, 'Televisor4', '100', '901', '[{"lote":288,"fecha vencimiento":10,"gramos":707,"des1":874,"des2":194,"des3":172,"des4":583}]', 'Y', '2020-04-12 15:48:24', NULL),
	(158, 3, 'Televisor5', '24', '928', '[{"lote":476,"fecha vencimiento":161,"gramos":982,"des1":704,"des2":963,"des3":317,"des4":471}]', 'Y', '2020-04-12 15:48:24', NULL),
	(159, 3, 'Televisor6', '604', '487', '[{"lote":587,"fecha vencimiento":633,"gramos":929,"des1":162,"des2":914,"des3":989,"des4":568}]', 'Y', '2020-04-12 15:48:24', NULL),
	(160, 3, 'Televisor7', '724', '792', '[{"lote":581,"fecha vencimiento":196,"gramos":444,"des1":963,"des2":974,"des3":171,"des4":190}]', 'Y', '2020-04-12 15:48:24', NULL),
	(161, 3, 'Televisor8', '976', '85', '[{"lote":716,"fecha vencimiento":997,"gramos":461,"des1":407,"des2":396,"des3":619,"des4":314}]', 'Y', '2020-04-12 15:48:24', NULL),
	(162, 3, 'Televisor9', '427', '130', '[{"lote":325,"fecha vencimiento":670,"gramos":21,"des1":396,"des2":860,"des3":226,"des4":515}]', 'Y', '2020-04-12 15:48:24', NULL),
	(163, 3, 'Televisor10', '855', '584', '[{"lote":906,"fecha vencimiento":905,"gramos":424,"des1":409,"des2":777,"des3":156,"des4":642}]', 'Y', '2020-04-12 15:48:24', NULL),
	(164, 3, 'Televisor11', '483', '619', '[{"lote":106,"fecha vencimiento":691,"gramos":573,"des1":429,"des2":697,"des3":814,"des4":584}]', 'Y', '2020-04-12 15:48:24', NULL),
	(165, 3, 'Televisor12', '266', '734', '[{"lote":457,"fecha vencimiento":561,"gramos":252,"des1":59,"des2":344,"des3":783,"des4":271}]', 'Y', '2020-04-12 15:48:24', NULL),
	(166, 3, 'Televisor13', '174', '261', '[{"lote":296,"fecha vencimiento":161,"gramos":224,"des1":38,"des2":968,"des3":452,"des4":505}]', 'Y', '2020-04-12 15:48:24', NULL),
	(167, 3, 'Televisor14', '824', '209', '[{"lote":564,"fecha vencimiento":788,"gramos":601,"des1":812,"des2":432,"des3":222,"des4":206}]', 'Y', '2020-04-12 15:48:24', NULL),
	(168, 3, 'Televisor15', '536', '283', '[{"lote":675,"fecha vencimiento":900,"gramos":186,"des1":485,"des2":442,"des3":894,"des4":508}]', 'Y', '2020-04-12 15:48:24', NULL),
	(169, 3, 'Televisor16', '811', '223', '[{"lote":783,"fecha vencimiento":76,"gramos":931,"des1":685,"des2":546,"des3":160,"des4":659}]', 'Y', '2020-04-12 15:48:24', NULL),
	(170, 3, 'Televisor17', '751', '649', '[{"lote":631,"fecha vencimiento":350,"gramos":155,"des1":813,"des2":777,"des3":695,"des4":744}]', 'Y', '2020-04-12 15:48:24', NULL),
	(171, 3, 'Televisor18', '589', '150', '[{"lote":791,"fecha vencimiento":988,"gramos":471,"des1":202,"des2":827,"des3":195,"des4":329}]', 'Y', '2020-04-12 15:48:24', NULL),
	(172, 3, 'Televisor19', '120', '907', '[{"lote":924,"fecha vencimiento":888,"gramos":281,"des1":315,"des2":889,"des3":682,"des4":262}]', 'Y', '2020-04-12 15:48:24', NULL),
	(173, 4, 'Televisor', '941', '141', '[{"lote":509,"fecha vencimiento":105,"gramos":703,"des1":691,"des2":613,"des3":855,"des4":30}]', 'Y', '2020-04-12 18:25:42', NULL),
	(174, 4, 'Televisor2', '28', '331', '[{"lote":207,"fecha vencimiento":512,"gramos":412,"des1":982,"des2":119,"des3":594,"des4":320}]', 'Y', '2020-04-12 18:25:42', NULL),
	(175, 4, 'Televisor3', '345', '887', '[{"lote":637,"fecha vencimiento":874,"gramos":110,"des1":980,"des2":148,"des3":983,"des4":604}]', 'Y', '2020-04-12 18:25:42', NULL),
	(176, 4, 'Televisor4', '100', '901', '[{"lote":288,"fecha vencimiento":10,"gramos":707,"des1":874,"des2":194,"des3":172,"des4":583}]', 'Y', '2020-04-12 18:25:42', NULL),
	(177, 4, 'Televisor5', '24', '928', '[{"lote":476,"fecha vencimiento":161,"gramos":982,"des1":704,"des2":963,"des3":317,"des4":471}]', 'Y', '2020-04-12 18:25:42', NULL),
	(178, 4, 'Televisor6', '604', '487', '[{"lote":587,"fecha vencimiento":633,"gramos":929,"des1":162,"des2":914,"des3":989,"des4":568}]', 'Y', '2020-04-12 18:25:42', NULL),
	(179, 4, 'Televisor7', '724', '792', '[{"lote":581,"fecha vencimiento":196,"gramos":444,"des1":963,"des2":974,"des3":171,"des4":190}]', 'Y', '2020-04-12 18:25:42', NULL),
	(180, 4, 'Televisor8', '976', '85', '[{"lote":716,"fecha vencimiento":997,"gramos":461,"des1":407,"des2":396,"des3":619,"des4":314}]', 'Y', '2020-04-12 18:25:42', NULL),
	(181, 4, 'Televisor9', '427', '130', '[{"lote":325,"fecha vencimiento":670,"gramos":21,"des1":396,"des2":860,"des3":226,"des4":515}]', 'Y', '2020-04-12 18:25:42', NULL),
	(182, 4, 'Televisor10', '855', '584', '[{"lote":906,"fecha vencimiento":905,"gramos":424,"des1":409,"des2":777,"des3":156,"des4":642}]', 'Y', '2020-04-12 18:25:42', NULL),
	(183, 4, 'Televisor11', '483', '619', '[{"lote":106,"fecha vencimiento":691,"gramos":573,"des1":429,"des2":697,"des3":814,"des4":584}]', 'Y', '2020-04-12 18:25:42', NULL),
	(184, 4, 'Televisor12', '266', '734', '[{"lote":457,"fecha vencimiento":561,"gramos":252,"des1":59,"des2":344,"des3":783,"des4":271}]', 'Y', '2020-04-12 18:25:42', NULL),
	(185, 4, 'Televisor13', '174', '261', '[{"lote":296,"fecha vencimiento":161,"gramos":224,"des1":38,"des2":968,"des3":452,"des4":505}]', 'Y', '2020-04-12 18:25:42', NULL),
	(186, 4, 'Televisor14', '824', '209', '[{"lote":564,"fecha vencimiento":788,"gramos":601,"des1":812,"des2":432,"des3":222,"des4":206}]', 'Y', '2020-04-12 18:25:42', NULL),
	(187, 4, 'Televisor15', '536', '283', '[{"lote":675,"fecha vencimiento":900,"gramos":186,"des1":485,"des2":442,"des3":894,"des4":508}]', 'Y', '2020-04-12 18:25:42', NULL),
	(188, 4, 'Televisor16', '811', '223', '[{"lote":783,"fecha vencimiento":76,"gramos":931,"des1":685,"des2":546,"des3":160,"des4":659}]', 'Y', '2020-04-12 18:25:42', NULL),
	(189, 4, 'Televisor17', '751', '649', '[{"lote":631,"fecha vencimiento":350,"gramos":155,"des1":813,"des2":777,"des3":695,"des4":744}]', 'Y', '2020-04-12 18:25:42', NULL),
	(190, 4, 'Televisor18', '589', '150', '[{"lote":791,"fecha vencimiento":988,"gramos":471,"des1":202,"des2":827,"des3":195,"des4":329}]', 'Y', '2020-04-12 18:25:42', NULL),
	(191, 4, 'Televisor19', '120', '907', '[{"lote":924,"fecha vencimiento":888,"gramos":281,"des1":315,"des2":889,"des3":682,"des4":262}]', 'Y', '2020-04-12 18:25:42', NULL),
	(192, 12, 'Televisor', '941', '141', '[{"lote":509,"fecha vencimiento":105,"gramos":703,"des1":691,"des2":613,"des3":855,"des4":30}]', 'Y', '2020-04-12 18:26:41', NULL),
	(193, 12, 'Televisor2', '28', '331', '[{"lote":207,"fecha vencimiento":512,"gramos":412,"des1":982,"des2":119,"des3":594,"des4":320}]', 'Y', '2020-04-12 18:26:41', NULL),
	(194, 12, 'Televisor3', '345', '887', '[{"lote":637,"fecha vencimiento":874,"gramos":110,"des1":980,"des2":148,"des3":983,"des4":604}]', 'Y', '2020-04-12 18:26:41', NULL),
	(195, 12, 'Televisor4', '100', '901', '[{"lote":288,"fecha vencimiento":10,"gramos":707,"des1":874,"des2":194,"des3":172,"des4":583}]', 'Y', '2020-04-12 18:26:41', NULL),
	(196, 12, 'Televisor5', '24', '928', '[{"lote":476,"fecha vencimiento":161,"gramos":982,"des1":704,"des2":963,"des3":317,"des4":471}]', 'Y', '2020-04-12 18:26:41', NULL),
	(197, 12, 'Televisor6', '604', '487', '[{"lote":587,"fecha vencimiento":633,"gramos":929,"des1":162,"des2":914,"des3":989,"des4":568}]', 'Y', '2020-04-12 18:26:41', NULL),
	(198, 12, 'Televisor7', '724', '792', '[{"lote":581,"fecha vencimiento":196,"gramos":444,"des1":963,"des2":974,"des3":171,"des4":190}]', 'Y', '2020-04-12 18:26:41', NULL),
	(199, 12, 'Televisor8', '976', '85', '[{"lote":716,"fecha vencimiento":997,"gramos":461,"des1":407,"des2":396,"des3":619,"des4":314}]', 'Y', '2020-04-12 18:26:41', NULL),
	(200, 12, 'Televisor9', '427', '130', '[{"lote":325,"fecha vencimiento":670,"gramos":21,"des1":396,"des2":860,"des3":226,"des4":515}]', 'Y', '2020-04-12 18:26:41', NULL),
	(201, 12, 'Televisor10', '855', '584', '[{"lote":906,"fecha vencimiento":905,"gramos":424,"des1":409,"des2":777,"des3":156,"des4":642}]', 'Y', '2020-04-12 18:26:41', NULL),
	(202, 12, 'Televisor11', '483', '619', '[{"lote":106,"fecha vencimiento":691,"gramos":573,"des1":429,"des2":697,"des3":814,"des4":584}]', 'Y', '2020-04-12 18:26:41', NULL),
	(203, 12, 'Televisor12', '266', '734', '[{"lote":457,"fecha vencimiento":561,"gramos":252,"des1":59,"des2":344,"des3":783,"des4":271}]', 'Y', '2020-04-12 18:26:41', NULL),
	(204, 12, 'Televisor13', '174', '261', '[{"lote":296,"fecha vencimiento":161,"gramos":224,"des1":38,"des2":968,"des3":452,"des4":505}]', 'Y', '2020-04-12 18:26:41', NULL),
	(205, 12, 'Televisor14', '824', '209', '[{"lote":564,"fecha vencimiento":788,"gramos":601,"des1":812,"des2":432,"des3":222,"des4":206}]', 'Y', '2020-04-12 18:26:41', NULL),
	(206, 12, 'Televisor15', '536', '283', '[{"lote":675,"fecha vencimiento":900,"gramos":186,"des1":485,"des2":442,"des3":894,"des4":508}]', 'Y', '2020-04-12 18:26:41', NULL),
	(207, 12, 'Televisor16', '811', '223', '[{"lote":783,"fecha vencimiento":76,"gramos":931,"des1":685,"des2":546,"des3":160,"des4":659}]', 'Y', '2020-04-12 18:26:41', NULL),
	(208, 12, 'Televisor17', '751', '649', '[{"lote":631,"fecha vencimiento":350,"gramos":155,"des1":813,"des2":777,"des3":695,"des4":744}]', 'Y', '2020-04-12 18:26:41', NULL),
	(209, 12, 'Televisor18', '589', '150', '[{"lote":791,"fecha vencimiento":988,"gramos":471,"des1":202,"des2":827,"des3":195,"des4":329}]', 'Y', '2020-04-12 18:26:41', NULL),
	(210, 12, 'Televisor19', '120', '907', '[{"lote":924,"fecha vencimiento":888,"gramos":281,"des1":315,"des2":889,"des3":682,"des4":262}]', 'Y', '2020-04-12 18:26:41', NULL),
	(211, 1, 'Televisor', '941', '141', '[{"lote":509,"fecha vencimiento":105,"gramos":703,"des1":691,"des2":613,"des3":855,"des4":30}]', 'Y', '2020-04-12 18:27:40', NULL),
	(212, 1, 'Televisor2', '28', '331', '[{"lote":207,"fecha vencimiento":512,"gramos":412,"des1":982,"des2":119,"des3":594,"des4":320}]', 'Y', '2020-04-12 18:27:40', NULL),
	(213, 1, 'Televisor3', '345', '887', '[{"lote":637,"fecha vencimiento":874,"gramos":110,"des1":980,"des2":148,"des3":983,"des4":604}]', 'Y', '2020-04-12 18:27:40', NULL),
	(214, 1, 'Televisor4', '100', '901', '[{"lote":288,"fecha vencimiento":10,"gramos":707,"des1":874,"des2":194,"des3":172,"des4":583}]', 'Y', '2020-04-12 18:27:40', NULL),
	(215, 1, 'Televisor5', '24', '928', '[{"lote":476,"fecha vencimiento":161,"gramos":982,"des1":704,"des2":963,"des3":317,"des4":471}]', 'Y', '2020-04-12 18:27:40', NULL),
	(216, 1, 'Televisor6', '604', '487', '[{"lote":587,"fecha vencimiento":633,"gramos":929,"des1":162,"des2":914,"des3":989,"des4":568}]', 'Y', '2020-04-12 18:27:40', NULL),
	(217, 1, 'Televisor7', '724', '792', '[{"lote":581,"fecha vencimiento":196,"gramos":444,"des1":963,"des2":974,"des3":171,"des4":190}]', 'Y', '2020-04-12 18:27:40', NULL),
	(218, 1, 'Televisor8', '976', '85', '[{"lote":716,"fecha vencimiento":997,"gramos":461,"des1":407,"des2":396,"des3":619,"des4":314}]', 'Y', '2020-04-12 18:27:40', NULL),
	(219, 1, 'Televisor9', '427', '130', '[{"lote":325,"fecha vencimiento":670,"gramos":21,"des1":396,"des2":860,"des3":226,"des4":515}]', 'Y', '2020-04-12 18:27:40', NULL),
	(220, 1, 'Televisor10', '855', '584', '[{"lote":906,"fecha vencimiento":905,"gramos":424,"des1":409,"des2":777,"des3":156,"des4":642}]', 'Y', '2020-04-12 18:27:40', NULL),
	(221, 1, 'Televisor11', '483', '619', '[{"lote":106,"fecha vencimiento":691,"gramos":573,"des1":429,"des2":697,"des3":814,"des4":584}]', 'Y', '2020-04-12 18:27:40', NULL),
	(222, 1, 'Televisor12', '266', '734', '[{"lote":457,"fecha vencimiento":561,"gramos":252,"des1":59,"des2":344,"des3":783,"des4":271}]', 'Y', '2020-04-12 18:27:40', NULL),
	(223, 1, 'Televisor13', '174', '261', '[{"lote":296,"fecha vencimiento":161,"gramos":224,"des1":38,"des2":968,"des3":452,"des4":505}]', 'Y', '2020-04-12 18:27:40', NULL),
	(224, 1, 'Televisor14', '824', '209', '[{"lote":564,"fecha vencimiento":788,"gramos":601,"des1":812,"des2":432,"des3":222,"des4":206}]', 'Y', '2020-04-12 18:27:40', NULL),
	(225, 1, 'Televisor15', '536', '283', '[{"lote":675,"fecha vencimiento":900,"gramos":186,"des1":485,"des2":442,"des3":894,"des4":508}]', 'Y', '2020-04-12 18:27:40', NULL),
	(226, 1, 'Televisor16', '811', '223', '[{"lote":783,"fecha vencimiento":76,"gramos":931,"des1":685,"des2":546,"des3":160,"des4":659}]', 'Y', '2020-04-12 18:27:40', NULL),
	(227, 1, 'Televisor17', '751', '649', '[{"lote":631,"fecha vencimiento":350,"gramos":155,"des1":813,"des2":777,"des3":695,"des4":744}]', 'Y', '2020-04-12 18:27:40', NULL),
	(228, 1, 'Televisor18', '589', '150', '[{"lote":791,"fecha vencimiento":988,"gramos":471,"des1":202,"des2":827,"des3":195,"des4":329}]', 'Y', '2020-04-12 18:27:40', NULL),
	(229, 1, 'Televisor19', '120', '907', '[{"lote":924,"fecha vencimiento":888,"gramos":281,"des1":315,"des2":889,"des3":682,"des4":262}]', 'Y', '2020-04-12 18:27:40', NULL),
	(230, 12, 'Televisor', '941', '141', '[{"lote":509,"fecha vencimiento":105,"gramos":703,"des1":691,"des2":613,"des3":855,"des4":30}]', 'Y', '2020-04-12 18:29:25', NULL),
	(231, 12, 'Televisor2', '28', '331', '[{"lote":207,"fecha vencimiento":512,"gramos":412,"des1":982,"des2":119,"des3":594,"des4":320}]', 'Y', '2020-04-12 18:29:25', NULL),
	(232, 12, 'Televisor3', '345', '887', '[{"lote":637,"fecha vencimiento":874,"gramos":110,"des1":980,"des2":148,"des3":983,"des4":604}]', 'Y', '2020-04-12 18:29:25', NULL),
	(233, 12, 'Televisor4', '100', '901', '[{"lote":288,"fecha vencimiento":10,"gramos":707,"des1":874,"des2":194,"des3":172,"des4":583}]', 'Y', '2020-04-12 18:29:25', NULL),
	(234, 12, 'Televisor5', '24', '928', '[{"lote":476,"fecha vencimiento":161,"gramos":982,"des1":704,"des2":963,"des3":317,"des4":471}]', 'Y', '2020-04-12 18:29:25', NULL),
	(235, 12, 'Televisor6', '604', '487', '[{"lote":587,"fecha vencimiento":633,"gramos":929,"des1":162,"des2":914,"des3":989,"des4":568}]', 'Y', '2020-04-12 18:29:25', NULL),
	(236, 12, 'Televisor7', '724', '792', '[{"lote":581,"fecha vencimiento":196,"gramos":444,"des1":963,"des2":974,"des3":171,"des4":190}]', 'Y', '2020-04-12 18:29:25', NULL),
	(237, 12, 'Televisor8', '976', '85', '[{"lote":716,"fecha vencimiento":997,"gramos":461,"des1":407,"des2":396,"des3":619,"des4":314}]', 'Y', '2020-04-12 18:29:25', NULL),
	(238, 12, 'Televisor9', '427', '130', '[{"lote":325,"fecha vencimiento":670,"gramos":21,"des1":396,"des2":860,"des3":226,"des4":515}]', 'Y', '2020-04-12 18:29:25', NULL),
	(239, 12, 'Televisor10', '855', '584', '[{"lote":906,"fecha vencimiento":905,"gramos":424,"des1":409,"des2":777,"des3":156,"des4":642}]', 'Y', '2020-04-12 18:29:25', NULL),
	(240, 12, 'Televisor11', '483', '619', '[{"lote":106,"fecha vencimiento":691,"gramos":573,"des1":429,"des2":697,"des3":814,"des4":584}]', 'Y', '2020-04-12 18:29:25', NULL),
	(241, 12, 'Televisor12', '266', '734', '[{"lote":457,"fecha vencimiento":561,"gramos":252,"des1":59,"des2":344,"des3":783,"des4":271}]', 'Y', '2020-04-12 18:29:25', NULL),
	(242, 12, 'Televisor13', '174', '261', '[{"lote":296,"fecha vencimiento":161,"gramos":224,"des1":38,"des2":968,"des3":452,"des4":505}]', 'Y', '2020-04-12 18:29:25', NULL),
	(243, 12, 'Televisor14', '824', '209', '[{"lote":564,"fecha vencimiento":788,"gramos":601,"des1":812,"des2":432,"des3":222,"des4":206}]', 'Y', '2020-04-12 18:29:25', NULL),
	(244, 12, 'Televisor15', '536', '283', '[{"lote":675,"fecha vencimiento":900,"gramos":186,"des1":485,"des2":442,"des3":894,"des4":508}]', 'Y', '2020-04-12 18:29:25', NULL),
	(245, 12, 'Televisor16', '811', '223', '[{"lote":783,"fecha vencimiento":76,"gramos":931,"des1":685,"des2":546,"des3":160,"des4":659}]', 'Y', '2020-04-12 18:29:25', NULL),
	(246, 12, 'Televisor17', '751', '649', '[{"lote":631,"fecha vencimiento":350,"gramos":155,"des1":813,"des2":777,"des3":695,"des4":744}]', 'Y', '2020-04-12 18:29:25', NULL),
	(247, 12, 'Televisor18', '589', '150', '[{"lote":791,"fecha vencimiento":988,"gramos":471,"des1":202,"des2":827,"des3":195,"des4":329}]', 'Y', '2020-04-12 18:29:25', NULL),
	(248, 12, 'Televisor19', '120', '907', '[{"lote":924,"fecha vencimiento":888,"gramos":281,"des1":315,"des2":889,"des3":682,"des4":262}]', 'Y', '2020-04-12 18:29:25', NULL),
	(249, 4, 'Televisor', '941', '141', '[{"lote":509,"fecha vencimiento":105,"gramos":703,"des1":691,"des2":613,"des3":855,"des4":30}]', 'Y', '2020-04-12 18:30:51', NULL),
	(250, 4, 'Televisor2', '28', '331', '[{"lote":207,"fecha vencimiento":512,"gramos":412,"des1":982,"des2":119,"des3":594,"des4":320}]', 'Y', '2020-04-12 18:30:51', NULL),
	(251, 4, 'Televisor3', '345', '887', '[{"lote":637,"fecha vencimiento":874,"gramos":110,"des1":980,"des2":148,"des3":983,"des4":604}]', 'Y', '2020-04-12 18:30:51', NULL),
	(252, 4, 'Televisor4', '100', '901', '[{"lote":288,"fecha vencimiento":10,"gramos":707,"des1":874,"des2":194,"des3":172,"des4":583}]', 'Y', '2020-04-12 18:30:51', NULL),
	(253, 4, 'Televisor5', '24', '928', '[{"lote":476,"fecha vencimiento":161,"gramos":982,"des1":704,"des2":963,"des3":317,"des4":471}]', 'Y', '2020-04-12 18:30:51', NULL),
	(254, 4, 'Televisor6', '604', '487', '[{"lote":587,"fecha vencimiento":633,"gramos":929,"des1":162,"des2":914,"des3":989,"des4":568}]', 'Y', '2020-04-12 18:30:51', NULL),
	(255, 4, 'Televisor7', '724', '792', '[{"lote":581,"fecha vencimiento":196,"gramos":444,"des1":963,"des2":974,"des3":171,"des4":190}]', 'Y', '2020-04-12 18:30:51', NULL),
	(256, 4, 'Televisor8', '976', '85', '[{"lote":716,"fecha vencimiento":997,"gramos":461,"des1":407,"des2":396,"des3":619,"des4":314}]', 'Y', '2020-04-12 18:30:51', NULL),
	(257, 4, 'Televisor9', '427', '130', '[{"lote":325,"fecha vencimiento":670,"gramos":21,"des1":396,"des2":860,"des3":226,"des4":515}]', 'Y', '2020-04-12 18:30:51', NULL),
	(258, 4, 'Televisor10', '855', '584', '[{"lote":906,"fecha vencimiento":905,"gramos":424,"des1":409,"des2":777,"des3":156,"des4":642}]', 'Y', '2020-04-12 18:30:51', NULL),
	(259, 4, 'Televisor11', '483', '619', '[{"lote":106,"fecha vencimiento":691,"gramos":573,"des1":429,"des2":697,"des3":814,"des4":584}]', 'Y', '2020-04-12 18:30:51', NULL),
	(260, 4, 'Televisor12', '266', '734', '[{"lote":457,"fecha vencimiento":561,"gramos":252,"des1":59,"des2":344,"des3":783,"des4":271}]', 'Y', '2020-04-12 18:30:51', NULL),
	(261, 4, 'Televisor13', '174', '261', '[{"lote":296,"fecha vencimiento":161,"gramos":224,"des1":38,"des2":968,"des3":452,"des4":505}]', 'Y', '2020-04-12 18:30:51', NULL),
	(262, 4, 'Televisor14', '824', '209', '[{"lote":564,"fecha vencimiento":788,"gramos":601,"des1":812,"des2":432,"des3":222,"des4":206}]', 'Y', '2020-04-12 18:30:51', NULL),
	(263, 4, 'Televisor15', '536', '283', '[{"lote":675,"fecha vencimiento":900,"gramos":186,"des1":485,"des2":442,"des3":894,"des4":508}]', 'Y', '2020-04-12 18:30:51', NULL),
	(264, 4, 'Televisor16', '811', '223', '[{"lote":783,"fecha vencimiento":76,"gramos":931,"des1":685,"des2":546,"des3":160,"des4":659}]', 'Y', '2020-04-12 18:30:51', NULL),
	(265, 4, 'Televisor17', '751', '649', '[{"lote":631,"fecha vencimiento":350,"gramos":155,"des1":813,"des2":777,"des3":695,"des4":744}]', 'Y', '2020-04-12 18:30:51', NULL),
	(266, 4, 'Televisor18', '589', '150', '[{"lote":791,"fecha vencimiento":988,"gramos":471,"des1":202,"des2":827,"des3":195,"des4":329}]', 'Y', '2020-04-12 18:30:51', NULL),
	(267, 4, 'Televisor19', '120', '907', '[{"lote":924,"fecha vencimiento":888,"gramos":281,"des1":315,"des2":889,"des3":682,"des4":262}]', 'Y', '2020-04-12 18:30:51', NULL),
	(268, 15, 'Televisor', '941', '141', '[{"lote":509,"fecha vencimiento":105,"gramos":703,"des1":691,"des2":613,"des3":855,"des4":30}]', 'Y', '2020-04-12 18:37:29', NULL),
	(269, 15, 'Televisor2', '28', '331', '[{"lote":207,"fecha vencimiento":512,"gramos":412,"des1":982,"des2":119,"des3":594,"des4":320}]', 'Y', '2020-04-12 18:37:29', NULL),
	(270, 15, 'Televisor3', '345', '887', '[{"lote":637,"fecha vencimiento":874,"gramos":110,"des1":980,"des2":148,"des3":983,"des4":604}]', 'Y', '2020-04-12 18:37:29', NULL),
	(271, 15, 'Televisor4', '100', '901', '[{"lote":288,"fecha vencimiento":10,"gramos":707,"des1":874,"des2":194,"des3":172,"des4":583}]', 'Y', '2020-04-12 18:37:29', NULL),
	(272, 15, 'Televisor5', '24', '928', '[{"lote":476,"fecha vencimiento":161,"gramos":982,"des1":704,"des2":963,"des3":317,"des4":471}]', 'Y', '2020-04-12 18:37:29', NULL),
	(273, 15, 'Televisor6', '604', '487', '[{"lote":587,"fecha vencimiento":633,"gramos":929,"des1":162,"des2":914,"des3":989,"des4":568}]', 'Y', '2020-04-12 18:37:29', NULL),
	(274, 15, 'Televisor7', '724', '792', '[{"lote":581,"fecha vencimiento":196,"gramos":444,"des1":963,"des2":974,"des3":171,"des4":190}]', 'Y', '2020-04-12 18:37:29', NULL),
	(275, 15, 'Televisor8', '976', '85', '[{"lote":716,"fecha vencimiento":997,"gramos":461,"des1":407,"des2":396,"des3":619,"des4":314}]', 'Y', '2020-04-12 18:37:29', NULL),
	(276, 15, 'Televisor9', '427', '130', '[{"lote":325,"fecha vencimiento":670,"gramos":21,"des1":396,"des2":860,"des3":226,"des4":515}]', 'Y', '2020-04-12 18:37:29', NULL),
	(277, 15, 'Televisor10', '855', '584', '[{"lote":906,"fecha vencimiento":905,"gramos":424,"des1":409,"des2":777,"des3":156,"des4":642}]', 'Y', '2020-04-12 18:37:29', NULL),
	(278, 15, 'Televisor11', '483', '619', '[{"lote":106,"fecha vencimiento":691,"gramos":573,"des1":429,"des2":697,"des3":814,"des4":584}]', 'Y', '2020-04-12 18:37:29', NULL),
	(279, 15, 'Televisor12', '266', '734', '[{"lote":457,"fecha vencimiento":561,"gramos":252,"des1":59,"des2":344,"des3":783,"des4":271}]', 'Y', '2020-04-12 18:37:29', NULL),
	(280, 15, 'Televisor13', '174', '261', '[{"lote":296,"fecha vencimiento":161,"gramos":224,"des1":38,"des2":968,"des3":452,"des4":505}]', 'Y', '2020-04-12 18:37:29', NULL),
	(281, 15, 'Televisor14', '824', '209', '[{"lote":564,"fecha vencimiento":788,"gramos":601,"des1":812,"des2":432,"des3":222,"des4":206}]', 'Y', '2020-04-12 18:37:29', NULL),
	(282, 15, 'Televisor15', '536', '283', '[{"lote":675,"fecha vencimiento":900,"gramos":186,"des1":485,"des2":442,"des3":894,"des4":508}]', 'Y', '2020-04-12 18:37:29', NULL),
	(283, 15, 'Televisor16', '811', '223', '[{"lote":783,"fecha vencimiento":76,"gramos":931,"des1":685,"des2":546,"des3":160,"des4":659}]', 'Y', '2020-04-12 18:37:29', NULL),
	(284, 15, 'Televisor17', '751', '649', '[{"lote":631,"fecha vencimiento":350,"gramos":155,"des1":813,"des2":777,"des3":695,"des4":744}]', 'Y', '2020-04-12 18:37:29', NULL),
	(285, 15, 'Televisor18', '589', '150', '[{"lote":791,"fecha vencimiento":988,"gramos":471,"des1":202,"des2":827,"des3":195,"des4":329}]', 'Y', '2020-04-12 18:37:29', NULL),
	(286, 15, 'Televisor19', '120', '907', '[{"lote":924,"fecha vencimiento":888,"gramos":281,"des1":315,"des2":889,"des3":682,"des4":262}]', 'Y', '2020-04-12 18:37:29', NULL),
	(287, 9, 'Televisor', '941', '141', '[{"lote":509,"fecha vencimiento":105,"gramos":703,"des1":691,"des2":613,"des3":855,"des4":30}]', 'Y', '2020-04-12 18:38:30', NULL),
	(288, 9, 'Televisor2', '28', '331', '[{"lote":207,"fecha vencimiento":512,"gramos":412,"des1":982,"des2":119,"des3":594,"des4":320}]', 'Y', '2020-04-12 18:38:30', NULL),
	(289, 9, 'Televisor3', '345', '887', '[{"lote":637,"fecha vencimiento":874,"gramos":110,"des1":980,"des2":148,"des3":983,"des4":604}]', 'Y', '2020-04-12 18:38:30', NULL),
	(290, 9, 'Televisor4', '100', '901', '[{"lote":288,"fecha vencimiento":10,"gramos":707,"des1":874,"des2":194,"des3":172,"des4":583}]', 'Y', '2020-04-12 18:38:30', NULL),
	(291, 9, 'Televisor5', '24', '928', '[{"lote":476,"fecha vencimiento":161,"gramos":982,"des1":704,"des2":963,"des3":317,"des4":471}]', 'Y', '2020-04-12 18:38:30', NULL),
	(292, 9, 'Televisor6', '604', '487', '[{"lote":587,"fecha vencimiento":633,"gramos":929,"des1":162,"des2":914,"des3":989,"des4":568}]', 'Y', '2020-04-12 18:38:30', NULL),
	(293, 9, 'Televisor7', '724', '792', '[{"lote":581,"fecha vencimiento":196,"gramos":444,"des1":963,"des2":974,"des3":171,"des4":190}]', 'Y', '2020-04-12 18:38:30', NULL),
	(294, 9, 'Televisor8', '976', '85', '[{"lote":716,"fecha vencimiento":997,"gramos":461,"des1":407,"des2":396,"des3":619,"des4":314}]', 'Y', '2020-04-12 18:38:30', NULL),
	(295, 9, 'Televisor9', '427', '130', '[{"lote":325,"fecha vencimiento":670,"gramos":21,"des1":396,"des2":860,"des3":226,"des4":515}]', 'Y', '2020-04-12 18:38:30', NULL),
	(296, 9, 'Televisor10', '855', '584', '[{"lote":906,"fecha vencimiento":905,"gramos":424,"des1":409,"des2":777,"des3":156,"des4":642}]', 'Y', '2020-04-12 18:38:30', NULL),
	(297, 9, 'Televisor11', '483', '619', '[{"lote":106,"fecha vencimiento":691,"gramos":573,"des1":429,"des2":697,"des3":814,"des4":584}]', 'Y', '2020-04-12 18:38:30', NULL),
	(298, 9, 'Televisor12', '266', '734', '[{"lote":457,"fecha vencimiento":561,"gramos":252,"des1":59,"des2":344,"des3":783,"des4":271}]', 'Y', '2020-04-12 18:38:30', NULL),
	(299, 9, 'Televisor13', '174', '261', '[{"lote":296,"fecha vencimiento":161,"gramos":224,"des1":38,"des2":968,"des3":452,"des4":505}]', 'Y', '2020-04-12 18:38:30', NULL),
	(300, 9, 'Televisor14', '824', '209', '[{"lote":564,"fecha vencimiento":788,"gramos":601,"des1":812,"des2":432,"des3":222,"des4":206}]', 'Y', '2020-04-12 18:38:30', NULL),
	(301, 9, 'Televisor15', '536', '283', '[{"lote":675,"fecha vencimiento":900,"gramos":186,"des1":485,"des2":442,"des3":894,"des4":508}]', 'Y', '2020-04-12 18:38:30', NULL),
	(302, 9, 'Televisor16', '811', '223', '[{"lote":783,"fecha vencimiento":76,"gramos":931,"des1":685,"des2":546,"des3":160,"des4":659}]', 'Y', '2020-04-12 18:38:30', NULL),
	(303, 9, 'Televisor17', '751', '649', '[{"lote":631,"fecha vencimiento":350,"gramos":155,"des1":813,"des2":777,"des3":695,"des4":744}]', 'Y', '2020-04-12 18:38:30', NULL),
	(304, 9, 'Televisor18', '589', '150', '[{"lote":791,"fecha vencimiento":988,"gramos":471,"des1":202,"des2":827,"des3":195,"des4":329}]', 'Y', '2020-04-12 18:38:30', NULL),
	(305, 9, 'Televisor19', '120', '907', '[{"lote":924,"fecha vencimiento":888,"gramos":281,"des1":315,"des2":889,"des3":682,"des4":262}]', 'Y', '2020-04-12 18:38:30', NULL),
	(306, 16, 'Televisor', '941', '141', '[{"lote":509,"fecha vencimiento":105,"gramos":703,"des1":691,"des2":613,"des3":855,"des4":30}]', 'Y', '2020-04-12 18:40:46', NULL),
	(307, 16, 'Televisor2', '28', '331', '[{"lote":207,"fecha vencimiento":512,"gramos":412,"des1":982,"des2":119,"des3":594,"des4":320}]', 'Y', '2020-04-12 18:40:46', NULL),
	(308, 16, 'Televisor3', '345', '887', '[{"lote":637,"fecha vencimiento":874,"gramos":110,"des1":980,"des2":148,"des3":983,"des4":604}]', 'Y', '2020-04-12 18:40:46', NULL),
	(309, 16, 'Televisor4', '100', '901', '[{"lote":288,"fecha vencimiento":10,"gramos":707,"des1":874,"des2":194,"des3":172,"des4":583}]', 'Y', '2020-04-12 18:40:46', NULL),
	(310, 16, 'Televisor5', '24', '928', '[{"lote":476,"fecha vencimiento":161,"gramos":982,"des1":704,"des2":963,"des3":317,"des4":471}]', 'Y', '2020-04-12 18:40:46', NULL),
	(311, 16, 'Televisor6', '604', '487', '[{"lote":587,"fecha vencimiento":633,"gramos":929,"des1":162,"des2":914,"des3":989,"des4":568}]', 'Y', '2020-04-12 18:40:46', NULL),
	(312, 16, 'Televisor7', '724', '792', '[{"lote":581,"fecha vencimiento":196,"gramos":444,"des1":963,"des2":974,"des3":171,"des4":190}]', 'Y', '2020-04-12 18:40:46', NULL),
	(313, 16, 'Televisor8', '976', '85', '[{"lote":716,"fecha vencimiento":997,"gramos":461,"des1":407,"des2":396,"des3":619,"des4":314}]', 'Y', '2020-04-12 18:40:46', NULL),
	(314, 16, 'Televisor9', '427', '130', '[{"lote":325,"fecha vencimiento":670,"gramos":21,"des1":396,"des2":860,"des3":226,"des4":515}]', 'Y', '2020-04-12 18:40:46', NULL),
	(315, 16, 'Televisor10', '855', '584', '[{"lote":906,"fecha vencimiento":905,"gramos":424,"des1":409,"des2":777,"des3":156,"des4":642}]', 'Y', '2020-04-12 18:40:46', NULL),
	(316, 16, 'Televisor11', '483', '619', '[{"lote":106,"fecha vencimiento":691,"gramos":573,"des1":429,"des2":697,"des3":814,"des4":584}]', 'Y', '2020-04-12 18:40:46', NULL),
	(317, 16, 'Televisor12', '266', '734', '[{"lote":457,"fecha vencimiento":561,"gramos":252,"des1":59,"des2":344,"des3":783,"des4":271}]', 'Y', '2020-04-12 18:40:46', NULL),
	(318, 16, 'Televisor13', '174', '261', '[{"lote":296,"fecha vencimiento":161,"gramos":224,"des1":38,"des2":968,"des3":452,"des4":505}]', 'Y', '2020-04-12 18:40:46', NULL),
	(319, 16, 'Televisor14', '824', '209', '[{"lote":564,"fecha vencimiento":788,"gramos":601,"des1":812,"des2":432,"des3":222,"des4":206}]', 'Y', '2020-04-12 18:40:46', NULL),
	(320, 16, 'Televisor15', '536', '283', '[{"lote":675,"fecha vencimiento":900,"gramos":186,"des1":485,"des2":442,"des3":894,"des4":508}]', 'Y', '2020-04-12 18:40:46', NULL),
	(321, 16, 'Televisor16', '811', '223', '[{"lote":783,"fecha vencimiento":76,"gramos":931,"des1":685,"des2":546,"des3":160,"des4":659}]', 'Y', '2020-04-12 18:40:46', NULL),
	(322, 16, 'Televisor17', '751', '649', '[{"lote":631,"fecha vencimiento":350,"gramos":155,"des1":813,"des2":777,"des3":695,"des4":744}]', 'Y', '2020-04-12 18:40:46', NULL),
	(323, 16, 'Televisor18', '589', '150', '[{"lote":791,"fecha vencimiento":988,"gramos":471,"des1":202,"des2":827,"des3":195,"des4":329}]', 'Y', '2020-04-12 18:40:46', NULL),
	(324, 16, 'Televisor19', '120', '907', '[{"lote":924,"fecha vencimiento":888,"gramos":281,"des1":315,"des2":889,"des3":682,"des4":262}]', 'Y', '2020-04-12 18:40:46', NULL),
	(325, 16, 'Televisor', '941', '141', '[{"lote":509,"fecha vencimiento":105,"gramos":703,"des1":691,"des2":613,"des3":855,"des4":30}]', 'Y', '2020-04-12 18:41:27', NULL),
	(326, 16, 'Televisor2', '28', '331', '[{"lote":207,"fecha vencimiento":512,"gramos":412,"des1":982,"des2":119,"des3":594,"des4":320}]', 'Y', '2020-04-12 18:41:27', NULL),
	(327, 16, 'Televisor3', '345', '887', '[{"lote":637,"fecha vencimiento":874,"gramos":110,"des1":980,"des2":148,"des3":983,"des4":604}]', 'Y', '2020-04-12 18:41:27', NULL),
	(328, 16, 'Televisor4', '100', '901', '[{"lote":288,"fecha vencimiento":10,"gramos":707,"des1":874,"des2":194,"des3":172,"des4":583}]', 'Y', '2020-04-12 18:41:27', NULL),
	(329, 16, 'Televisor5', '24', '928', '[{"lote":476,"fecha vencimiento":161,"gramos":982,"des1":704,"des2":963,"des3":317,"des4":471}]', 'Y', '2020-04-12 18:41:27', NULL),
	(330, 16, 'Televisor6', '604', '487', '[{"lote":587,"fecha vencimiento":633,"gramos":929,"des1":162,"des2":914,"des3":989,"des4":568}]', 'Y', '2020-04-12 18:41:27', NULL),
	(331, 16, 'Televisor7', '724', '792', '[{"lote":581,"fecha vencimiento":196,"gramos":444,"des1":963,"des2":974,"des3":171,"des4":190}]', 'Y', '2020-04-12 18:41:27', NULL),
	(332, 16, 'Televisor8', '976', '85', '[{"lote":716,"fecha vencimiento":997,"gramos":461,"des1":407,"des2":396,"des3":619,"des4":314}]', 'Y', '2020-04-12 18:41:27', NULL),
	(333, 16, 'Televisor9', '427', '130', '[{"lote":325,"fecha vencimiento":670,"gramos":21,"des1":396,"des2":860,"des3":226,"des4":515}]', 'Y', '2020-04-12 18:41:27', NULL),
	(334, 16, 'Televisor10', '855', '584', '[{"lote":906,"fecha vencimiento":905,"gramos":424,"des1":409,"des2":777,"des3":156,"des4":642}]', 'Y', '2020-04-12 18:41:27', NULL),
	(335, 16, 'Televisor11', '483', '619', '[{"lote":106,"fecha vencimiento":691,"gramos":573,"des1":429,"des2":697,"des3":814,"des4":584}]', 'Y', '2020-04-12 18:41:27', NULL),
	(336, 16, 'Televisor12', '266', '734', '[{"lote":457,"fecha vencimiento":561,"gramos":252,"des1":59,"des2":344,"des3":783,"des4":271}]', 'Y', '2020-04-12 18:41:27', NULL),
	(337, 16, 'Televisor13', '174', '261', '[{"lote":296,"fecha vencimiento":161,"gramos":224,"des1":38,"des2":968,"des3":452,"des4":505}]', 'Y', '2020-04-12 18:41:27', NULL),
	(338, 16, 'Televisor14', '824', '209', '[{"lote":564,"fecha vencimiento":788,"gramos":601,"des1":812,"des2":432,"des3":222,"des4":206}]', 'Y', '2020-04-12 18:41:27', NULL),
	(339, 16, 'Televisor15', '536', '283', '[{"lote":675,"fecha vencimiento":900,"gramos":186,"des1":485,"des2":442,"des3":894,"des4":508}]', 'Y', '2020-04-12 18:41:27', NULL),
	(340, 16, 'Televisor16', '811', '223', '[{"lote":783,"fecha vencimiento":76,"gramos":931,"des1":685,"des2":546,"des3":160,"des4":659}]', 'Y', '2020-04-12 18:41:27', NULL),
	(341, 16, 'Televisor17', '751', '649', '[{"lote":631,"fecha vencimiento":350,"gramos":155,"des1":813,"des2":777,"des3":695,"des4":744}]', 'Y', '2020-04-12 18:41:27', NULL),
	(342, 16, 'Televisor18', '589', '150', '[{"lote":791,"fecha vencimiento":988,"gramos":471,"des1":202,"des2":827,"des3":195,"des4":329}]', 'Y', '2020-04-12 18:41:27', NULL),
	(343, 16, 'Televisor19', '120', '907', '[{"lote":924,"fecha vencimiento":888,"gramos":281,"des1":315,"des2":889,"des3":682,"des4":262}]', 'Y', '2020-04-12 18:41:27', NULL),
	(344, 9, 'Televisor', '941', '141', '[{"lote":509,"fecha vencimiento":105,"gramos":703,"des1":691,"des2":613,"des3":855,"des4":30}]', 'Y', '2020-04-12 18:57:21', NULL),
	(345, 9, 'Televisor2', '28', '331', '[{"lote":207,"fecha vencimiento":512,"gramos":412,"des1":982,"des2":119,"des3":594,"des4":320}]', 'Y', '2020-04-12 18:57:21', NULL),
	(346, 9, 'Televisor3', '345', '887', '[{"lote":637,"fecha vencimiento":874,"gramos":110,"des1":980,"des2":148,"des3":983,"des4":604}]', 'Y', '2020-04-12 18:57:21', NULL),
	(347, 9, 'Televisor4', '100', '901', '[{"lote":288,"fecha vencimiento":10,"gramos":707,"des1":874,"des2":194,"des3":172,"des4":583}]', 'Y', '2020-04-12 18:57:21', NULL),
	(348, 9, 'Televisor5', '24', '928', '[{"lote":476,"fecha vencimiento":161,"gramos":982,"des1":704,"des2":963,"des3":317,"des4":471}]', 'Y', '2020-04-12 18:57:21', NULL),
	(349, 9, 'Televisor6', '604', '487', '[{"lote":587,"fecha vencimiento":633,"gramos":929,"des1":162,"des2":914,"des3":989,"des4":568}]', 'Y', '2020-04-12 18:57:21', NULL),
	(350, 9, 'Televisor7', '724', '792', '[{"lote":581,"fecha vencimiento":196,"gramos":444,"des1":963,"des2":974,"des3":171,"des4":190}]', 'Y', '2020-04-12 18:57:21', NULL),
	(351, 9, 'Televisor8', '976', '85', '[{"lote":716,"fecha vencimiento":997,"gramos":461,"des1":407,"des2":396,"des3":619,"des4":314}]', 'Y', '2020-04-12 18:57:21', NULL),
	(352, 9, 'Televisor9', '427', '130', '[{"lote":325,"fecha vencimiento":670,"gramos":21,"des1":396,"des2":860,"des3":226,"des4":515}]', 'Y', '2020-04-12 18:57:21', NULL),
	(353, 9, 'Televisor10', '855', '584', '[{"lote":906,"fecha vencimiento":905,"gramos":424,"des1":409,"des2":777,"des3":156,"des4":642}]', 'Y', '2020-04-12 18:57:21', NULL),
	(354, 9, 'Televisor11', '483', '619', '[{"lote":106,"fecha vencimiento":691,"gramos":573,"des1":429,"des2":697,"des3":814,"des4":584}]', 'Y', '2020-04-12 18:57:21', NULL),
	(355, 9, 'Televisor12', '266', '734', '[{"lote":457,"fecha vencimiento":561,"gramos":252,"des1":59,"des2":344,"des3":783,"des4":271}]', 'Y', '2020-04-12 18:57:21', NULL),
	(356, 9, 'Televisor13', '174', '261', '[{"lote":296,"fecha vencimiento":161,"gramos":224,"des1":38,"des2":968,"des3":452,"des4":505}]', 'Y', '2020-04-12 18:57:21', NULL),
	(357, 9, 'Televisor14', '824', '209', '[{"lote":564,"fecha vencimiento":788,"gramos":601,"des1":812,"des2":432,"des3":222,"des4":206}]', 'Y', '2020-04-12 18:57:21', NULL),
	(358, 9, 'Televisor15', '536', '283', '[{"lote":675,"fecha vencimiento":900,"gramos":186,"des1":485,"des2":442,"des3":894,"des4":508}]', 'Y', '2020-04-12 18:57:21', NULL),
	(359, 9, 'Televisor16', '811', '223', '[{"lote":783,"fecha vencimiento":76,"gramos":931,"des1":685,"des2":546,"des3":160,"des4":659}]', 'Y', '2020-04-12 18:57:21', NULL),
	(360, 9, 'Televisor17', '751', '649', '[{"lote":631,"fecha vencimiento":350,"gramos":155,"des1":813,"des2":777,"des3":695,"des4":744}]', 'Y', '2020-04-12 18:57:21', NULL),
	(361, 9, 'Televisor18', '589', '150', '[{"lote":791,"fecha vencimiento":988,"gramos":471,"des1":202,"des2":827,"des3":195,"des4":329}]', 'Y', '2020-04-12 18:57:21', NULL),
	(362, 9, 'Televisor19', '120', '907', '[{"lote":924,"fecha vencimiento":888,"gramos":281,"des1":315,"des2":889,"des3":682,"des4":262}]', 'Y', '2020-04-12 18:57:21', NULL),
	(363, 16, 'Televisor', '941', '141', '[{"lote":509,"fecha vencimiento":105,"gramos":703,"des1":691,"des2":613,"des3":855,"des4":30}]', 'Y', '2020-04-12 18:59:38', NULL),
	(364, 16, 'Televisor2', '28', '331', '[{"lote":207,"fecha vencimiento":512,"gramos":412,"des1":982,"des2":119,"des3":594,"des4":320}]', 'Y', '2020-04-12 18:59:38', NULL),
	(365, 16, 'Televisor3', '345', '887', '[{"lote":637,"fecha vencimiento":874,"gramos":110,"des1":980,"des2":148,"des3":983,"des4":604}]', 'Y', '2020-04-12 18:59:38', NULL),
	(366, 16, 'Televisor4', '100', '901', '[{"lote":288,"fecha vencimiento":10,"gramos":707,"des1":874,"des2":194,"des3":172,"des4":583}]', 'Y', '2020-04-12 18:59:38', NULL),
	(367, 16, 'Televisor5', '24', '928', '[{"lote":476,"fecha vencimiento":161,"gramos":982,"des1":704,"des2":963,"des3":317,"des4":471}]', 'Y', '2020-04-12 18:59:38', NULL),
	(368, 16, 'Televisor6', '604', '487', '[{"lote":587,"fecha vencimiento":633,"gramos":929,"des1":162,"des2":914,"des3":989,"des4":568}]', 'Y', '2020-04-12 18:59:38', NULL),
	(369, 16, 'Televisor7', '724', '792', '[{"lote":581,"fecha vencimiento":196,"gramos":444,"des1":963,"des2":974,"des3":171,"des4":190}]', 'Y', '2020-04-12 18:59:38', NULL),
	(370, 16, 'Televisor8', '976', '85', '[{"lote":716,"fecha vencimiento":997,"gramos":461,"des1":407,"des2":396,"des3":619,"des4":314}]', 'Y', '2020-04-12 18:59:38', NULL),
	(371, 16, 'Televisor9', '427', '130', '[{"lote":325,"fecha vencimiento":670,"gramos":21,"des1":396,"des2":860,"des3":226,"des4":515}]', 'Y', '2020-04-12 18:59:38', NULL),
	(372, 16, 'Televisor10', '855', '584', '[{"lote":906,"fecha vencimiento":905,"gramos":424,"des1":409,"des2":777,"des3":156,"des4":642}]', 'Y', '2020-04-12 18:59:38', NULL),
	(373, 16, 'Televisor11', '483', '619', '[{"lote":106,"fecha vencimiento":691,"gramos":573,"des1":429,"des2":697,"des3":814,"des4":584}]', 'Y', '2020-04-12 18:59:38', NULL),
	(374, 16, 'Televisor12', '266', '734', '[{"lote":457,"fecha vencimiento":561,"gramos":252,"des1":59,"des2":344,"des3":783,"des4":271}]', 'Y', '2020-04-12 18:59:38', NULL),
	(375, 16, 'Televisor13', '174', '261', '[{"lote":296,"fecha vencimiento":161,"gramos":224,"des1":38,"des2":968,"des3":452,"des4":505}]', 'Y', '2020-04-12 18:59:38', NULL),
	(376, 16, 'Televisor14', '824', '209', '[{"lote":564,"fecha vencimiento":788,"gramos":601,"des1":812,"des2":432,"des3":222,"des4":206}]', 'Y', '2020-04-12 18:59:38', NULL),
	(377, 16, 'Televisor15', '536', '283', '[{"lote":675,"fecha vencimiento":900,"gramos":186,"des1":485,"des2":442,"des3":894,"des4":508}]', 'Y', '2020-04-12 18:59:38', NULL),
	(379, 16, 'Televisor17', '751', '649', '[{"lote":631,"fecha vencimiento":350,"gramos":155,"des1":813,"des2":777,"des3":695,"des4":744}]', 'Y', '2020-04-12 18:59:38', NULL),
	(380, 16, 'Televisor18', '589', '150', '[{"lote":791,"fecha vencimiento":988,"gramos":471,"des1":202,"des2":827,"des3":195,"des4":329}]', 'Y', '2020-04-12 18:59:38', NULL),
	(381, 16, 'Televisor19', '120', '907', '[{"lote":924,"fecha vencimiento":888,"gramos":281,"des1":315,"des2":889,"des3":682,"des4":262}]', 'Y', '2020-04-12 18:59:38', NULL),
	(382, 9, 'Televisor', '941', '141', '[{"lote":509,"fecha vencimiento":105,"gramos":703,"des1":691,"des2":613,"des3":855,"des4":30}]', 'Y', '2020-04-12 21:57:12', NULL),
	(383, 9, 'Televisor2', '28', '331', '[{"lote":207,"fecha vencimiento":512,"gramos":412,"des1":982,"des2":119,"des3":594,"des4":320}]', 'Y', '2020-04-12 21:57:12', NULL),
	(384, 9, 'Televisor3', '345', '887', '[{"lote":637,"fecha vencimiento":874,"gramos":110,"des1":980,"des2":148,"des3":983,"des4":604}]', 'Y', '2020-04-12 21:57:12', NULL),
	(385, 9, 'Televisor4', '100', '901', '[{"lote":288,"fecha vencimiento":10,"gramos":707,"des1":874,"des2":194,"des3":172,"des4":583}]', 'Y', '2020-04-12 21:57:12', NULL),
	(386, 9, 'Televisor5', '24', '928', '[{"lote":476,"fecha vencimiento":161,"gramos":982,"des1":704,"des2":963,"des3":317,"des4":471}]', 'Y', '2020-04-12 21:57:12', NULL),
	(387, 9, 'Televisor6', '604', '487', '[{"lote":587,"fecha vencimiento":633,"gramos":929,"des1":162,"des2":914,"des3":989,"des4":568}]', 'Y', '2020-04-12 21:57:12', NULL),
	(388, 9, 'Televisor7', '724', '792', '[{"lote":581,"fecha vencimiento":196,"gramos":444,"des1":963,"des2":974,"des3":171,"des4":190}]', 'Y', '2020-04-12 21:57:12', NULL),
	(389, 9, 'Televisor8', '976', '85', '[{"lote":716,"fecha vencimiento":997,"gramos":461,"des1":407,"des2":396,"des3":619,"des4":314}]', 'Y', '2020-04-12 21:57:12', NULL),
	(390, 9, 'Televisor9', '427', '130', '[{"lote":325,"fecha vencimiento":670,"gramos":21,"des1":396,"des2":860,"des3":226,"des4":515}]', 'Y', '2020-04-12 21:57:12', NULL),
	(391, 9, 'Televisor10', '855', '584', '[{"lote":906,"fecha vencimiento":905,"gramos":424,"des1":409,"des2":777,"des3":156,"des4":642}]', 'Y', '2020-04-12 21:57:12', NULL),
	(392, 9, 'Televisor11', '483', '619', '[{"lote":106,"fecha vencimiento":691,"gramos":573,"des1":429,"des2":697,"des3":814,"des4":584}]', 'Y', '2020-04-12 21:57:12', NULL),
	(393, 9, 'Televisor12', '266', '734', '[{"lote":457,"fecha vencimiento":561,"gramos":252,"des1":59,"des2":344,"des3":783,"des4":271}]', 'Y', '2020-04-12 21:57:12', NULL),
	(394, 9, 'Televisor13', '174', '261', '[{"lote":296,"fecha vencimiento":161,"gramos":224,"des1":38,"des2":968,"des3":452,"des4":505}]', 'Y', '2020-04-12 21:57:12', NULL),
	(395, 9, 'Televisor14', '824', '209', '[{"lote":564,"fecha vencimiento":788,"gramos":601,"des1":812,"des2":432,"des3":222,"des4":206}]', 'Y', '2020-04-12 21:57:12', NULL),
	(396, 9, 'Televisor15', '536', '283', '[{"lote":675,"fecha vencimiento":900,"gramos":186,"des1":485,"des2":442,"des3":894,"des4":508}]', 'Y', '2020-04-12 21:57:12', NULL),
	(397, 9, 'Televisor16', '811', '223', '[{"lote":783,"fecha vencimiento":76,"gramos":931,"des1":685,"des2":546,"des3":160,"des4":659}]', 'Y', '2020-04-12 21:57:12', NULL),
	(398, 9, 'Televisor17', '751', '649', '[{"lote":631,"fecha vencimiento":350,"gramos":155,"des1":813,"des2":777,"des3":695,"des4":744}]', 'Y', '2020-04-12 21:57:12', NULL),
	(399, 9, 'Televisor18', '589', '150', '[{"lote":791,"fecha vencimiento":988,"gramos":471,"des1":202,"des2":827,"des3":195,"des4":329}]', 'Y', '2020-04-12 21:57:12', NULL),
	(400, 9, 'Televisor19', '120', '907', '[{"lote":924,"fecha vencimiento":888,"gramos":281,"des1":315,"des2":889,"des3":682,"des4":262}]', 'Y', '2020-04-12 21:57:12', NULL),
	(401, 10, 'Televisor', '941', '141', '[{"lote":509,"fecha vencimiento":105,"gramos":703,"des1":691,"des2":613,"des3":855,"des4":30}]', 'Y', '2020-04-12 22:09:04', NULL),
	(402, 10, 'Televisor2', '28', '331', '[{"lote":207,"fecha vencimiento":512,"gramos":412,"des1":982,"des2":119,"des3":594,"des4":320}]', 'Y', '2020-04-12 22:09:04', NULL),
	(403, 10, 'Televisor3', '345', '887', '[{"lote":637,"fecha vencimiento":874,"gramos":110,"des1":980,"des2":148,"des3":983,"des4":604}]', 'Y', '2020-04-12 22:09:04', NULL),
	(404, 10, 'Televisor4', '100', '901', '[{"lote":288,"fecha vencimiento":10,"gramos":707,"des1":874,"des2":194,"des3":172,"des4":583}]', 'Y', '2020-04-12 22:09:04', NULL),
	(405, 10, 'Televisor5', '24', '928', '[{"lote":476,"fecha vencimiento":161,"gramos":982,"des1":704,"des2":963,"des3":317,"des4":471}]', 'Y', '2020-04-12 22:09:04', NULL),
	(406, 10, 'Televisor6', '604', '487', '[{"lote":587,"fecha vencimiento":633,"gramos":929,"des1":162,"des2":914,"des3":989,"des4":568}]', 'Y', '2020-04-12 22:09:04', NULL),
	(407, 10, 'Televisor7', '724', '792', '[{"lote":581,"fecha vencimiento":196,"gramos":444,"des1":963,"des2":974,"des3":171,"des4":190}]', 'Y', '2020-04-12 22:09:04', NULL),
	(408, 10, 'Televisor8', '976', '85', '[{"lote":716,"fecha vencimiento":997,"gramos":461,"des1":407,"des2":396,"des3":619,"des4":314}]', 'Y', '2020-04-12 22:09:04', NULL),
	(409, 10, 'Televisor9', '427', '130', '[{"lote":325,"fecha vencimiento":670,"gramos":21,"des1":396,"des2":860,"des3":226,"des4":515}]', 'Y', '2020-04-12 22:09:04', NULL),
	(410, 10, 'Televisor10', '855', '584', '[{"lote":906,"fecha vencimiento":905,"gramos":424,"des1":409,"des2":777,"des3":156,"des4":642}]', 'Y', '2020-04-12 22:09:04', NULL),
	(411, 10, 'Televisor11', '483', '619', '[{"lote":106,"fecha vencimiento":691,"gramos":573,"des1":429,"des2":697,"des3":814,"des4":584}]', 'Y', '2020-04-12 22:09:04', NULL),
	(412, 10, 'Televisor12', '266', '734', '[{"lote":457,"fecha vencimiento":561,"gramos":252,"des1":59,"des2":344,"des3":783,"des4":271}]', 'Y', '2020-04-12 22:09:04', NULL),
	(413, 10, 'Televisor13', '174', '261', '[{"lote":296,"fecha vencimiento":161,"gramos":224,"des1":38,"des2":968,"des3":452,"des4":505}]', 'Y', '2020-04-12 22:09:04', NULL),
	(414, 10, 'Televisor14', '824', '209', '[{"lote":564,"fecha vencimiento":788,"gramos":601,"des1":812,"des2":432,"des3":222,"des4":206}]', 'Y', '2020-04-12 22:09:04', NULL),
	(415, 10, 'Televisor15', '536', '283', '[{"lote":675,"fecha vencimiento":900,"gramos":186,"des1":485,"des2":442,"des3":894,"des4":508}]', 'Y', '2020-04-12 22:09:04', NULL),
	(416, 10, 'Televisor16', '811', '223', '[{"lote":783,"fecha vencimiento":76,"gramos":931,"des1":685,"des2":546,"des3":160,"des4":659}]', 'Y', '2020-04-12 22:09:04', NULL),
	(417, 10, 'Televisor17', '751', '649', '[{"lote":631,"fecha vencimiento":350,"gramos":155,"des1":813,"des2":777,"des3":695,"des4":744}]', 'Y', '2020-04-12 22:09:04', NULL),
	(418, 10, 'Televisor18', '589', '150', '[{"lote":791,"fecha vencimiento":988,"gramos":471,"des1":202,"des2":827,"des3":195,"des4":329}]', 'Y', '2020-04-12 22:09:04', NULL),
	(419, 10, 'Televisor19', '120', '907', '[{"lote":924,"fecha vencimiento":888,"gramos":281,"des1":315,"des2":889,"des3":682,"des4":262}]', 'Y', '2020-04-12 22:09:04', NULL);
/*!40000 ALTER TABLE `prov_productos` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
