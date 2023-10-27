CREATE DATABASE Registros_partidos; -- SE CREA LA BASE DE DATOS
go

-- DEFINICION DE TABLAS --
CREATE TABLE Tipo_usuario(
	cod_tipoUsuario INT NOT NULL,
	descripcion VARCHAR(100) NOT NULL,
	fecha_creacion DATETIME DEFAULT GETDATE(),
	CONSTRAINT PK_tipoUsuario PRIMARY KEY(cod_tipoUsuario)
);

go

CREATE TABLE Usuario(
	id_usuario INT IDENTITY(1,1),
	nombre_usuario VARCHAR(50) NOT NULL,
	mail VARCHAR(200) NOT NULL,
	contraseña VARCHAR(200) NOT NULL,
	fecha_creacion DATETIME DEFAULT GETDATE(),
	cod_tipoUsuario INT NOT NULL,
	CONSTRAINT PK_usuario PRIMARY KEY(id_usuario),
	CONSTRAINT FK_Usuario_tipoUsuario FOREIGN KEY (cod_tipoUsuario) REFERENCES Tipo_usuario(cod_tipoUsuario),
	CONSTRAINT CK_User_mailUnico UNIQUE(mail),
	CONSTRAINT CK_User_mail_aceptable CHECK (mail like '%@%'),
);

go

CREATE TABLE Jugadora( 
  id_jugadora CHAR(8) NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  fecha_nac DATETIME NOT NULL,
  fecha_creacion DATETIME DEFAULT GETDATE(),
  id_usuario INT NOT NULL,
  CONSTRAINT PK_jugadora PRIMARY KEY (id_jugadora),
  CONSTRAINT FK_jugadora_usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
  CONSTRAINT CK_jugadora_fechanac CHECK ((DATEDIFF(YEAR, fecha_nac, GETDATE()) <= 100)),
  CONSTRAINT CK_dni_jugadora_soloNum CHECK(ISNUMERIC(id_jugadora)=1)
);

go

CREATE TABLE Equipo(
  cod_equipo INT IDENTITY(1,1),
  nombre VARCHAR(100) NOT NULL,
  fecha_creacion DATETIME DEFAULT GETDATE(),
  id_usuario INT NOT NULL,
  CONSTRAINT PK_equipo PRIMARY KEY (cod_equipo),
  CONSTRAINT FK_equipo_usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
);

go 

CREATE TABLE Estadio(
  cod_estadio INT IDENTITY(1,1),
  nombre VARCHAR(100) NOT NULL,
  fecha_creacion DATETIME DEFAULT GETDATE(),
  id_usuario INT NOT NULL,
  CONSTRAINT PK_estadio PRIMARY KEY (cod_estadio),
  CONSTRAINT FK_estadio_usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
);

go

CREATE TABLE Alta_equipo(
  cod_equipo INT NOT NULL,
  id_jugadora CHAR(8) NOT NULL,
  fecha_alta DATE NOT NULL,
  fecha_creacion DATETIME DEFAULT GETDATE(),
  id_usuario INT NOT NULL,
  CONSTRAINT PK_alta_equipo PRIMARY KEY (cod_equipo, id_jugadora),
  CONSTRAINT FK_altaEquipo_Equipo FOREIGN KEY (cod_equipo) REFERENCES Equipo(cod_equipo),
  CONSTRAINT FK_altaEquipo_jugadora FOREIGN KEY (id_jugadora) REFERENCES Jugadora(id_jugadora),
  CONSTRAINT FK_altaEquipo_usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
);

go

CREATE TABLE Condicion_ingreso(
  cod_condicion INT IDENTITY(1,1),
  descripcion VARCHAR(50) NOT NULL,
  fecha_creacion DATETIME DEFAULT GETDATE(),
  id_usuario INT NOT NULL,
  CONSTRAINT PK_condicionIngreso PRIMARY KEY (cod_condicion),
  CONSTRAINT FK_condicionIngreso_usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
);

go

CREATE TABLE Partido(
  cod_partido INT IDENTITY(1,1),
  fecha DATE NOT NULL,
  humedad DECIMAL(3,1) NOT NULL,
  temperatura DECIMAL(3,1) NOT NULL,
  hora TIME NOT NULL,
  cod_estadio INT NOT NULL,
  fecha_creacion DATETIME DEFAULT GETDATE(),
  id_usuario INT NOT NULL,
  CONSTRAINT PK_partido PRIMARY KEY (cod_partido),
  CONSTRAINT FK_partido_estadio FOREIGN KEY  (cod_estadio) REFERENCES Estadio(cod_estadio),
  CONSTRAINT FK_partido_usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
);

go

CREATE TABLE Partido_jugado(
  cod_juego INT IDENTITY(1,1),
  minutos_jugados INT NOT NULL,
  km_recorridos DECIMAL(2,1) NOT NULL,
  id_jugadora CHAR(8) NOT NULL,
  cod_partido INT NOT NULL,
  cod_condicion INT NOT NULL,
  fecha_creacion DATETIME DEFAULT GETDATE(),
  id_usuario INT NOT NULL,
  CONSTRAINT PK_partidoJugado PRIMARY KEY (cod_juego),
  CONSTRAINT FK_partidoJugado_jugadora FOREIGN KEY (id_jugadora) REFERENCES Jugadora(id_jugadora),
  CONSTRAINT FK_partidoJugado_partido FOREIGN KEY (cod_partido) REFERENCES Partido(cod_partido),
  CONSTRAINT FK_partidoJugado_condIngreso FOREIGN KEY (cod_condicion) REFERENCES condicion_ingreso(cod_condicion),
  CONSTRAINT FK_partidoJugado_usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
);
