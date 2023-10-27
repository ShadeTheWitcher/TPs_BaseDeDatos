CREATE database Casos_abogados;

go

-- DEFINICION DE TABLAS --
CREATE TABLE Tipo_usuario(
	cod_tipoUsuario INT NOT NULL,
	descripcion VARCHAR(100) NOT NULL,
	fecha_creacion DATETIME DEFAULT GETDATE(),
	PRIMARY KEY(cod_tipoUsuario)
);

go 

CREATE TABLE Usuario(
	id_usuario INT IDENTITY,
	nombre_usuario VARCHAR(50) NOT NULL,
	mail VARCHAR(200) NOT NULL,
	contraseña VARCHAR(200) NOT NULL,
	fecha_creacion DATETIME DEFAULT GETDATE(),
	cod_tipoUsuario INT NOT NULL,
	CONSTRAINT PK_usuario PRIMARY KEY(id_usuario),
	CONSTRAINT FK_usuario_tipoUsuario FOREIGN KEY (cod_tipoUsuario) REFERENCES Tipo_usuario(cod_tipoUsuario),
	CONSTRAINT CK_User_mailUnico UNIQUE(mail),
	CONSTRAINT CK_User_mail CHECK (mail like '%@%'),
);

go 

CREATE TABLE Cliente(
  dni_cliente CHAR(8) NOT NULL,
  nombre VARCHAR(50)NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  direccion VARCHAR(100) NOT NULL,
  mail VARCHAR(100) NOT NULL,
  fecha_creacion DATETIME DEFAULT GETDATE(),
  id_usuario INT NOT NULL,
  CONSTRAINT PK_cliente PRIMARY KEY (dni_cliente),
  CONSTRAINT FK_cliente_usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
  CONSTRAINT CK_cliente_mailUnico UNIQUE(mail),
  CONSTRAINT CK_cliente_mail_aceptable CHECK (mail like '%@%'),
  CONSTRAINT CK_dni_cliente_soloNum CHECK(ISNUMERIC(dni_cliente)=1)
);

go 

CREATE TABLE Abogado(
  dni_abogado CHAR(8) NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  direccion VARCHAR(100) NOT NULL,
  matricula INT NOT NULL,
  mail VARCHAR(100) NOT NULL,
  fecha_creacion DATETIME DEFAULT GETDATE(),
  id_usuario INT NOT NULL,
  CONSTRAINT PK_abogado PRIMARY KEY (dni_abogado),
  CONSTRAINT FK_abogado_usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
  CONSTRAINT CK_abogado_mailUnico UNIQUE(mail),
  CONSTRAINT CK_abogado_mail_aceptable CHECK (mail like '%@%'),
  CONSTRAINT CK_dni_abogado_soloNum CHECK(ISNUMERIC(dni_abogado)=1)
);

go 

CREATE TABLE tipo_archivo(
  cod_archivo INT NOT NULL,
  descripcion VARCHAR(100) NOT NULL,
  fecha_creacion DATETIME DEFAULT GETDATE(),
  id_usuario INT NOT NULL,
  CONSTRAINT PK_tipoArchivo PRIMARY KEY (cod_archivo),
  CONSTRAINT FK_tipoArchivo_usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
);

go 

CREATE TABLE Estado_Caso(
  cod_estado INT NOT NULL,
  descripcion VARCHAR(100) NOT NULL,
  fecha_creacion DATETIME DEFAULT GETDATE(),
  id_usuario INT NOT NULL,
  CONSTRAINT PK_estadoCaso PRIMARY KEY (cod_estado),
  CONSTRAINT FK_estadoCaso_usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
);

go 

CREATE TABLE Procurador(
  dni_procurador CHAR(8) NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  direccion VARCHAR(100) NOT NULL,
  fecha_creacion DATETIME DEFAULT GETDATE(),
  id_usuario INT NOT NULL,
  CONSTRAINT PK_procurador PRIMARY KEY (dni_procurador),
  CONSTRAINT FK_procurador_usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
  CONSTRAINT CK_dni_procurador_soloNum CHECK(ISNUMERIC(dni_procurador)=1)
);

go 

CREATE TABLE Lote(
  cod_lote INT NOT NULL,
  descripcion_archivos VARCHAR(200) NOT NULL,
  enlace_repositorio VARCHAR(200) NOT NULL,
  cod_archivo INT NOT NULL,
  fecha_creacion DATETIME DEFAULT GETDATE(),
  id_usuario INT NOT NULL,
  CONSTRAINT PK_lote PRIMARY KEY (cod_lote),
  CONSTRAINT FK_lote_tipoArchivo FOREIGN KEY (cod_archivo) REFERENCES tipo_archivo(cod_archivo),
  CONSTRAINT FK_lote_usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
);

go 

CREATE TABLE Registro(
  cod_registro INT NOT NULL,
  cod_lote INT NOT NULL,
  fecha_creacion DATETIME DEFAULT GETDATE(),
  id_usuario INT NOT NULL,
  CONSTRAINT PK_registro PRIMARY KEY (cod_registro),
  CONSTRAINT FK_registro_lote FOREIGN KEY (cod_lote) REFERENCES Lote(cod_lote),
  CONSTRAINT FK_registro_usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
);

go 

CREATE TABLE Caso(
  num_expediente INT NOT NULL,
  fecha_inicio DATE NOT NULL,
  fecha_archivo DATE NOT NULL,
  cod_estado INT NOT NULL,
  dni_cliente CHAR(8) NOT NULL,
  dni_procurador CHAR(8) NOT NULL,
  cod_registro INT NOT NULL,
  fecha_creacion DATETIME DEFAULT GETDATE(),
  id_usuario INT NOT NULL,
  CONSTRAINT PK_caso PRIMARY KEY (num_expediente),
  CONSTRAINT FK_caso_estadoCaso FOREIGN KEY (cod_estado) REFERENCES Estado_Caso(cod_estado),
  CONSTRAINT FK_caso_cliente FOREIGN KEY (dni_cliente) REFERENCES Cliente(dni_cliente),
  CONSTRAINT FK_caso_procurador FOREIGN KEY (dni_procurador) REFERENCES Procurador(dni_procurador),
  CONSTRAINT FK_caso_registro FOREIGN KEY (cod_registro) REFERENCES Registro(cod_registro),
  CONSTRAINT FK_caso_usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
);

go 

CREATE TABLE Caso_abogado(
  fecha_ingreso DATETIME NOT NULL,
  dni_abogado CHAR(8) NOT NULL,
  num_expediente INT NOT NULL,
  fecha_creacion DATETIME DEFAULT GETDATE(),
  id_usuario INT NOT NULL,
  CONSTRAINT PK_casoAbogado PRIMARY KEY (dni_abogado, num_expediente),
  CONSTRAINT FK_casoAbogado_abogado FOREIGN KEY (dni_abogado) REFERENCES Abogado(dni_abogado),
  CONSTRAINT FK_casoAbogado_caso FOREIGN KEY (num_expediente) REFERENCES Caso(num_expediente),
  CONSTRAINT FK_casoAbogado_usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
);
