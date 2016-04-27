drop database algebrarelacional;
CREATE DATABASE algebrarelacional;
use algebrarelacional;

CREATE TABLE Profesores (
	cedula_profesor INTEGER PRIMARY KEY,
	nombre1_profesor VARCHAR (15) NOT NULL,
	apellido1_profesor VARCHAR (15) NOT NULL,
	estrato_profesor INTEGER NOT NULL
);

CREATE TABLE Asignaturas (
	asignatura_id INTEGER PRIMARY KEY,
	nombre_asignatura VARCHAR (100) NOT NULL
);

INSERT INTO Profesores (cedula_profesor, nombre1_profesor, apellido1_profesor, estrato_profesor)
	VALUES
	(555,'Juan','Perez',1),
	(666,'Alicia','Garcia',2),
	(777,'Andres','Fernandez',1),
	(888,'Juan', 'Mendez',3);


INSERT INTO Asignaturas (asignatura_id, nombre_asignatura)
	VALUES
	(5120,'Pensamiento Logico'),
	(5121,'Escritura'),
	(5122,'Pensamiento Espacial, temporal y casual'),
	(5123,'Ingles'),
	(5124,'Pensamiento Numerico');

CREATE TABLE Asignatura_Profesor (
	cedula_profesor INTEGER REFERENCES Profesores (cedula_profesor),
	asignatura_id INTEGER REFERENCES Asignaturas(asignatura_id),
	PRIMARY KEY (cedula_profesor, asignatura_id)
);

INSERT INTO Asignatura_Profesor (asignatura_id, cedula_profesor)
	VALUES
	(5120,555),
	(5120,888),
	(5124,555),
	(5124,666),
	(5121,777),
	(5121,555),
	(5123,777),
	(5122,666);



/*1*/
SELECT cedula_profesor, nombre1_profesor FROM Profesores;

/*2*/
SELECT cedula_profesor FROM Profesores WHERE estrato_profesor=1;

/*3*/
SELECT nombre1_profesor, apellido1_profesor FROM Profesores WHERE estrato_profesor>=1 AND estrato_profesor<=3;

/*4*/
SELECT nombre1_profesor FROM Profesores WHERE estrato_profesor>1;

/*5*/
SELECT nombre1_profesor, apellido1_profesor FROM Profesores WHERE estrato_profesor=1 OR estrato_profesor=3;

/*6*/
SELECT nombre1_profesor, apellido1_profesor FROM Profesores WHERE estrato_profesor=1 AND estrato_profesor=2;

/*7*/
SELECT nombre1_profesor, apellido1_profesor FROM Profesores WHERE NOT estrato_profesor=3;

SELECT nombre1_profesor, apellido1_profesor FROM Profesores WHERE estrato_profesor<>3;

SELECT nombre1_profesor, apellido1_profesor FROM Profesores WHERE estrato_profesor<3 OR estrato_profesor>3;

SELECT nombre1_profesor, apellido1_profesor FROM Profesores WHERE estrato_profesor!=3;

/*8*/
SELECT asignatura_id, nombre_asignatura FROM Asignaturas WHERE nombre_asignatura LIKE '%Pensamiento%';

/*9*/

SELECT asignatura_id, nombre_asignatura FROM Profesores, Asignaturas WHERE nombre1_profesor='Juan' AND apellido1_profesor='Perez';


SELECT
	p.nombre1_profesor AS nombre,
	p.apellido1_profesor AS apellido,
	a.nombre_asignatura AS asignatura


	
FROM Asignatura_Profesor AS ap
JOIN Profesores AS p
	ON ap.cedula_profesor =p.cedula_profesor
JOIN Asignaturas AS a
	ON ap.asignatura_id =a.asignatura_id
ORDER BY p.nombre1_profesor;
--------------------------------------

SELECT 
	a.asignatura_id AS asignatura, 
	a.nombre_asignatura AS nombre 

FROM Profesores AS p,
	 Asignaturas AS a,
	 Asignatura_Profesor AS ap
	 WHERE nombre1_profesor='Juan' AND apellido1_profesor='Perez'
	 AND 
	 p.cedula_profesor=ap.cedula_profesor
	 AND
	 ap.asignatura_id=a.asignatura_id;


-----------------------------------------------------------------------
SELECT
	p.nombre1_profesor AS nombre,
	p.apellido1_profesor AS apellido,
	a.nombre_asignatura AS asignatura
FROM Asignatura_Profesor AS ap
JOIN Profesores AS p
	ON ap.cedula_profesor =p.cedula_profesor
JOIN Asignaturas AS a
	ON ap.asignatura_id =a.asignatura_id
	WHERE nombre1_profesor='Juan' AND apellido1_profesor='Perez';


-------------------------------------------


SELECT 
	p.nombre1_profesor AS asignatura, 
	a.nombre_asignatura AS nombre 

FROM Profesores AS p,
	 Asignaturas AS a,
	 Asignatura_Profesor AS ap
	 WHERE nombre_asignatura = 'Ingles'
	 AND 
	 p.cedula_profesor=ap.cedula_profesor
	 AND
	 ap.asignatura_id=a.asignatura_id;


CREATE TABLE Colegios (
	colegio_id INTEGER PRIMARY KEY,
	nombre VARCHAR(30) NOT NULL
	);

INSERT INTO Colegios (colegio_id, nombre)
	VALUES (8090,'C.P. Cervantes'),
			(8092, 'Lozano'),
			(8091,'C.P. Quevedo');


ALTER TABLE Profesores ADD colegio_id INTEGER NOT NULL DEFAULT 8090;

UPDATE Profesores SET colegio_id = 8090
WHERE  cedula_profesor = 555
LIMIT 1;

UPDATE Profesores SET colegio_id = 8090
WHERE  cedula_profesor = 666
LIMIT 1;

UPDATE Profesores SET colegio_id = 8090
WHERE  cedula_profesor = 777
LIMIT 1;

UPDATE Profesores SET colegio_id = 8091
WHERE  cedula_profesor = 888
LIMIT 1;


ALTER TABLE Profesores ADD CONSTRAINT fk_profesores_colegio FOREIGN KEY (colegio_id) REFERENCES Colegios (colegio_id);



------------------------------------------------------------------------------------------------------------------------

CREATE TABLE Profesores (
	cedula_profesor INTEGER PRIMARY KEY,
	nombre1_profesor VARCHAR (15) NOT NULL,
	apellido1_profesor VARCHAR (15) NOT NULL,
	estrato_profesor INTEGER NOT NULL
);

CREATE TABLE Asignaturas (
	asignatura_id INTEGER PRIMARY KEY,
	nombre_asignatura VARCHAR (100) NOT NULL
);

INSERT INTO Profesores (cedula_profesor, nombre1_profesor, apellido1_profesor, estrato_profesor)
	VALUES
	(555,'Juan','Perez',1),
	(666,'Alicia','Garcia',2),
	(777,'Andres','Fernandez',1),
	(888,'Juan', 'Mendez',3);


INSERT INTO Asignaturas (asignatura_id, nombre_asignatura)
	VALUES
	(5120,'Pensamiento Logico'),
	(5121,'Escritura'),
	(5122,'Pensamiento Espacial, temporal y casual'),
	(5123,'Ingles'),
	(5124,'Pensamiento Numerico');

CREATE TABLE Asignatura_Profesor (
	cedula_profesor INTEGER REFERENCES Profesores (cedula_profesor),
	asignatura_id INTEGER REFERENCES Asignaturas(asignatura_id),
	PRIMARY KEY (cedula_profesor, asignatura_id)
);

INSERT INTO Asignatura_Profesor (asignatura_id, cedula_profesor)
	VALUES
	(5120,555),
	(5120,888),
	(5124,555),
	(5124,666),
	(5121,777),
	(5121,555),
	(5123,777),
	(5122,666);


CREATE TABLE Colegios (
	colegio_id INTEGER PRIMARY KEY,
	nombre VARCHAR(30) NOT NULL
	);

INSERT INTO Colegios (colegio_id, nombre)
	VALUES (8090,'C.P. Cervantes'),
			(8092, 'Lozano'),
			(8091,'C.P. Quevedo');


ALTER TABLE Profesores ADD colegio_id INTEGER NOT NULL DEFAULT 8090;

UPDATE Profesores SET colegio_id = 8090
WHERE  cedula_profesor = 555;


UPDATE Profesores SET colegio_id = 8090
WHERE  cedula_profesor = 666;


UPDATE Profesores SET colegio_id = 8090
WHERE  cedula_profesor = 777;


UPDATE Profesores SET colegio_id = 8091
WHERE  cedula_profesor = 888;



ALTER TABLE Profesores ADD CONSTRAINT fk_profesores_colegio FOREIGN KEY (colegio_id) REFERENCES Colegios (colegio_id);


--1
select * from Profesores;

SELECT
	colegio_id,
	nombre
	FROM Colegios
	WHERE colegio_id < 8092;


--2
SELECT 
	p.cedula_profesor AS codigo, 
	p.nombre1_profesor AS nombre 

FROM Profesores AS p,
	 Colegios AS c
	
	 WHERE nombre = 'C.P. Cervantes'
	 AND 
	 p.colegio_id=c.colegio_id;


--3

SELECT 
	c.colegio_id AS codigo, 
	c.nombre AS nombre 

FROM Profesores AS p,
	 Colegios AS c
	
	 WHERE nombre1_profesor='Andres' AND apellido1_profesor='Fernandez'
	 AND 
	 p.colegio_id=c.colegio_id;
	 
--4

SELECT 
	c.colegio_id AS codigo, 
	c.nombre AS nombre,
	p.nombre1_profesor AS profe

FROM Profesores AS p,
	 Colegios AS c,
	 Asignaturas AS a,
	 Asignatura_Profesor AS ap
	 WHERE nombre_asignatura = 'Ingles'
	 AND 
	 p.colegio_id=c.colegio_id
	 AND
	 p.cedula_profesor=ap.cedula_profesor
	 AND
	 ap.asignatura_id=a.asignatura_id
	 
