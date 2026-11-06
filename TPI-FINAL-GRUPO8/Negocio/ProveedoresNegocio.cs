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
                    aux.Cuit = (string)datos.Lector["CUIT"];
                    aux.Telefono = (string)datos.Lector["Telefono"];
                    aux.Mail = (string)datos.Lector["Mail"];
                    aux.Activo = (bool)datos.Lector["Activo"];
                    lista.Add(aux);
                }
                datos.cerrarConexion();
            }
            catch (Exception ex)
            {
                throw ex;
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
                    proveedor.Cuit = (string)datos.Lector["CUIT"];
                    proveedor.Telefono = (string)datos.Lector["Telefono"];
                    proveedor.Mail = (string)datos.Lector["Mail"];
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
                datos.setearParametro("@Activo", nuevo.Activo);

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
                datos.setearParametro("@Codigo", modificar.Codigo);
                datos.setearParametro("@RazonSocial", modificar.RazonSocial);
                datos.setearParametro("@Cuit", modificar.Cuit);
                datos.setearParametro("@Telefono", modificar.Telefono);
                datos.setearParametro("@Mail", modificar.Mail);
                datos.setearParametro("@Activo", modificar.Activo);
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
        public void eliminarLogico(int Id, bool Activo = false)
        {
            try
            {
                AccesoDatos datos = new AccesoDatos();

                datos.setearConsulta("Update Proveedor set Activo = @activo where IdProveedor=@Id");
                datos.setearParametro("@idProveedor", Id);
                datos.setearParametro("@activo", Activo);
                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public bool ExisteCod(string Codigo, int IdActual )
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("spListaProveedor");
                datos.setearParametro("@codigo", Codigo);

                datos.ejecutarLectura();
                if (datos.Lector.Read())
                {
                    int idEncontrado = (int)datos.Lector["IdProveedor"];
                    if (IdActual != 0 && idEncontrado == IdActual)
                    {
                        return false;
                    }
                    return true;
                }
                return false;
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
        public bool ExisteCuit(string Cuit, int IdActual)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("spBuscarPorCuit");
                datos.setearParametro("@cuit", Cuit);

                datos.ejecutarLectura();
                if (datos.Lector.Read())
                {
                    int idEncontrado = (int)datos.Lector["IdProveedor"];
                    if (IdActual != 0 && idEncontrado == Convert.ToInt32(IdActual))
                    {
                        return false;
                    }
                    return true;
                }
                return false;
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
