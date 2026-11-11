using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading.Tasks;
using Dominio;

namespace Negocio
{
    public class ProveedoresNegocio
    {
        public List<Proveedores> Listar()
        {
            List<Proveedores> lista = new List<Proveedores>();
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("spListaProveedor");
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    Proveedores aux = new Proveedores();
                    aux.Id = (int)datos.Lector["IdProveedor"];
                    aux.Codigo = (string)datos.Lector["Codigo"];
                    aux.RazonSocial = (string)datos.Lector["RazonSocial"];
                    aux.Cuit = datos.Lector["CUIT"] == DBNull.Value ? "" : datos.Lector["CUIT"].ToString();
                    aux.Telefono = datos.Lector["Telefono"] == DBNull.Value ? "" : datos.Lector["Telefono"].ToString();
                    aux.Mail = datos.Lector["Mail"] == DBNull.Value ? "" : datos.Lector["Mail"].ToString();
                    aux.Activo = (bool)datos.Lector["Activo"];
                    lista.Add(aux);
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
            return lista;
        }
        public Proveedores listarIdProveedor(string idProveedor = "")
        {
            Proveedores proveedor = new Proveedores();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("spListaIDProveedor");
                datos.setearParametro("@idProveedor", idProveedor);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    proveedor.Id = (int)datos.Lector["IdProveedor"];
                    proveedor.Codigo = (string)datos.Lector["Codigo"];
                    proveedor.RazonSocial = (string)datos.Lector["RazonSocial"];
                    proveedor.Cuit = datos.Lector["CUIT"] == DBNull.Value ? "" : datos.Lector["CUIT"].ToString();
                    proveedor.Telefono = datos.Lector["Telefono"] == DBNull.Value ? "" : datos.Lector["Telefono"].ToString();
                    proveedor.Mail = datos.Lector["Mail"] == DBNull.Value ? "" : datos.Lector["Mail"].ToString();
                    proveedor.Activo = (bool)datos.Lector["Activo"];
                }
                return proveedor;
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
        public int agregarProveedor(Proveedores nuevo)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("SP_AgregarProveedor");
                datos.setearParametro("@Codigo", nuevo.Codigo);
                datos.setearParametro("@RazonSocial", nuevo.RazonSocial);
                datos.setearParametro("@Cuit", nuevo.Cuit);
                datos.setearParametro("@Telefono", nuevo.Telefono);
                datos.setearParametro("@Mail", nuevo.Mail);

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
        public void modificar(Proveedores modificar)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("SP_ModificarProveedor");
                datos.setearParametro("@IdProveedor", modificar.Id);
                datos.setearParametro("@Codigo", modificar.Codigo);
                datos.setearParametro("@RazonSocial", modificar.RazonSocial);
                datos.setearParametro("@Cuit", modificar.Cuit);
                datos.setearParametro("@Telefono", modificar.Telefono);
                datos.setearParametro("@Mail", modificar.Mail);

                datos.ejecutarAccion();
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
        public void eliminarLogico(int Id)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("SP_BajaProveedor");
                datos.setearParametro("@IdProveedor", Id);
                datos.ejecutarAccion();
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
        public bool ExisteCod(string codigo, int idActual)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("spBuscarPorCodigo");
                datos.setearParametro("@Codigo", codigo.Trim());
                datos.setearParametro("@IdActual", idActual);

                object resultado = datos.ejecutarAccionEscalar();
                return Convert.ToBoolean(resultado);
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
        public bool ExisteCuit(string cuit, int idActual)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("spBuscarPorCuit");
                datos.setearParametro("@CUIT", cuit.Trim());
                datos.setearParametro("@IdActual", idActual);

                return Convert.ToBoolean(datos.ejecutarAccionEscalar());
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
