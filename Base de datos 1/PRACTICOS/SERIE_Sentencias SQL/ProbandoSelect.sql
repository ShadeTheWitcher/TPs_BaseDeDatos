use base_consorcio;

--Sin asteriscos para mostrar columnas en concreto
SELECT apeynom, fechnac from conserje;


SELECT apeynom, fechnac, anio = Year(fechnac) from conserje;

--Alias Año para la columna sin nombre fechanac usando AS Si hay caracteres especiales o espacos va entre []
SELECT apeynom, fechnac, Year(fechnac) AS 'Año' from conserje;

--Select con condición. Siempre va la columna primero contra el valor que quiero comparar.
SELECT * from conserje WHERE idconserje = 5;

-- '' Porque es un String.
SELECT * from conserje WHERE  estciv = 'S';

--Busca todos los que empiecen con MAR y lo que no me importa lo represento con %
--Like comparación de String y se puede usar dos elementos como comodines de patrones
SELECT * from conserje WHERE  apeynom like 'Marin%';

--Me devuelve todos los elementos que empiezan en el cuarto caracter con IN
SELECT * from conserje WHERE  apeynom like '___IN%';

-- Con Order By (Método de ordenamiento Peor O Más costoso) con ASC (Ascendente) y DESC (Descendente) se puede ordenar todos los datos de una columna.
-- Order By siempre se ejecuta último.
SELECT * from conserje WHERE  apeynom like '___IN%' ORDER BY apeynom ASC;	

-- Agregar otra condición con AND o OR.
SELECT * from conserje WHERE  apeynom like '___IN%' AND estciv = 'C' ORDER BY apeynom ASC;	

--Count imprime la cantidad de filas que tenemos en cierta tabla con cierta condición, No se puede usar Order by
SELECT COUNT(*) from conserje WHERE  apeynom like '___IN%' AND estciv = 'C' -- ORDER BY apeynom ASC;

--Cuenta la cantidad de registros en donde apellido y nombre es un dato nulo
SELECT COUNT(*) from conserje WHERE  apeynom Is Null;

--Muestra los registros nulos
SELECT * from conserje WHERE  apeynom Is Null;

--Cuenta la cantidad de registros en donde apellido y nombre es un dato no nulo
SELECT COUNT(*) from conserje WHERE  apeynom Is Not Null;

--Muestra los registros no nulos
SELECT * from conserje WHERE  apeynom Is Not Null;

--Al usar COUNT(Con Columnas) se van a contar sólo los registros que tengan dato, los nulos los descarta
SELECT COUNT(apeynom) from conserje;

Update conserje set apeynom = NULL Where idconserje = 2;

--No se puede comprar un campo con null sólo usar IS NULL o IS NOT NULL
SELECT * from conserje WHERE  apeynom = NULL;

Select * From Conserje Where (Year(fechnac) < 1958)

--Calculando Edades y agregando una columnna con las mismas
Select *, Year(getdate())-Year(fechnac) AS EDAD From Conserje Where Year(getdate())-Year(fechnac) > 50

--Calculando Edades y agregando una columnna con las mismas usando DATEDIFF
Select *, DATEDIFF(Year, fechnac, getdate()) AS EDAD From Conserje Where Year(getdate())-Year(fechnac) > 50

--Siempre que Ocupe un UPDATE o DELETE aplicarlo junto con el WHERE
--Los comandos sólo se colocan una vez
-- Cuando se ordenan se puede usar los alias
-- NO se puede usar Alias de columna ni en WHERE ni en from Sólo en ORDER BY

-- En este código: 
-- Select *, DATEDIFF(Year, fechnac, getdate()) AS EDAD From Conserje Where Year(getdate())-Year(fechnac) > 50

-- Se va a ejecutar primero Select * From Conserje
-- Después Select * From Conserje Where Year(getdate())-Year(fechnac) > 50
-- Luego  Select *, DATEDIFF(Year, fechnac, getdate()) AS EDAD
-- Por último si hubiese un ORDER BY se ejecutaría al final Select *, DATEDIFF(Year, fechnac, getdate()) AS EDAD From Conserje Where Year(getdate())-Year(fechnac) > 50 Order By EDAD ASC
-- ordenando la columna edad


