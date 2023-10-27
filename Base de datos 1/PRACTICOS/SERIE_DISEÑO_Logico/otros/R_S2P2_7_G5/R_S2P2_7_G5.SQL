CREATE DATABASE Serie2Ejercicio7;


CREATE TABLE Usuario(
	ID_usuario INT PRIMARY KEY IDENTITY(1, 1),
	Rol_usuario VARCHAR(50)
);


CREATE TABLE Categoria(
	ID_categoria INT PRIMARY KEY IDENTITY(1, 1),
	Nombre_categoria VARCHAR(50),
	Fecha_y_hora_creacion DATETIME DEFAULT GETDATE(),
	Usuario_creacion INT,
	CONSTRAINT FK_usuarioCategoria FOREIGN KEY(Usuario_creacion) REFERENCES Usuario(ID_usuario)
);


CREATE TABLE Cliente(
	DNI_cliente VARCHAR(8) PRIMARY KEY,
	Nombre VARCHAR(50),
	Apellido VARCHAR(50),
	Correo_Electronico VARCHAR(100) UNIQUE,
	Direccion VARCHAR(50),
	Fecha_y_hora_creacion DATETIME DEFAULT GETDATE(),
	Usuario_creacion INT,
	CONSTRAINT FK_usuarioCliente FOREIGN KEY(Usuario_creacion) REFERENCES Usuario(ID_usuario),
	CONSTRAINT CK_LongitudDNIcliente CHECK (LEN(DNI_cliente) <= 8)
);

CREATE TABLE Vendedor(
	DNI_vendedor VARCHAR(8) PRIMARY KEY,
	Nombre VARCHAR(50),
	Apellido VARCHAR(50),
	Correo_Electronico VARCHAR(100) UNIQUE,
	Direccion VARCHAR(50),
	Fecha_y_hora_creacion DATETIME DEFAULT GETDATE(),
	Usuario_creacion INT,
	CONSTRAINT FK_usuarioVendedor FOREIGN KEY(Usuario_creacion) REFERENCES Usuario(ID_usuario),
	CONSTRAINT CK_LongitudDNIvendedor CHECK (LEN(DNI_vendedor) <= 8)
);


CREATE TABLE Producto(
	ID_producto INT PRIMARY KEY IDENTITY(1,1),
	Nombre_producto VARCHAR(50),
	Precio MONEY,
	Stock INT,
	Descripcion VARCHAR(70),
	Fecha_y_hora_creacion DATETIME DEFAULT GETDATE(),
	Usuario_creacion INT,
	CONSTRAINT FK_usuarioProducto FOREIGN KEY(Usuario_creacion) REFERENCES Usuario(ID_usuario),
	DNI_vendedor VARCHAR(8),
	CONSTRAINT FK_DNI_vendedor FOREIGN KEY(DNI_vendedor) REFERENCES Vendedor(DNI_vendedor)
);

CREATE TABLE Consulta(
	ID_Consulta INT PRIMARY KEY IDENTITY(1,1),
	Fecha_consulta DATE,
	Texto_consulta VARCHAR(200),
	Fecha_y_hora_creacion DATETIME DEFAULT GETDATE(),
	Usuario_creacion INT,
	CONSTRAINT FK_usuarioConsulta FOREIGN KEY(Usuario_creacion) REFERENCES Usuario(ID_usuario),
	DNI_cliente VARCHAR(8),
	CONSTRAINT FK_DNI_cliente FOREIGN KEY(DNI_cliente) REFERENCES Cliente(DNI_cliente),
	ID_producto INT,
	CONSTRAINT FK_ID_producto FOREIGN KEY(ID_producto) REFERENCES Producto(ID_producto),
	ID_categoria INT, 
	CONSTRAINT FK_Id_categoria FOREIGN KEY(ID_categoria) REFERENCES Categoria(ID_categoria)
);


CREATE TABLE Respuesta(
	ID_Respuesta INT PRIMARY KEY IDENTITY(1,1),
	Texto_respuesta VARCHAR(200),
	Fecha_respuesta DATE,
	Fecha_y_hora_creacion DATETIME DEFAULT GETDATE(),
	Usuario_creacion INT,
	CONSTRAINT FK_usuarioRespuesta FOREIGN KEY(Usuario_creacion) REFERENCES Usuario(ID_usuario),
	ID_consulta INT,
	CONSTRAINT FK_ID_consulta FOREIGN KEY(ID_consulta) REFERENCES Consulta(ID_consulta),
	DNI_vendedor VARCHAR(8),
	CONSTRAINT FK_DNIVendedor FOREIGN KEY(DNI_vendedor) REFERENCES Vendedor(DNI_vendedor)
);

--inserta usuarios
INSERT INTO Usuario(Rol_usuario)
VALUES ('ADMINISTRADOR');

INSERT INTO Usuario(Rol_usuario)
VALUES ('SUPERADMIN');


-- inserta 2 clientes
INSERT INTO Cliente (DNI_cliente, Nombre, Apellido, Correo_Electronico, Direccion, Usuario_creacion)
VALUES ('12345678', 'Juan', 'Pérez', 'juan@example.com', '123 Calle Principal', (SELECT ID_usuario FROM Usuario WHERE ID_usuario = '2'));

INSERT INTO Cliente (DNI_cliente, Nombre, Apellido, Correo_Electronico, Direccion,Usuario_creacion)
VALUES ('43787444', 'fabri', 'Pérez', 'juan@gmail.com', '123 Calle Principal', (SELECT ID_usuario FROM Usuario WHERE ID_usuario = '2'));


-- inserta 2 vendedores
INSERT INTO Vendedor (DNI_vendedor, Nombre, Apellido, Correo_Electronico, Direccion, Usuario_creacion)
VALUES ('43787475', 'jose', 'candia', 'candia@gmail.com', '1890 Calle Las Heras', (SELECT ID_usuario FROM Usuario WHERE ID_usuario = '1'));

INSERT INTO Vendedor (DNI_vendedor, Nombre, Apellido, Correo_Electronico, Direccion, Usuario_creacion)
VALUES ('17434343', 'gonzalo', 'cristaldo', 'cristaldo@gmail.com', '1890 Calle Mitre',(SELECT ID_usuario FROM Usuario WHERE ID_usuario = '1'));

-- inserta 3 productos
INSERT INTO Producto (Nombre_producto, Precio, Stock, Descripcion, DNI_vendedor, Usuario_creacion)
VALUES ('Bicicleta', 69999.10, 3, 'Bicicleta rodado 29', (SELECT DNI_vendedor FROM Vendedor WHERE DNI_vendedor = '17434343'), (SELECT ID_usuario FROM Usuario WHERE ID_usuario = '1'));

INSERT INTO Producto (Nombre_producto, Precio, Stock, Descripcion, DNI_vendedor, Usuario_creacion)
VALUES ('Celular Samsung S23', 600000.00, 20, 'Celular Samsung S23', (SELECT DNI_vendedor FROM Vendedor WHERE DNI_vendedor = '43787475'), (SELECT ID_usuario FROM Usuario WHERE ID_usuario = '1'));

INSERT INTO Producto (Nombre_producto, Precio, Stock, Descripcion, DNI_vendedor, Usuario_creacion)
VALUES ('Celular iphone', 900000.00, 20, 'Celular', (SELECT DNI_vendedor FROM Vendedor WHERE DNI_vendedor = '43787475'), (SELECT ID_usuario FROM Usuario WHERE ID_usuario = '1'));


-- inserta las categorias
INSERT INTO Categoria(Nombre_categoria , Usuario_creacion)
VALUES ('Garantia', (SELECT ID_usuario FROM Usuario WHERE ID_usuario = '1'));

INSERT INTO Categoria(Nombre_categoria , Usuario_creacion)
VALUES ('Devoluciones',(SELECT ID_usuario FROM Usuario WHERE ID_usuario = '1'));

INSERT INTO Categoria(Nombre_categoria , Usuario_creacion)
VALUES ('Medios de pago', (SELECT ID_usuario FROM Usuario WHERE ID_usuario = '1'));


--inserta una consulta
INSERT INTO Consulta(Fecha_consulta,Texto_consulta , DNI_cliente, ID_producto ,ID_categoria , Usuario_creacion)
VALUES (GETDATE(), 'que medios de pago aceptan?', (SELECT DNI_cliente FROM Cliente WHERE DNI_cliente = '12345678'),(SELECT ID_producto FROM Producto WHERE ID_producto = '1'),(SELECT ID_categoria FROM Categoria WHERE ID_categoria = '3'), (SELECT ID_usuario FROM Usuario WHERE ID_usuario = '1'));

--inserta una respuesta
INSERT INTO Respuesta(Texto_respuesta,Fecha_respuesta , ID_consulta ,DNI_vendedor , Usuario_creacion)
VALUES ('aceptamos tarjetas de credito y debito de todos los bancos', GETDATE(), (SELECT ID_consulta FROM Consulta WHERE ID_Consulta = '1'),(SELECT DNI_vendedor FROM Vendedor WHERE DNI_vendedor = '17434343'),(SELECT ID_usuario FROM Usuario WHERE ID_usuario = '1'));


SELECT * FROM Cliente;
SELECT * FROM Vendedor;
SELECT * FROM Producto;
SELECT * FROM Categoria;
SELECT * FROM Consulta;
SELECT * FROM Usuario;
SELECT * FROM Respuesta;