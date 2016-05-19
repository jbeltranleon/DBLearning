CREATE DATABASE instituto;
USE instituto;

CREATE TABLE alumnos (
	codigo SERIAL PRIMARY KEY,
	nombre VARCHAR (15) NOT NULL,
	apellido VARCHAR (15) NOT NULL,
	telefono VARCHAR (10) NOT NULL,
	sueldo INTEGER NOT NULL
);

INSERT INTO alumnos (nombre, apellido, telefono, sueldo)
	VALUES 
	('MARIA', 'GOMEZ', '333', 120000),
	('ALBERTO', 'GARCIA', '444', 150000),
	('LICETH', 'GONZALEZ', '555', 170000),
	('MATEO', 'SANDOVAL', '666', 90000),
	('MONICA', 'LONDOÑO', '888', 130000);


SELECT nombre, telefono FROM alumnos WHERE sueldo>=120000 AND sueldo <= 150000; 

SELECT nombre, telefono FROM alumnos WHERE NOT sueldo = 120000;

SELECT nombre, telefono FROM alumnos WHERE sueldo=120000 AND sueldo = 150000;

SELECT nombre, telefono FROM alumnos WHERE sueldo=120000 OR sueldo = 150000; 


CREATE TABLE ciudades (
		ciudad_id INTEGER PRIMARY KEY,
		nombre VARCHAR (10) NOT NULL
);

INSERT INTO ciudades (ciudad_id, nombre)
		VALUES
		(290,'Fusagasuga'),
		(320,'Arbelaez'),
		(291,'Girardot');

ALTER TABLE alumnos ADD ciudad_id INTEGER NOT NULL DEFAULT 0;

UPDATE alumnos SET ciudad_id = 290
WHERE codigo = 1
LIMIT 1;

UPDATE alumnos SET ciudad_id = 290
WHERE codigo = 2
LIMIT 1;

UPDATE alumnos SET ciudad_id = 290
WHERE codigo = 3
LIMIT 1;

UPDATE alumnos SET ciudad_id = 290
WHERE codigo = 1
LIMIT 1;

UPDATE alumnos SET ciudad_id = 290
WHERE codigo = 4
LIMIT 1;

UPDATE alumnos SET ciudad_id = 290
WHERE codigo = 5
LIMIT 1;

ALTER TABLE alumnos ADD CONSTRAINT fk_alumnos_ciudad FOREIGN KEY (ciudad_id) REFERENCES ciudades (ciudad_id);



SELECT
	a.nombre AS nombre,
	c.nombre AS ciudad
	
FROM alumnos AS a
JOIN ciudades AS c
	ON a.ciudad_id =c.ciudad_id
ORDER BY a.nombre