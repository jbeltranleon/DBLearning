CREATE TABLE Ciudad (
	cod_ciudad INTEGER PRIMARY KEY,
	nombre VARCHAR NOT NULL
);

CREATE TABLE Socio (
	cod_socio INTEGER PRIMARY KEY,
	nombre VARCHAR NOT NULL,
	apellido VARCHAR NOT NULL,
	direccion VARCHAR NOT NULL,
	cod_ciudad INTEGER NOT NULL REFERENCES Ciudad(cod_ciudad),
	fecha_nacimiento DATE NOT NULL
);

CREATE TABLE Pelicula (
	cod_peli INTEGER PRIMARY KEY,
	titulo VARCHAR NOT NULL,
	genero VARCHAR NOT NULL
);

CREATE TABLE Cinta (
	cod_cinta INTEGER PRIMARY KEY,
	cod_peli INTEGER NOT NULL REFERENCES Pelicula(cod_peli)
);

CREATE TABLE Prestamo (
	cod_socio INTEGER REFERENCES Socio(cod_socio),
	cod_cinta INTEGER REFERENCES Cinta(cod_cinta),
	fecha_pres DATE NOT NULL,
	fecha_dev DATE NOT NULL,
	PRIMARY KEY (cod_socio, cod_cinta)
);

INSERT INTO Ciudad (cod_ciudad, nombre)
VALUES
	(123, 'Fusagasuga'),
	(124, 'Silvania'),
	(125, 'Pasca'),
	(126, 'Arbelaez'),
	(127, 'Chinauta');

INSERT INTO Socio (cod_socio, nombre, apellido, direccion,cod_ciudad, fecha_nacimiento)
VALUES
	(1,'Jorge','Vanegas','Carrera 4 #4-50',123,'01/05/96'),
	(2,'Camilo','Rodriguez','Calle 5 #6-58',126,'05/02/95');

INSERT INTO Pelicula (cod_peli, titulo, genero)
VALUES
	(54,'Mr. Robot', 'Hacking'),
	(55,'Anabel','Terror'),
	(56,'Lucifer', 'Terror'),
	(57,'Cars','Infantil'),
	(58,'El aro', 'Terror');

INSERT INTO Cinta (cod_cinta, cod_peli)
VALUES
	(5,54),
	(6,55),
	(7,56),
	(8,57),
	(9,55),
	(10,57),
	(11,55),
	(12,58),
	(13,54),
	(14,56);

UPDATE Cinta SET cod_peli=58 WHERE cod_cinta=8

SELECT * FROM Cinta	

INSERT INTO Prestamo (cod_socio, cod_cinta, fecha_pres, fecha_dev)
VALUES
	(1,5,'05/01/2015','05/02/2015'),
	(1,7,'08/01/2016','02/03/2016'),
	(1,8,'03/02/2016','25/02/2016'),
	(2,5,'15/04/2016','05/06/2016'),
	(2,11,'02/05/2016','25/06/2016');

UPDATE Prestamo SET fecha_dev='28/04/2016' WHERE cod_cinta=8	

	SELECT * FROM Prestamo

UPDATE Socio SET nombre = 'Guillermo' WHERE nombre='Camilo'
UPDATE Socio SET apellido = 'Leon' WHERE nombre='Rodriguez'

SELECT nombre, apellido FROM Socio WHERE fecha_nacimiento<'2016-12-31' AND fecha_nacimiento<'2001-12-31' ORDER BY nombre

SELECT * FROM Socio
SELECT Prestamo.cod_cinta FROM Socio, Prestamo, Cinta WHERE
Socio.nombre= 'Guillermo' AND Socio.cod_socio=Prestamo.cod_socio AND Prestamo.cod_cinta=Cinta.cod_cinta

SELECT Pelicula.cod_peli, Pelicula.titulo FROM Pelicula, Cinta, Prestamo
WHERE Pelicula.genero='Terror' AND Prestamo.fecha_dev='2016-04-28' AND 
Pelicula.cod_peli=Cinta.cod_peli AND Cinta.cod_cinta=Prestamo.cod_cinta

SELECT Socio.cod_socio, Socio.nombre, Socio.direccion FROM Socio, Prestamo, Cinta, Pelicula
WHERE Pelicula.genero='Terror' AND Socio.cod_socio=Prestamo.cod_socio AND Pelicula.cod_peli=Cinta.cod_peli
AND Cinta.cod_cinta=Prestamo.cod_cinta

SELECT count(Socio.cod_socio),
Ciudad.nombre
FROM Ciudad, Socio
WHERE Socio.cod_ciudad=Ciudad.cod_ciudad
GROUP BY Ciudad.cod_ciudad

SELECT
Ciudad.cod_ciudad,
count(cod_socio)
FROM Ciudad, Socio
GROUP BY Ciudad.cod_ciudad
HAVING count(cod_socio)>3