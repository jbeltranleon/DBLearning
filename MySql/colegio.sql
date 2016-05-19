CREATE DATABASE colegio_colombia;
USE colegio_colombia;

CREATE TABLE colegios (
	colegio_id INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(30) NOT NULL
	);

INSERT INTO colegios (nombre)
	VALUES ('C.P. Cervantes'),
			('C.P. Quevedo');

CREATE TABLE aulas (
	aula_id VARCHAR(12) PRIMARY KEY,
	capacidad INTEGER NOT NULL,
	colegio_id INTEGER UNSIGNED NOT NULL,
	FOREIGN KEY (colegio_id) REFERENCES colegios (colegio_id)
	);

INSERT INTO aulas (aula_id, capacidad, colegio_id)
	VALUES('1.A01', 40, 1),
			('1.B01', 40, 1),
			('2.B02', 40, 2);

CREATE TABLE profesores (
	profesor_id INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	primer_nombre VARCHAR(15) NOT NULL,
	segundo_nombre VARCHAR(15),
	primer_apellido VARCHAR(15) NOT NULL,
	segundo_apellido VARCHAR(15)
	);

INSERT INTO profesores (primer_nombre, primer_apellido)
	VALUES('Juan', 'Pérez'),
			('Alicia', 'García'),
			('Andrés', 'Fernandez'),
			('Juan', 'Mendez');

CREATE TABLE profesoresColegios (
	profesor_id INTEGER UNSIGNED,
	colegio_id INTEGER UNSIGNED,
	FOREIGN KEY (profesor_id) REFERENCES profesores (profesor_id),
	FOREIGN KEY (colegio_id) REFERENCES colegios (colegio_id),
	PRIMARY KEY(profesor_id, colegio_id)
	); 

INSERT INTO profesoresColegios (profesor_id, colegio_id)
	VALUES (1, 1),
			(2, 1),
			(3, 1),
			(4, 2);

CREATE TABLE asignaturas (
	asignatura_id INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL
	);

INSERT INTO asignaturas (nombre)
	VALUES ('Pensamiento Lógico'),
			('Escritura'),
			('Pensamiento Numérico'),
			('Pensamiento Espacial, Temporal y Causal'),
			('Inglés');

CREATE TABLE profesoresAsignaturas (
	profesor_id INTEGER UNSIGNED,
	asignatura_id INTEGER UNSIGNED,
	FOREIGN KEY (profesor_id) REFERENCES profesores (profesor_id),
	FOREIGN KEY (asignatura_id) REFERENCES asignaturas (asignatura_id),
	PRIMARY KEY(profesor_id, asignatura_id)
	);

INSERT INTO profesoresAsignaturas (profesor_id, asignatura_id)
	VALUES (1, 1),
			(1, 2),
			(1, 3),
			(2, 4),
			(2, 3),
			(3, 2),
			(3, 5),
			(4, 1),
			(4, 3);

CREATE TABLE cursos (
	curso_id VARCHAR(5) PRIMARY KEY,
	nombre VARCHAR(30)
	);

INSERT INTO cursos (curso_id)
	VALUES ('1°'),
			('2°');

CREATE TABLE profesoresCursos (
	profesor_id INTEGER UNSIGNED,
	curso_id VARCHAR(5),
	FOREIGN KEY (profesor_id) REFERENCES profesores (profesor_id),
	FOREIGN KEY (curso_id) REFERENCES cursos (curso_id),
	PRIMARY KEY(profesor_id, curso_id)
	);

INSERT INTO profesoresCursos(profesor_id, curso_id)
	VALUES (1, '1°'),
			(2, '1°'),
			(3, '1°'),
			(3, '2°'),
			(4, '1°');

CREATE TABLE editoriales (
	editorial_id INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(30) NOT NULL
	);

INSERT INTO editoriales (nombre)
	VALUES ('Graó'),
			('Técnicas Rubio'),
			('Prentice Hall'),
			('Temas de Hoy');

CREATE TABLE libros (
	libro_id INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL,
	copias INTEGER UNSIGNED NOT NULL,
	editorial_id INTEGER UNSIGNED NOT NULL,
	FOREIGN KEY (editorial_id) REFERENCES editoriales (editorial_id)
	);

INSERT INTO libros (nombre, copias, editorial_id)
	VALUES('Aprender y Enseñar en Educacion Infantil', 15, 1),
			('Preescolar Rubio.N6', 15, 2),
			('Educacion Infantil.N9', 15, 3),
			('Saber Educar: Guia para Padres y Profesores', 15, 4);



CREATE TABLE biblioteca(
	operacion_id INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	colegio_id INTEGER UNSIGNED NOT NULL,
	profesor_id INTEGER UNSIGNED NOT NULL,
	libro_id INTEGER UNSIGNED NOT NULL,
	fecha DATE NOT NULL,
	FOREIGN KEY (colegio_id) REFERENCES colegios (colegio_id),
	FOREIGN KEY (profesor_id) REFERENCES profesores (profesor_id),
	FOREIGN KEY (libro_id) REFERENCES libros (libro_id)
	);

INSERT INTO biblioteca (colegio_id, profesor_id, libro_id, fecha)
	VALUES(1, 1, 1, '2006-09-09'),
			(1, 1, 2, '2005-05-05'),
			(1, 1, 1, '2005-05-05'),
			(1, 2, 3, '2005-05-06'),
			(1, 2, 1, '2005-05-06'),
			(1, 3, 1, '2006-09-09'),
			(1, 3, 4, '2005-05-05'),
			(2, 4, 4, '2006-12-18'),
			(2, 4, 1, '2005-05-06');

SELECT b.operacion_id AS Op_No,
       c.nombre AS Colegio,
       p.primer_nombre AS Primer_Nombre,
       p.primer_apellido AS Primer_Apellido,
       l.nombre AS libros,
       b.fecha
     
FROM biblioteca AS b
LEFT JOIN colegios AS c
  ON b.colegio_id = c.colegio_id
LEFT JOIN profesores AS p
  ON b.profesor_id = p.profesor_id
LEFT JOIN libros AS l
  ON b.libro_id = l.libro_id
ORDER BY p.primer_apellido;



/*Esta parte del codigo me hace dudar*/ 

SELECT pcolegios.colegio_id AS colegio,
       pcolegios.profesor_id AS profesor,
       pcursos.curso_id AS curso,
       a.aula_id AS aula,
       pasignaturas.asignatura_id AS asignatura
     
FROM profesoresColegios AS pcolegios
LEFT JOIN profesoresCursos AS pcursos
  ON pcolegios.profesor_id = pcursos.profesor_id
LEFT JOIN profesoresAsignaturas AS pasignaturas
  ON pcolegios.profesor_id = pasignaturas.profesor_id
ORDER BY pcolegios.profesor_id;

