--se pretende realizar un intercambio deportivo entre el club arsenal y el club country se desea saber cuales son los partidos de cada jugador,
--debemos tener en cuenta que al ser un intercambio los jugadores no van a competir contra jugadores del mismo club
CREATE DATABASE intercambio
use intercambio

CREATE TABLE arsenal(

	jugador_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR (20) NOT NULL,
	ranking_interno INTEGER UNSIGNED NOT NULL
);

CREATE TABLE country(

	jugador_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR (20) NOT NULL,
	ranking_interno INTEGER UNSIGNED NOT NULL
);


INSERT INTO arsenal (nombre, ranking_interno )
	VALUES 
	('JHON', 1),
	('BRYAN', 2);

INSERT INTO country (nombre,  ranking_interno)
	VALUES
	('YOJAN', 1),
	('ANDRES', 2);

 


--cartesiano
SELECT * FROM arsenal, country;

--union
(SELECT * FROM arsenal)
union 
(SELECT * FROM country);
--interseccion
(SELECT nombre FROM arsenal)
INTERSECT
(SELECT nombre FROM country);

--seleccion

SELECT * FROM arsenal where nombre = 'JHON';

-- proyeccion

SELECT nombre FROM arsenal;




