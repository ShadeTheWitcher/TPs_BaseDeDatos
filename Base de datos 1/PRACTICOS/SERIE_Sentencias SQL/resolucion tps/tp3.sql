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











--Ejercicio Nº 3