--- Creación BD---
use master
go
create database COMERCIO_TP_FINAL
go
use COMERCIO_TP_FINAL
go

---Creacion tablas---

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

create table Cliente(
    Id int not null primary key identity(1,1),
    Nombre varchar(50) not null,
    Apellido varchar(50) not null,
    Dni varchar(50) not null,
    Email varchar(200) not null,
    Activo Bit not null default 1
);

CREATE TABLE Usuario (
    Id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    NombreUsuario VARCHAR(50) NOT NULL UNIQUE,
    Pass VARCHAR(100) NOT NULL,
    Rol VARCHAR(30) NOT NULL,
    Activo BIT NOT NULL DEFAULT 1
);

create table Proveedor(
IdProveedor INT PRIMARY KEY IDENTITY(1,1),
Codigo VARCHAR(50) UNIQUE NOT NULL,
RazonSocial VARCHAR(100) NOT NULL,
CUIT VARCHAR(20),
Telefono VARCHAR(20),
Mail VARCHAR(50),
Activo BIT NOT NULL
    CONSTRAINT DF_Proveedor_Activo DEFAULT (1)
);
GO

Create table Venta(
   Id int not null primary key identity(1,1),
   IdCliete int not null foreign key references Cliente(Id),
   fecha datetime not null,
   NroFactura varchar(100) not null,
   Total decimal not null,
   Anulado bit not null default 0
)
go

--detalle venta
Create table DetalleVenta(
    Id int not null primary key identity(1,1),
    IdProducto int not null foreign key references Producto(IdProducto),
    IdVenta int not null foreign key references Venta(Id),
    Cantidad int not null,
    PrecioUnitario decimal not null,
    SubTotal decimal not null
)




---Carga de datos---
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


INSERT INTO Cliente (Nombre, Apellido,Dni,Email,Activo) 
VALUES 
('Juan', 'Pérez','32456711','juanperez@gmail.com', 1),
('María', 'Gómez','37980100','gomez@maria.gmail.com', 1),
('Carlos', 'Rodríguez','29341678','rodriguezcarlos@gmail.com',1),
('Ana', 'Martínez','27900243','ana@gmail.com',1);
go

INSERT INTO Usuario (Nombre, Apellido, NombreUsuario, Pass, Rol, Activo)
VALUES
('Carlos', 'Administrador', 'admin', '1234', 'Administrador', 1),
('Lucía', 'Gómez', 'lgomez', 'abcd', 'Vendedor', 1),
('Esteban', 'Pérez', 'eperez', 'clave123', 'Vendedor', 1),
('Mariana', 'López', 'mlopez', 'pass456', 'Administrador', 1);


--Procedimiento Almacenado---
Create Procedure spListaCliente
AS
BEGIN
    SELECT Id, Nombre, Apellido,Dni,Email, Activo 
    FROM Cliente
END
go

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

-- Procedimientos de Usuarios

CREATE PROCEDURE sp_ListaUsuario
AS
BEGIN
    SELECT Id, Nombre, Apellido, NombreUsuario, Pass, Rol, Activo
    FROM Usuario;
END;
GO

CREATE PROCEDURE sp_listaUsuarioId
    @id INT
AS
BEGIN
    SELECT Id, Nombre, Apellido, NombreUsuario, Pass, Rol, Activo
    FROM Usuario
    WHERE Id = @id;
END;
GO

CREATE PROCEDURE sp_AgregarUsuario
    @nombre VARCHAR(50),
    @apellido VARCHAR(50),
    @nombreUsuario VARCHAR(50),
    @pass VARCHAR(100),
    @rol VARCHAR(30)
AS
BEGIN
    INSERT INTO Usuario (Nombre, Apellido, NombreUsuario, Pass, Rol)
    VALUES (@nombre, @apellido, @nombreUsuario, @pass, @rol);
END;
GO

CREATE PROCEDURE sp_ModificarUsuario
    @id INT,
    @nombre VARCHAR(50),
    @apellido VARCHAR(50),
    @nombreUsuario VARCHAR(50),
    @pass VARCHAR(100),
    @rol VARCHAR(30)
AS
BEGIN
    UPDATE Usuario
    SET Nombre = @nombre,
        Apellido = @apellido,
        NombreUsuario = @nombreUsuario,
        Pass = @pass,
        Rol = @rol
    WHERE Id = @id;
END;
GO

CREATE PROCEDURE sp_UsuarioExistente
    @nombreUsuario VARCHAR(50)
AS
BEGIN
    SELECT Id, Nombre, Apellido, NombreUsuario, Pass, Rol, Activo
    FROM Usuario
    WHERE NombreUsuario = @nombreUsuario;
END;
GO

-- Proveedores

Create Procedure spListaProveedor
AS
BEGIN
    SELECT IdProveedor, Codigo, RazonSocial,CUIT,Telefono,Mail ,Activo 
    FROM Proveedor
END
GO


Create PROCEDURE SP_AgregarProveedor
    @Codigo VARCHAR(50),
    @RazonSocial VARCHAR(100),
    @CUIT VARCHAR(20),
    @Telefono VARCHAR(20),
    @Mail VARCHAR(50)
AS
BEGIN
    INSERT INTO Proveedor (Codigo, RazonSocial, CUIT, Telefono, Mail)
    VALUES (@Codigo, @RazonSocial, @CUIT, @Telefono, @Mail)
    SELECT CONVERT(INT, SCOPE_IDENTITY()) AS IdProveedor;
END
GO


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


CREATE PROCEDURE SP_BajaProveedor
    @IdProveedor INT
AS
BEGIN
    UPDATE Proveedor 
    SET Activo = 0 
    WHERE IdProveedor = @IdProveedor;
END
go


Create Procedure spListaIDProveedor
@idProveedor int
AS
BEGIN
    SELECT IdProveedor, Codigo, RazonSocial,CUIT,Telefono, mail, Activo 
    FROM Proveedor where IdProveedor=@idProveedor
END
GO


CREATE PROCEDURE spBuscarPorCuit
    @CUIT VARCHAR(20),
    @IdActual INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT CAST(
        CASE WHEN EXISTS (
            SELECT 1
            FROM dbo.Proveedor
            WHERE CUIT = @CUIT
              AND IdProveedor <> @IdActual
        )
        THEN 1 ELSE 0 END
        AS BIT
    ) AS Existe;
END
GO

Create Procedure spBuscarPorCodigo
    @Codigo VARCHAR(50),
    @IdActual Int
AS
BEGIN
    SET NOCOUNT ON;
     SELECT CAST(
        CASE WHEN EXISTS (
            SELECT 1
            FROM Proveedor
            WHERE Codigo = @Codigo
              AND IdProveedor <> @IdActual
        )
        THEN 1 ELSE 0 END
        AS BIT
    ) AS Existe;
END
GO

--producto
create procedure sp_ListarPorNombre
@nombre varchar(50)
as 
begin
  select IdProducto, Nombre,StockActual,StockMinimo,UltimoPrecioCompra,PorcentajeGanancia,Activo
  from Producto WHERE Nombre LIKE '%' + @nombre + '%'
      AND Activo = 1
    ORDER BY Nombre;
end

---stock de productos 
create procedure sp_DescontarStock
@cantidad int,
@idProducto int 
as
begin
  Update Producto set StockActual = StockActual - @cantidad
  where IdProducto = @idProducto
  and StockActual >= @cantidad
  select @@ROWCOUNT as filasAfectadas;
end


--ventas
Create procedure sp_AgregarVenta
@idCliente int,
@fecha datetime,
@nroFactura varchar(100),
@total decimal
as
begin
   Insert into Venta (IdCliete,fecha,NroFactura,Total)
   values (@idCliente,@fecha,@nroFactura,@total)
   SELECT SCOPE_IDENTITY()
end

create procedure sp_ListaVenta
as
begin
    select 
        V.Id, 
        V.Fecha, 
        V.NroFactura, 
        V.Total, 
        C.Id as IdCliente,      
        C.Nombre as NombreCliente,
        V.Anulado
    from Venta V
    INNER JOIN Cliente C on V.IdCliete = C.Id;
end
--obtener factura
CREATE PROCEDURE spObtenerUltimoNumeroFactura
AS
BEGIN
    SELECT ISNULL(MAX(CAST(REPLACE(NroFactura, 'FAC-', '') AS INT)), 0) + 1 AS SiguienteNumero 
    FROM Venta;
END


EXEC sp_ListaVenta

--detalle venta

Create procedure sp_AgregarDetalleVenta 
@idProducto int,
@idVenta int,
@cantidad int,
@precioUnitario decimal,
@subTotal decimal
as
begin
  Insert into DetalleVenta (IdProducto,IdVenta,Cantidad,PrecioUnitario,SubTotal)
  values (@idProducto,@idVenta,@cantidad,@precioUnitario,@subTotal)
end

--listar por id
create procedure sp_ListarVentaId
 @id int
as
begin
    select 
        V.Id, 
        V.Fecha, 
        V.NroFactura, 
        V.Total, 
        C.Id as IdCliente,    
        C.Nombre as NombreCliente,
        V.Anulado
    from Venta V
    inner join Cliente C on V.IdCliete = C.Id
    Where V.Id = @id
end

-- anular la venta y devolver el stock
CREATE PROCEDURE sp_AnularVenta
    @idVenta INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        
        IF NOT EXISTS (SELECT 1 FROM Venta WHERE Id = @idVenta AND Anulado = 0)
        BEGIN
            ROLLBACK TRANSACTION;
            SELECT 0 AS Resultado; 
            RETURN;
        END

        UPDATE Venta
        SET Anulado = 1
        WHERE Id = @idVenta;

        UPDATE P
        SET P.StockActual = P.StockActual + DV.Cantidad
        FROM Producto P
        INNER JOIN DetalleVenta DV ON P.IdProducto = DV.IdProducto
        WHERE DV.IdVenta = @idVenta;

        COMMIT TRANSACTION;
        SELECT 1 AS Resultado; 
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END;

--obtener el id venta del detalle
Create procedure sp_ObtenerDetalleVenta
 @idVenta int
as
begin
     select 
        d.Id,
        d.IdVenta,      
        d.IdProducto,   
        p.Nombre as NombreProducto,
        d.Cantidad,
        d.PrecioUnitario,
        d.SubTotal
    from DetalleVenta d
    inner join Producto p on d.IdProducto = p.IdProducto
    where d.IdVenta = @IdVenta;
end

