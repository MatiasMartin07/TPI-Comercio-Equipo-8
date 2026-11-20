using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace Negocio
{
    public class ComprasNegocio
    {
        public void Registrar(Compras compra)
        {
            if (compra == null)
            {
                throw new ArgumentNullException("compra");
            }

            if (compra.Proveedor == null || compra.Proveedor.Id <= 0)
            {
                throw new ArgumentException("Seleccione un proveedor válido.");
            }

            if (compra.Detalles == null || compra.Detalles.Count == 0)
            {
                throw new ArgumentException("La compra debe tener al menos un producto.");
            }

            decimal total = 0;

            foreach (DetalleCompra detalle in compra.Detalles)
            {
                if (detalle == null || detalle.Producto == null ||
                    detalle.Producto.IdProducto <= 0)
                {
                    throw new ArgumentException("Hay un producto inválido en el detalle.");
                }

                if (detalle.Cantidad <= 0 || detalle.PrecioUnitario < 0)
                {
                    throw new ArgumentException("La cantidad o el precio no son válidos.");
                }

                total += detalle.SubTotal;
            }

            compra.Total = total;

            AccesoDatos datos = new AccesoDatos();
            bool transaccionIniciada = false;

            try
            {
                datos.iniciarTransaccion();
                transaccionIniciada = true;

                datos.setearConsulta(
                    "INSERT INTO Compra (Fecha, IdProveedor, Total) " +
                    "OUTPUT INSERTED.IdCompra " +
                    "VALUES (@Fecha, @IdProveedor, @Total)");

                datos.setearParametro("@Fecha", compra.Fecha);
                datos.setearParametro("@IdProveedor", compra.Proveedor.Id);
                datos.setearParametro("@Total", compra.Total);

                int idCompra = Convert.ToInt32(datos.ejecutarAccionEscalar());
                compra.IdCompra = idCompra;

                foreach (DetalleCompra detalle in compra.Detalles)
                {
                    datos.setearConsulta(
                        "INSERT INTO DetalleCompra " +
                        "(IdCompra, IdProducto, Cantidad, PrecioUnitario) " +
                        "VALUES (@IdCompra, @IdProducto, @Cantidad, @PrecioUnitario)");

                    datos.setearParametro("@IdCompra", idCompra);
                    datos.setearParametro("@IdProducto", detalle.Producto.IdProducto);
                    datos.setearParametro("@Cantidad", detalle.Cantidad);
                    datos.setearParametro("@PrecioUnitario", detalle.PrecioUnitario);
                    datos.ejecutarAccion();

                    datos.setearConsulta(
                        "UPDATE Producto " +
                        "SET StockActual = StockActual + @Cantidad " +
                        "WHERE IdProducto = @IdProducto");

                    datos.setearParametro("@Cantidad", detalle.Cantidad);
                    datos.setearParametro("@IdProducto", detalle.Producto.IdProducto);
                    datos.ejecutarAccion();
                }

                datos.confirmarTransaccion();
                transaccionIniciada = false;
            }
            catch
            {
                if (transaccionIniciada)
                {
                    datos.cancelarTransaccion();
                }

                throw;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
        public List<Compras> Listar()
        {
            List<Compras> lista = new List<Compras>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(
                    "SELECT c.IdCompra, c.Fecha, c.IdProveedor, " +
                    "p.RazonSocial, c.Total " +
                    "FROM dbo.Compra c " +
                    "INNER JOIN Proveedor p ON c.IdProveedor = p.IdProveedor " +
                    "ORDER BY c.IdCompra DESC");

                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Compras compra = new Compras();
                    compra.IdCompra = (int)datos.Lector["IdCompra"];
                    compra.Fecha = (DateTime)datos.Lector["Fecha"];
                    compra.Total = (decimal)datos.Lector["Total"];

                    compra.Proveedor = new Proveedores();
                    compra.Proveedor.Id = (int)datos.Lector["IdProveedor"];
                    compra.Proveedor.RazonSocial =
                        (string)datos.Lector["RazonSocial"];

                    lista.Add(compra);
                }

                return lista;
            }
            finally
            {
                datos.cerrarConexion();
            }

        }
        public List<DetalleCompra> ListarDetalles(int idCompra)
        {
            List<DetalleCompra> lista = new List<DetalleCompra>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(
                    "SELECT d.IdDetalleCompra, d.IdProducto, p.Nombre AS NombreProducto, " +
                    "d.Cantidad, d.PrecioUnitario " +
                    "FROM DetalleCompra d " +
                    "INNER JOIN Producto p ON d.IdProducto = p.IdProducto " +
                    "WHERE d.IdCompra = @IdCompra " +
                    "ORDER BY d.IdDetalleCompra");

                datos.setearParametro("@IdCompra", idCompra);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    DetalleCompra detalle = new DetalleCompra();

                    detalle.IdDetalleCompra = (int)datos.Lector["IdDetalleCompra"];
                    detalle.Cantidad = (int)datos.Lector["Cantidad"];
                    detalle.PrecioUnitario = (decimal)datos.Lector["PrecioUnitario"];

                    detalle.Producto = new Producto();
                    detalle.Producto.IdProducto = (int)datos.Lector["IdProducto"];
                    detalle.Producto.Nombre = (string)datos.Lector["NombreProducto"];

                    lista.Add(detalle);
                }

                return lista;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}
