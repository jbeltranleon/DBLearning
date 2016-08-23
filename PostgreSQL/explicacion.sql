

CREATE DATABASE veterinaria;
USE veterinaria;

/*Relación de uno a muchos*/

CREATE TABLE areasDeTrabajo (
	areaDeTrabajo_id SERIAL PRIMARY KEY,
	nombre VARCHAR(20) NOT NULL
);

INSERT INTO areasDeTrabajo (nombre)
VALUES
	('INSECTOS'),
	('PECES DE OCEANO');

/* Relacion de uno a uno */

/*veterinarios grupos de trabajo 1 veterinario es jefe de 1 grupo*/

CREATE TABLE veterinarios(
	veterinario_id INTEGER PRIMARY KEY,
	primer_nombre VARCHAR (15) NOT NULL,
	segundo_nombre VARCHAR (15) DEFAULT '---',
	primer_apellido VARCHAR (15) NOT NULL,
	segundo_apellido VARCHAR (15) DEFAULT '---',
	areaDeTrabajo_id INTEGER REFERENCES areasDeTrabajo(areaDeTrabajo_id)
);

INSERT INTO veterinarios (veterinario_id, primer_apellido, primer_nombre)
VALUES
	(1, 'PARDO', 'YOJA'),
	(2, 'SANTANA', 'PIPE'),
	(3, 'RODRIGUEZ', 'MAO'); 

CREATE TABLE gruposDeTrabajo(
	grupo_id SERIAL PRIMARY KEY,
	descripcion TEXT DEFAULT 'atencion domiciliaria',
	jefe_id INTEGER REFERENCES veterinarios(veterinario_id) NOT NULL
);

INSERT INTO gruposDeTrabajo (descripcion, jefe_id)
VALUES
	('Investigacion efectos de las empanadas en los perros', 3);


/*ALTER TABLE gruposDeTrabajo ADD CONSTRAINT fk_vet_grupos FOREIGN KEY(jefe_id) REFERENCES veterinarios(veterinarios_id);*/




/*Relación de muchos a muchos*/

CREATE TABLE telefonos (
	numero INTEGER PRIMARY KEY
);

INSERT INTO telefonos (numero)
VALUES
	(10),
	(20);

CREATE TABLE veterinarios_telefonos (
	veterinario_id INTEGER REFERENCES veterinarios(veterinario_id),
	numero INTEGER REFERENCES telefonos(numero),
	PRIMARY KEY (veterinario_id, numero)
);

INSERT INTO veterinarios_telefonos (veterinario_id, numero)
VALUES
	(1, 20),
	(1, 10),
	(2, 10);
