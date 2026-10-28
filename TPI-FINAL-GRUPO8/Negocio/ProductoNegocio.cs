using System;
using System.Collections.Generic;
using Dominio;


namespace Negocio
{
    public class ProductoNegocio
    {
        public List<Producto> Listar()
        {
            List<Producto> lista = new List<Producto>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT IdProducto, Nombre, StockActual, StockMinimo, " +
                                    "UltimoPrecioCompra, PorcentajeGanancia, Activo FROM Producto");
                datos.ejecutarLectura();

                while (datos.Lector.Read()) {
                    Producto aux = new  Producto();

                    aux.IdProducto = (int)datos.Lector["IdProducto"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.StockActual = (int)datos.Lector["StockActual"];
                    aux.StockMinimo = (int)datos.Lector["StockMinimo"];
                    aux.UltimoPrecioCompra = (decimal)datos.Lector["UltimoPrecioCompra"];
                    aux.PorcentajeGanancia = (decimal)datos.Lector["PorcentajeGanancia"];
                    aux.Activo = (bool)datos.Lector["Activo"];

                    lista.Add(aux);
                }
                return lista;
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}
