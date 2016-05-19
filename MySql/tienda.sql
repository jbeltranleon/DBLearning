CREATE DATABASE tienda;
USE tienda;


CREATE TABLE clientes (
	cliente_id INTEGER UNSIGNED PRIMARY KEY,
	primer_nombre VARCHAR(15) NOT NULL,
	segundo_nombre VARCHAR(15),
	primer_apellido VARCHAR(15) NOT NULL,
	segundo_apellido VARCHAR(15),
	direccion VARCHAR(140)
	);

CREATE TABLE telefonos(
	telefono_id VARCHAR (20) NOT NULL,
	cliente_id INTEGER UNSIGNED NOT NULL
	);

ALTER TABLE telefonos ADD CONSTRAINT fk_clientes_telefonos FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id);


CREATE TABLE facturas (
	factura_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
 	fecha DATE NOT NULL,
 	cliente_id INTEGER UNSIGNED NOT NULL
 	);
ALTER TABLE facturas ADD CONSTRAINT fk_clientes_facturas FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id);

CREATE TABLE productos (
	producto_id VARCHAR (10) PRIMARY KEY,
	nombre VARCHAR (30) NOT NULL,
	precio INTEGER UNSIGNED NOT NULL,
	iva INTEGER UNSIGNED NOT NULL
	); 


CREATE TABLE facturas_productos(
	factura_id INTEGER UNSIGNED NOT NULL,
	producto_id VARCHAR(10) NOT NULL,
	cantidad INTEGER UNSIGNED NOT NULL,
	subtotal INTEGER UNSIGNED NOT NULL,
	PRIMARY KEY(factura_id, producto_id)
	);

ALTER TABLE facturas_productos ADD CONSTRAINT fk_factura_facturas_productos FOREIGN KEY (factura_id) REFERENCES facturas(factura_id);
ALTER TABLE facturas_productos ADD CONSTRAINT fk_producto_facturas_productos FOREIGN KEY (producto_id) REFERENCES productos(producto_id);


#PARA POSTGRESQL

CREATE TABLE clientes (
	cliente_id INTEGER PRIMARY KEY,
	primer_nombre VARCHAR(15) NOT NULL,
	segundo_nombre VARCHAR(15),
	primer_apellido VARCHAR(15) NOT NULL,
	segundo_apellido VARCHAR(15),
	direccion VARCHAR(140)
	);

CREATE TABLE telefonos(
	telefono_id VARCHAR (20) NOT NULL,
	cliente_id INTEGER NOT NULL
	);

ALTER TABLE telefonos ADD CONSTRAINT fk_clientes_telefonos FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id);


CREATE TABLE facturas (
	factura_id SERIAL PRIMARY KEY,
 	fecha DATE NOT NULL,
 	cliente_id INTEGER NOT NULL
 	);
ALTER TABLE facturas ADD CONSTRAINT fk_clientes_facturas FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id);

CREATE TABLE productos (
	producto_id VARCHAR (10) PRIMARY KEY,
	nombre VARCHAR (30) NOT NULL,
	precio INTEGER NOT NULL,
	iva INTEGER NOT NULL
	); 


CREATE TABLE facturas_productos(
	factura_id INTEGER NOT NULL,
	producto_id VARCHAR(10) NOT NULL,
	cantidad INTEGER NOT NULL,
	subtotal INTEGER NOT NULL,
	PRIMARY KEY(factura_id, producto_id)
	);

ALTER TABLE facturas_productos ADD CONSTRAINT fk_factura_facturas_productos FOREIGN KEY (factura_id) REFERENCES facturas(factura_id);
ALTER TABLE facturas_productos ADD CONSTRAINT fk_producto_facturas_productos FOREIGN KEY (producto_id) REFERENCES productos(producto_id);