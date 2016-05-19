CREATE DATABASE platzi;
USE platzi;

CREATE TABLE books (
	book_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    publisher_id INTEGER UNSIGNED NOT NULL,
    title VARCHAR(60) NOT NULL,
    description TEXT NOT NULL,
    author VARCHAR(100) NOT NULL,
    price DECIMAL(5,2),
    copies INT NOT NULL DEFAULT 0
);

CREATE TABLE publishers(
	publisher_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL,
	country VARCHAR(20)
);

CREATE TABLE users(
	user_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL,
	email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE actions(
	action_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	book_id INTEGER UNSIGNED NOT NULL,
	user_id INTEGER UNSIGNED NOT NULL,
	action_type ENUM ('venta', 'prestamo', 'devolucion')
		NOT NULL,
	created_ad TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP

);

INSERT INTO publishers (name, country)
	VALUES ('BuhoMachine', 'Colombia');


SELECT COUNT (*) FROM publishers
--para saber la cardinalidad---

SELECT COUNT (publisher_id) FROM publishers;
--tarda menos--

DELETE * FROM publishers;
--para eliminar manteniendo metadata--

TRUNCATE publishers;
--para eliminar sin mantener la metadata--

INSERT INTO users(name, email) VALUES
    ('Ricardo', 'ricardo@hola.com'),
    ('Laura', 'laura@hola.com'),
    ('Jose', 'jose@hola.com'),
    ('Sofia', 'sofia@hola.com'),
    ('Fernanda', 'fernanda@hola.com'),
    ('Jose Guillermo', 'memo@hola.com'),
    ('Maria', 'maria@hola.com'),
    ('Susana', 'susana@hola.com'),
    ('Jorge', 'jorge@hola.com');


SELECT * FROM users;

INSERT INTO publishers(publisher_id, name, country) VALUES
    (1, 'OReilly', 'USA'),
    (2, 'Santillana', 'Mexico'),
    (3, 'MIT Edu', 'USA'),
    (4, 'UTPC', 'Colombia'),
    (5, 'Platzi', 'USA');

INSERT INTO books(publisher_id, title, author, description, price, copies) VALUES
    (1, 'Mastering MySQL', 'John Goodman', 'Clases de bases de datos usando MySQL', 10.50, 4),
    (2, 'Trigonometria avanzada', 'Pi Tagoras', 'Trigonometria desde sus origenes', 7.30, 2),
    (3, 'Advanced Statistics', 'Carl Gauss', 'De curvas y otras graficas', 23.60, 1),
    (4, 'Redes Avanzadas', 'Tim Bernes-Lee', 'Lo que viene siendo el Internet', 13.50, 4),
    (2, 'Curvas Parabolicas', 'Napoleon TNT', 'Historia de la parabola', 6.99, 10),
    (1, 'Ruby On (the) Road', 'A Miner', 'Un nuevo acercamiento a la programacion', 18.75, 4),
    (1, 'Estudios basicos de estudios', 'John Goodman', 'Clases de datos usando MySQL', 10.50 , 4),
    (4, 'Donde esta Y?', 'John Goodman', 'Clases de datos usando MySQL', 10.50, 4),
    (3, 'Quimica Avanzada', 'John White', 'Profitable studies on chemistry', 45.35, 1),
    (4, 'Graficas Matematicas', 'Rene Descartes', 'De donde viene el plano', 13.99, 7),
    (4, 'Numeros Importantes', 'Leonard Euler', 'De numeros que a veces nos sirven', 10, 3),
    (3, 'Modelado de conocimiento', 'Jack Friedman', 'Una vez adquirido, como se guarda el conocimiento', 29.99, 2),
    (3, 'Teoria de juegos', 'John Nash', 'A o B?', 12.55, 3),
    (1, 'Calculo de variables', 'Brian Kernhigan', 'Programacion mega basica', 9.50, 3),
    (5, 'Produccion de streaming', 'Juan Pablo Rojas', 'De la oficina ala pan', 23.49, 9),
    (5, 'ELearning', 'JFD & DvdH', 'Diseno y ejecucion de educacion online', 23.55, 4),
    (5, 'Pet Caring for Geeks', 'KC', 'Que tu perro aprenda a programar', 18.79, 3 ),
    (1, 'Algebra basica', 'Al Juarismi', 'Esto de encontrar X o Y, dependiendo', 13.50, 8);


    SELECT * FROM books where book_id = 6 \G 
    --comando usado en la teremnal para que cree tarjetas y se puedan leer mejor los datos--

    SELECT * FROM books where book_id = 6; 
    --normal-


INSERT INTO actions ( book_id, user_id, action_type) VALUES 
    (3,2,'venta'),
    (6,1,'prestamo'),
    (7,7,'prestamo'),
    (7,7,'devolucion'),
    (2,5,'venta'),
    (10,9,'venta'),
    (18,8,'prestamo'),
    (12,4,'venta'),
    (1,3,'venta'),
    (4,5,'prestamo'),
    (5,2,'venta');

-- en algunas ocaciones necesitamos referirnos a tablas con nombres muy largos, para acortar dichos 
--nombres podemos usar alias o apodos para nuestras tablas 
/*
SELECT a.action_id AS aid,/*columna a usar en la tabla
       b.title,			  /*columna a usar en la tabla
       a.action_type,	  /*columna a usar en la tabla
       u.name,			  /*columna a usar en la tabla
--	   b.price AS price
       IF(a.action_type= 'venta', b.price, '0') AS price
       /*condicion para que los prestamos y las devoluciones no tengan precio
       b.book_id AS bid,
       IF (b.book_id IN (1,4,7,8,2), b.price * .9, b.price, b.price) AS dcto
FROM actions AS a /*tabla pivote
LEFT JOIN books AS b
  ON b.book_id = a.book_id/*igualacion para comparar los datos que requiere la tabla pivote con respecto a la tabla con la que se hace el join
LEFT JOIN users AS u
  ON a.user_id = u.user_id
*/


/*IF(b.book_id IN(1,4,5,3,2,6),
           b.price*.9,
           b.price) AS dcto*/

/*Script correcto para hacer util nuestra informacion en una tabla satelite*/

  SELECT a.action_id AS aid,
       b.title,
       a.action_type,
       u.name,
       IF(a.action_type= 'venta',
           b.price, '0') AS price
       
       
FROM actions AS a
LEFT JOIN books AS b
  ON b.book_id = a.book_id
LEFT JOIN users AS u
  ON a.user_id = u.user_id



/*----------------------------------*/

SELECT
	p.name,
	b.title,
	b.price,
	b.copies
FROM books AS b
JOIN publishers AS p
	ON b.publisher_id = p.publisher_id



SELECT
	p.publisher_id AS pid,
	p.name,
	SUM(b.price * b.copies)
FROM books AS b
JOIN publishers AS p
	ON b.publisher_id = p.publisher_id
GRoUP BY pid/*para que ejecute todas las lineas que contenga en este caso pid*/


SELECT
	p.publisher_id AS pid,
	p.name,
	SUM(IF(b.price<15, 0, b.price * b.copies)) AS total
FROM books AS b
JOIN publishers AS p
	ON b.publisher_id = p.publisher_id
GROUP BY pid

/*asumiendo que una persona decide comprarnos todos los libros que valen menos de 15*/
SELECT
	p.publisher_id AS pid,
	p.name,
	COUNT(b.book_id) AS libros,
	SUM(IF(b.price >=15, 1, 0)) AS mis_libros
FROM books AS b
LEFT JOIN publishers AS p
	ON p.publisher_id = b.publisher_id
GROUP BY pid



SELECT
	p.publisher_id AS pid,
	p.name,
	SUM(IF(b.price<15, 0, b.price * b.copies)) AS total,
	SUM(IF(b.price<15, 0, 1)) AS libros_por_vender
FROM books AS b
JOIN publishers AS p
	ON b.publisher_id = p.publisher_id
GROUP BY pid



SELECT
	p.publisher_id AS pid,
	p.name,
	SUM(IF(b.price<15, 0, b.price * b.copies)) AS total,
	SUM(IF(b.price<15, 0, 1)) AS libros_por_vender,
	COUNT(b.book_id) AS libros
FROM books AS b
JOIN publishers AS p
	ON b.publisher_id = p.publisher_id
	WHERE b.price >15
GROUP BY pid


ALTER TABLE users ADD COLUMN active tinyint (1) NOT NULL DEFAULT 1;
/*para agregar una columna*/


UPDATE users SET active = 1 WHERE user_id=9;

/*usado para mantener integridad de los datos y ahorrar tiempo de encontrar las excepciones*/
INSERT INTO users (name,email)
	VALUES ('Andrea', 'sofia@hola.com')
ON DUPLICATE KEY
UPDATE 
	active = active + 1,
	name = CONCAT (name,' - nuevo');



/* Recuerda cuidar la info de tu DB usa un limit 1 para no romper toda tu info*/
UPDATE users SET name = 'juan'0
WHERE user_id = 5
LIMIT 1;
/* limit 1 para que ejecute esa accion solo en una tupla*/


/*un replace puede escribirse con la estructura de un update o de un insert y va 
a ejecutar un update o un insert segun sea el caso y segun lo permita la base de datos*/
--1
	REPLACE INTO users (name, email, active)
		VALUES ('lorena', 'laura@hola.com', 4);

--2
	REPLACE INTO users 
	SET name = 'juan',
	email='juan@hotmail.com';

/*replace ayuda a mantener la integridad de los datos*/
