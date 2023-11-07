-- TP2

--Ejercicio 1

select * FROM conserje;

--EJE 2

select idconserje, apeynom FROM conserje;


--eje 3

SELECT 4 + 5 * 3 / 2 - 1; --10 El resultado esperado es 10. La multiplicación y la división se realizan antes de la suma y la resta.

SELECT (4 + 5) * 3 / 2 - 1; -- 12 El resultado esperado es 12. Los paréntesis aseguran que primero se realice la suma y luego se apliquen las otras operaciones.


--eje 4

SELECT 
    gasto AS "Sin formato",
    ROUND(gasto * 1.20, 1) AS "Redondeado a 1 dígito decimal",
    CAST(gasto * 1.20 AS DECIMAL(10, 1)) AS "Truncado a 1 dígito"
FROM gasto;

--eje 5

SELECT descripcion AS "nombre", poblacion
FROM provincia;

-- eje 6

SELECT DISTINCT idprovincia
FROM consorcio;

-- eje 7

select TOP 15 apeynom as "nombre" 
FROM conserje;

-- eje 8
SELECT nombre AS "Nombre", direccion AS "Dirección"
FROM consorcio
WHERE idprovincia = 2;

--eje 9 Escribir y ejecutar una sentencia SELECT que devuelva los consorcios cuyo nombre comience con EDIFICIO-3. Tabla a utilizar: consorcio, columna: nombre
SELECT nombre AS "Nombre", direccion AS "Dirección"
FROM consorcio
WHERE nombre LIKE 'EDIFICIO-3%';

--eje 10
-- Crear una consulta que muestre el nombre y apellido, teléfono y fecha de nacimiento en una
--sola columna, separados por un guión para todos los administradores mujeres (Sexo =F). Poner
--alias “Datos personales” en la primera columna:

SELECT 
    CONCAT(apeynom, ' - ', tel, ' - ', CONVERT(VARCHAR, fechnac, 105)) AS "Datos personales"
FROM administrador -- el 105 es un formato de fecha
WHERE sexo = 'F';

--El estilo 101 es "MM/DD/YYYY".
--El estilo 103 es "DD/MM/YYYY".
--El estilo 105 es "DD-MM-YYYY".
-- 120  "YYYY-MM-DD HH:MI:SS"


--eje 11 Crear una consulta que muestre los gastos cuyos importes estén entre 10,00 y 100,00.
SELECT *
FROM gasto
WHERE importe >= 10.00 AND importe <= 100.00;

--eje 12
SELECT *
FROM administrador
WHERE YEAR(fechnac) >= 1960 AND YEAR(fechnac) <= 1969
ORDER BY fechnac DESC;

--eje 13 
--Crear una consulta que muestre las localidades de las provincias de capital federal 
--y buenos aires (1 y 2), ordenado alfabéticamente dentro de cada provincia.
SELECT *
FROM localidad
WHERE idprovincia = 1 OR idprovincia = 2
ORDER BY idlocalidad ASC;

--otra forma donde si lo ordena como la foto

SELECT *
FROM localidad
WHERE idprovincia IN (1,2)
ORDER BY idprovincia 

--eje 14
-- Crear una consulta que muestre los datos de los consorcios cuya dirección contenga la letra ‘N’
--en la Posición 5.
SELECT *
FROM consorcio
WHERE SUBSTRING(direccion, 5, 1) = 'N';

--EJE 15 
--Crear una consulta para mostrar los 697 gastos más costosos
SELECT TOP 697 idprovincia, idlocalidad, idgasto, periodo, fechapago, idtipogasto, importe WITH TIES
FROM gasto
ORDER BY importe DESC;
 
-- el whit ties va después del top   Msg 319, Level 15, State 1, Line 145



-- codigo profe
SELECT TOP 10 WITH TIES idprovincia, idlocalidad
FROM gasto
ORDER BY idprovincia, idlocalidad DESC;

 -- codigo profe clase

SELECT TOP 10 idprovincia, idlocalidad

FROM gasto

 

ORDER BY idprovincia, idlocalidad DESC;

--


--eje 16 Sobre la consulta anterior mostrar los importes repetidos.

SELECT TOP 697 WITH TIES *
FROM gasto
ORDER BY importe DESC;

--ej 17
SELECT idgasto, idprovincia, idlocalidad, idconsorcio, periodo, fechapago, idtipogasto,
       CASE
           WHEN importe < 10000 THEN importe * 1.15
           WHEN importe BETWEEN 10000 AND 20000 THEN importe * 1.10
           ELSE importe * 1.05
       END AS importe_con_incremento
FROM gasto
ORDER BY importe_con_incremento DESC;


--ej 18 Informar la cantidad de administradores masculinos y femeninos (sexo = ‘M’ y sexo = ‘F’)

-- COUNT se utiliza para contar registros, no para evaluar condiciones.
SELECT 
    SUM(CASE WHEN sexo = 'M' THEN 1 ELSE 0 END) AS Masculino,
    SUM(CASE WHEN sexo = 'F' THEN 1 ELSE 0 END) AS Femenino
FROM administrador;

--Utilizamos la función SUM junto con una expresión condicional para contar los administradores masculinos y femeninos por separado.
--La expresión CASE evalúa si la columna "sexo" es igual a 'M' o 'F' y, en función de esa evaluación, suma 1 si se cumple la condición o 0 si no se cumple.



--eje 19 Informar la suma total de gastos, la cantidad de gastos y el promedio del mismo. Utilizar Sum,Count y Avg
SELECT
    SUM(importe) AS "Suma Total de Gastos",
    COUNT(idgasto) AS "Cantidad de Gastos",
    AVG(importe) AS "Promedio de Gastos"
FROM gasto;

--Utilizamos la función SUM(importe) para calcular la suma total de los importes de gastos.
--Utilizamos la función COUNT(idgasto) para contar la cantidad de registros de gastos.
--Utilizamos la función AVG(importe) para calcular el promedio de los importes de gastos.

--eje 20
-- a) Mostrar el importe total acumulado de gasto por tipo de gasto
SELECT idtipogasto AS "ID Tipo de Gasto", SUM(importe) AS "Importe Total Acumulado"
FROM gasto
GROUP BY idtipogasto

--b) Sobre la consulta anterior, listar solo aquellos gastos cuyos importes sean superior a
--2.000.000.
SELECT idtipogasto AS "ID Tipo de Gasto", SUM(importe) AS "Importe Total Acumulado"
FROM gasto
GROUP BY idtipogasto
HAVING SUM(importe) > 2000000;

--c) Listar solamente los dos (2) tipos de gastos con menor importe acumulado.
SELECT TOP 2 idtipogasto AS "ID Tipo de Gasto", SUM(importe) AS "Importe Total Acumulado"
FROM gasto
GROUP BY idtipogasto
ORDER BY SUM(importe) ASC;

--eje 21 Mostrar por cada tipo de gasto, el importe del mayor gasto realizado.
SELECT
    idtipogasto AS "ID Tipo de Gasto",
    MAX(importe) AS "Mayor Gasto Realizado"
FROM
    gasto
GROUP BY
    idtipogasto;

--otr forma usando 2 tablas
SELECT 
    tg.idtipogasto AS "ID Tipo de Gasto",
    tg.descripcion AS "Descripción Tipo de Gasto",
    (SELECT MAX(importe) FROM gasto WHERE idtipogasto = tg.idtipogasto) AS "Mayor Gasto Realizado"
FROM
    tipogasto AS tg;


-- otra forma de hacer el 21 usando 2 tablas
SELECT
    tg.idtipogasto AS "ID Tipo de Gasto",
    tg.descripcion AS "Descripción Tipo de Gasto",
    (SELECT MAX(g.importe)
     FROM gasto AS g
     WHERE g.idtipogasto = tg.idtipogasto) AS "Mayor Gasto Realizado"
FROM tipogasto AS tg;

--eje 22 Mostrar el promedio de gasto por tipo de gasto, solo para aquellos pertenecientes al 1er
--semestre (períod del 1 al 6).

SELECT
    idtipogasto AS "ID Tipo de Gasto",
    AVG(importe) AS "Promedio de Gasto"
FROM
    gasto
WHERE
    DATEPART(MONTH, fechapago) BETWEEN 1 AND 6
GROUP BY
    idtipogasto;


--forma mas detallada de mostrar
SELECT
    tg.idtipogasto AS "ID Tipo de Gasto",
    tg.descripcion AS "Descripción Tipo de Gasto",
    AVG(g.importe) AS "Promedio de Gasto"
FROM
    tipogasto AS tg
JOIN
    gasto AS g ON tg.idtipogasto = g.idtipogasto
WHERE
    DATEPART(MONTH, g.fechapago) BETWEEN 1 AND 6
GROUP BY
    tg.idtipogasto, tg.descripcion;

--eje 23  Mostrar la cantidad de consorcios concentrados por zonas. Solo para las zonas 2 (NORTE), 
-- 3(SUR) y 4 (ESTE).

SELECT 
    c.idzona AS "ID Zona",
    COUNT(c.idconsorcio) AS "Cantidad de Consorcios por Zona"
FROM 
    consorcio AS c
WHERE 
    c.idzona IN (2, 3, 4)
GROUP BY  -- si o si se necesita group by cuando se usa un count
    c.idzona;

-- eje 24  Mostrar la cantidad de consorcios existentes por localidad. Visualizar la lista en forma
--descendente por cantidad.


-- no funciona
SELECT 
    c.idprovincia AS "ID provincia", 
    c.idlocalidad as "id localidad"
    COUNT(c.idconsorcio) AS "Cantidad de Consorcios por localidad"
FROM 
    consorcio AS c

GROUP BY DESC --se debe usar un order by

-- forma correcta
SELECT 
    c.idprovincia AS "ID Provincia",
    c.idlocalidad AS "ID Localidad",
    COUNT(c.idconsorcio) AS "Cantidad de Consorcios por Localidad"
FROM 
    consorcio AS c
GROUP BY 
    c.idprovincia, c.idlocalidad
ORDER BY 
    "Cantidad de Consorcios por Localidad" DESC;
    

-- eje 25 Mostrar la cantidad de conserjes agrupados por estado civil y edad. Mostrar un listado
--ordenado.
select
    c.estciv as "estado civil",
    DATEDIFF(YEAR, c.fechnac, GETDATE()) AS "Edad",
    COUNT(*) AS "Cantidad de Conserjes"
from 
    conserje as c
    group by
        c.estciv, DATEDIFF(YEAR, c.fechnac, GETDATE())
    order by 
    "Edad" DESC, c.estciv;

--eje 26 Mostrar el importe total acumulado de gasto por tipo de gasto. Mostrar las descripciones de
--cada tipo de gasto de la tabla tipogasto.

SELECT
    tg.descripcion AS "Descripción Tipo de Gasto",
    SUM(g.importe) AS "Importe Total Acumulado"
FROM
    tipogasto AS tg
JOIN
    gasto AS g ON tg.idtipogasto = g.idtipogasto
GROUP BY
    tg.descripcion;


--eje 27 Mostrar los nombres de todos los consorcios y en que provincia y localidad esta cada uno.
--Ordenados por Provincia, localidad y consorcio

select 
    c.nombre as "nombre Consorcio",
    l.descripcion as "localidad",
    p.descripcion as "provincia"
from consorcio as c
JOIN
    localidad as l on c.idlocalidad = l.idlocalidad
JOIN provincia as p on c.idprovincia =  p.idprovincia
--group BY
--    c.idconsorcio p.idprovincia, l.idlocalidad  --NO HACE FALTA
order BY
    p.descripcion, l.descripcion, c.nombre;
--Utilizamos la cláusula ORDER BY para ordenar los resultados por "Provincia", "Localidad" y "Nombre Consorcio" en ese orden.

--No es necesario usar la cláusula GROUP BY en este caso, ya que simplemente deseas listar los nombres de los consorcios 
--junto con la provincia y localidad correspondientes.





-- eje 28 Mostrar los 10 (diez) consorcios donde se registraron mayores gastos y a qué provincia
--pertenecen.

select top 10
    c.nombre as "Consorcio",
    p.descripcion as "Provincia",
    sum(g.importe) as "Total Gastos"
FROM consorcio as c 
JOIN 
    provincia as p on c.idprovincia =  p.idprovincia
JOIN 
    gasto AS g ON c.idconsorcio = g.idconsorcio --esta incompleto porq la clave tiene mas de 1 atributo entonces es inconsistente los resultados

GROUP BY
    c.nombre, p.descripcion
ORDER BY
    "Total Gastos" DESC;



-- otra forma

SELECT TOP 10

    C.nombre AS NombreConsorcio,

    P.descripcion AS Provincia,

    SUM(G.importe) AS TotalGasto

FROM consorcio C

INNER JOIN provincia P ON C.idprovincia = P.idprovincia -- inner join se usa si o si cuando hay mas de 1 relacion

INNER JOIN gasto G ON C.idprovincia = G.idprovincia

    AND C.idlocalidad = G.idlocalidad

    AND C.idconsorcio = G.idconsorcio

GROUP BY C.nombre, P.descripcion

ORDER BY TotalGasto DESC;



--eje 29 Mostrar todas las provincias registradas. Para las que tengan consorcios mostrar a qué
--localidad pertenecen. Todos con sus nombres respectivos. Ordene los resultados por Provincia,
--localidad y consorcio.
--Cuál es la provincia que no tiene consorcio asignado?

SELECT
    p.descripcion AS "Provincia",
    l.descripcion AS "Localidad",
    c.nombre AS "Consorcio"
FROM
    provincia AS p
LEFT JOIN
    localidad AS l ON p.idprovincia = l.idprovincia
LEFT JOIN
    consorcio AS c ON l.idprovincia = c.idprovincia AND l.idlocalidad = c.idlocalidad
ORDER BY
    "Provincia", "Localidad", "Consorcio"
--Utilizamos una unión izquierda (LEFT JOIN) para unir las tablas provincia, localidad y consorcio. 
--Esto garantiza que todas las provincias se incluyan en el resultado, incluso si no tienen consorcios asociados.





--Mostrar provincia Con consorcio

--cant: 83

SELECT   

   Provincia =  p.descripcion  ,

   Localidad = l.descripcion ,

   Consorcio = CON.nombre 

FROM [dbo].[consorcio] CON

	INNER JOIN [dbo].[localidad] L

	ON CON.idprovincia = L.idlocalidad

	AND CON.idprovincia = L.idprovincia

	INNER JOIN [dbo].[provincia] P

	ON L.idprovincia = p.idprovincia

	ORDER BY p.descripcion, l.descripcion, CON.nombre;

 
--codigo compañero
--Mostrar provincia (aunque no tengan) Con consorcio

--cant: 100

SELECT   

   Provincia =  p.descripcion  ,

   Localidad = l.descripcion ,

   Consorcio = CON.nombre 

FROM [dbo].[consorcio] CON

	LEFT JOIN [dbo].[localidad] L

	ON CON.idprovincia = L.idlocalidad

	AND CON.idprovincia = L.idprovincia

	LEFT JOIN [dbo].[provincia] P

	ON L.idprovincia = p.idprovincia

	ORDER BY p.descripcion, l.descripcion, CON.nombre;


--otro compañero
SELECT p.descripcion AS Provincia,

	l.descripcion AS Localidad,

	c.nombre AS Consorcio

FROM provincia AS p

LEFT JOIN consorcio AS c

ON c.idprovincia = p.idprovincia

LEFT JOIN localidad AS l

ON c.idprovincia = l.idprovincia AND c.idlocalidad = l.idlocalidad

ORDER BY p.descripcion, l.descripcion, c.nombre;

--otro 

SELECT p.descripcion AS Provincia,

	l.descripcion AS Localidad,

	c.nombre AS Consorcio

FROM provincia AS p

LEFT JOIN consorcio AS c

ON c.idprovincia = p.idprovincia

LEFT JOIN localidad AS l

ON c.idprovincia = l.idprovincia AND c.idlocalidad = l.idlocalidad

ORDER BY p.descripcion, l.descripcion, c.nombre;


--otro

SELECT *

FROM provincia P

LEFT JOIN consorcio C 

ON P.idprovincia = C.idprovincia

WHERE C.idprovincia IS NULL


--con subconsulta

select * from provincia p

where p.idprovincia not in (

    select distinct c.idprovincia 
    from consorcio c

)


-- otro sub
SELECT p.descripcion AS Provincia

FROM provincia p

WHERE NOT EXISTS ( --donde no exista una provincia con consorcio

    SELECT 1 --en vez de 1 se pone NULL

    FROM consorcio c

    WHERE c.idprovincia = p.idprovincia

);


--Eje 30 Mostrar los nombres de todos los conserjes. Para los que están asignados a algún consorcio
--mostrar también ese nombre. Ordene por apellido y nombre.







--Sabiendo que un conserje no puede estar asignado a más de un consorcio, como puede
--verificar que la cantidad de registros devuelta por la consulta sea la correcta y cuál es esa
--cantidad?





--EJERCICIO 31 Inserte un registro en la tabla consorcio con los siguientes valores:
--Idprovincia=1
--Idlocalidad =1
--Idconsorcio =3
--Nombre ='EDIFICIO-113'
--Direccion ='PARAGUAY Nº 630'
--Idzona = 5
--Idconserje = null
--Idadmin = null
--Mostrar los consorcios registrados, tengan o no tengan conserjes asignados.





