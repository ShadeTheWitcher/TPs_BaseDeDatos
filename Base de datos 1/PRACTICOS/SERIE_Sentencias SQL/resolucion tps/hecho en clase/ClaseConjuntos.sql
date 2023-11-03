

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

--full join no es lo mismo que UNION  

--inner join muestra lo que contiene asociado  A/B

--inclusion A c B  

--left vamos a tener resultados y right no vamos a tener resultados

--importante para tener en cuenta el uso de right/left, 
--left esta a la izq, conjunto que esta a la izq
--right esta  ala dercha, conj q esta a la derecha

--inner join y un right/left join es un union e interseccion

--inclusion   acepta null, elementos de A que no esten en B. PEro si puede haber elementos de B q esten en A
-- la inclusion es un inner join pero cuando es estricto
-- si no es estricto es una interseccion el inner

--outer es todo lo que esta donde  , inner  diferencia entre outer y inner

SELECT * --no recomendado
  FROM  consorcio as c, administrador as a
  where c.idadmin - a.idadmin  --es lo mismo que un inner join pero no standarizado y no es recomendable mezcla todo


--listado de personal de consorcio 1 sola consulta, nombre de la persona, fechanac, rol que tiene(admin, conserje)
select
    a.apeynom , a.fechnac, 'administrador' as rol
    from administrador as a
union
select c.apeynom, c.fechnac, 'Conserje' as rol  
    from conserje as c

    --no es recomendable el union porq ocupa muchos recursos y aveces no considera algunas 

--buscar diferencia entre union y union old

--inion(? union) fuerza el ordenamiento , es mejor dejarlo para el programador

--eje 29 entregar

--variante con combinaciones y con subconsulta, hacer ambas y comparar cuanto consume cada forma