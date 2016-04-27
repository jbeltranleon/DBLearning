create database ventas;

create table clientes (
cliente_id SERIAL PRIMARY KEY,
nombre VARCHAR(20) NOT NULL,
estado VARCHAR(30) NOT NULL,
categoria VARCHAR(1) NOT NULL
);

create table vendedores(
vendedor_id SERIAL PRIMARY KEY,
nombre VARCHAR(12) NOT NULL,
edad VARCHAR(2) NOT NULL
);

create table ventas (
venta_id SERIAL PRIMARY KEY,
cliente_id INTEGER NOT NULL,
vendedor_id INTEGER NOT NULL,
monto INTEGER NOT NULL
);

alter table ventas add constraint FK_ventas_cliente foreign key(cliente_id)REFERENCES clientes(cliente_id);
alter table ventas add constraint FK_ventas_vendedor foreign key(vendedor_id)REFERENCES vendedores(vendedor_id);

INSERT INTO clientes ( nombre, estado, categoria) 
VALUES ( 'Ana', 'Hidalgo', '1'),
	( 'Benito', 'Morelos', '1'),
	( 'Carlos', 'Hidalgo', '2'),
	( 'Carolina', 'Nayarit', '3'),
	( 'Maria', 'Hidalgo', '2'),
	( 'Noemi', 'Morelos', '3'),
    ( 'Pablo', 'Morelos', '1'),
    ( 'Teofilo', 'Chiapas', '1'),
    ( 'Tomas', 'Chiapas', '2');

INSERT INTO vendedores ( nombre, edad) 
VALUES ( 'Alberto', '30'),
	( 'Crispin', '25'),
	( 'Danilo', '28'),
	( 'Hernan', '32');

INSERT INTO ventas ( cliente_id, vendedor_id, monto) 
VALUES	(1,1,200),
		(2,2,300),
		(1,3,200),
		(3,3,150),
		(9,2,150),
		(7,2,130),
		(6,1,120),
		(6,2,180),
		(3,3,200),
		(9,3,500),
		(8,4,700),
		(2,4,800);

SELECT * FROM clientes
SELECT * FROM vendedores
SELECT * FROM ventas

---------------------union
SELECT nombre FROM clientes 
UNION
SELECT nombre FROM vendedores

SELECT nombre FROM clientes 
INTERSECT
SELECT nombre FROM vendedores

----------------------interseccion
SELECT 
	c.nombre AS nombre
FROM 
	clientes AS c,
	ventas AS v,
	vendedores AS vd
WHERE 
	c.cliente_id = v.cliente_id 
AND 
	vd.vendedor_id = v.vendedor_id
AND 
	vd.nombre LIKE '%Alberto%'
   INTERSECT 
SELECT 
	c.nombre
FROM 
	clientes AS c,
	ventas AS v, 
	vendedores AS vd
WHERE 
	c.cliente_id = v.cliente_id 
AND 
	vd.vendedor_id = v.vendedor_id
AND 
	vd.nombre LIKE '%Danilo%' 

----------------------------excepcion
SELECT 
	c.nombre AS nombre
FROM 
	clientes AS c, 
	ventas AS v, 
	vendedores AS vd
WHERE 
	c.cliente_id = v.cliente_id 
AND 
	vd.vendedor_id = v.vendedor_id
AND 
	vd.nombre LIKE '%Alberto%' 
   EXCEPT
SELECT 
	c.nombre AS nombre
FROM 
	clientes AS c, 
	ventas AS v, 
	vendedores AS vd
WHERE 
	c.cliente_id = v.cliente_id 
AND 
	vd.vendedor_id = v.vendedor_id
AND vd.nombre LIKE '%Danilo%'



