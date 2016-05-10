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




--La tabla se encuentra en tercera forma normal debido a que no posee campos de la llave primaria que dependan
--de otro campo (dependencia transitiva)

--CONSULTAS

--a---------------------------
SELECT nombre, apellido FROM socios 
WHERE fecha_nacimiento < '2016-12-31' 
AND fecha_nacimiento > '2001-12-31'
ORDER BY nombre;
--consulta con datos
SELECT nombre, apellido FROM socios 
WHERE fecha_nacimiento < '2016-12-31' 
AND fecha_nacimiento > '1994-12-31'
ORDER BY nombre;

--b---------------------------
SELECT 
	c.cinta_id
FROM 
	cintas AS c,
	socios AS s,
	prestamos AS p
WHERE
	c.cinta_id = p.cinta_id
AND
	s.socio_id = p.socio_id
AND
	s.nombre like '%Guillermo%'
AND
	s.apellido like '%Leon%';

--

SELECT 
	c.cinta_id
FROM 
	prestamos AS p
JOIN 
	cintas AS c
ON 
	c.cinta_id = p.cinta_id
JOIN 
	socios AS s
ON 
	s.socio_id = p.socio_id
WHERE
	s.nombre like '%Guillermo%'
AND
	s.apellido like '%Leon%';


--c----------------------------

SELECT 
	pe.pelicula_id AS Codigo,
	pe.titulo AS Titulo
FROM
	peliculas AS pe,
	prestamos AS pr,
	cintas AS c 
WHERE 
	pe.pelicula_id = c.pelicula_id
AND
	c.cinta_id = pr.cinta_id
AND 
	pe.genero like '%Terror%'
AND
	pr.devolucion = '2016-04-28';

--

SELECT 
	pe.pelicula_id AS Codigo,
	pe.titulo AS Titulo
FROM
	cintas AS c
JOIN 
	peliculas AS pe
ON 
	pe.pelicula_id = c.pelicula_id
JOIN 
	prestamos AS pr
ON
	c.cinta_id = pr.cinta_id
WHERE 
	pe.genero like '%Terror%'
AND
	pr.devolucion = '2016-04-28';


--d----------------------------
SELECT
	s.socio_id AS Codigo,
	s.nombre AS Nombre,
	s.direccion AS Direccion,
	pe.titulo AS Pelicula
FROM
	prestamos AS pr,
	socios AS s,
	peliculas AS pe,
	cintas AS c
WHERE
	pr.socio_id = s.socio_id
AND
	pr.cinta_id = c.cinta_id
AND	
	pe.pelicula_id = c.pelicula_id
AND
	pe.genero like '%Terror%';

--e----------------------------

SELECT 
	c.nombre,
	count(s.socio_id)
FROM 
	ciudades AS c,
	socios AS s
WHERE
	s.ciudad_id=c.ciudad_id
GROUP BY
	c.ciudad_id;

--f----------------------------

SELECT
c.ciudad_id,
count(s.socio_id)
FROM 
	ciudades AS c,
	socios AS s
WHERE
	s.ciudad_id=c.ciudad_id
GROUP BY 
	c.ciudad_id
HAVING count(s.socio_id)>3


---------------Vista----------

CREATE VIEW sociosporciudad AS
SELECT

c.ciudad_id AS Codigo,
c.nombre AS Nombre,
count(s.socio_id) AS Cantidad_socios
FROM 
	ciudades AS c,
	socios AS s
WHERE
	s.ciudad_id=c.ciudad_id
GROUP BY 
	c.ciudad_id

------------------------------
SELECT * FROM sociosporciudad



