CREATE DATABASE empresa;
USE empresa

CREATE TABLE aseguradoras (
	aseguradora_id SERIAL PRIMARY KEY,
	nombre VARCHAR (30) NOT NULL
);

INSERT INTO aseguradoras (nombre)
VALUES
	(1, 'COLSANITAS'),
	('SALUCOP');

CREATE TABLE cargos (
	cargo_id SERIAL PRIMARY KEY,
	nombre VARCHAR (30) NOT NULL
);

CREATE TABLE empleados (
	empleado_id SERIAL PRIMARY KEY,
	primer_nombre VARCHAR (15) NOT NULL,
	segundo_nombre VARCHAR (15),
	primer_apellido VARCHAR (15) NOT NULL,
	segundo_apellido VARCHAR (15),
	email VARCHAR (50) NOT NULL,
	sueldo INTEGER NOT NULL,
	aseguradora_id INTEGER NOT NULL REFERENCES aseguradoras(aseguradora_id),
	cargo_id INTEGER NOT NULL
);

alter table empleados add constraint FK_empleados_cargos foreign key(cargo_id)REFERENCES cargos(cargo_id);

CREATE TABLE telefonos (
	telefono_id SERIAL PRIMARY KEY,
	numero VARCHAR (15)
);

CREATE TABLE telefonos_empleados (
	empleado_id INTEGER REFERENCES empleados(empleado_id),
	telefono_id INTEGER	REFERENCES telefonos(telefono_id),
	PRIMARY KEY(empleado_id, telefono_id)
);