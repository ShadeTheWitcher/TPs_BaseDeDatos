/* ejericio 2 */

-- MODIFICACIONES ADMINISTRADOR

-- Modificar el tipo de datos de la columna "fechnac" a VARCHAR(50)
ALTER TABLE administrador
ALTER COLUMN fechnac VARCHAR(50);


-- Agregar restricción para valores menores a 01 de enero del 1998
ALTER TABLE administrador
ADD CONSTRAINT CK_FechaNacimiento CHECK (
    ISDATE(fechnac) = 0 OR CAST(fechnac AS DATE) >= '1998-01-01'
);


-- Agregar restricción para la columna "viveahi"
ALTER TABLE administrador
ADD CONSTRAINT CK_habitante_viveahi CHECK (viveahi IN ('S', 'N'));

-- Agregar restricción para la columna "sexo"
ALTER TABLE administrador
ADD CONSTRAINT CK_sexo CHECK (sexo IN ('F', 'M'));


-- MODIFICACIONES CONSERJE

-- Agregar restricción para valores menores a 01 de enero del 1998 en la columna "fechnac"
ALTER TABLE conserje
ADD CONSTRAINT CK_FechaNacimiento_conserje CHECK (fechnac < '1998-01-01');


-- Agregar restricción para la columna "estciv"
ALTER TABLE conserje
drop Constraint CK_estadocivil

ALTER TABLE conserje
ADD CONSTRAINT CK_estadocivil CHECK (estciv IN ('C', 'S', 'D', 'V', 'O'));


-- MODIFICACIONES PROVINCIA

-- Agregar poblacion a la tabla provincia
ALTER TABLE provincia
ADD poblacion INT NULL;

-- MODIFICACIONES GASTO

-- Agregar restricción para la columna "fechapago" superior o igual a la fecha del día
ALTER TABLE gasto
ADD CONSTRAINT CK_FechaPago CHECK (fechapago >= GETDATE());

-- Agregar restricción para la columna "periodo" para que no se pueda pagar un mes mayor al actual
ALTER TABLE gasto
ADD CONSTRAINT CK_Periodo CHECK (periodo <= MONTH(GETDATE()));


-- ejercicio 3

--LOTE DE DATOS.
---------------------------

---------------
-- Provincias
---------------

Insert into provincia (idprovincia, descripcion,km2,cantdptos,poblacion,nomcabe) values (1, 'Capital Federal',203,1,2891082,'Capital Federal')
Insert into provincia (idprovincia, descripcion,km2,cantdptos,poblacion,nomcabe) values (2, 'Buenos Aires',307571,127,15594428,'La Plata')
Insert into provincia (idprovincia, descripcion,km2,cantdptos,poblacion,nomcabe) values (3, 'Catamarca',102602,16,367820,'San Fernando del Valle de Catamarca')
Insert into provincia (idprovincia, descripcion,km2,cantdptos,poblacion,nomcabe) values (4, 'Chaco',99633,24,1053466,'Resistencia')
Insert into provincia (idprovincia, descripcion,km2,cantdptos,poblacion,nomcabe) values (5, 'Chubut',224686,15,506668,'Rawson')


--Select * from provincia

---------------
-- Localidades
---------------
INSERT INTO localidad (idprovincia, idlocalidad, descripcion) VALUES (1, 1, 'Ciudad Autnoma de Buenos Aires')
INSERT INTO localidad (idprovincia, idlocalidad, descripcion) VALUES (1, 2, 'Colegiales')
INSERT INTO localidad (idprovincia, idlocalidad, descripcion) VALUES (1, 3, 'Retiro')
INSERT INTO localidad (idprovincia, idlocalidad, descripcion) VALUES (1, 4, 'Villa Lugano')
INSERT INTO localidad (idprovincia, idlocalidad, descripcion) VALUES (1, 5, 'Villa Santa Rita')

---------------
-- Zonas
---------------
Insert into zona (descripcion) values ('Centro')
Insert into zona (descripcion) values ('NORTE')
Insert into zona (descripcion) values ('SUR')
Insert into zona (descripcion) values ('ESTE')
Insert into zona (descripcion) values ('OESTE')
Insert into zona (descripcion) values ('Periferica')

--select * from zona





---------------
-- Conserjes
---------------

Insert into conserje (ApeyNom,tel,fechnac,estciv) values ('RAMIREZ JORGE ESTEBAN', '374449272', '19830910', 'S')
Insert into conserje (ApeyNom,tel,fechnac,estciv) values ('ALCARAZ SONIA', '374449272', '19700710', 'C')
Insert into conserje (ApeyNom,tel,fechnac,estciv) values ('ALMADA DE R. EMERENCIANA', '374449372', '19840401', 'S')
Insert into conserje (ApeyNom,tel,fechnac,estciv) values ('RAMIREZ JORGE ESTEBAN', '373449472', '19690212', 'C')
Insert into conserje (ApeyNom,tel,fechnac,estciv) values ('MARIN DE P. ANTOLINA', '373449572', '19950627', 'S')

-- select * from conserje






--------------------
-- Administradores
--------------------

Insert into administrador(apeynom,viveahi,tel,sexo,fechnac) values ('Perez Juan Manuel', 'N', '3794112233', 'M', '2005-02-18')
Insert into administrador(apeynom,viveahi,tel,sexo,fechnac) values ('BASUALDO DELMIRA', 'N', '3624231689', 'F', '19981009')
Insert into administrador(apeynom,viveahi,tel,sexo,fechnac) values ('SEGOVIA ALEJANDRO H.', 'S', '3624232689', 'M', '20000602')
Insert into administrador(apeynom,viveahi,tel,sexo,fechnac) values ('ROMERO ELEUTERIO', 'N', '3624233689', 'M', '20020819')
Insert into administrador(apeynom,viveahi,tel,sexo,fechnac) values ('NAHMIAS DE K. NIDIA', 'S', '3624234689', 'F', '20031128')

-- estos no cumplen con la fecha mayor a 19998
Insert into administrador(apeynom,viveahi,tel,sexo,fechnac) values ('Perez Juan Manuel', 'N', '3794112233', 'M', '19850218')
Insert into administrador(apeynom,viveahi,tel,sexo,fechnac) values ('BASUALDO DELMIRA', 'N', '3624231689', 'F', '19801009')
Insert into administrador(apeynom,viveahi,tel,sexo,fechnac) values ('SEGOVIA ALEJANDRO H.', 'S', '3624232689', 'M', '19740602')
Insert into administrador(apeynom,viveahi,tel,sexo,fechnac) values ('ROMERO ELEUTERIO', 'N', '3624233689', 'M', '19720819')
Insert into administrador(apeynom,viveahi,tel,sexo,fechnac) values ('NAHMIAS DE K. NIDIA', 'S', '3624234689', 'F', '19711128')


-- select * from administrador


-----------------
-- Consorcios
-----------------
INSERT INTO consorcio(idprovincia,idlocalidad,idconsorcio, Nombre,direccion,idzona,idconserje,idadmin) VALUES (1, 1, 1, 'EDIFICIO-111', 'PARAGUAY N 630', 2, 1, 4)
INSERT INTO consorcio(idprovincia,idlocalidad,idconsorcio, Nombre,direccion,idzona,idconserje,idadmin) VALUES (1, 2, 2, 'EDIFICIO-122', 'B 250 VIV SEC 2 MZ 4 CSA N 2', 4, 2, 3)
INSERT INTO consorcio(idprovincia,idlocalidad,idconsorcio, Nombre,direccion,idzona,idconserje,idadmin) VALUES (1, 3, 1, 'EDIFICIO-2481', 'SAN LUIS N 1035, 4 piso, Dpto c', 1, 3, 5)
INSERT INTO consorcio(idprovincia,idlocalidad,idconsorcio, Nombre,direccion,idzona,idconserje,idadmin) VALUES (1, 5, 2, 'EDIFICIO-2552', 'REMEDIOS DE ESCALADA N 5353', 3, 5, 6)
INSERT INTO consorcio(idprovincia,idlocalidad,idconsorcio, Nombre,direccion,idzona,idconserje,idadmin) VALUES (1, 4, 1, 'EDIFICIO-3161', 'B VENEZUELA, GR.4, MZ.21,C.2', 2, 5, 5)

-------------------
-- TIPO de Gastos 
-------------------
Insert into tipogasto (idtipogasto, descripcion) values (1,'Servicios')
Insert into tipogasto (idtipogasto, descripcion) values (2,'Limpieza')
Insert into tipogasto (idtipogasto, descripcion) values (3,'Sueldos')
Insert into tipogasto (idtipogasto, descripcion) values (4,'Aportes')
Insert into tipogasto (idtipogasto, descripcion) values (5,'OTROS')

--SELECT * FROM tipogasto

-----------------
-- Gastos 
-----------------

--pasan solo si la fecha de pago es mayor o igual a la actual
INSERT INTO gasto (idprovincia,idlocalidad,idconsorcio,periodo,fechapago,idtipogasto,importe) VALUES (1,1,1,6,'2023-06-16',5,608.97)
INSERT INTO gasto (idprovincia,idlocalidad,idconsorcio,periodo,fechapago,idtipogasto,importe) VALUES (1,1,1,3,'2023-10-31',3,48026.65)
INSERT INTO gasto (idprovincia,idlocalidad,idconsorcio,periodo,fechapago,idtipogasto,importe) VALUES (1,1,1,7,'2024-12-09',3,62573.61)
INSERT INTO gasto (idprovincia,idlocalidad,idconsorcio,periodo,fechapago,idtipogasto,importe) VALUES (1,1,1,7,'2023-11-08',3,91137.20)
INSERT INTO gasto (idprovincia,idlocalidad,idconsorcio,periodo,fechapago,idtipogasto,importe) VALUES (1,1,1,8,'2023-11-14',2,3033.99)

-- 2013 -- estos no van a ser insertados porque ya estamos en 2023
INSERT INTO gasto (idprovincia,idlocalidad,idconsorcio,periodo,fechapago,idtipogasto,importe) VALUES (1,1,1,6,'20130616',5,608.97)
INSERT INTO gasto (idprovincia,idlocalidad,idconsorcio,periodo,fechapago,idtipogasto,importe) VALUES (1,1,1,3,'20130311',3,48026.65)
INSERT INTO gasto (idprovincia,idlocalidad,idconsorcio,periodo,fechapago,idtipogasto,importe) VALUES (1,1,1,7,'20130709',3,62573.61)
INSERT INTO gasto (idprovincia,idlocalidad,idconsorcio,periodo,fechapago,idtipogasto,importe) VALUES (1,1,1,7,'20130708',3,91137.20)
INSERT INTO gasto (idprovincia,idlocalidad,idconsorcio,periodo,fechapago,idtipogasto,importe) VALUES (1,1,1,8,'20130814',2,3033.99)



-- MODIFICACION DE DATOS DE REGISTROS

-- Modificar el importe de un registro en la tabla gasto
UPDATE gasto
SET importe = 100.00
WHERE idgasto = 1;

-- Borrar registros en la tabla gasto donde importe sea menor a 120
DELETE FROM gasto
WHERE importe < 120.00;

-- Borrar registros en la tabla administrador con fechnac menor a 1998-01-01
DELETE FROM administrador
WHERE fechnac < '1998-01-01'; -- no funciona al estar dentro de un consorcio y al no haber fechas menores a eso



SELECT count(*) FROM [dbo].[localidad];
SELECT count(*) FROM [dbo].[provincia];
SELECT count(*) FROM [dbo].[tipogasto];
SELECT count(*) FROM [dbo].[zona];
SELECT count(*) FROM [dbo].[administrador];
SELECT count(*) FROM [dbo].[conserje];
SELECT count(*) FROM [dbo].[consorcio];
SELECT count(*) FROM [dbo].[gasto];


--EJERCICIO 4

-- Eliminar los datos existentes en las tablas

DELETE FROM gasto;
DELETE FROM consorcio;
DELETE FROM tipogasto;
DELETE FROM localidad;
DELETE FROM zona;
DELETE FROM administrador;
DELETE FROM conserje;
DELETE FROM provincia;













-- si se quisiese borrar en cadena los registros vinculados a otros se deberia usar esto


-- Elimina las restricciones de clave externa existentes (si es necesario)
ALTER TABLE consorcio
DROP CONSTRAINT FK_consorcio_pcia;

ALTER TABLE consorcio
DROP CONSTRAINT FK_consorcio_zona;

ALTER TABLE consorcio
DROP CONSTRAINT FK_consorcio_conserje;

ALTER TABLE consorcio
DROP CONSTRAINT FK_consorcio_admin;

-- Agrega nuevas restricciones de clave externa con ON DELETE CASCADE para que se eliminen
ALTER TABLE consorcio
ADD CONSTRAINT FK_consorcio_pcia
FOREIGN KEY (idprovincia, idlocalidad) REFERENCES localidad(idprovincia, idlocalidad) ON DELETE CASCADE;

ALTER TABLE consorcio
ADD CONSTRAINT FK_consorcio_zona
FOREIGN KEY (idzona) REFERENCES zona(idzona) ON DELETE CASCADE;

ALTER TABLE consorcio
ADD CONSTRAINT FK_consorcio_conserje
FOREIGN KEY (idconserje) REFERENCES conserje(idconserje) ON DELETE CASCADE;

ALTER TABLE consorcio
ADD CONSTRAINT FK_consorcio_admin
FOREIGN KEY (idadmin)
REFERENCES administrador(idadmin)
ON DELETE CASCADE;

-- Elimina las restricciones de clave externa existentes (si es necesario)
ALTER TABLE gasto
DROP CONSTRAINT FK_gasto_consorcio;

ALTER TABLE gasto
DROP CONSTRAINT FK_gasto_tipo;

-- Agrega nuevas restricciones de clave externa con ON DELETE CASCADE
ALTER TABLE gasto
ADD CONSTRAINT FK_gasto_consorcio
FOREIGN KEY (idprovincia, idlocalidad, idconsorcio)
REFERENCES consorcio(idprovincia, idlocalidad, idconsorcio)
ON DELETE CASCADE;

ALTER TABLE gasto
ADD CONSTRAINT FK_gasto_tipo FOREIGN KEY (idtipogasto) REFERENCES tipogasto(idtipogasto) ON DELETE CASCADE;


TRUNCATE TABLE gasto;

DELETE FROM consorcio WHERE idconserje IN (SELECT idconserje FROM conserje WHERE ...);
DELETE FROM consorcio WHERE idadmin IN (SELECT idadmin FROM administrador WHERE ...);
DELETE FROM consorcio;

DELETE FROM administrador;




