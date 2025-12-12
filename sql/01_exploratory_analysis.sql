-- COMPROBACIÓN DE DATOS

--1RO CREAMOS UNA TABLA NUEVA DE TURISAS X COMUNIDAD CON LOS DATOS EN SU CORRECTO FORMATO
CREATE TABLE turistas_comunidad_clean AS
SELECT
  CAST(periodo AS INTEGER) AS periodo,
  comunidad,
  CAST(
        REPLACE(
            TRIM(turistas),
            ',', ''
        ) AS INTEGER
      ) AS turistas
FROM turistas_comunidad;

-- COMPROBACIONES TURISTAS POR DESTINO

--- VER CANTIDAD TOTAL DE RESULTADOS (COMUNIDADES POR CADA AÑO)
SELECT
	COUNT(*) AS filas
FROM turistas_comunidad_clean t;  --Resultado: 114

--- CANTIDAD DE COMUNIDADES
SELECT
	COUNT ( DISTINCT t.comunidad)  AS TOTAL_COMUNIDADES 
FROM turistas_comunidad_clean t; --Resultado: 19

--- RANGO DE AÑOS
SELECT
	COUNT (DISTINCT t.periodo ) AS total_annos,
	MIN(t.periodo),
	MAX(t.periodo )
FROM turistas_comunidad_clean t;  --Resultado: 6 años, max 2024 y min 2019

---COMPROBAR TOTALES (19 COMUNIDADES X 6 AÑOS)
SELECT
	total_comunidades,
	total_anios,
	total_comunidades * total_anios AS datos_totales
FROM 
(
	SELECT
		COUNT(DISTINCT t.comunidad ) AS total_comunidades,
		COUNT (DISTINCT t.periodo ) AS total_anios
	FROM turistas_comunidad_clean AS t
)AS X; --Datos totales: 114, TODO OK

--- VALORES NULOS Y NEGATIVOS
SELECT
	COUNT(*) AS VACIOS
FROM turistas_comunidad_clean t
WHERE t.turistas IS NULL OR t.turistas <= 0 ; --Resultado: hay 4 valores en blanco

---¿CUALES?
SELECT
	t.periodo, 
	t.comunidad, 
	t.turistas 
FROM turistas_comunidad_clean t
WHERE t.turistas = 0 or t.comunidad IS NULL; --MELILLA Y CEUTA!

