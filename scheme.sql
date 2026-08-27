create database guinda_db;
use guinda_db;

create table categorias_producto(
	id_cat INT AUTO_INCREMENT PRIMARY KEY,
	nombre_cat VARCHAR(50) NOT NULL UNIQUE,
	descripcion_cat VARCHAR(255), 
    estado_cat BOOL NOT NULL DEFAULT TRUE
);

create table marcas_producto(
	id_marca INT AUTO_INCREMENT PRIMARY KEY,
	nombre_marca VARCHAR(50) NOT NULL UNIQUE,
	descripcion_marca VARCHAR(255), 
    estado_marca BOOL NOT NULL DEFAULT TRUE
);

create table provedores(
	id_prov INT AUTO_INCREMENT PRIMARY KEY,
	razon_social_prov VARCHAR(120) NOT NULL,
	cuit_prov VARCHAR(13) NOT NULL UNIQUE,
    telefono_prov VARCHAR(20),
    email_prov VARCHAR(100),
    direccion_prov VARCHAR(200),
    observaciones_prov VARCHAR(500),
    estado_marca BOOL NOT NULL DEFAULT TRUE
);

create table promociones (
    id_prom INT AUTO_INCREMENT PRIMARY KEY,
    nombre_prom VARCHAR(80) NOT NULL,
    descripcion_prom VARCHAR (255),
    tipo_descuento ENUM('porcentaje', 'monto_fijo') NOT NULL,
    fecha_inicio_prom DATE NOT NULL,
    fecha_FIN_prom DATE NOT NULL,
    estado_marca BOOL NOT NULL DEFAULT TRUE
);

CREATE TABLE roles(
	id_rol INT AUTO_INCREMENT PRIMARY KEY,
    nombre_rol VARCHAR(50) NOT NULL UNIQUE,
    descripcion__rol VARCHAR(255),
    permisos TEXT NOT NULL
);
