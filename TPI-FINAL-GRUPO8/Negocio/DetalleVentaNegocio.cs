using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class DetalleVentaNegocio
    {
        public void agregarDetalleVenta(List<DetalleVenta> carrito, int idVenta)
        {
            foreach (DetalleVenta detalle in carrito)
            {
                AccesoDatos datos = new AccesoDatos();
                try
                {
                    datos.setearProcedimiento("sp_AgregarDetalleVenta");
                    datos.setearParametro("@idProducto", detalle.Producto.IdProducto);
                    datos.setearParametro("@idVenta", idVenta);
                    datos.setearParametro("@cantidad", detalle.Cantidad);
                    datos.setearParametro("@precioUnitario", detalle.PrecioUnitario);
                    datos.setearParametro("@subTotal", detalle.SubTotal);
                    datos.ejecutarAccion();
                }
                finally
                {
                    datos.cerrarConexion();
                }
            }
        }

        //listar por id venta
        public List<DetalleVenta> listarPorVenta(int idVenta)
        {
            AccesoDatos datos = new AccesoDatos();
            List<DetalleVenta> lista = new List<DetalleVenta>();

            try
            {
                datos.setearProcedimiento("sp_ObtenerDetalleVenta");
                datos.setearParametro("@IdVenta", idVenta);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    DetalleVenta detalle = new DetalleVenta();
                    detalle.Id = (int)datos.Lector["Id"];
                    detalle.Venta = new Venta();
                    detalle.Venta.Id = (int)datos.Lector["IdVenta"];
                    detalle.Producto = new Producto();
                    detalle.Producto.IdProducto = (int)datos.Lector["IdProducto"];
                    detalle.Producto.Nombre = datos.Lector["NombreProducto"].ToString();
                    detalle.Cantidad = (int)datos.Lector["Cantidad"];
                    detalle.PrecioUnitario = (decimal)datos.Lector["PrecioUnitario"];
                    detalle.SubTotal = (decimal)datos.Lector["SubTotal"];
                    lista.Add(detalle);
                }
                return lista;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

    }
}
