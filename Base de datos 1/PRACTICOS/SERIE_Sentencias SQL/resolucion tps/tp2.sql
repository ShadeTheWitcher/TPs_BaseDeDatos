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





