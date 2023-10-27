--1)todos los datos
select *from conserje;

--2)determinados datos
select idconserje,apeynom from conserje;

--3)Calcular Suma
select 4 + 5 * 3 / 2 - 1 AS Resultado1, (4 + 5) * 3 / 2 - 1 AS Resultado2;


--4)Mostrar Datos de Gastos Edificios
select *from gasto;

select 
 importe AS "Sin Formato",
 Round (importe *0.20,1) AS "Redondeado a 1 dígito decimal",
 Cast (importe * 0.20 AS DECIMAL(9,1)) AS "Truncado a 1 dígito"
 from gasto;

--5)Listar el nombre (descripcion) y la población (poblacion) de cada Provincia.
 select descripcion,poblacion from provincia;

 --6)Listar sin repetir, todos los códigos de provincia de la tabla “consorcio”. Usar Clausula DISTINCT
 select distinct idprovincia from consorcio;

 --7)Listar los 15 primeros conserjes de la respectiva tabla. Usar cláusula TOP
 select top 15 *from conserje;

 --8)Crear una consulta que muestre el Nombre y la dirección de los consorcios de la provincia de “Buenos Aires”. Tabla a utilizar: consorcio y idprovincia = 2	 select nombre,direccion from consorcio	 where idprovincia=2;--9)Escribir y ejecutar una sentencia SELECT que devuelva los consorcios cuyo nombre comience con EDIFICIO-3. Tabla a utilizar: consorcio, columna: nombreselect nombre,direccion from consorciowhere nombre like 'EDIFICIO-3%';/*10)Crear una consulta que muestre el nombre y apellido, teléfono y fecha de nacimiento en una 
sola columna, separados por un guión para todos los administradores mujeres (Sexo =F). Poner 
alias “Datos personales” en la primera columna:*/

select CONCAT (apeynom,' - ',tel,' - ',fechnac) As 'Datos Personales' from administrador
where sexo='F';

/*11)Crear una consulta que muestre los gastos cuyos importes estén entre 10,00 y 100,00. */

select *from gasto
where importe between 10.00 AND 100.00;

/*12)Crear una consulta que muestre los administradores que hayan nacido en la década del 60, 
ordenar el resultado por dicha fecha en forma descendente*/

select *from administrador
where fechnac BETWEEN '1960-01-01' AND '1969-12-31'
order by fechnac desc;

/*13)Crear una consulta que muestre las localidades de las provincias de capital federal y buenos 
aires (1 y 2), ordenado alfabéticamente dentro de cada provincia. */
select *from localidad
where idprovincia in (1,2)
order by descripcion asc;

/*14)Crear una consulta que muestre los datos de los consorcios cuya dirección contenga la letra ‘N’ 
en la Posición 5.*/
select *from consorcio
where substring(direccion,5,1)='N';

/*15)Crear una consulta para mostrar los 697 gastos más costosos*/
select top 697 *from gasto
order by importe desc;

/*16) Sobre la consulta anterior mostrar los importes repetidos.*/

SELECT TOP 697 WITH TIES * FROM gasto
ORDER BY importe DESC;

SELECT *
FROM gasto
WHERE importe IN (
    SELECT TOP 697 importe
    FROM gasto
    ORDER BY importe DESC
) OR importe IN (
    SELECT importe
    FROM gasto
    GROUP BY importe
    HAVING COUNT(*) > 1
)
ORDER BY importe DESC;


/*17)Crear una consulta que permita calcular un incremento de 15% para los gastos menores a 
10000, 10% para los que están entre 10000 y 20000 y un 5 % para el resto. Muestre la salida 
ordenada en forma decreciente por el importe.*/
select periodo,fechapago,idtipogasto,importe,
	Case
		when importe < 10000 then importe * 0.15
		when importe >= 10000 and importe <= 20000 then importe * 0.10
		else importe * 0.05
	end as 'importe incremento'
from gasto
order by importe desc;

/*18)Informar la cantidad de administradores masculinos y femeninos (sexo = ‘M’ y sexo = ‘F’) */
SELECT
    SUM(CASE WHEN sexo = 'M' THEN 1 ELSE 0 END) AS Masculino,
    SUM(CASE WHEN sexo = 'F' THEN 1 ELSE 0 END) AS Femenino
FROM administrador
WHERE sexo IN ('M', 'F');

/*19)Informar la suma total de gastos, la cantidad de gastos y el promedio del mismo. Utilizar Sum, Count y Avg*/
select
	sum(importe) As Total,
	Count(*) As Cantidad,
	Avg(importe) As Promedio
	from gasto;

/*20-a)Mostrar el importe total acumulado de gasto por tipo de gasto.*/
select idtipogasto,Sum(importe) as ImporteAcumulado
from gasto
group by idtipogasto;

/*20-b)Sobre la consulta anterior, listar solo aquellos gastos cuyos importes sean superior a 2.000.000.*/
SELECT idtipogasto, Sum(importe) as ImporteAcumulado 
FROM gasto
group by idtipogasto
HAVING SUM(importe) > 2000000;

/*20-c)Listar solamente los dos (2) tipos de gastos con menor importe acumulado.*/
SELECT TOP 2 idtipogasto, SUM(importe) as ImporteAcumulado
FROM gasto
GROUP BY idtipogasto
ORDER BY ImporteAcumulado;

/*21)Mostrar por cada tipo de gasto, el importe del mayor gasto realizado.*/
WITH GastosConRango AS (
    SELECT idtipogasto, importe,
           ROW_NUMBER() OVER (PARTITION BY idtipogasto ORDER BY importe DESC) AS Rango
    FROM gasto
)
SELECT idtipogasto, importe
FROM GastosConRango
WHERE Rango = 1;

/*22)Mostrar el promedio de gasto por tipo de gasto, solo para aquellos pertenecientes al 1er semestre (períod del 1 al 6).*/
select idtipogasto,avg(importe) as PromedioGasto
from gasto
where month(fechapago) between 1 and 6
group by idtipogasto

/*23)Mostrar la cantidad de consorcios concentrados por zonas. Solo para las zonas 2 (NORTE), 3 (SUR) y 4 (ESTE).*/
select
sum(case when idzona = 2 then 1 else 0 end)as NORTE,
sum(case when idzona = 3 then 1 else 0 end)as SUR,
sum(case when idzona = 4 then 1 else 0 end)as ESTE
from consorcio
where idzona in(2,3,4);

select idzona, count(*) as CantidadDeConsorcios
from consorcio
where idzona IN (2, 3, 4)
group by idzona;

/*24)Mostrar la cantidad de consorcios existentes por localidad. Visualizar la lista en forma 
descendente por cantidad.*/
select idlocalidad, count(*) as 'Cantidad consorcios por localidad'
from consorcio
group by idlocalidad
order by 'Cantidad consorcios por localidad' DESC;


/*25)Mostrar la cantidad de conserjes agrupados por estado civil y edad. Mostrar un listado ordenado.*/
select estciv,
	   DATEDIFF(YEAR,fechnac,GETDATE()) as Edad,
	   count(*) as Cantidad
 from conserje
where estciv in('C','S')
group by estciv,DATEDIFF(YEAR,fechnac,GETDATE())
order by estciv,Edad;

/*26)Mostrar el importe total acumulado de gasto por tipo de gasto. Mostrar las descripciones de cada tipo de gasto de la tabla tipogasto.*/
select tg.descripcion, sum(g.importe) as 'Importe Acumalado'
from gasto as g
join tipogasto tg on g.idtipogasto = tg.idtipogasto
group by tg.descripcion;

/*27)Mostrar los nombres de todos los consorcios y en que provincia y localidad esta cada uno. 
Ordenados por Provincia, localidad y consorcio*/
select p.descripcion as Provincia,l.descripcion as Localidad,c.nombre
from consorcio as c
join provincia p on c.idprovincia = p.idprovincia 
join localidad l on c.idlocalidad = l.idlocalidad;

SELECT COUNT(*) AS TotalRegistros
FROM consorcio AS c
JOIN provincia AS p ON c.idprovincia = p.idprovincia
JOIN localidad AS l ON c.idlocalidad = l.idlocalidad;

/*Explicacion:Datos duplicados: Puede haber duplicados en una o más de las tablas involucradas en la consulta. Esto hará 
que la consulta devuelva más registros de los esperados.
Múltiples coincidencias: Si en alguna de las tablas existe una relación uno a muchos (por ejemplo, un consorcio con múltiples localidades), 
esto puede hacer que se devuelvan más registros de los esperados cuando se unen las tablas.*/


/*28)Mostrar los 10 (diez) consorcios donde se registraron mayores gastos y a qué provincia pertenecen.*/
select top 10 c.nombre as Consorcio,p.descripcion as Provincia,sum(importe) as 'Total Gastado'
from gasto as g
join provincia as p on g.idprovincia = p.idprovincia 
join consorcio as c on g.idconsorcio = c.idconsorcio
group by c.nombre,p.descripcion;

/*29)Mostrar todas las provincias registradas. Para las que tengan consorcios mostrar a qué
localidad pertenecen. Todos con sus nombres respectivos. Ordene los resultados por Provincia, 
localidad y consorcio.*/
SELECT
    p.descripcion AS Provincia,
    l.descripcion AS Localidad,
    c.nombre AS Consorcio
FROM provincia AS p
LEFT JOIN localidad AS l ON p.idprovincia = l.idprovincia
LEFT JOIN consorcio AS c ON l.idlocalidad = c.idlocalidad
ORDER BY Provincia, Localidad, Consorcio;

/*30)Mostrar los nombres de todos los conserjes. Para los que están asignados a algún consorcio 
mostrar también ese nombre. Ordene por apellido y nombre.*/
SELECT c.apeynom, cc.nombre AS Consorcio
FROM conserje AS c
LEFT JOIN consorcio AS cc ON cc.idconserje = c.idconserje;


-- Contar la cantidad total de conserjes
SELECT COUNT(*) AS TotalConserjes FROM conserje;