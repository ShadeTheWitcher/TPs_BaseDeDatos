-- Lovato Matias Sebastian LU:56499 dni: 44574243 
--COMISION 2
--SQL Server 2022  


--Ejercicio 1
--Mostrar todos los consorcios (solo sus nombres) y todos los inmuebles (solo su ID).
--Organizando primero los consorcios sin inmuebles asignados, luego los inmuebles sin
--consorcios y después el resto.


select c.nombre AS Consorcio, NULL AS id_Inmueble --consorcio sin inmuebles
FROM consorcio c
WHERE NOT EXISTS (
    SELECT 1
    FROM inmueble i
    WHERE c.idprovincia = i.idprovincia
      AND c.idlocalidad = i.idlocalidad
      AND c.idconsorcio = i.idconsorcio
)

UNION ALL


SELECT NULL AS Consorcio, i.idinmueble AS id_Inmueble -- Inmuebles sin consorcios
FROM inmueble i
WHERE i.idconsorcio IS NULL

UNION ALL

-- demas consorcios
SELECT c.nombre AS Consorcio, i.idinmueble AS id_Inmueble
FROM consorcio c
JOIN inmueble i ON c.idprovincia = i.idprovincia
                AND c.idlocalidad = i.idlocalidad
                AND c.idconsorcio = i.idconsorcio;



--Ejercicio 2
--Usando subconsulta, mostrar todos los consorcios que no tienen inmuebles asignados.


select c.nombre 
FROM consorcio c
WHERE NOT EXISTS ( --busca los consorcios que no esten en inmueble
  SELECT 1
  FROM inmueble i
  WHERE c.idconsorcio = i.idconsorcio  -- compara la clave compuesta
                AND c.idlocalidad = i.idlocalidad
                AND c.idconsorcio = i.idconsorcio
)



--Ejercicio 3
--Mostrar en una sola línea la cantidad de Departamentos/inmuebles con 1, 2, 3 y 4 o más
--pisos que estén asignados a algún consorcio.
--Respetando el siguiente formato:

--Cantidad                   UnPiso  dosPisos  TresPisos Masdetrespisos
--Cantidad inmuebles x piso     0        0       0            0

select 
    'Cantidad inmuebles x piso' AS Cantidad,
    -- suma 1 si el nro de pisos coincide con el buscado 
    SUM(CASE WHEN i.nro_piso = 1 AND i.idconsorcio IS NOT NULL THEN 1 ELSE 0 END) AS UnPiso, 
    SUM(CASE WHEN i.nro_piso = 2 AND i.idconsorcio IS NOT NULL THEN 1 ELSE 0 END) AS DosPisos,
    SUM(CASE WHEN i.nro_piso = 3 AND i.idconsorcio IS NOT NULL THEN 1 ELSE 0 END) AS TresPisos,
    SUM(CASE WHEN i.nro_piso >= 4 AND i.idconsorcio IS NOT NULL THEN 1 ELSE 0 END) AS MasDeTresPisos 
    -- se valida tambien que tenga un consorcio asignado con "is not null"
FROM inmueble as i;

