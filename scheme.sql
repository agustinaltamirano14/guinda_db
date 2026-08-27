create database guinda_db;
use guinda_db;

create table categoria_producto(
	id_cat INT AUTO_INCREMENT PRIMARY KEY,
	nombre_cat VARCHAR(50) NOT NULL UNIQUE,
	descripcion_cat VARCHAR(255), 
    estado_cat BOOL NOT NULL DEFAULT TRUE
);