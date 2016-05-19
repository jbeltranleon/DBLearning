CREATE TABLE peliculas (
		pelicula_id INTEGER PRIMARY KEY,
		titulo VARCHAR (50) NOT NULL,
		genero VARCHAR (30) NOT NULL
);
INSERT INTO peliculas (pelicula_id, titulo, genero)
VALUES
		(100, 'La vida de Brian', 'Comedia'),
		(200, 'Hostel', 'Suspenso'),
		(300, 'Holocausto Canibal', 'Terror'),
		(400, 'Yo te saludo, María', 'Drama'),
		(500, 'La matanza de Texas', 'Terror');

CREATE TABLE peliculasFueraDeCartelera (
		pelicula_id INTEGER PRIMARY KEY,
		titulo VARCHAR (50) NOT NULL,
		genero VARCHAR (30) NOT NULL
);



CREATE OR REPLACE FUNCTION insertar_peliculas_fuera_de_cartelera()
RETURNS TRIGGER AS $insertar$
DECLARE BEGIN
	INSERT INTO peliculasFueraDeCartelera values(OLD.pelicula_id, OLD.titulo, OLD.genero);
	RETURN NULL; 
END;
$insertar$
LANGUAGE plpgsql;

CREATE TRIGGER fuera_de_cartelera AFTER DELETE 
ON peliculas FOR EACH ROW 
EXECUTE PROCEDURE insertar_peliculas_fuera_de_cartelera();

DELETE FROM peliculas WHERE pelicula_id = 100;

SELECT * FROM peliculas;
SELECT * FROM peliculasFueraDeCartelera;