using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class VentaNegocio
    {
        public List<Venta> listar()
        {
            List<Venta> lista = new List<Venta>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("sp_ListaVenta");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Venta aux = new Venta();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.Cliente = new Cliente();
                    aux.Cliente.Id = (int)datos.Lector["IdCliente"];
                    aux.Cliente.Nombre = (string)datos.Lector["NombreCliente"];
                    aux.Fecha = (DateTime)datos.Lector["fecha"];
                    aux.NroFactura = (string)datos.Lector["NroFactura"];
                    aux.Total = (decimal)datos.Lector["Total"];
                    aux.Anulado = (bool)datos.Lector["Anulado"];

                    lista.Add(aux);
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

        public int AgregarVenta(Venta venta)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("sp_AgregarVenta");
                datos.setearParametro("@idCliente", venta.Cliente.Id);
                datos.setearParametro("@fecha", venta.Fecha);
                datos.setearParametro("@nroFactura", venta.NroFactura);
                datos.setearParametro("@total", venta.Total);
                return Convert.ToInt32(datos.ejecutarAccionEscalar());
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

        public string ObtenerSiguienteNumeroFactura()
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("spObtenerUltimoNumeroFactura");
                datos.ejecutarLectura();

                int siguienteId = 1;
                if (datos.Lector.Read())
                {
                    siguienteId = Convert.ToInt32(datos.Lector["SiguienteNumero"]);
                }
                return "FAC-" + siguienteId.ToString("D8");
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

    //obtener el id de la venta
     public Venta obtnerId(int idVenta)
        {
            AccesoDatos datos = new AccesoDatos();
            Venta venta = null;
            int idCliente = 0;
            try
            {
                datos.setearProcedimiento("sp_ListarVentaId");
                datos.setearParametro("@id", idVenta);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    venta = new Venta();
                    venta.Id = (int)datos.Lector["Id"];
                    venta.Fecha = (DateTime)datos.Lector["Fecha"];
                    idCliente = (int)datos.Lector["IdCliente"];
                    venta.NroFactura = (string)datos.Lector["NroFactura"];
                    venta.Total = (decimal)datos.Lector["Total"];
                    venta.Anulado = (bool)datos.Lector["Anulado"];
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }

            ClienteNegocio negocio = new ClienteNegocio();
            DetalleVentaNegocio detalle = new DetalleVentaNegocio();

            venta.Cliente = negocio.listarId(idCliente.ToString());
            venta.Detalle = detalle.listarPorVenta(idVenta);
            return venta;
        }

        //anular Venta
        public bool anularVenta(int idVenta)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("sp_AnularVenta");
                datos.setearParametro("@idVenta", idVenta);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    int estado = (int)datos.Lector["Resultado"];
                    return estado == 1;
                }
                return false;
            }
            catch(Exception ex)
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
