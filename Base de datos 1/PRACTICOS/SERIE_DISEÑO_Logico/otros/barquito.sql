CREATE DATABASE barquito_db;

USE barquito_db;

CREATE TABLE Usuario
(
  nombre VARCHAR(100) NOT NULL,
  apellido VARCHAR(100) NOT NULL,
  dni_creador INT NOT NULL,
  constraint PK_dniCreador PRIMARY KEY (dni_creador),
  /* CONSTRAINT UQ_dni_creador UNIQUE (dni_creador), no es necesario al ser PK*/
  CONSTRAINT CK_dni_creador_length CHECK (LEN(CONVERT(VARCHAR, dni_creador)) = 8)
);



CREATE TABLE Licencia_Conductor
(
  nro_licencia INT NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  apellido VARCHAR(100) NOT NULL,
  createdAt DATE NOT NULL Default GETDATE(),
  fecha_nacimiento DATE NOT NULL,
  dni_creador INT NOT NULL,
  constraint PK_nro_licencia PRIMARY KEY (nro_licencia),
  constraint FK_dni_creador FOREIGN KEY (dni_creador) REFERENCES Usuario(dni_creador),

  
  CONSTRAINT CK_fechaNac100 CHECK (100 >= DATEDIFF(YEAR, fecha_nacimiento, GETDATE()))
);

CREATE TABLE Pasajero
(
  dni_pasajero INT NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  apelido VARCHAR(100) NOT NULL,
  direccion VARCHAR(100) NOT NULL,
  createdAt DATE NOT NULL Default GETDATE(),
  dni_creador INT NOT NULL,
  PRIMARY KEY (dni_pasajero),
  FOREIGN KEY (dni_creador) REFERENCES Usuario(dni_creador),

  CONSTRAINT CK_dni_pasajero_length CHECK (LEN(CONVERT(VARCHAR, dni_pasajero)) = 8)  /* convierte en varchar el int para saber la longitud y lo compara con 11 */
);

CREATE TABLE Categoria
(
  id_categoria INT NOT NULL IDENTITY(1,1),
  tipo_categoria VARCHAR(100) NOT NULL,
  createdAt DATE NOT NULL Default GETDATE(),
  dni_creador INT NOT NULL,
  PRIMARY KEY (id_categoria),
  FOREIGN KEY (dni_creador) REFERENCES Usuario(dni_creador)
);

CREATE TABLE Salida
(
  num_registro INT NOT NULL IDENTITY(1,1),
  fecha_salida DATE NOT NULL,
  hora_salida TIME NOT NULL,  /*solo poner hora */
  destino VARCHAR(100) NOT NULL,
  createdAt DATE NOT NULL Default GETDATE(),
  nro_licencia INT NOT NULL,
  dni_creador INT NOT NULL,
  PRIMARY KEY (num_registro),
  FOREIGN KEY (nro_licencia) REFERENCES Licencia_Conductor(nro_licencia),
  FOREIGN KEY (dni_creador) REFERENCES Usuario(dni_creador)
);

CREATE TABLE Socio
(
  nro_socio INT NOT NULL IDENTITY(1,1),
  fecha_alta DATE NOT NULL,
  createdAt DATE NOT NULL Default GETDATE(),
  correoElectronico VARCHAR(150) NOT NULL,
  id_categoria INT NOT NULL,
  dni_creador INT NOT NULL,
  PRIMARY KEY (nro_socio),
  FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria),
  FOREIGN KEY (dni_creador) REFERENCES Usuario(dni_creador),
  constraint UQ_correoElectronico UNIQUE (correoElectronico)
);

CREATE TABLE Boleto
(
  createdAt DATE NOT NULL Default GETDATE(),
  num_registro INT NOT NULL,
  dni_pasajero INT NOT NULL,
  dni_creador INT NOT NULL,
  PRIMARY KEY (num_registro, dni_pasajero),
  FOREIGN KEY (num_registro) REFERENCES Salida(num_registro),
  FOREIGN KEY (dni_pasajero) REFERENCES Pasajero(dni_pasajero),
  FOREIGN KEY (dni_creador) REFERENCES Usuario(dni_creador)
);

CREATE TABLE Embarcacion
(
  num_matricula INT NOT NULL ,
  nombre VARCHAR(100) NOT NULL,
  num_amarre INT NOT NULL,
  createdAt DATE NOT NULL Default GETDATE(),
  nro_socio INT NOT NULL,
  num_registro INT NOT NULL,
  dni_creador INT NOT NULL,
  PRIMARY KEY (num_matricula),
  FOREIGN KEY (nro_socio) REFERENCES Socio(nro_socio),
  FOREIGN KEY (num_registro) REFERENCES Salida(num_registro),
  FOREIGN KEY (dni_creador) REFERENCES Usuario(dni_creador),

  constraint UQ_matricula UNIQUE(num_matricula)
);

select * from Usuario

insert into Usuario(nombre, apellido, dni_creador)
VALUES ('jorge', 'lopez', 33222333); /* si se crea otra vez no pasa*/

insert into Usuario(nombre, apellido, dni_creador)
VALUES ('nahuel', 'lopez', 332223334); /* si se crea no pasa porq se excede de 8 el dni*/



select * from Licencia_Conductor

insert into Licencia_Conductor(nro_licencia, nombre, apellido, fecha_nacimiento, dni_creador )
VALUES (12345, 'jose', 'roberto', '1993-09-18', 33222333 ); 

insert into Licencia_Conductor(nro_licencia, nombre, apellido, fecha_nacimiento, dni_creador )
VALUES (123454, 'jose', 'roberto', '1993-09-18', 4422232 ); /*no pasa porque no existe un usuario con ese dni*/

insert into Licencia_Conductor(nro_licencia, nombre, apellido, fecha_nacimiento, dni_creador )
VALUES (14252242, 'viejo', 'roberto', '1923-09-26', 33222333 ); /*pasa porq tiene 100 años*/

insert into Licencia_Conductor(nro_licencia, nombre, apellido, fecha_nacimiento, dni_creador )
VALUES (14252242, 'jose', 'roberto', '1920-09-26', 33222333 ); /*no pasa porque la fecha pasa de 100 años*/

select * from Categoria

insert into Categoria(tipo_categoria, dni_creador )
VALUES ( 'socio adherente', 33222333 ); /**/

insert into Categoria(tipo_categoria, dni_creador )
VALUES ( 'grupos familiar', 33222333 ); /**/

select * from Socio

insert into Socio(fecha_alta, correoElectronico, id_categoria, dni_creador )
VALUES ( '2023-09-18', '123@gmail.com', 1, 33222333 ); /**/

insert into Socio(fecha_alta, correoElectronico, id_categoria, dni_creador )
VALUES ( '2023-09-18', '123@gmail.com', 2, 33222333 ); /*no pasa porque tiene un correo q ya existe*/