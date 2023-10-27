

--hacer ejemplo de tipos de combinaciones , interseccion, diferencia,

-- interseccion : elementos que coinciden, 2 tablas se necesitan y se usan inner join

--diferencia left consorcio no asignado a conserjes

--diferencia right  ,

--union
--union e interseccion
--




(
  SELECT z.idzona, z.descripcion
  FROM zona z
  LEFT JOIN consorcio c ON z.idzona = c.idzona
  WHERE c.idzona IS NULL
)
UNION
(
  SELECT c.idconsorcio, c.nombre
  FROM consorcio c 
  LEFT JOIN zona z ON c.idzona = z.idzona
  WHERE z.idzona IS NULL
)

(
  SELECT p.idprovincia, p.descripcion
  FROM provincia p
  LEFT JOIN localidad l ON p.idprovincia = l.idprovincia
  WHERE l.idprovincia IS NULL
)
UNION 
(
  SELECT l.idlocalidad, l.descripcion
  FROM localidad l
  LEFT JOIN provincia p ON l.idprovincia = p.idprovincia
  WHERE p.idprovincia IS NULL  
)

--
SELECT c.idconserje, c.apeynom
FROM conserje c
LEFT JOIN consorcio co ON c.idconserje = co.idconserje  
WHERE co.idconserje IS NULL

--
SELECT c.idprovincia, c.idlocalidad, c.idconsorcio, c.nombre
FROM consorcio c
LEFT JOIN localidad l 
  ON c.idprovincia = l.idprovincia
  AND c.idlocalidad = l.idlocalidad
WHERE l.idlocalidad IS NULL


SELECT l.idprovincia, l.idlocalidad, l.descripcion
FROM localidad l
LEFT JOIN consorcio c
  ON l.idprovincia = c.idprovincia
  AND l.idlocalidad = c.idlocalidad  
WHERE c.idconsorcio IS NULL

