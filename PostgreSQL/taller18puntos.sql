CREATE TABLE Almacenes (
	almacen_id VARCHAR(100) PRIMARY KEY,
	responsable VARCHAR(100) NOT NULL,
	ciudad VARCHAR(100) NOT NULL
);

CREATE TABLE Articulos (
	articulo_id VARCHAR(100) PRIMARY KEY,
	nombre_articulo VARCHAR(100) NOT NULL,
	precio_articulo INTEGER NOT NULL
);

CREATE TABLE Materiales (
	material_id VARCHAR(100) PRIMARY KEY,
	descripcion_material VARCHAR(100) NOT NULL
);

CREATE TABLE Proveedores (
	proveedor_id VARCHAR(100) PRIMARY KEY,
	nombre_proveedor VARCHAR(100) NOT NULL,
	domicilio VARCHAR (100) NOT NULL,
	ciudad VARCHAR (100) NOT NULL
);


CREATE TABLE Almacenes_Articulos (
	almacen_id VARCHAR(100) REFERENCES Almacenes(almacen_id),
	articulo_id VARCHAR(100) REFERENCES Articulos(articulo_id),
	cantidad VARCHAR(100),
	PRIMARY KEY (almacen_id, articulo_id)
);

CREATE TABLE Articulos_Materiales (
	articulo_id VARCHAR(100) REFERENCES Articulos (articulo_id),
	material_id VARCHAR(100) REFERENCES Materiales (material_id),
	PRIMARY KEY (articulo_id, material_id)
);

CREATE TABLE Materiales_Proveedores (
	material_id VARCHAR(100) REFERENCES Materiales (material_id),
	proveedor_id VARCHAR(100) REFERENCES Proveedores (proveedor_id),
	PRIMARY KEY (material_id, proveedor_id)
);

COPY Almacenes FROM '/home/jhon/Downloads/bases/almacen1.txt' USING DELIMITERS ';'
-- SELECT * FROM Almacenes

COPY Articulos FROM '/home/jhon/Downloads/bases/articulo1.txt' USING DELIMITERS ';'
-- SELECT * FROM Articulos

COPY Proveedores FROM '/home/jhon/Downloads/bases/proveedor1.txt' USING DELIMITERS ';'
-- SELECT * FROM Proveedores

COPY Materiales FROM '/home/jhon/Downloads/bases/material1.txt' USING DELIMITERS ';'
-- SELECT * FROM Materiales

COPY Almacenes_Articulos FROM '/home/jhon/Downloads/bases/almacen_articulo1.txt' USING DELIMITERS ';'
-- SELECT * FROM Almacenes_Articulos

COPY Articulos_Materiales FROM '/home/jhon/Downloads/bases/articulo_material1.txt' USING DELIMITERS ';'
-- SELECT * FROM Articulos_Materiales

COPY Materiales_Proveedores FROM '/home/jhon/Downloads/bases/material_proveedor1.txt' USING DELIMITERS ';'
-- SELECT * FROM Materiales_Proveedores

-------------------1-------------------
SELECT proveedor_id, nombre_proveedor, domicilio FROM Proveedores
WHERE ciudad = 'BOGOTA'
-----------------2---------------------

SELECT
  p.proveedor_id,
	p.nombre_proveedor
FROM
	Proveedores p

EXCEPT

SELECT
	mp.proveedor_id, p.nombre_proveedor
FROM
	Proveedores p,
	Materiales_Proveedores mp

WHERE mp.proveedor_id=p.proveedor_id;

---------------------------------------

SELECT
  p.nombre_proveedor
FROM
  Proveedores p

EXCEPT

SELECT
   p.nombre_proveedor
FROM
  Proveedores p
JOIN  Materiales_Proveedores mp
ON mp.proveedor_id=p.proveedor_id;

---------------------------------------
insert into Proveedores (proveedor_id, nombre_proveedor, domicilio, ciudad)
	values
	('3444', 'Bryan', 'Pekin', 'hong kong');


select p.nombre_proveedor from Proveedores p
WHERE proveedor_id in (

SELECT
  p.proveedor_id
FROM
  Proveedores p

EXCEPT

SELECT
   mp.proveedor_id
FROM
  Materiales_Proveedores mp
);




------------------3--------------------
SELECT
  articulo_id,
  nombre_articulo
FROM
  Articulos
WHERE
  precio_articulo>250000
ORDER BY nombre_articulo
---------------------4-----------------
SELECT
  articulo_id,
  nombre_articulo
FROM
  Articulos a
WHERE
  precio_articulo>=350000
AND
  precio_articulo<='500000'
--------------------5-------------------

CREATE VIEW descuentoMes AS 
SELECT
  articulo_id identificador, 
  nombre_articulo articulo
 FROM
  Articulos a
WHERE
  precio_articulo>=350000
AND
  precio_articulo<='500000';

SELECT * FROM descuentoMes;
SELECT identificador FROM descuentoMes;

---bad idea------
UPDATE  descuentoMes SET articulo = '410023'
--Esto nos rompe la tabla
--Las vistas son utiles para ocultar el nombre de los campos a un usuario,
--tambien son utiles para ahorrar tiempo al querer hacer una consulta varias veces


--------------------6-------------------
SELECT proveedor_id, nombre_proveedor FROM Proveedores
WHERE ciudad <> 'BOGOTA'
--------------------7--------------------
SELECT proveedor_id, nombre_proveedor FROM Proveedores
WHERE ciudad LIKE 'B%'
--------------------8---------------------
--Una funcion de agregacion realiza una operacion individual para multiples filas.
--Con las funciones de agregacion podemos calcular
-- cantidad (count), suma (sum), promedio (avg), máximo (max), y mínimo (min)
--sobre un conjunto de filas.

--la instruccion group by funciona agrupar las filas que se van a relacionar con
--la funcion de agregacion
--la funcion de having funciona como un where con funciones de agregacion
--------------------9----------------------
SELECT count(*) FROM Proveedores
--------------------10---------------------
SELECT
      m.material_id AS id,
      m.descripcion_material AS descripcion,
      p.nombre_proveedor AS nombre
FROM
  Materiales AS m,
	Proveedores AS p,
	Materiales_Proveedores AS mp
WHERE
  p.ciudad = 'BOGOTA'
AND
  m.material_id= mp.material_id
AND
  p.proveedor_id=mp.proveedor_id

----------------------11---------------------
SELECT
    a.almacen_id as almacen,
    ar.nombre_articulo as articulo,
    a.responsable as nombre
FROM
	Almacenes as a,
	Articulos as ar,
	Materiales as m,
	Almacenes_Articulos AS aa,
	Articulos_Materiales as am
WHERE m.material_id = '51001'
AND a.almacen_id = aa.almacen_id AND ar.articulo_id=aa.articulo_id
AND m.material_id = am.material_id AND aa.articulo_id=am.articulo_id

--------------------------12----------------------
SELECT avg(precio_articulo) FROM Articulos

--------------------------13----------------------
SELECT sum(precio_articulo) FROM Articulos

--------------------------14----------------------

SELECT
aa.articulo_id ,
aa.cantidad,
a.nombre_articulo nombre,
a.precio_articulo precio,
aa.cantidad*a.precio_articulo total

FROM
Articulos as a,
Almacenes_Articulos as aa
where
a.articulo_id = aa.articulo_id
GROUP BY aa.articulo_id,
a.nombre_articulo,
a.precio_articulo,
aa.cantidad, aa.cantidad*a.precio_articulo
------------------------15---------------------


  SELECT
    aa.almacen_id,

    min(precio_articulo),
    max(precio_articulo),
    avg(precio_articulo)
  FROM
    Articulos a,
    Almacenes_Articulos aa

  WHERE
    a.articulo_id=aa.articulo_id
  GROUP BY

    aa.almacen_id

-----------con los nombres de los responsables---

SELECT
  al.responsable,

  min(precio_articulo),
  max(precio_articulo),
  avg(precio_articulo)
FROM
  Articulos a,
  Almacenes_Articulos aa,
  Almacenes al
WHERE
  a.articulo_id=aa.articulo_id
AND
  al.almacen_id=aa.almacen_id
GROUP BY

  al.responsable

------------------------16---------------------
SELECT articulo_id, nombre_articulo FROM Articulos
    WHERE precio_articulo = (SELECT min(precio_articulo) FROM Articulos);

-----------------------17----------------------
SELECT
	a.nombre_articulo as nombre,
	count(am.material_id)
FROM
	Articulos as a, Articulos_Materiales as am
WHERE a.precio_articulo>250000 AND a.articulo_id=am.articulo_id
GROUP BY a.nombre_articulo
HAVING count(am.material_id)>3

---------------------18-------------------------
--taller18puntos.sql
