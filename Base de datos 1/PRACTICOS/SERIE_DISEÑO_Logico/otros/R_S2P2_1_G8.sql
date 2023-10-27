CREATE DATABASE ejercicioSlack;
USE ejercicioSlack;


CREATE TABLE tipoUsuario(
idTipoUsuario INT NOT NULL IDENTITY(1,1),
descripcion VARCHAR(200),
CONSTRAINT PK_idTipoUsuario PRIMARY KEY(idTipoUsuario),
);
GO

CREATE TABLE usuario(
idUsuario INT NOT NULL IDENTITY(1,1),
nombreUsuario VARCHAR(200),
correoElectronico VARCHAR(200) UNIQUE,
fechaRegistro DATE NOT NULL DEFAULT GETDATE(),
idTipoUsuario INT NOT NULL DEFAULT(2),
CONSTRAINT PK_idUsuario PRIMARY KEY(idUsuario),
CONSTRAINT FK_idTipoUsuario FOREIGN KEY (idTipoUsuario) REFERENCES tipoUsuario(idTipoUsuario),
);
GO

CREATE TABLE tipo(
idTipo INT NOT NULL IDENTITY(1,1),
nombre VARCHAR(200),
fechaHoraCracion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
fechaHoraModificacion DATETIME,
idUsuario INT,
CONSTRAINT PK_idTipo PRIMARY KEY(idTipo),
CONSTRAINT FK_idUsuario FOREIGN KEY (idUsuario) REFERENCES usuario(idUsuario),
);
GO

CREATE TABLE compositores(
idCompositor INT NOT NULL IDENTITY(1,1),
nombreArtista VARCHAR(200),
nombreGrupo VARCHAR(200),
fechaHoraCracion DATETIME DEFAULT CURRENT_TIMESTAMP,
fechaHoraModificacion DATETIME,
idUsuario INT,
CONSTRAINT PK_idCompositor PRIMARY KEY(idCompositor),
CONSTRAINT FK_idUsuario_compositores FOREIGN KEY (idUsuario) REFERENCES usuario(idUsuario),
);
GO

CREATE TABLE album(
idAlbum INT NOT NULL IDENTITY(1,1),
nombre VARCHAR,
fechaHoraCracion DATETIME DEFAULT CURRENT_TIMESTAMP,
fechaHoraModificacion DATETIME,
idUsuario INT,
CONSTRAINT PK_idAlbum PRIMARY KEY(idAlbum),
CONSTRAINT FK_idUsuario_album FOREIGN KEY (idUsuario) REFERENCES usuario(idUsuario),
);
GO

CREATE TABLE genero(
idGenero INT NOT NULL IDENTITY(1,1),
nombre VARCHAR,
fechaHoraCracion DATETIME DEFAULT CURRENT_TIMESTAMP,
fechaHoraModificacion DATETIME,
idUsuario INT,
CONSTRAINT PK_idGenero PRIMARY KEY(idGenero),
CONSTRAINT FK_idUsuario_genero FOREIGN KEY (idUsuario) REFERENCES usuario(idUsuario),
);
GO

CREATE TABLE audio(
idAudio INT NOT NULL IDENTITY(1,1),
titulo VARCHAR(200),
duracion TIME,
anioLanzamiento DATE,
idCompositor INT,
idAlbum INT,
idTipo INT,
fechaHoraCracion DATETIME DEFAULT CURRENT_TIMESTAMP,
fechaHoraModificacion DATETIME,
idUsuario INT,
CONSTRAINT PK_idAudio PRIMARY KEY(idAudio),
CONSTRAINT FK_idUsuario_audio FOREIGN KEY (idUsuario) REFERENCES usuario(idUsuario),
CONSTRAINT FK_idCompositor FOREIGN KEY (idCompositor) REFERENCES compositores(idCompositor),
CONSTRAINT FK_idAlbum FOREIGN KEY (idAlbum) REFERENCES album(idAlbum),
CONSTRAINT FK_idTipo FOREIGN KEY (idTipo) REFERENCES tipo(idTipo),
);
GO

CREATE TABLE generoAudio(
idAudio INT,
idGenero INT,
fechaHoraCracion DATETIME DEFAULT CURRENT_TIMESTAMP,
fechaHoraModificacion DATETIME,
idUsuario INT,
CONSTRAINT FK_idUsuario_generoAudio FOREIGN KEY (idUsuario) REFERENCES usuario(idUsuario),
CONSTRAINT FK_idAudio FOREIGN KEY (idAudio) REFERENCES audio(idAudio),
CONSTRAINT FK_idGenero FOREIGN KEY (idGenero) REFERENCES genero(idGenero),
);
GO

CREATE TABLE listaReproduccion(
idLista INT NOT NULL IDENTITY(1,1),
nombre VARCHAR(200),
fechaCreacion DATE,
idUsuario INT,
IdAudio INT,
fechaHoraCracion DATETIME DEFAULT CURRENT_TIMESTAMP,
fechaHoraModificacion DATETIME,
idUsuarioAdmin INT FOREIGN KEY REFERENCES usuario(idUsuario),
CONSTRAINT PK_idLista PRIMARY KEY(idLista),
CONSTRAINT FK_idUsuario_listaRepro FOREIGN KEY (idUsuario) REFERENCES usuario(idUsuario),
CONSTRAINT FK_idAdmin FOREIGN KEY (idUsuarioAdmin) REFERENCES usuario(idUsuario),
CONSTRAINT FK_IdAudio_listaRepro FOREIGN KEY (IdAudio) REFERENCES audio(idAudio),
);
GO

INSERT INTO tipoUsuario(descripcion) VALUES('admin');
INSERT INTO tipoUsuario(descripcion) VALUES('comun');

INSERT INTO usuario(nombreUsuario,correoElectronico,idTipoUsuario) VALUES('nicolas', 'nicolaspeloso@hotmail','1');
INSERT INTO usuario(nombreUsuario,correoElectronico,idTipoUsuario) VALUES('anibal', 'nicolasanibal@hotmail','2');

INSERT INTO tipo(nombre, fechaHoraCracion, idUsuario) VALUES('musica', convert(datetime,'2023-09-23T12:20:00'),
'1');

INSERT INTO compositores(nombreArtista,fechaHoraCracion,idUsuario) VALUES('Bob Marley',
convert(datetime,'2023-09-23T12:20:00'), '1');
INSERT INTO compositores(nombreArtista,nombreGrupo,fechaHoraCracion,idUsuario) VALUES('Fredy','los Ramones',
convert(datetime,'2023-09-23T12:20:00'), '1');
INSERT INTO compositores(nombreArtista,nombreGrupo,idUsuario) VALUES('Ringo Star','los Beatles', '1');

SELECT * FROM usuario;

SELECT * FROM compositores;