create database clinica;
use clinica;

CREATE TABLE medicos(
			medico_id INTEGER UNSIGNED PRIMARY KEY NOT NULL,
			primer_nombre VARCHAR(10) NOT NULL,
			segundo_nombre VARCHAR(10),
			primer_apellido VARCHAR(10) NOT NULL,
			segundo_apellido VARCHAR(10)
			);

CREATE TABLE especialidades(
			especialidad_id INTEGER UNSIGNED  PRIMARY KEY NOT NULL,
			nombre VARCHAR(15) NOT NULL
			);
CREATE TABLE medico_especialidad(
			medico_id INTEGER UNSIGNED NOT NULL,
			especialidad_id INTEGER UNSIGNED NOT NULL,
            PRIMARY KEY (medico_id, especialidad_id)
			);


ALTER TABLE medico_especialidad ADD CONSTRAINT fk_especialidad_medico_especialidad FOREIGN KEY (especialidad_id) REFERENCES especialidades (especialidad_id);

ALTER TABLE medico_especialidad ADD CONSTRAINT fk_medico_medico_especialidad FOREIGN KEY (medico_id) REFERENCES medicos (medico_id);


INSERT INTO medicos(medico_id, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido)
			VALUES 
			(127, 'MONICA','ALEJANDRA', 'ROBAYO', 'MARTINEZ'),
			(125, 'DIEGO', 'FERNANDO', 'RIVEROS', 'TORRES');


INSERT INTO especialidades(especialidad_id, nombre)
			VALUES
			(42, 'anestesilogo'),
			(44, 'pediatra' );

INSERT  INTO medico_especialidad(medico_id, especialidad_id)
		VALUES 
		(127, 42),
		(127, 44);


CREATE TABLE telefono_medicos(
			telefono_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
			numero VARCHAR (15) NOT NULL,
			medico_id INTEGER UNSIGNED NOT NULL
			);




ALTER TABLE telefono_medicos ADD CONSTRAINT fk_telefono_medico FOREIGN KEY (medico_id) REFERENCES medicos (medico_id);


INSERT INTO telefono_medicos (numero, medico_id)
		VALUES 
		('44444', 127),
		('44445', 125);

CREATE TABLE ingresos(
		ingreso_id INTEGER UNSIGNED  PRIMARY KEY AUTO_INCREMENT,
		medico_id INTEGER UNSIGNED NOT NULL,
		habitacion INTEGER UNSIGNED NOT NULL,
		cama INTEGER UNSIGNED NOT NULL,
		fecha_ingreso TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
		);


ALTER TABLE ingresos ADD CONSTRAINT fk_ingresos_medico FOREIGN KEY (medico_id) REFERENCES medicos (medico_id);

INSERT INTO ingresos (medico_id, habitacion, cama, fecha_ingreso)
		VALUES
		(127, 1, 1, '2016-02-18'),
		(125, 2, 1, '2016-02-18');


CREATE TABLE departamentos(
		departamento_id INTEGER UNSIGNED PRIMARY KEY,
		nombre VARCHAR (20) NOT NULL
		);


INSERT INTO departamentos (departamento_id, nombre)
		VALUES
		(55, 'ANTIOQUIA'),
		(25, 'CUNDINAMARCA'),
		(50, 'META');

UPDATE departamentos SET departamento_id = 05 WHERE departamento_id =55;

CREATE TABLE municipios (
		municipio_id INTEGER UNSIGNED PRIMARY KEY,
		departamento_id INTEGER UNSIGNED NOT NULL,
		nombre VARCHAR (20) NOT NULL
		);

ALTER TABLE municipios ADD CONSTRAINT fk_municipios_departamento FOREIGN KEY (departamento_id) REFERENCES departamentos (departamento_id);

INSERT INTO municipios(municipio_id, departamento_id, nombre)
			VALUES
			(50001, 50, 'VILLAVICENCIO'),
			(25290, 25, 'FUSAGASUGÁ'),
			(05001, 05, 'MEDELLIN');


CREATE TABLE pacientes (
		paciente_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
		municipio_id INTEGER UNSIGNED NOT NULL,
		primer_nombre VARCHAR(10) NOT NULL,
		segundo_nombre VARCHAR(10),
		primer_apellido VARCHAR(10) NOT NULL,
		segundo_apellido VARCHAR(10),
		direccion TEXT NOT NULL 
		);


ALTER TABLE pacientes ADD CONSTRAINT fk_municipios_paciente FOREIGN KEY (municipio_id) REFERENCES municipios (municipio_id);

INSERT INTO pacientes(municipio_id, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, direccion)
		VALUES
		(25290, 'JHON', 'FREDY', 'BELTRAN', 'LEON', 'CALLE 17A #13-80 BARRIO PIEDRA GRANDE'),
		(50001, 'JUAN', 'PABLO', 'MORALES', 'VELEZ', 'CALLE 12 #23-56'),
		(05001, 'PEDRO', 'PABLO', 'LOPEZ', 'MARTINEZ', 'CARRERA 1 #23-56');


CREATE TABLE ingresos_pacientes (
		paciente_id INTEGER UNSIGNED NOT NULL,
		ingreso_id INTEGER UNSIGNED NOT NULL,
        PRIMARY KEY (paciente_id, ingreso_id)
		);


ALTER TABLE ingresos_pacientes ADD CONSTRAINT fk_ingresos_paciente FOREIGN KEY (paciente_id) REFERENCES pacientes (paciente_id);

ALTER TABLE ingresos_pacientes ADD CONSTRAINT fk_ingresos_paciente_ingresos FOREIGN KEY (ingreso_id) REFERENCES ingresos (ingreso_id);


INSERT INTO ingresos (medico_id, habitacion, cama, fecha_ingreso)
		VALUES
		(127, 2, 4, '2016-02-18'),
		(125, 5, 7, '2016-02-18');

INSERT INTO ingresos_pacientes(paciente_id, ingreso_id)
		VALUES
		(1,1),
		(2,2),
		(2,3),
		(3,4);

CREATE TABLE telefono_pacientes(
		telefono_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
		numero VARCHAR (15) NOT NULL
		);

CREATE TABLE guia_pacientes_telefonos(
		paciente_id INTEGER UNSIGNED NOT NULL,
		telefono_id INTEGER UNSIGNED NOT NULL
		);


ALTER TABLE guia_pacientes_telefonos ADD CONSTRAINT fk_guia_pacientes FOREIGN KEY (paciente_id) REFERENCES pacientes (paciente_id);
ALTER TABLE guia_pacientes_telefonos ADD CONSTRAINT fk_guia_telefonos FOREIGN KEY (telefono_id) REFERENCES telefono_pacientes(telefono_id);


INSERT INTO telefono_pacientes (numero)
		VALUES
		('1111111111'),
		('2222222222');


INSERT INTO guia_pacientes_telefonos(paciente_id, telefono_id)
		VALUES
		(1,1),
		(2,1),
		(3,2);