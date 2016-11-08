CREATE TABLE clientes(
	id SERIAL PRIMARY KEY,
	cedula VARCHAR(20) NOT NULL,
	primer_nombre VARCHAR(30) NOT NULL,
	segundo_nombre VARCHAR(30),
	primer_apellido VARCHAR(30) NOT NULL,
	segundo_apellido VARCHAR(30),
	correo VARCHAR (40)
);

CREATE TABLE telefonos(
	id SERIAL PRIMARY KEY,
	numero VARCHAR(20) NOT NULL
);

CREATE TABLE clientes_telefonos(
	id SERIAL PRIMARY KEY,
	cliente_id INTEGER NOT NULL REFERENCES clientes(id),
	telefono_id INTEGER NOT NULL REFERENCES telefonos(id)
);

INSERT INTO clientes(cedula, primer_nombre, primer_apellido, correo)
VALUES
	('1069758190', 'Jhon', 'Beltran', 'jbeltranleon@gmail.com'),
	('1069756624', 'Felipe', 'Santana', 'elmachoman@gmail.com');

INSERT INTO telefonos(numero)
VALUES
	('8865943'),
	('322850043');

INSERT INTO clientes_telefonos(cliente_id, telefono_id)
VALUES
	(1,1),
	(1,2),
	(2,1);

CREATE TABLE casas(
	id SERIAL PRIMARY KEY,
	direccion VARCHAR(50),
	cliente_id INTEGER NOT NULL REFERENCES clientes(id)
);

INSERT INTO casas(direccion, cliente_id)
VALUES
	('a1', 1),
	('h7', 2);

CREATE TABLE facturas(
	id SERIAL PRIMARY KEY,
	casa_id INTEGER NOT NULL REFERENCES casas(id),
	periodo_facturado VARCHAR(15) NOT NULL,
	pago_oportuno DATE NOT NULL,
	valor INTEGER NOT NULL,
	dias_mora INTEGER NOT NULL
);

INSERT INTO facturas(casa_id, periodo_facturado, pago_oportuno, valor, dias_mora)
VALUES
	(1, 'Octubre', '2016-11-20', 40000, 4),
	(2, 'Octubre', '2016-11-20', 50000, 0),
	(1, 'Noviembre', '2016-11-20', 40000, 4),
	(2, 'Noviembre', '2016-11-20', 50000, 0);


CREATE TABLE estados(
	id SERIAL PRIMARY KEY,
	factura_id INTEGER NOT NULL REFERENCES facturas(id)
);

INSERT INTO estados(factura_id)
VALUES
	(1),
	(2);


CREATE VIEW facturasCompleto AS
SELECT
	id, casa_id, periodo_facturado, pago_oportuno, valor+((valor*0.05)*(dias_mora)) AS total, dias_mora
FROM
	facturas;

CREATE VIEW FacturaA1 AS
SELECT 
	facturasCompleto.id AS id,
	clientes.primer_nombre AS nombre,
	casas.direccion AS direccion, 
	facturasCompleto.periodo_facturado AS periodo_facturado, 
	facturasCompleto.pago_oportuno AS pago_oportuno, 
	facturasCompleto.total AS total
FROM 
	facturasCompleto
JOIN
	casas
ON
	facturasCompleto.casa_id = casas.id
JOIN
	clientes
ON
	clientes.id = casas.cliente_id
where
	clientes.id = 1;


CREATE VIEW EstadoA1 AS
SELECT 
	estados.id, casas.direccion, clientes.primer_nombre, facturasCompleto.periodo_facturado, facturasCompleto.total
FROM
	estados
JOIN
	facturasCompleto
ON
	estados.factura_id = facturasCompleto.id
JOIN
	casas
ON
	facturasCompleto.casa_id = casas.id
JOIN
	clientes
ON	
	casas.cliente_id = clientes.id
where
	casas.id = 1;



