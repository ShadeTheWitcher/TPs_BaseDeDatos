/*Lovato Matias Sebastian LU:56499 dni: 44574243 SQL version 2022 */
create DATABASE veterinaria

use veterinaria


-- CREATE TABLE UsuarioCreador
-- (
--   id_usuarioCreador INT NOT NULL,
--   nombre INT NOT NULL,
--   CONSTRAINT PK_idCreador PRIMARY KEY (id_usuarioCreador)
-- );



CREATE TABLE Dueño
(
  id_dueño INT NOT NULL IDENTITY(1,1), /*incrmeta en 1 la id*/
  Dni INT NOT NULL,
  nombre VARCHAR(20) NOT NULL,
  direccion VARCHAR(40) NOT NULL,
  telefono INT NOT NULL,
  correo VARCHAR(50) NOT NULL,
  apellido VARCHAR(20) NOT NULL,
  creadoEl DATE NOT NULL Default GETDATE(),
  CONSTRAINT PK_idDueño PRIMARY KEY (id_dueño),
  CONSTRAINT UQ_dni UNIQUE  (Dni), 
  CONSTRAINT UQ_correo UNIQUE (correo), /*hace unico el correo*/
  CONSTRAINT CK_dni_Dueño_length CHECK (LEN(CONVERT(VARCHAR, Dni)) = 8), /*verifica que no pase de 8 carac */
  
);

CREATE TABLE tratamiento
(
  id_tratamiento INT NOT NULL IDENTITY(1,1),
  nombre VARCHAR NOT NULL,
  dosis INT NOT NULL,
  creadoEl DATE NOT NULL Default GETDATE(),
  duracion VARCHAR NOT NULL,
  CONSTRAINT PK_tratamiento PRIMARY KEY (id_tratamiento),
  
);

CREATE TABLE especie
(
  id_especie INT NOT NULL IDENTITY(1,1),
  nombre VARCHAR(30) NOT NULL,
  creadoEl DATE NOT NULL Default GETDATE(),
  CONSTRAINT PK_especie PRIMARY KEY (id_especie),
  
  
);

CREATE TABLE especialidad
(
  id_especialidad INT NOT NULL IDENTITY(1,1),
  nombre INT NOT NULL,
  creadoEl DATE NOT NULL Default GETDATE(),
  CONSTRAINT PK_especialidad PRIMARY KEY (id_especialidad),
  
);

CREATE TABLE PacientePet
(
  id_paciente INT NOT NULL IDENTITY(1,1),
  nombre VARCHAR(30) NOT NULL,
  raza VARCHAR(30) NOT NULL,
  peso INT NOT NULL,
  condicion_medica VARCHAR(30),
  fecha_nacimiento DATE NOT NULL,
  id_dueño INT NOT NULL,
  id_especie INT NOT NULL,
  creadoEl DATE NOT NULL Default GETDATE(),
  CONSTRAINT PK_paciente PRIMARY KEY (id_paciente),
  FOREIGN KEY (id_dueño) REFERENCES Dueño(id_dueño),
  FOREIGN KEY (id_especie) REFERENCES especie(id_especie),
  
);

CREATE TABLE veterinario
(
  id_veterinario INT NOT NULL IDENTITY(1,1),
  nombre INT NOT NULL,
  apellido INT NOT NULL,
  nro_licencia INT NOT NULL,
  horario_atencion VARCHAR(30) NOT NULL,
  id_especialidad INT, /*es opcional*/
  creadoEl DATE NOT NULL Default GETDATE(),
  CONSTRAINT PK_veterinario PRIMARY KEY (id_veterinario),
  FOREIGN KEY (id_especialidad) REFERENCES especialidad(id_especialidad),
  CONSTRAINT UQ_licencia UNIQUE (nro_licencia),
  
);

CREATE TABLE cita
(
  id_cita INT NOT NULL IDENTITY(1,1),
  fecha_progra DATE NOT NULL Default GETDATE(), /* toma la fecha actual */
  hora TIME NOT NULL,
  motivo VARCHAR(50) NOT NULL,
  observacion VARCHAR(60) NOT NULL,
  id_veterinario INT NOT NULL,
  id_paciente INT NOT NULL,
  id_tratamiento INT,  /* opcional */
  creadoEl DATE NOT NULL Default GETDATE(),
  CONSTRAINT PK_cita PRIMARY KEY (id_cita),
  FOREIGN KEY (id_veterinario) REFERENCES veterinario(id_veterinario),
  FOREIGN KEY (id_paciente) REFERENCES PacientePet(id_paciente),
  FOREIGN KEY (id_tratamiento) REFERENCES tratamiento(id_tratamiento),
  
);

/*casos de prueba*/


-- INSERT INTO UsuarioCreador(nombre, ) 
-- VALUES('jorge'); no me funcionaba el usuario en sql server

/* comando para insertar */

INSERT INTO Dueño(nombre, apellido, Dni , direccion, correo, telefono) 
VALUES('jose','ramos',44555777,'casa 500 barrio nuevo','josesito@gmail.com', 3333 ); /* dni de 8carac*/

INSERT INTO Dueño(nombre, apellido, Dni , direccion, correo, telefono) 
VALUES('jose','ramos',44555777,'casa 500 barrio nuevo','joses2ito@gmail.com' ,333); /* no pasa porq es unico el dni*/

INSERT INTO Dueño(nombre, apellido, Dni , direccion, correo, telefono) 
VALUES('jose','ramos',44552777,'casa 500 barrio nuevo','josesito@gmail.com' ,444); /* no pasa porq es unico el correo*/

INSERT INTO Dueño(nombre, apellido, Dni , direccion, correo, telefono) 
VALUES('jose','ramos',445557778,'casa 500 barrio nuevo','josesito@gmail.com' ,444); /* no pasa porq se pasa de 8 caract */

INSERT INTO especie(nombre) VALUES('Perro');

INSERT INTO PacientePet(nombre, raza, peso , condicion_medica, fecha_nacimiento, id_dueño, id_especie ) 
VALUES('jose','buldog',10,'enfermo','2000-01-02',1,1 );


INSERT INTO especialidad(nombre) VALUES('cirugia');

INSERT INTO veterinario(nombre, apellido, nro_licencia , horario_atencion, id_especialidad) 
VALUES('jose','ramos',4477,'de lunes a viernes 17hs', 1 ); /*con especialidad*/

INSERT INTO veterinario(nombre, apellido, nro_licencia , horario_atencion) 
VALUES('yosef','ramos',4477,'de lunes a viernes 17hs'  ); /*sin especialidad*/


INSERT INTO tratamiento(nombre, dosis, duracion)
VALUES('Abamectin', 2, 'una semana');

INSERT INTO cita(hora, motivo, observacion, id_veterinario, id_paciente,id_tratamiento)
VALUES('05:30:00','dolor en el pecho','el paciente tiene dolor intenso', 1, 1, 1  ); 


/*modificar tabla*/
alter table cita
 drop COLUMN  fecha_progra

 alter table cita
 add año VARCHAR(20) NULL, mes INT NULL, dia int NULL ;