CREATE DATABASE JSFM_VISION

USE JSFM_VISION

CREATE TABLE TipoEntidad
(
  Descripcion VARCHAR NOT NULL,
  Porcentual FLOAT NOT NULL,
  ID_TipoEntidad INT NOT NULL,
  FechaUltimaModificacion DATETIME NOT NULL,
  UsuarioIdUltimaModificacion INT NOT NULL,
  CONSTRAINT PK_TipoEntidad_ID_TípoEntidad PRIMARY KEY (ID_TipoEntidad) 
);

GO

CREATE TABLE Calle
(
  ID_Calle INT NOT NULL,
  Nombre INT NOT NULL,
  Ciudad VARCHAR NOT NULL,
  FechaUltimaModificacion DATETIME NOT NULL,
  UsuarioIdUltimaModificacion INT NOT NULL,
  CONSTRAINT PK_Calle_ID_CALLE PRIMARY KEY (ID_Calle)
);

GO

CREATE TABLE Zona
(
  ID_Zona INT NOT NULL,
  Descripcion INT NOT NULL,
  FechaUltimaModificacion DATETIME NOT NULL,
  UsuarioIdUltimaModificacion INT NOT NULL,
  CONSTRAINT PK_Zona_ID_Zona PRIMARY KEY (ID_Zona)
);

GO

CREATE TABLE Servicios
(
  ID_Servicio INT NOT NULL,
  Descripcion INT NOT NULL,
  Precio FLOAT NOT NULL,
  FechaUltimaModificacion DATETIME NOT NULL,
  UsuarioIdUltimaModificacion INT NOT NULL,
  CONSTRAINT PK_Servicios_ID_Servicio PRIMARY KEY (ID_Servicio)
);

GO

CREATE TABLE Socio_Entidad
(
--Algunos de los campos solicitados en la actividad, no estaban incluidas en el dominio de nuestro problema
  ID_Socio INT NOT NULL,
  Nro_Documento_Socio VARCHAR(8) CHECK (LEN(Nro_Documento_Socio) <= 8), --Verifica que la longitud del numero de documento sea menor o igual a 8
  Nombre VARCHAR NOT NULL,
  Apellido VARCHAR NOT NULL,
  ID_TipoEntidad INT NOT NULL,
  ID_Zona INT NOT NULL,
  ID_Calle INT NOT NULL,
  FechaUltimaModificacion DATETIME NOT NULL,
  UsuarioIdUltimaModificacion INT NOT NULL,
  FechaNacimiento DATETIME CHECK (DATEDIFF(YEAR, FechaNacimiento, GETDATE()) <= 100), --compara que la edad no sea superior a 100 años
  Correo_Electronico VARCHAR(150) NOT NULL UNIQUE, --Verifica que no se inserten datos duplicados en esta columna
  CONSTRAINT PK_Socio_Entidad_ID_Socio PRIMARY KEY (ID_Socio),
  CONSTRAINT FK_Socio_Entidad_TipoEntidad_ID_TipoEntidad FOREIGN KEY (ID_TipoEntidad) REFERENCES TipoEntidad(ID_TipoEntidad),
  CONSTRAINT FK_Socio_Entidad_Zona_ID_Zona FOREIGN KEY (ID_Zona) REFERENCES Zona(ID_Zona),
  CONSTRAINT FK_Socio_Entidad_Calle_ID_Calle FOREIGN KEY (ID_Calle) REFERENCES Calle(ID_Calle)
);

GO

CREATE TABLE Factura
(
  Monto FLOAT NOT NULL,
  Importe_Total INT NOT NULL,
  Servicio_descrpcion VARCHAR NOT NULL,
  Fecha DATE NOT NULL,
  Factura_Numero VARCHAR NOT NULL UNIQUE, --Valor Unico
  ID_Factura INT NOT NULL,
  ID_Servicio INT NOT NULL,
  ID_Socio INT NOT NULL,
  FechaUltimaModificacion DATETIME NOT NULL,
  UsuarioIdUltimaModificacion INT NOT NULL,
  CONSTRAINT PK_FACTURA_ID_Factura PRIMARY KEY (ID_Factura),
  CONSTRAINT FK_FACTURA_SERVICIOS_ID_Servicio FOREIGN KEY (ID_Servicio) REFERENCES Servicios(ID_Servicio),
  CONSTRAINT FK_FACTURA_Socio_Entidad_ID_Socio FOREIGN KEY (ID_Socio) REFERENCES Socio_Entidad(ID_Socio),
);

GO