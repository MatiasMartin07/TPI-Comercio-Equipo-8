using System;
using System.Collections.Generic;
using Dominio;

namespace Negocio
{
    public class CategoriaNegocio
    {
        public List<Categoria> Listar(bool incluirInactivas = false)
        {
            List<Categoria> lista = new List<Categoria>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT IdCategoria, Nombre, Activo FROM Categoria WHERE Activo = 1 OR @IncluirInactivas = 1");
                datos.setearParametro("@IncluirInactivas", incluirInactivas);

                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Categoria aux = new Categoria();

                    aux.IdCategoria = (int)datos.Lector["IdCategoria"];
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
        public void Agregar(Categoria nueva)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("INSERT INTO Categoria (Nombre, Activo) VALUES (@Nombre, 1)");
                datos.setearParametro("@Nombre", nueva.Nombre);
                datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
        public Categoria BuscarPorId(int idCategoria)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("SELECT IdCategoria, Nombre, Activo FROM Categoria WHERE IdCategoria = @IdCategoria");
                datos.setearParametro("@IdCategoria", idCategoria);
                datos.ejecutarLectura();

                if (!datos.Lector.Read())
                {
                    return null;
                }

                Categoria categoria = new Categoria();
                categoria.IdCategoria = (int)datos.Lector["IdCategoria"];
                categoria.Nombre = (string)datos.Lector["Nombre"];
                categoria.Activo = (bool)datos.Lector["Activo"];

                return categoria;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
        public void Modificar(Categoria categoria)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(
                    "UPDATE Categoria SET Nombre = @Nombre WHERE IdCategoria = @IdCategoria");
                datos.setearParametro("@Nombre", categoria.Nombre);
                datos.setearParametro("@IdCategoria", categoria.IdCategoria);
                datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
        public void Desactivar(int idCategoria)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("UPDATE Categoria SET Activo = 0 WHERE IdCategoria = @IdCategoria");
                datos.setearParametro("@IdCategoria", idCategoria);
                datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
        public void Reactivar(int idCategoria)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("UPDATE Categoria SET Activo = 1 WHERE IdCategoria = @IdCategoria");
                datos.setearParametro("@IdCategoria", idCategoria);
                datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
        public bool TieneProductosAsociados(int idCategoria)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(
                    "SELECT IdProducto FROM Producto WHERE IdCategoria = @IdCategoria");
                datos.setearParametro("@IdCategoria", idCategoria);
                datos.ejecutarLectura();

                return datos.Lector.Read();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void Eliminar(int idCategoria)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("DELETE FROM Categoria WHERE IdCategoria = @IdCategoria");
                datos.setearParametro("@IdCategoria", idCategoria);
                datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}
