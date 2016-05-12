DROP FUNCTION IF EXISTS mi_funcion (nombre TEXT, apellido TEXT);

CREATE OR REPLACE FUNCTION concatenar (nombre TEXT, apellido TEXT)
RETURNS TEXT
AS $BODY$
DECLARE
	-- Declaracion de variables
	_variable1 TEXT;
	ariable2 TEXT;

BEGIN
	RETURN nombre ||' '||apellido;
END;
$BODY$
--Tipo de lenguaje
LANGUAGE 'plpgsql';

--comentario en funciones
COMMENT ON FUNCTION concatenar (nombre TEXT, apellido TEXT) IS '
	Funcion que retorna el nombre completo
';

SELECT concatenar('Jhon', 'Beltrán');

------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION sumar (primerNumero INTEGER, segundoNumero INTEGER)
RETURNS INTEGER
AS $BODY$
DECLARE
		total INTEGER := 0;
BEGIN
	total:= primerNumero + segundoNumero;
	RETURN total;
END;
$BODY$
--Tipo de lenguaje
LANGUAGE 'plpgsql';
--comentario en funciones
COMMENT ON FUNCTION sumar (primerNumero INTEGER, segundoNumero INTEGER) IS 
'Funcion que suma dos valores';

SELECT sumar(3,5);

---------------------------------------------------------------------------


CREATE OR REPLACE FUNCTION operar (primerNumero INTEGER, segundoNumero INTEGER)
RETURNS REAL
AS $BODY$
DECLARE
		total REAL := 0;
BEGIN
	total:= (primerNumero*segundoNumero)/2.4 + (segundoNumero^2);
	RETURN total;
END;
$BODY$
--Tipo de lenguaje
LANGUAGE 'plpgsql';
--comentario en funciones
COMMENT ON FUNCTION operar (primerNumero INTEGER, segundoNumero INTEGER) IS 
'Funcion que suma dos valores';

SELECT operar(3,5);


-------------------------------------------------------------------------------


CREATE OR REPLACE FUNCTION usando_arrays (Numero INTEGER[])
RETURNS REAL
AS $BODY$
DECLARE
		total REAL := 0;
BEGIN
	--En postgresql los arrays inician a partir de 1
	RAISE NOTICE 'El valor almacenado es: %', Numero[2];
	--Usado para ver valores almacenados que no son visibles
	--La salida de el RAISE NOTICE la podemos ver en Messajes en el output pane
	total:= Numero[1] + Numero[1];
	RETURN total;
END;
$BODY$
--Tipo de lenguaje
LANGUAGE 'plpgsql';
--comentario en funciones
COMMENT ON FUNCTION usando_arrays (Numero INTEGER[]) IS 
'Funcion que usa arrays';

SELECT usando_arrays('{2,4}');

SELECT usando_arrays(ARRAY[2,4]);


---------------------------------------------------------------

CREATE OR REPLACE FUNCTION encontrandoALtrabajador (numeroDeRegistro INTEGER, Numero INTEGER[])
RETURNS TEXT
AS $BODY$
DECLARE
		variableDeAlmacenado RECORD;
BEGIN
	

	SELECT * INTO variableDeAlmacenado FROM socios WHERE socio_id=numeroDeRegistro;

	IF (Numero[1]>3) THEN
	--tambien existe un IF NOT

	RETURN variableDeAlmacenado.nombre ||' '|| 'es trabajador' ||' con el numero '||usando_arrays(Numero)::TEXT;

	ELSE

	RETURN variableDeAlmacenado.nombre ||' '|| 'no es trabajador' ||' con el numero '||usando_arrays(Numero)::TEXT; 

	END IF;
	RETURN 0;


END;
$BODY$
--Tipo de lenguaje
LANGUAGE 'plpgsql';
--comentario en funciones
COMMENT ON FUNCTION encontrandoALtrabajador  (numeroDeRegistro INTEGER, Numero INTEGER[]) IS 
'Funcion que encuentra al trabajador';


SELECT encontrandoALtrabajador(2,ARRAY[2,5]);


---------------------------------------------------------------------------------------

/* ************************* BEGIN FUNCIONES EN PL/pgSQL *****************************/
-- Función SELECT: El parámetro es el nombre cursor que nos traerá los datos
-- Si usamos variables con nombres combinados de Mayúsculas y Minúsculas debemos ponerlos entre comillas dobles (" ").
-- Ejemplo: CREATE FUNCTION  "verAllUsuarios" ...
CREATE OR REPLACE FUNCTION verusuarios(refcursor) RETURNS refcursor AS
$BODY$
BEGIN
    OPEN $1 FOR SELECT * FROM usuarios;
    RETURN $1;
END;
$BODY$  LANGUAGE 'plpgsql' VOLATILE;
 
 
--Selecciona las 6 primeras filas
BEGIN
SELECT verusuarios('hola') AS Answer;
FETCH FORWARD 6 in "hola"; -- Si no existe 6 nos devuelve solo las que encuentre
COMMIT;
--Selecciona las 3 primeras filas y la fila anterior de la selección (ose la fila 2)
select verusuarios('micursor');
FETCH FORWARD 3 in micursor;
FETCH BACKWARD 1 in miCursor;
 
-- SELECT: El primer parámetro es el nombre cursor que nos traerá los datos, y el segundo el campo por el que haremos la busqueda
CREATE OR REPLACE  FUNCTION usuariosbyname(refcursor,text) RETURNS refcursor AS
$BODY$
BEGIN
    OPEN $1 FOR SELECT * FROM usuarios WHERE nombres LIKE $2 || '%';
    RETURN $1;
END;
$BODY$  LANGUAGE 'plpgsql' VOLATILE;
 
BEGIN
SELECT usuariosbyname('otrocursor','m');
FETCH ALL IN otrocursor;
COMMIT;
 
-- Función INSERT: Insertamos un registro a la tabla
CREATE OR REPLACE FUNCTION insertar_usuarios(INT, VARCHAR(20), VARCHAR(50), VARCHAR(50),VARCHAR(20), CHAR(1)) RETURNS VOID AS
$BODY$
BEGIN
    INSERT INTO usuarios (codpais, nombres, apellidos, email, clave, estado )
    VALUES ($1, $2, $3, $4, $5,$6);
END;
$BODY$  LANGUAGE 'plpgsql' VOLATILE;
 
BEGIN
SELECT insertar_usuarios(1,'martin', 'dino', 'martin@gmail.com', 'mariquin', 'A' )
COMMIT;
SELECT * FROM usuarios;
 
-- Función UPDATE: Actualizamos un registro por el campo Código, devolvemos TRUE si se actualiza
CREATE OR REPLACE FUNCTION update_usuarios(INT, INT, VARCHAR(20), VARCHAR(50), VARCHAR(50),VARCHAR(20), CHAR(1)) RETURNS BOOL AS
$BODY$
DECLARE
codigo ALIAS FOR $1;
registro usuarios%ROWTYPE;
BEGIN
    SELECT * INTO registro FROM usuarios WHERE codusuario = codigo;
     IF FOUND THEN
        UPDATE usuarios SET
        codpais = $2, nombres = $3, apellidos = $4, email = $5, clave = $6, estado = $7 WHERE codusuario = codigo;  
      RETURN TRUE;
     END IF;
    RETURN FALSE;
END;
$BODY$  LANGUAGE 'plpgsql' VOLATILE;
 
SELECT update_usuarios(14,3,'marin', 'kino', 'marin@gmail.com', 'marin', 'I' )
SELECT * FROM usuarios;
 
-- Función DELETE: Si se elimina un registro devolvemos TRUE
CREATE OR REPLACE FUNCTION del_usuariobycod(INT) RETURNS BOOL AS
$$
DECLARE codigo ALIAS FOR $1;
BEGIN
    DELETE FROM usuarios WHERE codusuario = codigo;
    IF FOUND THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END; $$ LANGUAGE plpgsql;
 
SELECT * FROM del_usuariobycod(14);
SELECT * FROM usuarios;
 
-- Función SELECT usando RECORD
CREATE OR REPLACE FUNCTION traer_usuarios() RETURNS SETOF record AS
$$
DECLARE rec record;
BEGIN
    FOR  rec IN  SELECT * FROM usuarios LOOP
    return next  rec;
    END LOOP;
    RETURN;
END; $$ LANGUAGE plpgsql;
 
BEGIN
SELECT * FROM  traer_usuarios() AS (codusuario INT,codpais INT, nombres VARCHAR(50), apellidos VARCHAR(50), email VARCHAR(50), clave VARCHAR(50), estado CHAR(1) );
COMMIT;
/* *************************  END  FUNCIONES EN PL/pgSQL *****************************/


CREATE OR REPLACE FUNCTION socioPorPais (codigoSocio INTEGER )
RETURNS TEXT
AS $BODY$
DECLARE
		variableDeAlmacenado RECORD;
BEGIN
	

	SELECT 
		c.nombre,
		count(s.socio_id)
	INTO 
		variableDeAlmacenado
	FROM 
		ciudades AS c,
		socios AS s
	WHERE
		s.ciudad_id=c.ciudad_id
	AND
		c.ciudad_id=codigoSocio
	GROUP BY
		c.ciudad_id;

	RETURN variableDeAlmacenado::TEXT;

END;
$BODY$
--Tipo de lenguaje
LANGUAGE 'plpgsql';
--comentario en funciones
COMMENT ON FUNCTION socioPorPais  (codigoSocio INTEGER ) IS 
'Funcion que encuentra los socios de cada pais';



SELECT socioPorPais(10);
