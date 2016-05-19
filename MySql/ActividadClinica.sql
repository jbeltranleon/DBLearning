CREATE DATABASE clinica;

CREATE TABLE pacientes(
				paciente_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
				provincia_id INTEGER UNSIGNED NOT NULL,
				ingreso_id INTEGER UNSIGNED NOT NULL,
				nombre VARCHAR(30) NOT NULL,
				apellidos VARCHAR(50) NOT NULL,
				direccion TEXT NOT NULL,
				fecha_nacimiento TIMESTAMP NOT NULL
				);


CREATE TABLE medicos(
				medico_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
				nombre VARCHAR(30) NOT NULL,
				apellidos VARCHAR(50) NOT NULL,
				especialidad VARCHAR (50) NOT NULL
				);

CREATE TABLE provincias(
				provincia_id INTEGER UNSIGNED PRIMARY KEY,
				nombre VARCHAR(30) NOT NULL,
				codigo_postal VARCHAR (15)
				);
CREATE TABLE ingresos(
				ingreso_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
				medico_id INTEGER UNSIGNED NOT NULL,
				n_habitacion VARCHAR (10) NOT NULL,
				cama VARCHAR (10) NOT NULL,
				fecha_ingreso TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
				);

CREATE TABLE telefonos(
				telefono_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
				tipo ENUM('paciente', 'medico') NOT NULL,
				paciente_id INTEGER UNSIGNED,
				medico_id INTEGER UNSIGNED 
				);

ALTER TABLE pacientes ADD CONSTRAINT fk_paciente_provincia FOREIGN KEY (provincia_id) REFERENCES provincias (provincia_id);

ALTER TABLE pacientes ADD CONSTRAINT fk_paciente_ingreso FOREIGN KEY (ingreso_id) REFERENCES ingresos (ingreso_id);

ALTER TABLE ingresos ADD CONSTRAINT fk_ingresos_medico FOREIGN KEY (medico_id) REFERENCES medicos (medico_id);


ALTER TABLE pacientes ADD COLUMN estado tinyint (1) NOT NULL DEFAULT 5;

INSERT INTO provincias (provincia_id, nombre, codigo_postal)
		VALUES
		(101,'almeidas', '102'),
		(103,'oriente', '104'),
		(105,'tequendama', '106'),
		(107,'sumapaz', '108'),
		(109,'guavio', '110');

INSERT INTO medicos (nombre, apellidos, especialidad)
		VALUES
		('juan','perez','cardiologo'),
		('jose', 'martinez', 'ortopedita'),
		('andres', 'gonzalez', 'medicogeneral'),
		('alejandro', 'torres', 'optometra'),
		('antonio', 'pardo', 'oncolo'),
		('bryan', 'poveda', 'neumologo'),
		('carlos', 'beltran', 'gastroenterologo'),
		('karen', 'jimenez', 'fonoaudiologo'),
		('maria', 'marquez', 'medicotrumatologo');

INSERT INTO ingresos (n_habitacion, cama, fecha_ingreso, medico_id)
		VALUES
		('1a', '1', '2015-12-12 08:08:07', 2),
		('2a', '2', '2016-01-01 08:08:07', 1),
		('3a', '3', '2016-01-01 08:08:07', 2),
		('4a', '4', '2016-01-01 08:08:07', 3),
		('5a', '1', '2016-01-01 08:08:07', 4),
		('6a', '2', '2016-02-01 08:08:07', 5),
		('7a', '3', '2016-02-01 08:08:07', 6),
		('8a', '4', '2016-02-12 08:08:07', 7),
		('9a', '1', '2016-02-12 08:08:07', 8),
		('1b', '2', '2016-02-12 08:08:07', 9),
		('2b', '3', '2016-02-12 08:08:07', 1),
		('3b', '4', '2016-02-12 08:08:07', 2),
		('4b', '1', '2016-02-12 08:08:07', 2);

INSERT INTO pacientes (nombre, apellidos, direccion, fecha_nacimiento, provincia_id, ingreso_id)
		VALUES
		('jhon', 'beltran', 'calle 123', '1997-02-20', 101, 1),
		('felipe', 'santana', 'carrera 123', '1996-09-12', 101, 2),
		('diego', 'bautista', 'calle 123', '1997-12-12', 101, 3),
		('bryan', 'castaño', 'carrera 123', '1995-07-12', 101, 4),
		('andres', 'vanegas', 'calle 456', '1991-12-12', 103, 5),
		('yojan', 'pardo', 'calle 456', '1996-10-08', 103, 6),
		('sebastian', 'carvajal', 'calle 1', '1994-03-04', 105, 7),
		('alvaro', 'beltran', 'calle 1', '1987-09-12', 105, 8),
		('jhon', 'beltran', 'calle 123', '1997-02-20', 107, 9),
		('felipe', 'santana', 'carrera 123', '1996-09-12', 101, 10),
		('diego', 'bautista', 'calle 123', '1997-12-12', 101, 11),
		('bryan', 'castaño', 'carrera 123', '1995-07-12', 101, 12),
		('jhon', 'beltran', 'calle 123', '1997-02-20', 101, 13);


ALTER TABLE telefonos ADD COLUMN numero VARCHAR (10) NOT NULL;

INSERT INTO telefonos (tipo, numero, paciente_id, medico_id)
			VALUES
			('paciente', '8888887', 1, 0),
			('paciente', '8888888', 1, 0),
			('paciente', '8888888', 0, 1);


SELECT
	p.nombre AS paciente,
	i.cama,
	i.n_habitacion,
	m.nombre AS medico
FROM ingresos AS i
LEFT JOIN pacientes AS p
	ON i.ingreso_id = p.ingreso_id
LEFT JOIN medicos As m
	ON m.medico_id = i.medico_id
	ORDER BY m.nombre;

SELECT * FROM pacientes ORDER BY nombre;

SELECT
	p.nombre AS paciente,
	m.nombre AS medico,
	t.numero
FROM telefonos AS t
LEFT JOIN pacientes AS p
	ON t.paciente_id = p.paciente_id
LEFT JOIN medicos As m
	ON m.medico_id = t.medico_id
	ORDER BY m.nombre;




select * from pacientes;
select * from medicos;
select * from ingresos;
select * from telefonos;
