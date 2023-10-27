



/*

Crear una tabla persona:

- nombre

- apellido

- dni

- email

- fecha nacimiento 

- estado civil tipo CHAR de un solo caracter ( "C", "S", "D", "O")

- agregar una restricción que controle que solo se puedan ingresar esas letras en la columna

2) sin eliminar la tabla persona, modificar la misma de tal manera de incorporar una referencia a una nueva tabla que se va a llamar. 
Crear una nueva tabla que se llame Estado Civil que va a tener id -descripcion - descripción corta (char 1) y referenciar esa tabla nueva a la tabla Persona  
​
3) hacer lote de prueba que nos permita controlar cada una de las restricciones
*/


CREATE TABLE Persona
(
  nombre VARCHAR(20) NOT NULL,
  apellido VARCHAR(20) NOT NULL,
  email VARCHAR(50) NOT NULL,
  fechaNacimiento DATE NOT NULL,
  estado_civil CHAR(1) NOT NULL,
  dni INT NOT NULL,

  CONSTRAINT Pk_dni PRIMARY KEY (dni), 

  CONSTRAINT CK_estadoCivilChar CHECK (estado_civil IN ('C', 'S', 'D', 'O')),
  
);

CREATE TABLE Estado_civil_tipo
(
  id INT NOT NULL IDENTITY(1,1),
  descripcion VARCHAR(15) NOT NULL,
  descrip_corta CHAR(1) NOT NULL,
  CONSTRAINT pk_estadoCivil PRIMARY KEY (id),
  CONSTRAINT CK_Estado_Civil CHECK (descrip_corta IN ('C', 'S', 'D', 'O'))
);





ALTER TABLE Persona

    drop CONSTRAINT CK_estadoCivilChar /* eliminamos la anterior constraint que ya no sirve antes que la columna*/

ALTER TABLE Persona DROP COLUMN estado_civil ; /* eliminamos lo anterior colum*/



alter table persona 

    ADD estado_civil_tipo_id int;

alter table persona 
    ADD CONSTRAINT FK_estado_civil_tipo_id FOREIGN KEY (estado_civil_tipo_id) REFERENCES Estado_civil_tipo(id)




/* casos de prueba*/
SELECT * FROM Estado_civil_tipo;

INSERT INTO Estado_civil_tipo(descripcion, descrip_corta) VALUES('soltero', 'S');
INSERT INTO Estado_civil_tipo(descripcion, descrip_corta) VALUES('casado', 'C');
INSERT INTO Estado_civil_tipo(descripcion, descrip_corta) VALUES('divorciado', 'D1');

INSERT INTO Persona(dni,nombre, apellido, email, fechaNacimiento, estado_civil_tipo_id ) VALUES(444, 'jorge','jose','josesitokapo1','2000-02-01',1);



/* comentar todo en el parcial  anotar la version que se usa de la base de datos*/









 




 /* ////////////// compañeros codigos */



CREATE TABLE Estado_Civil(

	Id_EstadoCivil INT NOT NULL IDENTITY(1,1),

	Estado_Civil VARCHAR(1) NOT NULL,

	CONSTRAINT PK_EstadoCivil PRIMARY KEY (Id_EstadoCivil),

	CONSTRAINT CK_Estado_Civil CHECK (Estado_Civil IN ('C', 'S', 'D', 'O'))

);
















ALTER TABLE Persona

drop CONSTRAINT CK_Estado_Civil

 

 

ALTER TABLE Persona

ALTER COLUMN Id_EstadoCivil INT

 

EXEC sp_rename 'Persona.Estado_Civil', 'Id_EstadoCivil', 'COLUMN';

 

ALTER TABLE Persona

ADD CONSTRAINT FK_EstadoCivil FOREIGN KEY (Id_EstadoCivil) REFERENCES Estado_Civil(Id_EstadoCivil);













alter table persona drop constraint CK_estadocivil,

alter table persona drop column estadoCivil,

alter table persona add id_estadoCivil  int not null,

alter table persona add constraint FK_persona_estado_civil Foreign Key (id_estadoCivil) References estado_civil(id_estadoCivil)


















