CREATE TABLE Municipios (
						cod_munici VARCHAR(3) NOT NULL PRIMARY KEY, 
						num_munici VARCHAR (30) NOT NULL);


CREATE TABLE Alumnos(
			codigo VARCHAR(10) NOT NULL PRIMARY KEY,
			apellidos VARCHAR (30) NOT NULL,
			nombres VARCHAR (30) NOT NULL,
			telefono VARCHAR (10) NOT NULL , 
			correo_electro VARCHAR (30) NOT NULL,
			cod_munici VARCHAR (3) NOT NULL
			);


ALTER TABLE alumnos ADD CONSTRAINT cod_munici FOREIGN KEY (cod_munici) REFERENCES municipios (cod_munici) ON DELETE CASCADE ON UPDATE CASCADE;


