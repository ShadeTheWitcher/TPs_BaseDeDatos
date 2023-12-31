 
 -- TABLA: inmueble
  
 /*
 -----------------------------
 Descripción de las columnas
 -----------------------------
	 sup: superficie total. cubierto, que ocupan todos los departamentos del inmueble
	 nro_pisos: cantidad de pisos que tiene el inmueble,
	 cant_dpto: cantidad de departamentos en el inmueble,
	 espacio_comun: si cuenta con espacios de uso comun (0- no, 1- si)
*/

 CREATE TABLE inmueble(
	 idprovincia INT NOt NULL,
	 idlocalidad INT NOT NULL,
	 idconsorcio INT NOT NULL,
	 sup DECIMAL(6,2),
	 nro_pisos INT,
	 cant_dpto INT,
	 espacio_comun INT NOT NULL
 );

ALTER TABLE inmueble
	ADD CONSTRAINT PK_inmueble PRIMARY KEY (idprovincia, idlocalidad, idconsorcio);
ALTER TABLE inmueble
	ADD CONSTRAINT FK_inmueble_consorcio FOREIGN KEY(idprovincia, idlocalidad, idconsorcio)REFERENCES consorcio(idprovincia, idlocalidad, idconsorcio);
	 
-- LOTE DATOS TABLA: inmueble
-- TRUNCATE TABLE inmueble;
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(1, 1,1,4,24,1656,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(1, 2,2,4,8,384,0);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(2, 48,1,2,8,400,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(2, 55,2,2,12,720,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(3, 16,1,4,20,1400,0);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(3, 20,2,4,8,544,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(3, 25,3,2,6,396,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(3, 27,4,1,4,204,0);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(3, 29,5,2,8,408,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(4, 21,1,4,24,984,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(4, 36,2,4,12,504,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(4, 37,3,1,6,300,0);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(5, 3,1,3,6,444,0);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(5, 4,2,4,12,660,0);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(5, 12,3,4,24,1536,0);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(5, 12,4,1,2,94,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(5, 14,5,3,18,828,0);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(6, 33,1,2,8,512,0);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(6, 45,2,1,5,330,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(6, 85,3,4,20,1020,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(6, 106,4,1,5,390,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(6, 112,5,2,4,288,0);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(8, 5,1,4,12,600,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(8, 17,2,1,3,216,0);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(8, 26,3,4,12,912,0);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(8, 31,4,4,8,488,0);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(8, 31,5,2,12,876,0);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(8, 31,6,3,6,306,0);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(8, 35,7,2,4,176,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(8, 35,8,3,9,648,0);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(8, 40,9,1,4,316,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(8, 42,10,4,8,360,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(9, 14,1,3,6,288,0);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(9, 15,2,3,15,675,0);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(9, 18,3,4,20,1500,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(10, 11,1,4,20,1280,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(10, 14,2,1,4,188,0);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(10, 15,3,4,8,440,0);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(11, 3,1,3,15,1110,0);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(11, 5,2,2,8,472,0);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(11, 5,3,3,9,441,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(12, 2,1,2,12,504,0);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(12, 3,2,4,24,1680,0);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(12, 5,3,2,6,306,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(12, 7,4,4,24,1032,0);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(12, 16,5,1,4,320,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(12, 17,6,2,8,640,0);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(13, 3,1,3,9,540,0);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(13, 10,2,2,12,852,0);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(13, 12,3,3,9,648,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(14, 8,1,2,4,248,0);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(14, 36,2,4,12,528,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(14, 41,3,1,3,240,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(14, 42,4,1,2,156,0);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(14, 48,5,1,6,288,0);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(15, 5,1,1,3,216,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(15, 7,2,4,16,1168,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(15, 13,3,4,24,1344,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(15, 13,4,4,12,876,0);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(15, 18,5,4,20,1440,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(15, 20,6,3,18,774,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(15, 25,7,3,18,882,0);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(16, 4,1,3,6,258,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(16, 7,2,4,20,1200,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(16, 29,3,4,20,1180,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(17, 7,1,1,2,150,0);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(17, 11,2,4,8,448,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(17, 13,3,4,24,1920,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(17, 14,4,2,4,304,0);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(17, 22,5,3,12,936,0);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(18, 3,1,2,6,462,0);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(18, 8,3,2,10,570,0);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(18, 20,4,2,12,564,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(19, 2,1,3,9,504,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(19, 5,2,4,16,1248,0);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(19, 9,3,4,8,456,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(19, 15,4,1,2,152,0);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(20, 1,1,2,8,352,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(20, 9,2,3,18,1188,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(20, 11,3,2,12,588,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(20, 14,4,2,10,420,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(21, 18,1,1,2,126,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(21, 32,2,3,6,264,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(21, 54,3,4,16,992,0);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(22, 3,1,2,12,540,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(22, 5,2,3,15,930,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(22, 25,3,1,5,235,0);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(23, 1,1,4,20,1540,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(23, 2,2,1,3,183,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(23, 2,3,3,9,495,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(24, 4,1,1,6,288,0);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(24, 7,2,1,2,156,0);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(24, 10,3,4,16,1056,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(24, 13,4,4,8,608,1);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(24, 14,5,1,6,306,0);
INSERT INTO inmueble(idprovincia, idlocalidad, idconsorcio, nro_pisos, cant_dpto, sup, espacio_comun)VALUES(24, 17,6,1,5,385,1);


SELECT * FROM inmueble;
