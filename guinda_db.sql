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

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '7f17b81b-a262-11f1-9f76-902e1632827c:1-16,
cf07596b-a293-11f1-aec1-9c6b007af5a7:1-22';

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
  `fecha_apertura_caja` date NOT NULL,
  `fecha_cierre_caja` date DEFAULT NULL,
  `monto_inicial` decimal(14,2) NOT NULL,
  `monto_final_real` decimal(14,2) DEFAULT NULL,
  `monto_final_teorico` decimal(14,2) DEFAULT NULL,
  `diferencia` decimal(14,2) DEFAULT NULL,
  `observaciones` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id_apertura_cierre`),
  KEY `id_cajas_fk_apertura_cierre_idx` (`id_cajas_fk_apertura_cierre`),
  KEY `id_usuarios_fk_apertura_cierre_idx` (`id_usuarios_fk_apertura_cierre`),
  CONSTRAINT `id_cajas_fk_apertura_cierre` FOREIGN KEY (`id_cajas_fk_apertura_cierre`) REFERENCES `cajas` (`id_cajas`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `id_usuarios_fk_apertura_cierre` FOREIGN KEY (`id_usuarios_fk_apertura_cierre`) REFERENCES `usuarios` (`id_usuarios`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auditorias`
--

DROP TABLE IF EXISTS `auditorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auditorias` (
  `id_auditorias` int NOT NULL AUTO_INCREMENT,
  `id_usuarios_auditorias` int NOT NULL,
  `accion` enum('INSERT','DELETE','UPDATE','LOGIN','LOGOUT') NOT NULL,
  `tabla_afectada` varchar(50) NOT NULL,
  `id_registro_afectado` int DEFAULT NULL,
  `datos_previos` text,
  `datos_nuevos` text,
  PRIMARY KEY (`id_auditorias`),
  KEY `id_usuarios_auditorias_idx` (`id_usuarios_auditorias`),
  CONSTRAINT `id_usuarios_auditorias` FOREIGN KEY (`id_usuarios_auditorias`) REFERENCES `usuarios` (`id_usuarios`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `dni_cuit` int NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `fecha_alta` varchar(45) NOT NULL,
  `estado` tinyint NOT NULL,
  PRIMARY KEY (`id_clientes`),
  UNIQUE KEY `dni_cuit_UNIQUE` (`dni_cuit`),
  UNIQUE KEY `id_usuarios_UNIQUE` (`id_usuarios_clientes`),
  CONSTRAINT `id_usuarios_clientes` FOREIGN KEY (`id_usuarios_clientes`) REFERENCES `usuarios` (`id_usuarios`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `observaciones` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_compras`),
  KEY `id_prov_idx` (`id_prov`),
  CONSTRAINT `id_prov` FOREIGN KEY (`id_prov`) REFERENCES `proveedores` (`id_prov`),
  CONSTRAINT `id_usuarios` FOREIGN KEY (`id_compras`) REFERENCES `usuarios` (`id_usuarios`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
-- Table structure for table `metodos_pago`
--

DROP TABLE IF EXISTS `metodos_pago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metodos_pago` (
  `idmetodos_pago` int NOT NULL AUTO_INCREMENT,
  `nombre_mp` varchar(50) NOT NULL,
  `estado_mp` tinyint NOT NULL,
  PRIMARY KEY (`idmetodos_pago`,`estado_mp`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre_mp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `idproductos` int NOT NULL AUTO_INCREMENT,
  `id_cat` int NOT NULL,
  `id_marca` int NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `precio_venta` decimal(12,2) NOT NULL,
  `precio_costo` decimal(12,2) NOT NULL,
  `fecha_alta` date NOT NULL,
  `estado_prod` tinyint DEFAULT NULL,
  PRIMARY KEY (`idproductos`),
  KEY `id_cat_idx` (`id_cat`),
  KEY `id_marca_idx` (`id_marca`),
  CONSTRAINT `id_cat` FOREIGN KEY (`id_cat`) REFERENCES `categorias_producto` (`id_cat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `id_marca` FOREIGN KEY (`id_marca`) REFERENCES `marcas_producto` (`id_marca`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `fecha_inicio_prom` date NOT NULL,
  `fecha_FIN_prom` date NOT NULL,
  `estado_marca` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_prom`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `estado_marca` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_prov`),
  UNIQUE KEY `cuit_prov` (`cuit_prov`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id_rol` int NOT NULL AUTO_INCREMENT,
  `nombre_rol` varchar(50) NOT NULL,
  `descripcion__rol` varchar(255) DEFAULT NULL,
  `permisos` text NOT NULL,
  PRIMARY KEY (`id_rol`),
  UNIQUE KEY `nombre_rol` (`nombre_rol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  KEY `id_usuario_idx` (`id_usuarios`),
  KEY `id_rol_idx` (`id_rol`),
  CONSTRAINT `id_rol` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `id_usuario` FOREIGN KEY (`id_usuarios`) REFERENCES `usuarios` (`id_usuarios`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-08-30 18:25:39
