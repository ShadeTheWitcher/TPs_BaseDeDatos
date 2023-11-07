--Ejercicio Nº 1: Mostrar los datos de los consorcios (provincia, localidad, nombres, dirección y zona) que
--pertenezcan a las dos zonas con mayor cantidad de consorcios.
SELECT p.descripcion AS provincia, l.descripcion AS localidad, c.nombre, c.direccion, z.descripcion AS zona
FROM consorcio c
INNER JOIN localidad l ON c.idprovincia = l.idprovincia AND c.idlocalidad = l.idlocalidad
INNER JOIN provincia p ON c.idprovincia = p.idprovincia
INNER JOIN zona z ON c.idzona = z.idzona
WHERE c.idzona IN (
    SELECT TOP 2 idzona
    FROM consorcio
    GROUP BY idzona
    ORDER BY COUNT(*) DESC
);

--Ejercicio Nº 2
--Seleccionar los consorcios que pertenezcan a la provincia con mayor número de habitantes, y
--mostrar los datos de los conserjes mayores a 50 años (ordenados de mayor a menor por edad)
--que no estén asignados a estos consorcios.

WITH ProvinciaMaxPoblacion AS (
    SELECT TOP 1 c.idprovincia
    FROM consorcio AS c
    INNER JOIN provincia AS p ON c.idprovincia = p.idprovincia
    GROUP BY c.idprovincia
    ORDER BY SUM(p.poblacion) DESC
)

SELECT c.idprovincia, c.idlocalidad, c.nombre AS nombre_consorcio, c.direccion, c.idzona,
       con.idconserje, con.apeynom AS nombre_conserje, con.fechnac
FROM consorcio AS c
INNER JOIN ProvinciaMaxPoblacion AS pmp ON c.idprovincia = pmp.idprovincia
LEFT JOIN conserje AS con ON c.idconserje = con.idconserje
WHERE (DATEDIFF(YEAR, con.fechnac, GETDATE()) > 50 OR con.idconserje IS NULL)
ORDER BY c.idprovincia, c.idlocalidad, nombre_consorcio, c.direccion, c.idzona, con.fechnac DESC;



WITH ProvinciaMaxPoblacion AS (
    SELECT TOP 1 WITH TIES c.idprovincia
    FROM consorcio AS c
    INNER JOIN provincia AS p ON c.idprovincia = p.idprovincia
    GROUP BY c.idprovincia, p.descripcion
    ORDER BY SUM(p.poblacion) DESC
)

SELECT c.idprovincia, c.idlocalidad, c.nombre AS nombre_consorcio, c.direccion, c.idzona, co.apeynom AS nombre_conserje, co.fechnac AS fecha_nacimiento_conserje
FROM consorcio AS c
INNER JOIN ProvinciaMaxPoblacion AS pmp ON c.idprovincia = pmp.idprovincia
LEFT JOIN conserje AS co ON c.idconserje = co.idconserje
WHERE (DATEDIFF(YEAR, co.fechnac, GETDATE()) > 50) AND co.idconserje IS NULL
ORDER BY c.idprovincia, c.idlocalidad, nombre_consorcio, c.direccion, c.idzona, co.fechnac DESC;


--Ejercicio Nº 3
--Mostrar todos los tipos de gastos, y sus respectivas descripciones, que no fueron registrados en
--toda la provincia de Buenos Aires para el mes de febrero del año 2015.
SELECT tg.idtipogasto, tg.descripcion AS descripcion_tipogasto
FROM tipogasto AS tg
WHERE tg.idtipogasto NOT IN (
    SELECT DISTINCT g.idtipogasto
    FROM gasto AS g
    INNER JOIN consorcio AS c ON g.idprovincia = c.idprovincia
    WHERE g.periodo = 201502
    AND c.idprovincia = 2
);


SELECT tg.idtipogasto, tg.descripcion AS descripcion_tipogasto
FROM tipogasto AS tg
WHERE tg.idtipogasto NOT IN (
    SELECT DISTINCT tg.idtipogasto
    FROM tipogasto AS tg
    LEFT JOIN gasto AS g ON tg.idtipogasto = g.idtipogasto
    LEFT JOIN consorcio AS c ON g.idprovincia = c.idprovincia
    WHERE g.periodo = 201502
    AND c.idprovincia = 2
);



--Ejercicio Nº 5
--Mostrar los nombres, en el caso que existan, de las provincias que no tengan localidades
--cargadas. Verificar el resultado por medio de otras consultas.
SELECT p.idprovincia, p.descripcion AS nombre_provincia
FROM provincia AS p
WHERE NOT EXISTS (
    SELECT 1
    FROM localidad AS l
    WHERE l.idprovincia = p.idprovincia
);

--Ejercicio Nº 6:
--Agregar un nuevo tipo de gasto y mostrar en el listado final los tipos de gastos que no se registraron en la tabla de gastos.
INSERT INTO tipogasto (idtipogasto, descripcion) VALUES (99, 'Nuevo Tipo de Gasto');

SELECT tg.idtipogasto, tg.descripcion AS descripcion_tipogasto
FROM tipogasto AS tg
LEFT JOIN gasto AS g ON tg.idtipogasto = g.idtipogasto --se usa left porq tipogasto es fk de gasto (tipogasto es tabla principal)
WHERE g.idgasto IS NULL;

--Ejercicio Nº 7
--Mostrar en un solo registro, la cantidad de consorcios que realizaron al menos un
--gasto (variante con combinaciones y con subconsulta)
SELECT COUNT(DISTINCT c.idconsorcio) AS cantidad_consorcios
FROM consorcio AS c
INNER JOIN gasto AS g ON c.idprovincia = g.idprovincia AND c.idlocalidad = g.idlocalidad AND c.idconsorcio = g.idconsorcio;

--Ejercicio Nº 8
--Mostrar los administradores que no están asignados a ningún consorcio (variante con
--combinaciones y con subconsulta)
SELECT a.idadmin, a.apeynom AS nombre_administrador
FROM administrador AS a
LEFT JOIN consorcio AS c ON a.idadmin = c.idadmin
WHERE c.idconsorcio IS NULL;


SELECT a.*
FROM administrador AS a
LEFT JOIN consorcio AS c ON a.idadmin = c.idadmin
WHERE c.idadmin IS NULL;


SELECT * 
FROM administrador AS a
WHERE a.idadmin NOT IN ( --subconsulta
    SELECT idadmin
    FROM consorcio
);

--Ejercicio Nº 9
--Mostrar los administradores con consorcios que estén por debajo del promedio de
--edad solo de los administradores asignados a estos consorcios.
SELECT a.*
FROM administrador AS a
WHERE a.edad < (
    SELECT AVG(a2.edad)
    FROM administrador AS a2
    WHERE a2.idadmin IN (
        SELECT idadmin
        FROM consorcio
    )
);

