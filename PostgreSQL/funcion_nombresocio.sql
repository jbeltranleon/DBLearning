
CREATE OR REPLACE FUNCTION nombreSocio (nombre_socio VARCHAR)
RETURN TEXT
AS $BODY$
DECLARE
		variabledefault RECORD;
BEGIN

	SELECT *
	INTO
		variabledefault
	FROM
		socios as s
	WHERE
		s.nombre = nombre_socio
	GROUP BY
		s.nombre;

	RETURN variabledefault::TEXT;

END;
$BODY$
LANGUAGE 'plpgsql';
COMMENT ON FUNCTION nombreSocio (nombre_socio VARCHAR) IS
'Funcion Kappita';

SELECT nombreSocio ('Pedro')
