

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
		PRIMARY KEY(medico_id, jefe_id),
		FOREIGN KEY (jefe_id) REFERENCES medicos (medico_id),
		FOREIGN KEY (medico_id) REFERENCES medicos (medico_id)
		);



CREATE TABLE especialidades(
			especialidad_id INTEGER  PRIMARY KEY NOT NULL,
			nombre VARCHAR(15) NOT NULL
			);

CREATE TABLE medico_especialidades(
			medico_id INTEGER NOT NULL,
			especialidad_id INTEGER NOT NULL,
            PRIMARY KEY (medico_id, especialidad_id),
            FOREIGN KEY (especialidad_id) REFERENCES especialidades (especialidad_id),
            FOREIGN KEY (medico_id) REFERENCES medicos (medico_id)
			);


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






SELECT m.medico_id AS ID,
       m.primer_nombre AS Nombre,
       m.primer_apellido AS Apellido,
       e.especialidad_id AS Especialidad,
       j.jefe_id AS Subordinado_de
     
FROM medicos AS m
LEFT JOIN medico_especialidades AS e
  ON m.medico_id = e.medico_id
LEFT JOIN jefesmedicos AS j
  ON m.medico_id = j.medico_id
  

ORDER BY m.medico_id;