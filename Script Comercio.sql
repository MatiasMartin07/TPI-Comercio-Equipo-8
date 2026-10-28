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