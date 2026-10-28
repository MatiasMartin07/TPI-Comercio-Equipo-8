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
        public void setearConsulta(string consulta)
        {
            comando.CommandType = System.Data.CommandType.Text;
            comando.CommandText = consulta;
            comando.Connection = conexion;
        }

        public void setearProcedimiento(string sp)
        {
            comando.CommandType = System.Data.CommandType.StoredProcedure;
            comando.CommandText = sp;
        }


        public void ejecutarLectura()
        {
            comando.Connection = conexion;
            try
            {
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
