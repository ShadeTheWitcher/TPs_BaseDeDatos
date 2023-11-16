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

--s

select p.descripcion as provincia, l.descripcion as localidad, c.nombre as consorcio, c.direccion, z.descripcion as zona
from consorcio
inner join localidad l on c.idprovincia = l.idprovincia and c.idlocalidad = l.idlocalidad
inner join provincia p on c.idprovincia = p.idprovincia
inner join zona z on c.idzona = z.idzona
where c.idzona in (
    select top 2 idzona
    from consorcio
    group by idzona
    order by count(*) desc
)


--Ejercicio Nº 2
--Seleccionar los consorcios que pertenezcan a la provincia con mayor número de habitantes, y
--mostrar los datos de los conserjes mayores a 50 años (ordenados de mayor a menor por edad)
--que no estén asignados a estos consorcios.

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


--sin with
SELECT c.idprovincia, c.idlocalidad, c.nombre AS nombre_consorcio, c.direccion, c.idzona,
       con.idconserje, con.apeynom AS nombre_conserje, con.fechnac
FROM consorcio AS c
LEFT JOIN conserje AS con ON c.idconserje = con.idconserje
WHERE 
    c.idprovincia = (SELECT TOP 1 idprovincia FROM consorcio GROUP BY idprovincia ORDER BY SUM(idprovincia) DESC) AND
    (DATEDIFF(YEAR, con.fechnac, GETDATE()) > 50 OR con.idconserje IS NULL)
ORDER BY c.idprovincia, c.idlocalidad, nombre_consorcio, c.direccion, c.idzona, con.fechnac DESC;




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
SELECT COUNT(DISTINCT c.idconsorcio) AS cantidad_consorcios -- distinct elimina duplicados
FROM consorcio AS c
INNER JOIN gasto AS g ON c.idprovincia = g.idprovincia AND c.idlocalidad = g.idlocalidad AND c.idconsorcio = g.idconsorcio;

-- Ejercicio Nº 7 con subconsulta
SELECT COUNT(DISTINCT idconsorcio) AS cantidad_consorcios
FROM consorcio
WHERE idconsorcio IN (
    SELECT DISTINCT g.idconsorcio
    FROM gasto g
    WHERE consorcio.idprovincia = g.idprovincia
    AND consorcio.idlocalidad = g.idlocalidad
    AND consorcio.idconsorcio = g.idconsorcio
);




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

--Ejercicio Nº 10
--Mostrar los datos del administrador correspondiente al consorcio que tenga menor
--gasto acumulado en el año (2015) en concepto de 'servicios'

select c.idadmin, a.apeynom as nombre_administrador
from consorcio as c
inner join administrador as a on c.idadmin = a.idadmin
where c.idadmin in (
    select top 1 idconsorcio
    from gasto
    where year(fechapago) = 2015
        and idtipogasto = (select idtipogasto FROM tipogasto where descripcion = 'Servicios')
        group by idconsorcio
        order by sum(importe)
);




--Ejercicio Nº 11
--Calcular el promedio de gasto anual (año 2015) por consorcio en concepto de
--'sueldos', y mostrar los consorcios que superen ese monto en este ítem de gasto en el
--mismo año.

select c.idconsorcio, c.nombre as consorcio, sum(g.importe) as gasto total
from consorcio as c
left join gasto as g on c.Idconsorcio = g.Idconsorcio
where 
    select 


--solucion 1
SELECT c.idconsorcio, c.nombre AS nombre_consorcio
FROM consorcio AS c
WHERE (
    SELECT SUM(importe)
    FROM gasto
    WHERE YEAR(fechapago) = 2015
      AND idtipogasto = (SELECT idtipogasto FROM tipogasto WHERE descripcion = 'sueldos')
      AND idconsorcio = c.idconsorcio
    ) > (
    SELECT AVG(importe)
    FROM gasto
    WHERE YEAR(fechapago) = 2015
      AND idtipogasto = (SELECT idtipogasto FROM tipogasto WHERE descripcion = 'sueldos')
    );




--Ejercicio complementario
--Generar un listado de todos los consorcios (una fila por consorcio), con el gasto total acumulado (histórico), y el año con mayor gasto anual registrado.

-------------------------------------------------------------------------------------------
--Nombre Consorcio | Total Gasto Acumulado | Año con mayor gasto  
-------------------------------------------------------------------------------------------
--Es IMPORTANTE, que junto a la propuesta de resolución, incluyan consultas que demuestren o validen el resultado logrado.

	SELECT
   -- c.idprovincia,
    --c.idlocalidad,
    --c.idconsorcio,
    c.nombre AS "Nombre Consorcio",
    COALESCE(SUM(g.importe), 0) AS "Total Gasto Acumulado", --Coalesece devuelve 0 si el consorcio tiene un gasto  null para no afectar la suma
    (
        SELECT TOP 1 YEAR(fechapago) AS YearConMaxGasto
        FROM gasto
        WHERE
            idprovincia = c.idprovincia
            AND idlocalidad = c.idlocalidad
            AND idconsorcio = c.idconsorcio
        GROUP BY YEAR(fechapago)
        ORDER BY SUM(importe) DESC
    ) AS "Año con Mayor Gasto"
FROM
    consorcio c
LEFT JOIN
    gasto g ON c.idprovincia = g.idprovincia
               AND c.idlocalidad = g.idlocalidad
               AND c.idconsorcio = g.idconsorcio
GROUP BY
    c.idprovincia, c.idlocalidad, c.idconsorcio, c.nombre;


--sin coalesce funciona igual porq no hay nulos en gasto.importe

	SELECT
   -- c.idprovincia,
    --c.idlocalidad,
    --c.idconsorcio,
    c.nombre AS "Nombre Consorcio",
    SUM(g.importe) AS "Total Gasto Acumulado", 
    (
        SELECT TOP 1 YEAR(fechapago) AS YearConMaxGasto
        FROM gasto
        WHERE
            idprovincia = c.idprovincia
            AND idlocalidad = c.idlocalidad
            AND idconsorcio = c.idconsorcio
        GROUP BY YEAR(fechapago)
        ORDER BY SUM(importe) DESC
    ) AS "Año con Mayor Gasto"
FROM
    consorcio c
LEFT JOIN
    gasto g ON c.idprovincia = g.idprovincia
               AND c.idlocalidad = g.idlocalidad
               AND c.idconsorcio = g.idconsorcio
GROUP BY
    c.idprovincia, c.idlocalidad, c.idconsorcio, c.nombre;