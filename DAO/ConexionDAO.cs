using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using MySql.Data.MySqlClient;
using System.Net.NetworkInformation;
using System.IO;

namespace DAO
{
    public class ConexionDAO
    {
        private static ConexionDAO instance = null;
        public MySqlConnection oConexion { set; get; }
        public String Usuario { set; get; }
        public String Clave { set; get; }
        public String Servidor { set; get; }
        public String BaseDatos { set; get; }

        public static bool PingHost(string nameOrAddress)
        {
            bool pingable = false;
            Ping pinger = null;

            try
            {
                pinger = new Ping();
                PingReply reply = pinger.Send(nameOrAddress);
                pingable = reply.Status == IPStatus.Success;
            }
            catch (PingException)
            {
                // Discard PingExceptions and return false;
            }
            finally
            {
                if (pinger != null)
                {
                    pinger.Dispose();
                }
            }

            return pingable;
        }

        public bool testConnection()
        {
            try
            {
                if (PingHost(Servidor))
                {
                    establecerConexion();
                    if ((oConexion.State & ConnectionState.Open) > 0)
                    {
                        oConexion.Close();
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
                else
                {
                    return false;
                }

                
            }
            catch (Exception)
            {
                
                throw;
            }
        }

        private ConexionDAO()
        {

            MySqlConnectionStringBuilder bdBuilder = new MySqlConnectionStringBuilder(ConfigurationManager.ConnectionStrings["dbCAIConexion"].ConnectionString);

            Usuario = bdBuilder.UserID;
            Clave = bdBuilder.Password;
            Servidor = bdBuilder.Server;
            BaseDatos = bdBuilder.Database;


        }
        public static ConexionDAO getInstance()
        {
            if (instance == null)
            {
                instance = new ConexionDAO();
            }
            return instance;
        }

        public void establecerConexion()
        {

            String hileraConexion = @"Server=" + Servidor +
                                   ";Database=" + BaseDatos +
                                   ";Uid=" + Usuario +
                                   ";Pwd=" + Clave;


            oConexion = new MySqlConnection(hileraConexion);
            try
            {
                oConexion.Open();

            }
            catch (Exception e)
            {
                throw new Exception("Error de conexión\n" + e.Message);
            }
        }

        public void cerrarConexion()
        {
            try
            {
                if (oConexion.State == ConnectionState.Open)
                {
                    oConexion.Close();
                }
            }
            catch (Exception)
            {

                throw;
            }
        }

        //Método que permite ejecutar sentencia Insert,Delete,Update
        //Retorna la cantidad de registros insertados
        public Int32 EjecutarSqlActualizacion(String oSql)
        {
            Int32 vRegistrosActualizados = 0;
            try
            {
                establecerConexion();
                MySqlCommand oCommand = new MySqlCommand();
                oCommand.Connection = oConexion;
                oCommand.CommandText = oSql;
                oCommand.CommandType = CommandType.Text;

                vRegistrosActualizados = oCommand.ExecuteNonQuery();
                return vRegistrosActualizados;
            }
            catch (Exception errorSQL)
            {
                throw new Exception("Error de SQL en Ejecutar sentencia SQL de actualización: \n" +
                                      errorSQL.Message + "\n");
            }
            finally
            {
                cerrarConexion();
            }

        }

        //Método que permite ejecutar sentencia Insert,Delete,Update
        //Retorna la cantidad de registros insertados
        public Int32 EjecutarSqlActualizacion(MySqlCommand oCommand)
        {
            Int32 vRegistrosActualizados = 0;

            try
            {
                establecerConexion();
                oCommand.Connection = oConexion;
                vRegistrosActualizados = oCommand.ExecuteNonQuery();
            }
            catch (Exception errorSQL)
            {
                throw new Exception("Error de SQL en Ejecutar sentencia SQL Actualización: \n" +
                                     errorSQL.Message + "\n");
            }
            finally
            {
                cerrarConexion();
            }
            return vRegistrosActualizados;
        }

        public int EjecutarSqlActualizacion(List<MySqlCommand> listaComandos)
        {
            establecerConexion();
            String textoComando = "";
            int vRegistrosActualizados = 0;
            using (MySqlTransaction transaccion = oConexion.BeginTransaction(IsolationLevel.ReadCommitted))
            {
                try
                {
                    foreach (MySqlCommand command in listaComandos)
                    {
                        command.Connection = oConexion;
                        command.Transaction = transaccion;
                        textoComando = command.CommandText;
                        command.ExecuteNonQuery();
                        vRegistrosActualizados++;
                    }
                    // Commit a la transacción
                    transaccion.Commit();
                }

                catch (Exception error)
                {
                    transaccion.Rollback();
                    throw new Exception("Error de SQL en Ejecutar sentencia SQL Actualización: \n" +
                                     error.Message + "\n" + textoComando);


                }
                finally
                {
                    cerrarConexion();
                }

            }

            return vRegistrosActualizados;
        }

        //Método que permite ejecutar instrucciones Select 
        //Retorna el resultado en un objeto DataTable
        public DataTable EjecutarConsultaDataTable(String oSql)
        {
            DataTable oDataTable = new DataTable();
            MySqlCommand oCommand = new MySqlCommand();
            try
            {
                establecerConexion();
                oCommand.Connection = oConexion;
                oCommand.CommandText = oSql;
                oCommand.CommandType = CommandType.Text;

                using (MySqlDataAdapter adaptador = new MySqlDataAdapter(oCommand))
                {
                    adaptador.Fill(oDataTable);
                    adaptador.Dispose();
                }
            }
            catch (Exception errorSQL)
            {
                throw new Exception("Error de SQL en la consulta Data Table\n" +
                    errorSQL.Message + "\n");
            }
            finally
            {
                oCommand = null;
                cerrarConexion();
            }
            return oDataTable;
        }

        public DataTable EjecutarConsultaDataTable(MySqlCommand oCommand)
        {
            DataTable oDataTable = new DataTable();
            oCommand.Connection = oConexion;

            try
            {
                establecerConexion();
                using (MySqlDataAdapter adaptador = new MySqlDataAdapter(oCommand))
                {

                    adaptador.Fill(oDataTable);
                    adaptador.Dispose();
                }
            }
            catch (Exception errorSQL)
            {

                throw new Exception("Error de SQL en la consulta DataTable\n" +
                                     errorSQL.Message + "\n");
            }
            finally
            {
                oCommand = null;
                cerrarConexion();
            }
            return oDataTable;
        }

        //Método que permite ejecutar instrucciones Select 
        //Retorna el resultado en un objeto DataTable
        public DataSet EjecutarConsultaDataSet(String oSql)
        {
            DataSet dsTabla = new DataSet();

            try
            {
                establecerConexion();
                MySqlCommand oCommand = new MySqlCommand();
                oCommand.Connection = oConexion;
                oCommand.CommandText = oSql;
                oCommand.CommandType = CommandType.Text;
                using (MySqlDataAdapter adaptador = new MySqlDataAdapter(oCommand))
                {
                    adaptador.Fill(dsTabla);
                    adaptador.Dispose();
                }
            }

            catch (Exception error)
            {
                throw new Exception("Error en Ejecutar SQL DataSet:\n" +
                                     error.Message + "\n");
            }
            finally
            {
                cerrarConexion();
            }

            return dsTabla;
        }

        // Método que permite ejecutar sentencias SQL Escalares --> SUM, AVG, MIN, MAX, etc.
        //Retorna el único resultado que genera la consulta en una String
        public String EjecutarSQLScalar(String oSql)
        {
            //Declaración de variable para resultado del SqlScalar            
            String vResultadoScalar = "";
            try
            {
                establecerConexion();
                // Creación del nuevo objeto tipo Command
                MySqlCommand oCommand = new MySqlCommand();

                //Asignación del objeto conexión, String SQL y tipo Command
                oCommand.Connection = oConexion;
                oCommand.CommandText = oSql;
                oCommand.CommandType = CommandType.Text;

                if (oCommand.ExecuteScalar().ToString().Equals(null))
                {
                    vResultadoScalar = "";
                }
                else
                {
                    vResultadoScalar = oCommand.ExecuteScalar().ToString();
                }
                //Ejecutar el SQL Escalar y retornar el valor 
                //Retornar el resultado del SqlScalar
                return vResultadoScalar;
            }
            catch (Exception error)
            {
                throw new Exception("Error en Ejecutar SQL escalar:\n" +
                                      error.Message + "\n");

            }
            finally
            {
                cerrarConexion();
            }

        }

        // Método que permite ejecutar sentencias SQL Escalares --> SUM, AVG, MIN, MAX, etc.
        //Retorna el único resultado que genera la consulta en una String
        public String EjecutarSQLScalar(MySqlCommand oCommand)
        {

            //Declaración de variable para resultado del SqlScalar            
            String vResultadoScalar = "";

            try
            {
                establecerConexion();
                //Asignación del objeto conexión, String SQL y tipo Command
                oCommand.Connection = oConexion;

                //Ejecutar el SQL Escalar y retornar el valor 
                vResultadoScalar = oCommand.ExecuteScalar().ToString();
                //Retornar el resultado del SqlScalar
                return vResultadoScalar;
            }
            catch (Exception error)
            {
                throw new Exception("Error en Ejecutar SQL escalar:\n" + error.Message +
                                     "\n" + oCommand.CommandText);

            }
            finally
            {
                cerrarConexion();
            }

        }

        public string crearBackup(string ruta)
        {
            try
            {

                string nombre = "CAI" + DateTime.Now.ToString("ddMMyy-hhmmss") + ".iac";
                string constring = "server=" + Servidor + ";user=" + Usuario + ";pwd=" + Clave + ";database=" + BaseDatos + ";";

                // Important Additional Connection Options
                constring += "charset=latin1;convertzerodatetime=true;";

                string file = ruta + nombre;
                using (MySqlConnection conn = new MySqlConnection(constring))
                {
                    using (MySqlCommand cmd = new MySqlCommand())
                    {
                        using (MySqlBackup mb = new MySqlBackup(cmd))
                        {
                            cmd.Connection = conn;
                            conn.Open();
                            mb.ExportToFile(file);
                            conn.Close();

                        }
                    }
                }

                return nombre;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public void restaurarbackup(string ruta)
        {
            try
            {
                string constring = "server=" + Servidor + ";user=" + Usuario + ";pwd=" + Clave + ";database=" + BaseDatos + ";";

                // Important Additional Connection Options
                constring += "charset=latin1;convertzerodatetime=true;";

                using (MySqlConnection conn = new MySqlConnection(constring))
                {
                    using (MySqlCommand cmd = new MySqlCommand())
                    {
                        using (MySqlBackup mb = new MySqlBackup(cmd))
                        {
                            cmd.Connection = conn;
                            conn.Open();
                            mb.ImportFromFile(ruta);
                            conn.Close();
                        }
                    }
                }
            }
            catch (Exception)
            {

                throw;
            }
        }

        public void restaurarbackup(string ruta, string database)
        {
            try
            {
                string constring = "server=" + Servidor + ";user=" + Usuario + ";pwd=" + Clave + ";database=" + database + ";";

                // Important Additional Connection Options
                constring += "charset=latin1;convertzerodatetime=true;";

                using (MySqlConnection conn = new MySqlConnection(constring))
                {
                    using (MySqlCommand cmd = new MySqlCommand())
                    {
                        using (MySqlBackup mb = new MySqlBackup(cmd))
                        {
                            cmd.Connection = conn;
                            conn.Open();
                            mb.ImportFromFile(ruta);
                            conn.Close();
                        }
                    }
                }
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
