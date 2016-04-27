CREATE TABLE clubLaEstancia(

	jugador_id SERIAL PRIMARY KEY,
	nombre VARCHAR (20) NOT NULL,
	ranking_interno INTEGER NOT NULL
);

CREATE TABLE clubHatoGrande(

	jugador_id SERIAL PRIMARY KEY,
	nombre VARCHAR (20) NOT NULL,
	ranking_interno INTEGER NOT NULL
);


INSERT INTO clubLaEstancia (nombre, ranking_interno )
	VALUES 
	('JHON', 1),
	('BRYAN', 2);

INSERT INTO clubHatoGrande (nombre,  ranking_interno)
	VALUES
	('YOJAN', 1),
	('ANDRES', 2);
	

--Para ver los partidos de los jugadores en la liga

SELECT 
		e.nombre AS Jugador_de_la_Estancia, 
		e.ranking_interno AS Clasificación, 
		h.nombre AS Jugador_de_Hato_Grade, 
		h.ranking_interno AS Clasificación
		
FROM 
	clubLaEstancia AS e,
	clubHatoGrande AS h;



--union
(SELECT * FROM clubLaEstancia)
union 
(SELECT * FROM clubHatoGrande);

--para poder realizar los siguientes ejemplos, agrego un jugador,
--que pertenece a ambos equipos.
INSERT INTO clubLaEstancia (nombre, ranking_interno )
	VALUES 
	('WILLIAM', 3);

INSERT INTO clubHatoGrande (nombre,  ranking_interno)
	VALUES
	('WILLIAM', 3);

--interseccion
(SELECT nombre FROM clubLaEstancia)
INTERSECT
(SELECT nombre FROM clubHatoGrande);

--diferencia
(SELECT nombre FROM clubLaEstancia)
EXCEPT
(SELECT nombre FROM clubHatoGrande);

--con esta consulta puedo ver que jugadores no forman parte de ambos clu
((SELECT nombre FROM clubLaEstancia)
EXCEPT
(SELECT nombre FROM clubHatoGrande))
UNION
((SELECT nombre FROM clubHatoGrande)
EXCEPT
(SELECT nombre FROM clubLaEstancia));


