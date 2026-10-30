use master
go
create database COMERCIO_TP_FINAL
go
use COMERCIO_TP_FINAL
go

create table Producto(
    IdProducto INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(100) NOT NULL,
    StockActual INT NOT NULL,
    StockMinimo INT NOT NULL,
    UltimoPrecioCompra DECIMAL(18,2) NOT NULL,
    PorcentajeGanancia DECIMAL(5,2) NOT NULL,
    Activo BIT NOT NULL
);

insert into Producto(Nombre,StockActual,StockMinimo,UltimoPrecioCompra,PorcentajeGanancia,Activo)
values  ('Cafe molido',15,10,850.00,25.00,1),
        ('Yerba mate', 8, 10, 1100.00, 20.00, 1),
        ('Azucar', 20, 5, 650.00, 25.00, 1),
        ('Leche', 18, 10, 1200.00, 20.00, 1),
        ('Harina', 25, 8, 800.00, 30.00, 1),
        ('Arroz', 30, 10, 950.00, 25.00, 1),
        ('Fideos', 22, 8, 750.00, 30.00, 1),
        ('Aceite', 12, 5, 1800.00, 20.00, 1),
        ('Galletitas', 16, 6, 900.00, 35.00, 1),
        ('Detergente', 14, 5, 1500.00, 30.00, 1);
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