use master
go
create database COMERCIO_TP_FINAL
go
use COMERCIO_TP_FINAL
go

CREATE TABLE Marca (
    IdMarca INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(100) NOT NULL,
    Activo BIT NOT NULL DEFAULT 1
);

CREATE TABLE Categoria (
    IdCategoria INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(100) NOT NULL,
    Activo BIT NOT NULL DEFAULT 1
);


CREATE TABLE Producto (
    IdProducto INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(100) NOT NULL,
    IdMarca INT NOT NULL,
    IdCategoria INT NOT NULL,
    StockActual INT NOT NULL,
    StockMinimo INT NOT NULL,
    UltimoPrecioCompra DECIMAL(18,2) NOT NULL,
    PorcentajeGanancia DECIMAL(5,2) NOT NULL,
    UrlImagen VARCHAR(2048) NULL,
    Activo BIT NOT NULL,

    CONSTRAINT FK_Producto_Marca
        FOREIGN KEY (IdMarca) REFERENCES Marca(IdMarca),

    CONSTRAINT FK_Producto_Categoria
        FOREIGN KEY (IdCategoria) REFERENCES Categoria(IdCategoria)
);

INSERT INTO Marca (Nombre)
VALUES ('Cabrales'),
       ('La Serenísima'),
       ('Marolio');

INSERT INTO Categoria (Nombre)
VALUES ('Almacén'),
       ('Lácteos'),
       ('Limpieza');

INSERT INTO Producto (
    Nombre, IdMarca, IdCategoria,
    StockActual, StockMinimo,
    UltimoPrecioCompra, PorcentajeGanancia, Activo
)
VALUES
    ('Cafe molido', 1, 1, 15, 10, 850.00, 25.00, 1),
    ('Yerba mate',  3, 1,  8, 10, 1100.00, 20.00, 1),
    ('Azucar',      3, 1, 20,  5, 650.00, 25.00, 1),
    ('Leche',       2, 2, 18, 10, 1200.00, 20.00, 1),
    ('Harina',      3, 1, 25,  8, 800.00, 30.00, 1),
    ('Arroz',       3, 1, 30, 10, 950.00, 25.00, 1),
    ('Fideos',      3, 1, 22,  8, 750.00, 30.00, 1),
    ('Aceite',      3, 1, 12,  5, 1800.00, 20.00, 1),
    ('Galletitas',  3, 1, 16,  6, 900.00, 35.00, 1),
    ('Detergente',  3, 3, 14,  5, 1500.00, 30.00, 1);
GO


select * from Producto;
go
create table Cliente(
    Id int not null primary key identity(1,1),
    Nombre varchar(50) not null,
    Apellido varchar(50) not null,
    Dni varchar(50) not null,
    Email varchar(200) not null,
    Activo Bit not null default 1
)

INSERT INTO Cliente (Nombre, Apellido,Dni,Email,Activo) 
VALUES 
('Juan', 'Pérez','32456711','juanperez@gmail.com', 1),
('María', 'Gómez','37980100','gomez@maria.gmail.com', 1),
('Carlos', 'Rodríguez','29341678','rodriguezcarlos@gmail.com',1),
('Ana', 'Martínez','27900243','ana@gmail.com',1);

select * from Cliente

go
--Procedimiento Almacenado---
Create Procedure spListaCliente
AS
BEGIN
    SELECT Id, Nombre, Apellido,Dni,Email, Activo 
    FROM Cliente
END
go
--Exec spListaCliente

Create Procedure spListaClienteId
@id int
AS
BEGIN
    SELECT Id, Nombre, Apellido,Dni,Email, Activo 
    FROM Cliente where Id=@id
END
go
Create Procedure spAltaCliente
    @nombre varchar(50),
    @apellido varchar(50),
    @dni varchar(50),
    @email varchar(200)
    As
    Begin
       Insert into Cliente (Nombre,Apellido,Dni,Email,Activo)
       values (@nombre,@apellido,@dni,@email,1)
    end
go
--exec spAltaCliente 'Peter', 'Parker','21900211','parkerpeter@gmail.com'

Create procedure spModificarCliente
    @id int,
    @nombre varchar(50),
    @apellido varchar(50),
    @dni varchar(50),
    @email varchar(200),
    @activo bit
    As
    Begin
       update Cliente set Nombre = @nombre, Apellido = @apellido, Dni=@dni, Email=@email, Activo=@activo
       where Id = @id
    end
go
Create procedure spListaClienteDni
@dni varchar(50)
AS
BEGIN
    SELECT Id, Nombre, Apellido,Dni,Email, Activo 
    FROM Cliente where Dni=@dni
END
go


CREATE TABLE Usuario (
    Id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    NombreUsuario VARCHAR(50) NOT NULL UNIQUE, 
    Pass VARCHAR(100) NOT NULL,
    Rol VARCHAR(30) NOT NULL,                
    Activo BIT NOT NULL DEFAULT 1
);

--INSERT INTO Usuario (Nombre, Apellido, NombreUsuario, Pass, Rol, Activo) 
--VALUES 
--('Carlos', 'Administrador', 'admin', '1234', 'Administrador', 1),
--('Lucía', 'Gómez', 'lgomez', 'abcd', 'Vendedor', 1),
--('Esteban', 'Pérez', 'eperez', 'clave123', 'Vendedor', 1),
--('Mariana', 'López', 'mlopez', 'pass456', 'Administrador', 1);
<<<<<<< Updated upstream

=======
go
create table Proveedor(
IdProveedor INT PRIMARY KEY IDENTITY(1,1),
Codigo VARCHAR(50) UNIQUE NOT NULL,
RazonSocial VARCHAR(100) NOT NULL,
CUIT VARCHAR(20),
Telefono VARCHAR(20),
Mail VARCHAR(50),
Activo bit
);
go
insert into Proveedor values ('M1020', 'Dos Anclas', '20123456789', '1145678855', 'dosanclas@gmail.com', 1)

--select * from Proveedor

Create Procedure spListaProveedor
AS
BEGIN
    SELECT IdProveedor, Codigo, RazonSocial,CUIT,Telefono,Mail ,Activo 
    FROM Proveedor
END

--1 SP Para agregar Proveedor
CREATE PROCEDURE SP_AgregarProveedor
    @Codigo VARCHAR(50),
    @RazonSocial VARCHAR(100),
    @CUIT VARCHAR(20),
    @Telefono VARCHAR(20),
    @Mail VARCHAR(50)
AS
BEGIN
    INSERT INTO Proveedor (Codigo, RazonSocial, CUIT, Telefono, Mail, Activo)
    VALUES (@Codigo, @RazonSocial, @CUIT, @Telefono, @Mail, 1)
END
GO
-- 2 SP Para modificar el proveedor 
CREATE PROCEDURE SP_ModificarProveedor
    @IdProveedor INT,
    @Codigo VARCHAR(50),
    @RazonSocial VARCHAR(100),
    @CUIT VARCHAR(20),
    @Telefono VARCHAR(20),
    @Mail VARCHAR(50)
AS
BEGIN
    UPDATE Proveedor 
    SET Codigo = @Codigo,
        RazonSocial = @RazonSocial,
        CUIT = @CUIT,
        Telefono = @Telefono,
        Mail = @Mail
    WHERE IdProveedor = @IdProveedor
END
GO

-- 3 SP para la baja logica
CREATE PROCEDURE SP_BajaProveedor
    @IdProveedor INT
AS
BEGIN
    UPDATE Proveedor 
    SET Activo = 0 
    WHERE IdProveedor = @IdProveedor
END
GO
Create Procedure spListaIDProveedor
@idProveedor int
AS
BEGIN
    SELECT IdProveedor, Codigo, RazonSocial,CUIT,Telefono, mail, Activo 
    FROM Proveedores where IdProveedores=@idProveedor
END
GO
--SP Para buscar por cuit
CREATE PROCEDURE spBuscarPorCuit
    @CUIT VARCHAR(20)
AS
BEGIN
    SELECT IdProveedor 
    FROM Proveedor 
    WHERE CUIT = @CUIT
END
GO
>>>>>>> Stashed changes
