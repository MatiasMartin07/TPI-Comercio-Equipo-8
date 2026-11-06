using System;
using System.Collections.Generic;
using System.Globalization;
using Dominio;


namespace Negocio
{
    public class ProductoNegocio
    {
        //public List<Producto> Listar()
        //{
        //    List<Producto> lista = new List<Producto>();
        //    AccesoDatos datos = new AccesoDatos();

        //    try
        //    {
        //        datos.setearConsulta("SELECT p.IdProducto, p.Nombre, p.StockActual, p.StockMinimo, " +
        //                            "p.UltimoPrecioCompra, p.PorcentajeGanancia, p.UrlImagen, p.Activo, " +
        //                            "m.IdMarca, m.Nombre AS NombreMarca, " +
        //                            "c.IdCategoria, c.Nombre AS NombreCategoria " +
        //                            "FROM Producto p " +
        //                            "INNER JOIN Marca m ON p.IdMarca = m.IdMarca " +
        //                            "INNER JOIN Categoria c ON p.IdCategoria = c.IdCategoria");
        //        datos.ejecutarLectura();

        //        while (datos.Lector.Read())
        //        {
        //            Producto aux = new Producto();

        //            aux.IdProducto = (int)datos.Lector["IdProducto"];
        //            aux.Nombre = (string)datos.Lector["Nombre"];
        //            aux.StockActual = (int)datos.Lector["StockActual"];
        //            aux.StockMinimo = (int)datos.Lector["StockMinimo"];
        //            aux.UltimoPrecioCompra = (decimal)datos.Lector["UltimoPrecioCompra"];
        //            aux.PorcentajeGanancia = (decimal)datos.Lector["PorcentajeGanancia"];

        //            if (datos.Lector["UrlImagen"] != DBNull.Value)
        //            {
        //                aux.UrlImagen = (string)datos.Lector["UrlImagen"];
        //            }
        //            aux.Activo = (bool)datos.Lector["Activo"];

        //            aux.Marca = new Marca();
        //            aux.Marca.IdMarca = (int)datos.Lector["IdMarca"];
        //            aux.Marca.Nombre = (string)datos.Lector["NombreMarca"];

        //            aux.Categoria = new Categoria();
        //            aux.Categoria.IdCategoria = (int)datos.Lector["IdCategoria"];
        //            aux.Categoria.Nombre = (string)datos.Lector["NombreCategoria"];

        //            lista.Add(aux);
        //        }
        //        return lista;
        //    }
        //    catch (Exception)
        //    {
        //        throw;
        //    }
        //    finally
        //    {
        //        datos.cerrarConexion();
        //    }
        //}
        //public Producto BuscarPorId(int idProducto)
        //{
        //    AccesoDatos datos = new AccesoDatos();

        //    try
        //    {
        //        datos.setearConsulta(
        //            "SELECT IdProducto, Nombre, IdMarca, IdCategoria, " +
        //            "StockActual, StockMinimo, UltimoPrecioCompra, " +
        //            "PorcentajeGanancia, UrlImagen, Activo " +
        //            "FROM dbo.Producto WHERE IdProducto = @IdProducto");

        //        datos.setearParametro("@IdProducto", idProducto);
        //        datos.ejecutarLectura();

        //        if (!datos.Lector.Read())
        //        {
        //            return null;
        //        }

        //        Producto producto = new Producto();
        //        producto.IdProducto = (int)datos.Lector["IdProducto"];
        //        producto.Nombre = (string)datos.Lector["Nombre"];
        //        producto.StockActual = (int)datos.Lector["StockActual"];
        //        producto.StockMinimo = (int)datos.Lector["StockMinimo"];
        //        producto.UltimoPrecioCompra = (decimal)datos.Lector["UltimoPrecioCompra"];
        //        producto.PorcentajeGanancia = (decimal)datos.Lector["PorcentajeGanancia"];
        //        producto.UrlImagen = datos.Lector["UrlImagen"] as string;
        //        producto.Activo = (bool)datos.Lector["Activo"];

        //        producto.Marca = new Marca();
        //        producto.Marca.IdMarca = (int)datos.Lector["IdMarca"];

        //        producto.Categoria = new Categoria();
        //        producto.Categoria.IdCategoria = (int)datos.Lector["IdCategoria"];

        //        return producto;
        //    }
        //    finally
        //    {
        //        datos.cerrarConexion();
        //    }
        //}
        //public void Agregar(Producto nuevo)
        //{
        //    AccesoDatos datos = new AccesoDatos();

        //    try
        //    {
        //        datos.setearConsulta(
        //                            "INSERT INTO Producto " +
        //                            "(Nombre, IdMarca, IdCategoria, StockActual, StockMinimo, " +
        //                            "UltimoPrecioCompra, PorcentajeGanancia, UrlImagen, Activo) " +
        //                            "VALUES (@Nombre, @IdMarca, @IdCategoria, @StockActual, " +
        //                            "@StockMinimo, @UltimoPrecioCompra, @PorcentajeGanancia, " +
        //                            "@UrlImagen, @Activo)");

        //        datos.setearParametro("@Nombre", nuevo.Nombre);
        //        datos.setearParametro("@IdMarca", nuevo.Marca.IdMarca);
        //        datos.setearParametro("@IdCategoria", nuevo.Categoria.IdCategoria);
        //        datos.setearParametro("@StockActual", nuevo.StockActual);
        //        datos.setearParametro("@StockMinimo", nuevo.StockMinimo);
        //        datos.setearParametro("@UltimoPrecioCompra", nuevo.UltimoPrecioCompra);
        //        datos.setearParametro("@PorcentajeGanancia", nuevo.PorcentajeGanancia);
        //        datos.setearParametro("@Activo", true);

        //        if (string.IsNullOrWhiteSpace(nuevo.UrlImagen))
        //        {
        //            datos.setearParametro("@UrlImagen", DBNull.Value);
        //        }
        //        else
        //        {
        //            datos.setearParametro("@UrlImagen", nuevo.UrlImagen);
        //        }

        //        datos.ejecutarAccion();
        //    }
        //    catch (Exception)
        //    {

        //        throw;
        //    }
        //    finally
        //    {
        //        datos.cerrarConexion();
        //    }
        //}
        //public void Modificar(Producto producto)
        //{
        //    AccesoDatos datos = new AccesoDatos();

        //    try
        //    {
        //        datos.setearConsulta(
        //                            "UPDATE dbo.Producto SET Nombre = @Nombre, IdMarca = @IdMarca, " +
        //                            "IdCategoria = @IdCategoria, StockActual = @StockActual, " +
        //                            "StockMinimo = @StockMinimo, UltimoPrecioCompra = @UltimoPrecioCompra, " +
        //                            "PorcentajeGanancia = @PorcentajeGanancia, UrlImagen = @UrlImagen " +
        //                            "WHERE IdProducto = @IdProducto");

        //        datos.setearParametro("@IdProducto", producto.IdProducto);
        //        datos.setearParametro("@Nombre", producto.Nombre);
        //        datos.setearParametro("@IdMarca", producto.Marca.IdMarca);
        //        datos.setearParametro("@IdCategoria", producto.Categoria.IdCategoria);
        //        datos.setearParametro("@StockActual", producto.StockActual);
        //        datos.setearParametro("@StockMinimo", producto.StockMinimo);
        //        datos.setearParametro("@UltimoPrecioCompra", producto.UltimoPrecioCompra);
        //        datos.setearParametro("@PorcentajeGanancia", producto.PorcentajeGanancia);

        //        if (string.IsNullOrWhiteSpace(producto.UrlImagen))
        //        {
        //            datos.setearParametro("@UrlImagen", DBNull.Value);
        //        }
        //        else
        //        {
        //            datos.setearParametro("@UrlImagen", producto.UrlImagen);
        //        }

        //        datos.ejecutarAccion();
        //    }
        //    finally
        //    {
        //        datos.cerrarConexion();
        //    }
        //}
        //public void Desactivar(int idProducto)
        //{
        //    AccesoDatos datos = new AccesoDatos();

        //    try
        //    {
        //        datos.setearConsulta(
        //            "UPDATE dbo.Producto SET Activo = 0 WHERE IdProducto = @IdProducto");

        //        datos.setearParametro("@IdProducto", idProducto);
        //        datos.ejecutarAccion();
        //    }
        //    finally
        //    {
        //        datos.cerrarConexion();
        //    }
        //}
        //public void Reactivar(int idProducto)
        //{
        //    AccesoDatos datos = new AccesoDatos();

        //    try
        //    {
        //        datos.setearConsulta("UPDATE dbo.Producto SET Activo = 1 WHERE IdProducto = @IdProducto");

        //        datos.setearParametro("@IdProducto", idProducto);
        //        datos.ejecutarAccion();
        //    }
        //    finally
        //    {
        //        datos.cerrarConexion();
        //    }
        //}
        //public void Eliminar(int idProducto)
        //{
        //    AccesoDatos datos = new AccesoDatos();

        //    try
        //    {
        //        datos.setearConsulta("DELETE FROM dbo.Producto WHERE IdProducto = @IdProducto");

        //        datos.setearParametro("@IdProducto", idProducto);
        //        datos.ejecutarAccion();
        //    }
        //    finally
        //    {
        //        datos.cerrarConexion();
        //    }
        //}
    }
}
