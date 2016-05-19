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
SELECT asignatura_id, nombre_asignatura FROM Asignaturas WHERE nombre_asignatura LIKE '%Pensamiento%'

/*9*/

SELECT asignatura_id, nombre_asignatura FROM Profesores, Asignaturas WHERE nombre1_profesor='Juan' AND apellido1_profesor='Perez';