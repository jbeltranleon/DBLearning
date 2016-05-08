CREATE TABLE ciudades (
		ciudad_id INTEGER PRIMARY KEY,
		nombre VARCHAR (30) NOT NULL 
);

CREATE TABLE socios (
		socio_id INTEGER PRIMARY KEY,
		ciudad_id INTEGER REFERENCES ciudades(ciudad_id),
		nombre VARCHAR (30) NOT NULL,
		apellido VARCHAR (30) NOT NULL,
		direccion VARCHAR (40) NOT NULL,
		fecha_nacimiento DATE NOT NULL
);

CREATE TABLE peliculas (
		pelicula_id INTEGER PRIMARY KEY,
		titulo VARCHAR (50) NOT NULL,
		genero VARCHAR (30) NOT NULL
);

CREATE TABLE cintas (
		cinta_id INTEGER PRIMARY KEY,
		pelicula_id INTEGER REFERENCES peliculas (pelicula_id)
);

CREATE TABLE prestamos (
		socio_id INTEGER REFERENCES socios (socio_id),
		cinta_id INTEGER REFERENCES cintas (cinta_id),
		prestamo DATE NOT NULL,
		devolucion DATE 
);

INSERT INTO ciudades (ciudad_id, nombre)
VALUES
		(10, 'Dublín'),
		(20, 'Kiev'),
		(30, 'Pionyang'),
		(40, 'Helsinki'),
		(50, 'Manaos');


INSERT INTO socios (socio_id, nombre, apellido, direccion, ciudad_id, fecha_nacimiento)
VALUES
		(1, 'John', 'Titor', ' Unit 6A KCR Industrial Estate', 10, '1996-05-01'),
		(2, 'Guillermo', 'Leon', 'Avenida Coronel Texeira #3162', 50, '1995-02-05'); 


INSERT INTO peliculas (pelicula_id, titulo, genero)
VALUES
		(100, 'La vida de Brian', 'Comedia'),
		(200, 'Hostel', 'Suspenso'),
		(300, 'Holocausto Canibal', 'Terror'),
		(400, 'Yo te saludo, María', 'Drama'),
		(500, 'La matanza de Texas', 'Terror');

INSERT INTO cintas (cinta_id, pelicula_id)
VALUES
		(1000,100),
		(2000,200),
		(3000,300),
		(4000,500),
		(5000,200),
		(6000,400),
		(7000,200),
		(8000,500),
		(9000,100),
		(10000,300);


INSERT INTO prestamos (socio_id, cinta_id, prestamo, devolucion)
VALUES
		(1,1000,'2015-01-05', '2015-02-05'),
		(1,3000,'2016-01-08', '2016-03-02'),
		(1,4000,'2016-02-03', '2016-04-28'),
		(2,1000,'2016-04-15', '2016-06-05'),
		(2,7000,'2016-05-02', '2016-06-25');