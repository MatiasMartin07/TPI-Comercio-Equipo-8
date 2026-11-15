using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class UsuarioNegocio
    {
        public List<Usuario> listar()
        {
            List<Usuario> lista = new List<Usuario>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("sp_ListaUsuario");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Usuario aux = new Usuario();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Apellido = (string)datos.Lector["Apellido"];
                    aux.NombreUsuario = (string)datos.Lector["NombreUsuario"];
                    aux.Pass = (string)datos.Lector["Pass"];
                    aux.Rol = (string)datos.Lector["Rol"];
                    aux.Activo = (bool)datos.Lector["Activo"];

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

        public Usuario listarUsuarioId(string id = "")
        {
            Usuario usuario = new Usuario();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("sp_listaUsuarioId");
                datos.setearParametro("@id", id);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    usuario.Id = (int)datos.Lector["Id"];
                    usuario.Nombre = (string)datos.Lector["Nombre"];
                    usuario.Apellido = (string)datos.Lector["Apellido"];
                    usuario.NombreUsuario = (string)datos.Lector["NombreUsuario"];
                    usuario.Pass = (string)datos.Lector["Pass"];
                    usuario.Rol = (string)datos.Lector["Rol"];
                    usuario.Activo = (bool)datos.Lector["Activo"];
                }
                return usuario;
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

        public void agregarUsuario(Usuario usuario)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("sp_AgregarUsuario");
                datos.setearParametro("@nombre", usuario.Nombre);
                datos.setearParametro("@apellido", usuario.Apellido);
                datos.setearParametro("@nombreUsuario", usuario.NombreUsuario);
                datos.setearParametro("@pass", usuario.Pass);
                datos.setearParametro("@rol", usuario.Rol);
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

        public void modificar(Usuario usuario)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("sp_ModificarUsuario");
                datos.setearParametro("@id", usuario.Id);
                datos.setearParametro("@nombre", usuario.Nombre);
                datos.setearParametro("@apellido", usuario.Apellido);
                datos.setearParametro("@nombreUsuario", usuario.NombreUsuario);
                datos.setearParametro("@pass", usuario.Pass);
                datos.setearParametro("@rol", usuario.Rol);
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

        public void eliminarLogico(int id, bool activo = false)
        {
            try
            {
                AccesoDatos datos = new AccesoDatos();

                datos.setearConsulta("Update Usuario set Activo = @activo where Id=@id");
                datos.setearParametro("@id", id);
                datos.setearParametro("@activo", activo);
                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void eliminar(int id)
        {
            try
            {
                AccesoDatos datos = new AccesoDatos();

                datos.setearConsulta("Delete from Usuario where Id=@id");
                datos.setearParametro("@id", id);
                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool existeUsuario(string usuario, int id)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("sp_UsuarioExistente");
                datos.setearParametro("@nombreUsuario", usuario);
                datos.ejecutarLectura();


                if (datos.Lector.Read())
                {
                    int idEncontrado = (int)datos.Lector["Id"];
                    if (id != 0 && idEncontrado == id)
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
