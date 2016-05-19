create database clinica;
use clinica;

CREATE TABLE medicos(
			medico_id INTEGER PRIMARY KEY NOT NULL,
			primer_nombre VARCHAR(10) NOT NULL,
			segundo_nombre VARCHAR(10),
			primer_apellido VARCHAR(10) NOT NULL,
			segundo_apellido VARCHAR(10),
			es_jefe INTEGER NOT NULL
			);

ALTER TABLE medicos ADD CONSTRAINT fk_es_jefe FOREIGN KEY (es_jefe) REFERENCES medicos (medico_id);

CREATE TABLE especialidades(
			especialidad_id INTEGER  PRIMARY KEY NOT NULL,
			nombre VARCHAR(15) NOT NULL
			);

CREATE TABLE medico_especialidades(
			medico_id INTEGER NOT NULL,
			especialidad_id INTEGER NOT NULL,
            PRIMARY KEY (medico_id, especialidad_id)
			);


ALTER TABLE medico_especialidades ADD CONSTRAINT fk_especialidad_medico_especialidad FOREIGN KEY (especialidad_id) REFERENCES especialidades (especialidad_id);

ALTER TABLE medico_especialidades ADD CONSTRAINT fk_medico_medico_especialidad FOREIGN KEY (medico_id) REFERENCES medicos (medico_id);


INSERT INTO medicos(medico_id, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, es_jefe)
			VALUES 
			(127, 'MONICA','ALEJANDRA', 'ROBAYO', 'MARTINEZ',127),
			(125, 'DIEGO', 'FERNANDO', 'RIVEROS', 'TORRES', 127);


INSERT INTO especialidades(especialidad_id, nombre)
			VALUES
			(42, 'anestesilogo'),
			(44, 'pediatra' );

INSERT  INTO medico_especialidades(medico_id, especialidad_id)
		VALUES 
		(127, 42),
		(127, 44);



############################################################################################################################


create database clinica;
use clinica;

CREATE TABLE medicos(
			medico_id INTEGER PRIMARY KEY NOT NULL,
			primer_nombre VARCHAR(10) NOT NULL,
			segundo_nombre VARCHAR(10),
			primer_apellido VARCHAR(10) NOT NULL,
			segundo_apellido VARCHAR(10)
			);

CREATE TABLE jefesmedicos(
		medico_id INTEGER NOT NULL,
		jefe_id INTEGER NOT NULL,
		PRIMARY KEY(medico_id, jefe_id)
		);

ALTER TABLE jefesmedicos ADD CONSTRAINT fk_jefesm_medicos FOREIGN KEY (jefe_id) REFERENCES medicos (medico_id);
ALTER TABLE jefesmedicos ADD CONSTRAINT fk_medicos_medicos FOREIGN KEY (medico_id) REFERENCES medicos (medico_id);




CREATE TABLE especialidades(
			especialidad_id INTEGER  PRIMARY KEY NOT NULL,
			nombre VARCHAR(15) NOT NULL
			);

CREATE TABLE medico_especialidades(
			medico_id INTEGER NOT NULL,
			especialidad_id INTEGER NOT NULL,
            PRIMARY KEY (medico_id, especialidad_id)
			);


ALTER TABLE medico_especialidades ADD CONSTRAINT fk_especialidad_medico_especialidad FOREIGN KEY (especialidad_id) REFERENCES especialidades (especialidad_id);

ALTER TABLE medico_especialidades ADD CONSTRAINT fk_medico_medico_especialidad FOREIGN KEY (medico_id) REFERENCES medicos (medico_id);


INSERT INTO medicos(medico_id, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido)
			VALUES 
			(127, 'MONICA','ALEJANDRA', 'ROBAYO', 'MARTINEZ'),
			(123, 'ANDRES', 'MARIA', 'PRIETO', 'SALMON'),
			(125, 'DIEGO', 'FERNANDO', 'RIVEROS', 'TORRES');

INSERT INTO jefesmedicos(medico_id, jefe_id)
			VALUES
			(127,125),
			(127,123),
			(123,125);


INSERT INTO especialidades(especialidad_id, nombre)
			VALUES
			(42, 'anestesilogo'),
			(44, 'pediatra' );

INSERT  INTO medico_especialidades(medico_id, especialidad_id)
		VALUES 
		(127, 42),
		(127, 44);

