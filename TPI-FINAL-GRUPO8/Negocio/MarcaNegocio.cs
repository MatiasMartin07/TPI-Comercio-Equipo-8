using System;
using System.CodeDom;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;

namespace Negocio
{
    public class MarcaNegocio
    {
        public List<Marca> Listar()
        {
            List<Marca> lista = new List<Marca>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT IdMarca, Nombre, Activo FROM Marca");
                datos.ejecutarLectura();

                while (datos.Lector.Read()) 
                { 
                    Marca aux = new Marca();

                    aux.IdMarca = (int)datos.Lector["IdMarca"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
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
        public void Agregar(Marca nueva)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("INSERT INTO Marca (Nombre, Activo) VALUES (@Nombre, 1)");
                datos.setearParametro("@Nombre", nueva.Nombre);
                datos.ejecutarAccion();
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
        public Marca BuscarPorId(int id)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT IdMarca, Nombre, Activo FROM Marca WHERE IdMarca = @Id");
                datos.setearParametro("@Id", id);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    Marca seleccionada = new Marca();

                    seleccionada.IdMarca = (int)datos.Lector["IdMarca"];
                    seleccionada.Nombre = (string)datos.Lector["Nombre"];
                    seleccionada.Activo = (bool)datos.Lector["Activo"];

                    return seleccionada;
                }

                return null;
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
        public void Modificar(Marca marca)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("UPDATE Marca SET Nombre = @Nombre WHERE IdMarca = @Id");
                datos.setearParametro("@Nombre", marca.Nombre);
                datos.setearParametro("@Id", marca.IdMarca);
                datos.ejecutarAccion();
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
        public void Desactivar(int idMarca)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("UPDATE Marca SET Activo = 0 WHERE IdMarca = @IdMarca");
                datos.setearParametro("@IdMarca", idMarca);
                datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
        public void Reactivar(int idMarca)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("UPDATE Marca SET Activo = 1 WHERE IdMarca = @IdMarca");
                datos.setearParametro("@IdMarca", idMarca);
                datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
        public bool TieneProductosAsociados(int idMarca)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT IdProducto FROM Producto WHERE IdMarca = @IdMarca");
                datos.setearParametro("@IdMarca", idMarca);
                datos.ejecutarLectura();

                return datos.Lector.Read();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
        public void Eliminar(int idMarca)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("DELETE FROM Marca WHERE IdMarca = @IdMarca");
                datos.setearParametro("@IdMarca", idMarca);
                datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
		
}
