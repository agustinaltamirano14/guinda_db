CREATE DATABASE  IF NOT EXISTS `guinda` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `guinda`;
-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: guinda
-- ------------------------------------------------------
-- Server version	26.7.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ 'cf07596b-a293-11f1-aec1-9c6b007af5a7:1-90';

--
-- Table structure for table `apertura_cierre_cajas`
--

DROP TABLE IF EXISTS `apertura_cierre_cajas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `apertura_cierre_cajas` (
  `id_apertura_cierre` int NOT NULL AUTO_INCREMENT,
  `id_cajas_fk_apertura_cierre` int NOT NULL,
  `id_usuarios_fk_apertura_cierre` int NOT NULL,
  `fecha_apertura_caja` datetime NOT NULL,
  `fecha_cierre_caja` datetime DEFAULT NULL,
  `monto_inicial` decimal(14,2) NOT NULL,
  `monto_final_real` decimal(14,2) DEFAULT NULL,
  `monto_final_teorico` decimal(14,2) DEFAULT NULL,
  `diferencia` decimal(14,2) DEFAULT NULL,
  `observaciones` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id_apertura_cierre`),
  KEY `id_cajas_fk_apertura_cierre_idx` (`id_cajas_fk_apertura_cierre`),
  KEY `id_usuarios_fk_apertura_cierre_idx` (`id_usuarios_fk_apertura_cierre`),
  CONSTRAINT `fk_apertura_cierre_cajas` FOREIGN KEY (`id_cajas_fk_apertura_cierre`) REFERENCES `cajas` (`id_cajas`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_apertura_cierre_usuarios` FOREIGN KEY (`id_usuarios_fk_apertura_cierre`) REFERENCES `usuarios` (`id_usuarios`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `ck_apertura_monto_inicial` CHECK ((`monto_inicial` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apertura_cierre_cajas`
--

LOCK TABLES `apertura_cierre_cajas` WRITE;
/*!40000 ALTER TABLE `apertura_cierre_cajas` DISABLE KEYS */;
/*!40000 ALTER TABLE `apertura_cierre_cajas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auditorias`
--

DROP TABLE IF EXISTS `auditorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auditorias` (
  `id_auditorias` int NOT NULL AUTO_INCREMENT,
  `id_usuarios_auditorias` int NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `accion` enum('INSERT','DELETE','UPDATE','LOGIN','LOGOUT') NOT NULL,
  `tabla_afectada` varchar(50) NOT NULL,
  `id_registro_afectado` int DEFAULT NULL,
  `datos_previos` text,
  `datos_nuevos` text,
  PRIMARY KEY (`id_auditorias`),
  KEY `id_usuarios_auditorias_idx` (`id_usuarios_auditorias`),
  CONSTRAINT `fk_auditorias_usuarios` FOREIGN KEY (`id_usuarios_auditorias`) REFERENCES `usuarios` (`id_usuarios`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditorias`
--

LOCK TABLES `auditorias` WRITE;
/*!40000 ALTER TABLE `auditorias` DISABLE KEYS */;
/*!40000 ALTER TABLE `auditorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cajas`
--

DROP TABLE IF EXISTS `cajas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cajas` (
  `id_cajas` int NOT NULL AUTO_INCREMENT,
  `nombre_cajas` varchar(45) NOT NULL,
  `ubicacion` varchar(100) DEFAULT NULL,
  `estado` tinyint NOT NULL,
  PRIMARY KEY (`id_cajas`),
  UNIQUE KEY `nombre_cajas_UNIQUE` (`nombre_cajas`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cajas`
--

LOCK TABLES `cajas` WRITE;
/*!40000 ALTER TABLE `cajas` DISABLE KEYS */;
/*!40000 ALTER TABLE `cajas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorias_producto`
--

DROP TABLE IF EXISTS `categorias_producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorias_producto` (
  `id_cat` int NOT NULL AUTO_INCREMENT,
  `nombre_cat` varchar(50) NOT NULL,
  `descripcion_cat` varchar(255) DEFAULT NULL,
  `estado_cat` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_cat`),
  UNIQUE KEY `nombre_cat` (`nombre_cat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias_producto`
--

LOCK TABLES `categorias_producto` WRITE;
/*!40000 ALTER TABLE `categorias_producto` DISABLE KEYS */;
/*!40000 ALTER TABLE `categorias_producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `id_clientes` int NOT NULL AUTO_INCREMENT,
  `id_usuarios_clientes` int DEFAULT NULL,
  `nombre` varchar(60) NOT NULL,
  `apellido` varchar(60) NOT NULL,
  `dni_cuit` varchar(13) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  `fecha_alta` date NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_clientes`),
  UNIQUE KEY `dni_cuit_UNIQUE` (`dni_cuit`),
  UNIQUE KEY `id_usuarios_UNIQUE` (`id_usuarios_clientes`),
  CONSTRAINT `fk_clientes_usuarios` FOREIGN KEY (`id_usuarios_clientes`) REFERENCES `usuarios` (`id_usuarios`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compras`
--

DROP TABLE IF EXISTS `compras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compras` (
  `id_compras` int NOT NULL AUTO_INCREMENT,
  `id_usuarios` int NOT NULL,
  `id_prov` int NOT NULL,
  `fecha` datetime NOT NULL,
  `numero_factura` varchar(30) DEFAULT NULL,
  `total` decimal(14,2) NOT NULL,
  `estado` enum('recibida','pendiente','anulada') NOT NULL,
  `observaciones` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id_compras`),
  KEY `id_prov_idx` (`id_prov`),
  KEY `fk_compras_usuarios` (`id_usuarios`),
  CONSTRAINT `fk_compras_proveedores` FOREIGN KEY (`id_prov`) REFERENCES `proveedores` (`id_prov`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_compras_usuarios` FOREIGN KEY (`id_usuarios`) REFERENCES `usuarios` (`id_usuarios`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `ck_compras_total` CHECK ((`total` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compras`
--

LOCK TABLES `compras` WRITE;
/*!40000 ALTER TABLE `compras` DISABLE KEYS */;
/*!40000 ALTER TABLE `compras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_compras`
--

DROP TABLE IF EXISTS `detalle_compras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle_compras` (
  `id_detalle_compras` int NOT NULL AUTO_INCREMENT,
  `id_compras_detalle` int NOT NULL,
  `id_productos_detalle_compra` int NOT NULL,
  `cantidad` int NOT NULL,
  `precio_unitario` decimal(12,2) NOT NULL,
  `subtotal` decimal(14,2) NOT NULL,
  PRIMARY KEY (`id_detalle_compras`),
  KEY `id_compras_detalle_idx` (`id_compras_detalle`),
  KEY `id_productos_detalle_compra_idx` (`id_productos_detalle_compra`),
  CONSTRAINT `fk_detcompra_compras` FOREIGN KEY (`id_compras_detalle`) REFERENCES `compras` (`id_compras`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_detcompra_productos` FOREIGN KEY (`id_productos_detalle_compra`) REFERENCES `productos` (`idproductos`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `ck_detcompra_cantidad` CHECK ((`cantidad` > 0)),
  CONSTRAINT `ck_detcompra_precio` CHECK ((`precio_unitario` >= 0)),
  CONSTRAINT `ck_detcompra_subtotal` CHECK ((`subtotal` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_compras`
--

LOCK TABLES `detalle_compras` WRITE;
/*!40000 ALTER TABLE `detalle_compras` DISABLE KEYS */;
/*!40000 ALTER TABLE `detalle_compras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_pedidos`
--

DROP TABLE IF EXISTS `detalle_pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle_pedidos` (
  `id_detalle_pedidos` int NOT NULL AUTO_INCREMENT,
  `id_pedidos_detalle` int NOT NULL,
  `id_productos_detalle_pedido` int NOT NULL,
  `cantidad` int NOT NULL,
  `precio_referencia` decimal(12,2) NOT NULL,
  PRIMARY KEY (`id_detalle_pedidos`),
  KEY `id_pedidos_detalle_idx` (`id_pedidos_detalle`),
  KEY `id_productos_detalle_pedido_idx` (`id_productos_detalle_pedido`),
  CONSTRAINT `fk_detpedido_pedidos` FOREIGN KEY (`id_pedidos_detalle`) REFERENCES `pedidos` (`id_pedidos`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_detpedido_productos` FOREIGN KEY (`id_productos_detalle_pedido`) REFERENCES `productos` (`idproductos`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `ck_detpedido_cantidad` CHECK ((`cantidad` > 0)),
  CONSTRAINT `ck_detpedido_precio` CHECK ((`precio_referencia` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_pedidos`
--

LOCK TABLES `detalle_pedidos` WRITE;
/*!40000 ALTER TABLE `detalle_pedidos` DISABLE KEYS */;
/*!40000 ALTER TABLE `detalle_pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_ventas`
--

DROP TABLE IF EXISTS `detalle_ventas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle_ventas` (
  `id_detalle_ventas` int NOT NULL AUTO_INCREMENT,
  `id_ventas_detalle` int NOT NULL,
  `id_productos_detalle_venta` int NOT NULL,
  `cantidad` int NOT NULL,
  `precio_unitario` decimal(12,2) NOT NULL,
  `descuento_aplicado` decimal(12,2) NOT NULL DEFAULT '0.00',
  `subtotal` decimal(14,2) NOT NULL,
  PRIMARY KEY (`id_detalle_ventas`),
  KEY `id_ventas_detalle_idx` (`id_ventas_detalle`),
  KEY `id_productos_detalle_venta_idx` (`id_productos_detalle_venta`),
  CONSTRAINT `fk_detventa_productos` FOREIGN KEY (`id_productos_detalle_venta`) REFERENCES `productos` (`idproductos`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_detventa_ventas` FOREIGN KEY (`id_ventas_detalle`) REFERENCES `ventas` (`id_ventas`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ck_detventa_cantidad` CHECK ((`cantidad` > 0)),
  CONSTRAINT `ck_detventa_descuento` CHECK ((`descuento_aplicado` >= 0)),
  CONSTRAINT `ck_detventa_precio` CHECK ((`precio_unitario` >= 0)),
  CONSTRAINT `ck_detventa_subtotal` CHECK ((`subtotal` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_ventas`
--

LOCK TABLES `detalle_ventas` WRITE;
/*!40000 ALTER TABLE `detalle_ventas` DISABLE KEYS */;
/*!40000 ALTER TABLE `detalle_ventas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `envios`
--

DROP TABLE IF EXISTS `envios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `envios` (
  `id_envios` int NOT NULL AUTO_INCREMENT,
  `id_ventas_envios` int NOT NULL,
  `fecha_despacho` datetime DEFAULT NULL,
  `empresa_transporte` varchar(80) DEFAULT NULL,
  `codigo_seguimiento` varchar(50) DEFAULT NULL,
  `direccion_entrega` varchar(200) NOT NULL,
  `estado` enum('pendiente','preparado','despachado','en_transito','entregado','demorado','devuelto') NOT NULL DEFAULT 'pendiente',
  `costo` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`id_envios`),
  KEY `id_ventas_envios_idx` (`id_ventas_envios`),
  CONSTRAINT `fk_envios_ventas` FOREIGN KEY (`id_ventas_envios`) REFERENCES `ventas` (`id_ventas`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `ck_envios_costo` CHECK ((`costo` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `envios`
--

LOCK TABLES `envios` WRITE;
/*!40000 ALTER TABLE `envios` DISABLE KEYS */;
/*!40000 ALTER TABLE `envios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marcas_producto`
--

DROP TABLE IF EXISTS `marcas_producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `marcas_producto` (
  `id_marca` int NOT NULL AUTO_INCREMENT,
  `nombre_marca` varchar(50) NOT NULL,
  `descripcion_marca` varchar(255) DEFAULT NULL,
  `estado_marca` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_marca`),
  UNIQUE KEY `nombre_marca` (`nombre_marca`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marcas_producto`
--

LOCK TABLES `marcas_producto` WRITE;
/*!40000 ALTER TABLE `marcas_producto` DISABLE KEYS */;
/*!40000 ALTER TABLE `marcas_producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metodos_pago`
--

DROP TABLE IF EXISTS `metodos_pago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metodos_pago` (
  `idmetodos_pago` int NOT NULL AUTO_INCREMENT,
  `nombre_mp` varchar(50) NOT NULL,
  `estado_mp` tinyint NOT NULL,
  PRIMARY KEY (`idmetodos_pago`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre_mp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metodos_pago`
--

LOCK TABLES `metodos_pago` WRITE;
/*!40000 ALTER TABLE `metodos_pago` DISABLE KEYS */;
/*!40000 ALTER TABLE `metodos_pago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movimientos_caja`
--

DROP TABLE IF EXISTS `movimientos_caja`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movimientos_caja` (
  `id_movimientos_caja` int NOT NULL AUTO_INCREMENT,
  `id_apertura_cierre_movimiento` int NOT NULL,
  `id_metodos_pago_movimiento` int NOT NULL,
  `id_ventas_movimiento` int DEFAULT NULL,
  `id_compras_movimiento` int DEFAULT NULL,
  `fecha_hora` datetime NOT NULL,
  `tipo_movimiento` enum('ingreso','egreso') NOT NULL,
  `monto` decimal(14,2) NOT NULL,
  `concepto` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_movimientos_caja`),
  KEY `id_apertura_cierre_movimiento_idx` (`id_apertura_cierre_movimiento`),
  KEY `id_metodos_pago_movimiento_idx` (`id_metodos_pago_movimiento`),
  KEY `id_ventas_movimiento_idx` (`id_ventas_movimiento`),
  KEY `id_compras_movimiento_idx` (`id_compras_movimiento`),
  CONSTRAINT `fk_movcaja_apertura_cierre` FOREIGN KEY (`id_apertura_cierre_movimiento`) REFERENCES `apertura_cierre_cajas` (`id_apertura_cierre`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_movcaja_compras` FOREIGN KEY (`id_compras_movimiento`) REFERENCES `compras` (`id_compras`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_movcaja_metodos_pago` FOREIGN KEY (`id_metodos_pago_movimiento`) REFERENCES `metodos_pago` (`idmetodos_pago`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_movcaja_ventas` FOREIGN KEY (`id_ventas_movimiento`) REFERENCES `ventas` (`id_ventas`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `ck_movcaja_monto` CHECK ((`monto` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movimientos_caja`
--

LOCK TABLES `movimientos_caja` WRITE;
/*!40000 ALTER TABLE `movimientos_caja` DISABLE KEYS */;
/*!40000 ALTER TABLE `movimientos_caja` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movimientos_stock`
--

DROP TABLE IF EXISTS `movimientos_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movimientos_stock` (
  `id_movimientos_stock` int NOT NULL AUTO_INCREMENT,
  `id_stock_movimiento` int NOT NULL,
  `id_usuarios_movimiento_stock` int NOT NULL,
  `fecha` datetime NOT NULL,
  `tipo_movimiento` enum('entrada','salida','ajuste','reposicion') NOT NULL,
  `cantidad` int NOT NULL,
  `motivo` varchar(255) DEFAULT NULL,
  `referencia` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_movimientos_stock`),
  KEY `id_stock_movimiento_idx` (`id_stock_movimiento`),
  KEY `id_usuarios_movimiento_stock_idx` (`id_usuarios_movimiento_stock`),
  CONSTRAINT `fk_movstock_stock` FOREIGN KEY (`id_stock_movimiento`) REFERENCES `stock` (`id_stock`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_movstock_usuarios` FOREIGN KEY (`id_usuarios_movimiento_stock`) REFERENCES `usuarios` (`id_usuarios`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `ck_movstock_cantidad` CHECK ((`cantidad` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movimientos_stock`
--

LOCK TABLES `movimientos_stock` WRITE;
/*!40000 ALTER TABLE `movimientos_stock` DISABLE KEYS */;
/*!40000 ALTER TABLE `movimientos_stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `id_pedidos` int NOT NULL AUTO_INCREMENT,
  `id_clientes_pedidos` int NOT NULL,
  `id_usuarios_pedidos` int DEFAULT NULL,
  `fecha` datetime NOT NULL,
  `canal` enum('WhatsApp','Instagram','presencial','MercadoLibre','web','otro') NOT NULL,
  `estado` enum('pendiente','reservado','en_espera_stock','listo','entregado','cancelado') NOT NULL DEFAULT 'pendiente',
  `observaciones` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id_pedidos`),
  KEY `id_clientes_pedidos_idx` (`id_clientes_pedidos`),
  KEY `id_usuarios_pedidos_idx` (`id_usuarios_pedidos`),
  CONSTRAINT `fk_pedidos_clientes` FOREIGN KEY (`id_clientes_pedidos`) REFERENCES `clientes` (`id_clientes`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_pedidos_usuarios` FOREIGN KEY (`id_usuarios_pedidos`) REFERENCES `usuarios` (`id_usuarios`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `idproductos` int NOT NULL AUTO_INCREMENT,
  `codigo_barras` varchar(50) DEFAULT NULL,
  `id_cat` int NOT NULL,
  `id_marca` int NOT NULL,
  `nombre` varchar(120) NOT NULL,
  `descripcion` varchar(500) DEFAULT NULL,
  `presentacion` varchar(60) DEFAULT NULL,
  `precio_venta` decimal(12,2) NOT NULL,
  `precio_costo` decimal(12,2) NOT NULL,
  `fecha_alta` date NOT NULL,
  `estado_prod` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idproductos`),
  UNIQUE KEY `uq_productos_codigo_barras` (`codigo_barras`),
  KEY `id_cat_idx` (`id_cat`),
  KEY `id_marca_idx` (`id_marca`),
  CONSTRAINT `fk_productos_categorias` FOREIGN KEY (`id_cat`) REFERENCES `categorias_producto` (`id_cat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_productos_marcas` FOREIGN KEY (`id_marca`) REFERENCES `marcas_producto` (`id_marca`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `ck_productos_precio_costo` CHECK ((`precio_costo` >= 0)),
  CONSTRAINT `ck_productos_precio_venta` CHECK ((`precio_venta` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promociones`
--

DROP TABLE IF EXISTS `promociones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `promociones` (
  `id_prom` int NOT NULL AUTO_INCREMENT,
  `nombre_prom` varchar(80) NOT NULL,
  `descripcion_prom` varchar(255) DEFAULT NULL,
  `tipo_descuento` enum('porcentaje','monto_fijo') NOT NULL,
  `valor_descuento` decimal(10,2) NOT NULL,
  `fecha_inicio_prom` date NOT NULL,
  `fecha_FIN_prom` date NOT NULL,
  `estado_prom` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_prom`),
  CONSTRAINT `ck_prom_fechas` CHECK ((`fecha_FIN_prom` >= `fecha_inicio_prom`)),
  CONSTRAINT `ck_prom_valor` CHECK ((`valor_descuento` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promociones`
--

LOCK TABLES `promociones` WRITE;
/*!40000 ALTER TABLE `promociones` DISABLE KEYS */;
/*!40000 ALTER TABLE `promociones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promociones_x_productos`
--

DROP TABLE IF EXISTS `promociones_x_productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `promociones_x_productos` (
  `id_prom_prod` int NOT NULL AUTO_INCREMENT,
  `id_prom_ppx` int NOT NULL,
  `id_productos_ppx` int NOT NULL,
  PRIMARY KEY (`id_prom_prod`),
  UNIQUE KEY `uq_prom_producto` (`id_prom_ppx`,`id_productos_ppx`),
  KEY `id_productos_ppx_idx` (`id_productos_ppx`),
  CONSTRAINT `fk_ppx_productos` FOREIGN KEY (`id_productos_ppx`) REFERENCES `productos` (`idproductos`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_ppx_promociones` FOREIGN KEY (`id_prom_ppx`) REFERENCES `promociones` (`id_prom`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promociones_x_productos`
--

LOCK TABLES `promociones_x_productos` WRITE;
/*!40000 ALTER TABLE `promociones_x_productos` DISABLE KEYS */;
/*!40000 ALTER TABLE `promociones_x_productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedores`
--

DROP TABLE IF EXISTS `proveedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proveedores` (
  `id_prov` int NOT NULL AUTO_INCREMENT,
  `razon_social_prov` varchar(120) NOT NULL,
  `cuit_prov` varchar(13) NOT NULL,
  `telefono_prov` varchar(20) DEFAULT NULL,
  `email_prov` varchar(100) DEFAULT NULL,
  `direccion_prov` varchar(200) DEFAULT NULL,
  `observaciones_prov` varchar(500) DEFAULT NULL,
  `estado_prov` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_prov`),
  UNIQUE KEY `cuit_prov` (`cuit_prov`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedores`
--

LOCK TABLES `proveedores` WRITE;
/*!40000 ALTER TABLE `proveedores` DISABLE KEYS */;
/*!40000 ALTER TABLE `proveedores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedores_x_productos`
--

DROP TABLE IF EXISTS `proveedores_x_productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proveedores_x_productos` (
  `id_prov_prod` int NOT NULL AUTO_INCREMENT,
  `id_prov_pxp` int NOT NULL,
  `id_productos_pxp` int NOT NULL,
  `precio_compra_referencia` decimal(12,2) DEFAULT NULL,
  `codigo_producto_proveedor` varchar(50) DEFAULT NULL,
  `observaciones` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id_prov_prod`),
  UNIQUE KEY `uq_prov_producto` (`id_prov_pxp`,`id_productos_pxp`),
  KEY `id_productos_pxp_idx` (`id_productos_pxp`),
  CONSTRAINT `fk_pxp_productos` FOREIGN KEY (`id_productos_pxp`) REFERENCES `productos` (`idproductos`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_pxp_proveedores` FOREIGN KEY (`id_prov_pxp`) REFERENCES `proveedores` (`id_prov`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `ck_pxp_precio` CHECK ((`precio_compra_referencia` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedores_x_productos`
--

LOCK TABLES `proveedores_x_productos` WRITE;
/*!40000 ALTER TABLE `proveedores_x_productos` DISABLE KEYS */;
/*!40000 ALTER TABLE `proveedores_x_productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id_rol` int NOT NULL AUTO_INCREMENT,
  `nombre_rol` varchar(50) NOT NULL,
  `descripcion_rol` varchar(255) DEFAULT NULL,
  `permisos` text NOT NULL,
  PRIMARY KEY (`id_rol`),
  UNIQUE KEY `nombre_rol` (`nombre_rol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock`
--

DROP TABLE IF EXISTS `stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock` (
  `id_stock` int NOT NULL AUTO_INCREMENT,
  `id_productos_stock` int NOT NULL,
  `cantidad_actual` int NOT NULL DEFAULT '0',
  `stock_minimo` int NOT NULL DEFAULT '0',
  `ultima_actualizacion` datetime NOT NULL,
  PRIMARY KEY (`id_stock`),
  UNIQUE KEY `uq_stock_producto` (`id_productos_stock`),
  CONSTRAINT `fk_stock_productos` FOREIGN KEY (`id_productos_stock`) REFERENCES `productos` (`idproductos`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `ck_stock_cantidad` CHECK ((`cantidad_actual` >= 0)),
  CONSTRAINT `ck_stock_minimo` CHECK ((`stock_minimo` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock`
--

LOCK TABLES `stock` WRITE;
/*!40000 ALTER TABLE `stock` DISABLE KEYS */;
/*!40000 ALTER TABLE `stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id_usuarios` int NOT NULL AUTO_INCREMENT,
  `nombre_usuario` varchar(30) NOT NULL,
  `contrasena_usuario` varchar(255) NOT NULL,
  `nombre_real_usuario` varchar(60) NOT NULL,
  `apellido_usuario` varchar(60) NOT NULL,
  `email` varchar(100) NOT NULL,
  `estado` tinyint NOT NULL,
  `fecha_alta` datetime NOT NULL,
  PRIMARY KEY (`id_usuarios`),
  UNIQUE KEY `nombre_usuario_UNIQUE` (`nombre_usuario`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuariosxroles`
--

DROP TABLE IF EXISTS `usuariosxroles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuariosxroles` (
  `id_usuariosxroles` int NOT NULL AUTO_INCREMENT,
  `id_usuarios` int NOT NULL,
  `id_rol` int NOT NULL,
  `fecha_asignacion` date DEFAULT NULL,
  `estado` tinyint NOT NULL,
  PRIMARY KEY (`id_usuariosxroles`),
  UNIQUE KEY `uq_usuario_rol` (`id_usuarios`,`id_rol`),
  KEY `id_usuario_idx` (`id_usuarios`),
  KEY `id_rol_idx` (`id_rol`),
  CONSTRAINT `fk_usuariosxroles_roles` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_usuariosxroles_usuarios` FOREIGN KEY (`id_usuarios`) REFERENCES `usuarios` (`id_usuarios`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuariosxroles`
--

LOCK TABLES `usuariosxroles` WRITE;
/*!40000 ALTER TABLE `usuariosxroles` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuariosxroles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas`
--

DROP TABLE IF EXISTS `ventas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ventas` (
  `id_ventas` int NOT NULL AUTO_INCREMENT,
  `id_clientes_ventas` int NOT NULL,
  `id_usuarios_ventas` int NOT NULL,
  `id_pedidos_ventas` int DEFAULT NULL,
  `fecha` datetime NOT NULL,
  `numero_comprobante` int NOT NULL,
  `total` decimal(14,2) NOT NULL,
  `tipo` enum('presencial','online') NOT NULL,
  `estado` enum('registrada','anulada') NOT NULL DEFAULT 'registrada',
  `observaciones` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id_ventas`),
  UNIQUE KEY `uq_ventas_pedido` (`id_pedidos_ventas`),
  KEY `id_clientes_ventas_idx` (`id_clientes_ventas`),
  KEY `id_usuarios_ventas_idx` (`id_usuarios_ventas`),
  CONSTRAINT `fk_ventas_clientes` FOREIGN KEY (`id_clientes_ventas`) REFERENCES `clientes` (`id_clientes`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_ventas_pedidos` FOREIGN KEY (`id_pedidos_ventas`) REFERENCES `pedidos` (`id_pedidos`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_ventas_usuarios` FOREIGN KEY (`id_usuarios_ventas`) REFERENCES `usuarios` (`id_usuarios`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `ck_ventas_total` CHECK ((`total` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas`
--

LOCK TABLES `ventas` WRITE;
/*!40000 ALTER TABLE `ventas` DISABLE KEYS */;
/*!40000 ALTER TABLE `ventas` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-08-30 22:13:08
