using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class AccesoDatos
    {
        private SqlConnection conexion;
        private SqlCommand comando;
        private SqlDataReader lector;
        private SqlTransaction transaccion;
        public SqlDataReader Lector
        {
            get { return lector; }
        }

        public AccesoDatos()
        {
            conexion = new SqlConnection();
            comando = new SqlCommand();

            try
            {
                string rutaConexionLocal = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "conexion.local.txt");

                try
                {
                    if (File.Exists(rutaConexionLocal))
                    {
                        conexion.ConnectionString = File.ReadAllText(rutaConexionLocal).Trim();
                    }
                    else
                    {
                        conexion.ConnectionString = "server =.\\SQLEXPRESS; database = COMERCIO_TP_FINAL; integrated security = true;";
                    }
                    conexion.Open();
                }
                catch
                {
                    conexion.ConnectionString = "server =.\\SQLEXPRESS; database = COMERCIO_TP_FINAL; integrated security = true;";
                    conexion.Open();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public void iniciarTransaccion()
        {
            transaccion = conexion.BeginTransaction();
            comando.Transaction = transaccion;
        }

        public void confirmarTransaccion()
        {
            if (transaccion != null)
            {
                transaccion.Commit();
                transaccion.Dispose();
                transaccion = null;
                comando.Transaction = null;
            }
        }

        public void cancelarTransaccion()
        {
            if (transaccion != null)
            {
                transaccion.Rollback();
                transaccion.Dispose();
                transaccion = null;
                comando.Transaction = null;
            }
        }

        public void setearConsulta(string consulta)
        {
            comando.Parameters.Clear();
            comando.CommandType = System.Data.CommandType.Text;
            comando.CommandText = consulta;
            comando.Connection = conexion;
            comando.Transaction = transaccion;
        }

        public void setearProcedimiento(string sp)
        {
            comando.Parameters.Clear();
            comando.CommandType = System.Data.CommandType.StoredProcedure;
            comando.CommandText = sp;
            comando.Connection = conexion;
            comando.Transaction = transaccion;
        }


        public void ejecutarLectura()
        {
            comando.Connection = conexion;
            try
            {
                comando.Transaction = transaccion;
                lector = comando.ExecuteReader();

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        public void setearParametro(string nombre, object valor)
        {
            comando.Parameters.AddWithValue(nombre, valor);
        }
        public void ejecutarAccion()
        {
            comando.Connection = conexion;
            try
            {
                comando.Transaction = transaccion;
                comando.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public object ejecutarAccionEscalar()
        {
            comando.Connection = conexion;
            try
            {
                comando.Transaction = transaccion;
                return comando.ExecuteScalar();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public void cerrarConexion()
        {
            if (lector != null && !lector.IsClosed)
                lector.Close();
            conexion.Close();
        }
    }
}
