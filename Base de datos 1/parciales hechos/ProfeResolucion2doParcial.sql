--------------------
--EJERCICIO 1 ------
--------------------
--Mostrar todos los consorcios (solo sus nombres) y todos los inmuebles (solo su ID).
--Organizando primero los consorcios sin inmuebles asignados, luego los inmuebles sin 
--consorcios y después el resto.

SELECT c.nombre, i.idinmueble
FROM inmueble i
FULL OUTER JOIN consorcio c ON c.idconsorcio = i.idconsorcio 
AND i.idprovincia = c.idprovincia 
AND i.idlocalidad = c.idlocalidad
ORDER BY i.idconsorcio, i.idlocalidad, i.idinmueble, i.idprovincia;

--------------------
--EJERCICIO 2 ------
--------------------
--Usando subconsulta, mostrar todos los consorcios que no tienen inmuebles asignados.

SELECT nombre AS 'Nombre'
FROM consorcio c
WHERE NOT EXISTS (SELECT NULL FROM inmueble i
                  WHERE i.idprovincia = c.idprovincia 
                  AND i.idlocalidad = c.idlocalidad 
                  AND c.idconsorcio = i.idconsorcio);
--------------------
--EJERCICIO 3 ------
--------------------
--Mostrar en una sola línea la cantidad de Departamentos/inmuebles con 1, 2, 3 y 4 o más
--pisos que estén asignados a algún consorcio. 
-- Respetando  el siguiente formato:
--Cantidad						UnPiso	dosPisos	TresPisos	Masdetrespisos
--Cantidad inmuebles por piso  	0			0			0			0


SELECT 'Cantidad inmuebles por piso ' AS 'Cantidad',
       SUM(CASE WHEN aux.cant = 1 THEN 1 ELSE 0 END) AS UnPiso,
       SUM(CASE WHEN aux.cant = 2 THEN 1 ELSE 0 END) AS dosPisos,
       SUM(CASE WHEN aux.cant = 3 THEN 1 ELSE 0 END) AS TresPisos,
       SUM(CASE WHEN aux.cant > 3 THEN 1 ELSE 0 END) AS Masdetrespisos
FROM
    (SELECT i.idconsorcio, i.idlocalidad, i.idprovincia, COUNT(DISTINCT i.nro_piso) Cant
     FROM inmueble i
     INNER JOIN consorcio c ON c.idconsorcio = i.idconsorcio 
                            AND i.idprovincia = c.idprovincia 
                            AND i.idlocalidad = c.idlocalidad
     GROUP BY i.idconsorcio, i.idlocalidad, i.idprovincia) aux;


