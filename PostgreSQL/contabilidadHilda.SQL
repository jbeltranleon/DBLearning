CREATE TABLE proveedores(
	proveedor_id SERIAL PRIMARY KEY,
	nombre VARCHAR (20) NOT NULL,
	direccion VARCHAR (25) NOT NULL DEFAULT 'NA'
);


CREATE TABLE telefonosProveedores(
	id SERIAL PRIMARY KEY,
	proveedor_id SERIAL REFERENCES proveedores (proveedor_id),
	telefono VARCHAR (15) NOT NULL
);

CREATE TABLE productos(
	producto_id SERIAL PRIMARY KEY,
	nombre VARCHAR (30) NOT NULL,
	cantidad INTEGER NOT NULL,
	valorUnitario INTEGER NOT NULL,
	valorTotal INTEGER NOT NULL,
	fecha DATE NOT NULL DEFAULT CURRENT_DATE
);


CREATE TABLE proveedoresProductos(
	id SERIAL PRIMARY KEY,
	proveedor_id SERIAL REFERENCES proveedores (proveedor_id),
	producto_id SERIAL REFERENCES productos (producto_id)
);


CREATE TABLE activos(
	activo_id SERIAL PRIMARY KEY,
	nombre VARCHAR (30) NOT NULL,
	cantidad INTEGER NOT NULL,
	valorUnitario INTEGER NOT NULL,
	valorTotal INTEGER NOT NULL,
	fecha DATE NOT NULL DEFAULT CURRENT_DATE
);


CREATE TABLE ventas (
	venta_id SERIAL PRIMARY KEY,
	concepto VARCHAR(100) NOT NULL,
	cantidad INTEGER NOT NULL,
	valorUnitario INTEGER NOT NULL,
	valorTotal INTEGER NOT NULL,
	fecha DATE NOT NULL DEFAULT CURRENT_DATE
);


CREATE TABLE gastos (
	gasto_id SERIAL PRIMARY KEY,
	concepto VARCHAR(100) NOT NULL,
	cantidad INTEGER NOT NULL,
	valorUnitario INTEGER NOT NULL,
	valorTotal INTEGER NOT NULL,
	fecha DATE NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE catalogos(
	movimiento_id SERIAL PRIMARY KEY,
	nombre VARCHAR (30) NOT NULL,
	cantidad INTEGER NOT NULL,
	valorUnitario INTEGER NOT NULL,
	valorTotal INTEGER NOT NULL,
	fecha DATE NOT NULL DEFAULT CURRENT_DATE,
	catalogo VARCHAR (20) NOT NULL
)


CREATE VIEW movimientos AS
(SELECT * FROM ventas)
UNION 
(SELECT * FROM gastos)
UNION
(SELECT * FROM activos);

select * from inventario
order by fecha;

select * from movimientos
order by fecha;