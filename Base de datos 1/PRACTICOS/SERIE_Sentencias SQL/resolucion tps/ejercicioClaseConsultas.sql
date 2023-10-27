
--listar por edad conserjes
SELECT (YEAR(GETDATE()) - YEAR(fechnac)) AS 'Edad', COUNT (YEAR(GETDATE()) - YEAR(fechnac)) AS 'Edad' --esta mal porq no cuenta 

FROM conserje

GROUP BY conserje.fechnac;








select DATEDIFF(YEAR,fechnac,GETDATE()) as Edad,

	   count(*) as Cantidad

 from conserje

group by DATEDIFF(YEAR,fechnac,GETDATE())

order by Edad;











--EDAD MAYOR A 40


select DATEDIFF(YEAR, fechnac , GETDATE()) as edad,
            count(*) as cantidad
    from conserje 
    where DATEDIFF(YEAR, fechnac, GETDATE())  > 40 -- si sacamos esta linea muestra todas las edad y con esto muestra los mayores de 40
    GROUP by DATEDIFF(YEAR, fechnac, GETDATE()) 
    ORDER by edad;





--que 8 pereonas tengan la edad


select DATEDIFF(YEAR, fechnac , GETDATE()) as edad,
            count(*) as cantidad
    from conserje 
    --where DATEDIFF(YEAR, fechnac, GETDATE())  > 40 -- si sacamos esta linea muestra todas las edad y con esto muestra los mayores de 40
    GROUP by DATEDIFF(YEAR, fechnac, GETDATE()) 
    having count(*) > 8 -- having permite filtrar sobre las nuevas columnas filtradas a travez del agrupamiento
    ORDER by edad;



--otra solucion q no funciona porque wheare no los tiene agrupados aun para contarlos
--porque en el where todavía se están recorriendo cada registro y en ese momento todavía no se sabe cuántos hay de cada grupo
-- where solo se aplica sobre una columna o una funcion sobre la columna, siempre afecta sobre 
-- having permite filtrar sobre las nuevas columnas filtradas a travez del agrupamiento
select DATEDIFF(YEAR,fechnac,GETDATE()) as Edad,

	   count(*) as Cantidad

 from conserje WHERE COUNT(*) > 8

group by DATEDIFF(YEAR,fechnac,GETDATE())

order by Edad;


-- otro ejercicio

select *
from consrocio c --la c es un alias
INNER JOIN administrador a ON c.idadmin = a.idadmin;    -- alias "a" en admin

--
select c.nombre 'Consorcio', a.apeynom 'Administrador'
from consrocio c --la c es un alias
INNER JOIN administrador a ON c.idadmin = a.idadmin;    -- alias "a" en admin