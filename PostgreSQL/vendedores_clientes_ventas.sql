
--Jhon Fredy Beltran--

CREATE TABLE Clientes (
	cliente_id SERIAL PRIMARY KEY,
	nombre VARCHAR (10) NOT NULL,
	estado VARCHAR (10) NOT NULL,
	categoria INTEGER NOT NULL
);

CREATE TABLE Vendedores (
	vendedor_id SERIAL PRIMARY KEY,
	nombre VARCHAR (10) NOT NULL,
	edad VARCHAR (10) NOT NULL
);

CREATE TABLE Ventas (
	numero SERIAL PRIMARY KEY,
	ncliente VARCHAR (10) NOT NULL,
	nvendedor VARCHAR (10) NOT NULL,
	monto INTEGER NOT NULL
);

INSERT INTO Clientes (nombre,estado,categoria)
	VALUES
	('Ana','Hidalgo',1),
	('Benito','Morelos',1),
	('Carlos','Hidalgo',2),
	('Carolina','Nayarit',3),
	('María','Hidalgo',2),
	('Noemí','Morelos',3),
	('Pablo','Morelos',1),
	('Teófilo','Chiapas',1),
	('Tomas','Chiapas',2);

INSERT INTO Vendedores (nombre,edad)
	VALUES
	('Alberto',30),
	('Crispín',25),
	('Danilo',28),
	('Hernán',32);



INSERT INTO Ventas (ncliente,nvendedor,monto)
	VALUES
	('Ana','Alberto',200),
	('Benito','Crispín',300),
	('Ana','Danilo',200),
	('Carlos','Danilo',150),
	('Tomas','Crispín',150),
	('Pablo','Crispín',130),
	('Noemí','Alberto',120),
	('Noemí','Crispín',180),
	('Carlos','Danilo',200),
	('Tomas','Danilo',500),
	('Teófilo','Hernán',700),
	('Benito','Hernán',800);

SELECT * FROM Clientes
SELECT * FROM Vendedores
SELECT * FROM Ventas

--union entre los nombres de los clientes y los vendedores
SELECT nombre_cliente FROM Clientes 
UNION
SELECT nombre_vendedor FROM Vendedores


--interseccion entre los clientes atendidos por 
SELECT ncliente FROM Ventas WHERE nvendedor='Hernán' 
INTERSECT
SELECT ncliente FROM Ventas WHERE nvendedor='Danilo'


--diferencia usada para ver que empleados fueron atendidos
-- por Alberto y que no fueron atendidos por Crispin
SELECT ncliente FROM Ventas WHERE nvendedor='Alberto' 
EXCEPT
SELECT ncliente FROM Ventas WHERE nvendedor='Crispín'

--Revisar pues creo que necesita llaves foraneas y primarias
