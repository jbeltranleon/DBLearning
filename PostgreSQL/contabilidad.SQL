CREATE TABLE proveedores(
	proveedor_id SERIAL PRIMARY KEY,
	nombre VARCHAR (20) NOT NULL,
	direccion VARCHAR (25) NOT NULL DEFAULT 'NA'
);

INSERT INTO proveedores(nombre)
VALUES 
	('chefrito'),
	('babaria');

CREATE TABLE telefonosProveedores(
	id SERIAL PRIMARY KEY,
	proveedor_id SERIAL REFERENCES proveedores (proveedor_id),
	telefono VARCHAR (15) NOT NULL
);

INSERT INTO telefonosProveedores(proveedor_id, telefono)
VALUES
	(1, '34'),
	(2, '12'),
	(2, '25');


CREATE TABLE productos(
	producto_id SERIAL PRIMARY KEY,
	nombre VARCHAR (30) NOT NULL,
	cantidad INTEGER NOT NULL,
	valorUnitario INTEGER NOT NULL,
	valorTotal INTEGER NOT NULL,
	fecha DATE NOT NULL DEFAULT CURRENT_DATE
);

INSERT INTO productos (nombre, cantidad, valorUnitario, valorTotal)
VALUES
	('doritos', 3, 1000, 3000),
	('packs', 3, 3000, 12000),
	('minecraft', 1, 70000, 70000);

CREATE TABLE proveedoresProductos(
	id SERIAL PRIMARY KEY,
	proveedor_id SERIAL REFERENCES proveedores (proveedor_id),
	producto_id SERIAL REFERENCES productos (producto_id)
);

INSERT INTO proveedoresProductos(proveedor_id, producto_id)
VALUES
	(1, 1),
	(2, 2),
	(2, 3);

CREATE TABLE activos(
	activo_id SERIAL PRIMARY KEY,
	nombre VARCHAR (30) NOT NULL,
	cantidad INTEGER NOT NULL,
	valorUnitario INTEGER NOT NULL,
	valorTotal INTEGER NOT NULL,
	fecha DATE NOT NULL DEFAULT CURRENT_DATE
);

INSERT INTO activos(nombre, cantidad, valorUnitario, valorTotal)
VALUES
	('Mesa', 1, 15000, 15000),
	('Televisor', 1, 400000, 400000);


CREATE TABLE ventas (
	venta_id SERIAL PRIMARY KEY,
	concepto VARCHAR(100) NOT NULL,
	cantidad INTEGER NOT NULL,
	valorUnitario INTEGER NOT NULL,
	valorTotal INTEGER NOT NULL,
	fecha DATE NOT NULL DEFAULT CURRENT_DATE
);

INSERT INTO ventas (concepto, cantidad, valorUnitario, valorTotal)
VALUES
	('Cerveza', 1, 2000, 2000),
	('Pan', 1, 200, 200);

CREATE TABLE gastos (
	gasto_id SERIAL PRIMARY KEY,
	concepto VARCHAR(100) NOT NULL,
	cantidad INTEGER NOT NULL,
	valorUnitario INTEGER NOT NULL,
	valorTotal INTEGER NOT NULL,
	fecha DATE NOT NULL DEFAULT CURRENT_DATE
);

INSERT INTO gastos (concepto, cantidad, valorUnitario, valorTotal)
VALUES 
	('Arriendo', 1, 1000000, 1000000);

CREATE VIEW inventario AS 
(SELECT * FROM productos)
UNION 
(SELECT * FROM activos);

CREATE VIEW movimientos AS
(SELECT * FROM ventas)
UNION 
(SELECT * FROM gastos)
UNION
(SELECT * FROM inventario);

select * from inventario;
order by fecha

select * from movimientos
order by fecha;