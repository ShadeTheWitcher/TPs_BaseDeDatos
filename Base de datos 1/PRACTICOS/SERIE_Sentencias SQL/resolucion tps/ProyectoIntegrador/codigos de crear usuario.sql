-- Crear dos usuarios de base de datos:
CREATE LOGIN UsuarioAdmin WITH PASSWORD = 'pwAdmin';
CREATE LOGIN UsuarioSoloLectura WITH PASSWORD = 'pwSoloLectura';


--Asignar permisos al usuario de administrador:
USE base_consorcioPI;
CREATE USER UsuarioAdmin FOR LOGIN UsuarioAdmin;
EXEC sp_addrolemember 'db_owner', 'UsuarioAdmin';

--Asignar permisos al usuario de solo lectura:
USE base_consorcioPI;
CREATE USER UsuarioSoloLectura FOR LOGIN UsuarioSoloLectura;
GRANT EXECUTE TO UsuarioSoloLectura;


-- Inserción con el usuario de administrador
EXECUTE AS LOGIN = 'UsuarioAdmin';
INSERT INTO administrador (apeynom, viveahi, tel, sexo, fechnac) VALUES ('Admin', 'S', '123456', 'M', GETDATE());
REVERT;

-- Inserción con el usuario de solo lectura a través del procedimiento almacenado
EXECUTE AS LOGIN = 'UsuarioSoloLectura';
EXECUTE NombreDelProcedimiento; -- Reemplaza "NombreDelProcedimiento" con el nombre de tu procedimiento
REVERT;