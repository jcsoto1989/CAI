using DAO;
using Entidad;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MySql.Data;
using MySql.Data.MySqlClient;

namespace DAL
{
    public class iacDAL
    {
        public static void GuardarIac(Iac oIac, string idUser)
        {
            try
            {
                MySqlCommand command = new MySqlCommand("sp_DatosIac");
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@idIACp", oIac.idIAC);
                command.Parameters.AddWithValue("@nombrep", oIac.nombre);
                command.Parameters.AddWithValue("@direccionp", oIac.direccion);
                command.Parameters.AddWithValue("@emailp", oIac.email);
                command.Parameters.AddWithValue("@telefono1p", oIac.telefono1);
                command.Parameters.AddWithValue("@ext1p", oIac.ext1);
                command.Parameters.AddWithValue("@telefono2p", oIac.telefono2);
                command.Parameters.AddWithValue("@ext2p", oIac.ext2);
                command.Parameters.AddWithValue("@telefono3p", oIac.telefono3);
                command.Parameters.AddWithValue("@ext3p", oIac.ext3);
                command.Parameters.AddWithValue("@rutaLogop", oIac.rutaLogo);
                command.Parameters.AddWithValue("@idUsuariop", idUser);
                
                ConexionDAO.getInstance().EjecutarSqlActualizacion(command);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static void GuardarIacIns(Iac_ins oIac, string idUser)
        {
            try
            {
                MySqlCommand command = new MySqlCommand("sp_DatosIns");
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@codigo_institucionp", oIac.codigo_institucion);
                command.Parameters.AddWithValue("@nombre_Institucionp", oIac.nombre_Institucion);
                command.Parameters.AddWithValue("@nombre_Departamentop", oIac.nombre_Departamento);
                command.Parameters.AddWithValue("@idpaisp", oIac.idpais);
                command.Parameters.AddWithValue("@telefono_Institucionp", oIac.telefono_Institucion);
                command.Parameters.AddWithValue("@direccionp", oIac.direccion);
                command.Parameters.AddWithValue("@idRepresentantep", oIac.idRepresentante);
                command.Parameters.AddWithValue("@rutaLogo_Institucionp", oIac.rutaLogo_Institucion);
                command.Parameters.AddWithValue("@rutaLogo_departamentop", oIac.rutaLogo_departamento);
                command.Parameters.AddWithValue("@idUsuariop", idUser);
              
                ConexionDAO.getInstance().EjecutarSqlActualizacion(command);
            }
            catch (Exception)
            {
                throw;
            }
        }
        public static void GuardarIacCol(Iac_col oIac, string idUser)
        {
            try
            {
                MySqlCommand command = new MySqlCommand("sp_DatosIacCol");
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@numero_Identificacionp", oIac.numero_Identificacion);
                command.Parameters.AddWithValue("@nombre_Completop", oIac.nombre_Completo);
                command.Parameters.AddWithValue("@idPuestop", oIac.idPuesto);
                command.Parameters.AddWithValue("@emailp", oIac.email);
                command.Parameters.AddWithValue("@tel_Oficinap", oIac.tel_Oficina);
                command.Parameters.AddWithValue("@ext_Oficinap", oIac.ext_Oficina);
                command.Parameters.AddWithValue("@celularp", oIac.celular);
                command.Parameters.AddWithValue("@sexop", oIac.sexo);
                command.Parameters.AddWithValue("@fecha_Nacimientop", oIac.fecha_Nacimiento);
                command.Parameters.AddWithValue("@fecha_Ingreso_IACp", oIac.fecha_Ingreso_IAC);
                command.Parameters.AddWithValue("@Ruta_Fotop", oIac.Ruta_Foto);
                command.Parameters.AddWithValue("@estadop", oIac.estado);
                command.Parameters.AddWithValue("@idUsuariop", idUser);
                
                ConexionDAO.getInstance().EjecutarSqlActualizacion(command);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static void GuardarTareaCol(string idColaborador, string tarea, int idTarea, string idUser)
        {
            try
            {
                MySqlCommand command = new MySqlCommand("sp_GuardarTareaColaborador");
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@idColaboradorp", idColaborador);
                command.Parameters.AddWithValue("@tareap", tarea);
                command.Parameters.AddWithValue("@idTareap", idTarea);
                command.Parameters.AddWithValue("@idUsuariop", idUser);

                ConexionDAO.getInstance().EjecutarSqlActualizacion(command);
            }
            catch (Exception)
            {
                throw;
            }
        }

        public static void GuardarArchivoCol(string idColaborador, string rutaArchivo, int idArchivo, string idUser)
        {
            try
            {
                MySqlCommand command = new MySqlCommand("sp_GuardarArchivoColaborador");
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@idColaboradorp", idColaborador);
                command.Parameters.AddWithValue("@rutaArchivop", rutaArchivo);
                command.Parameters.AddWithValue("@idArchivop", idArchivo);
                command.Parameters.AddWithValue("@idUsuariop", idUser);

                ConexionDAO.getInstance().EjecutarSqlActualizacion(command);
            }
            catch (Exception)
            {
                throw;
            }
        }

        public static DataTable CancelarIac()
        {
            string oSql = "select * from datos_iac";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static DataTable CancelarIns()
        {
            string oSql = "select * from datos_institucion";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static DataTable CancelarCol(String numero)
        {
            string oSql = "select * from colaborador where numero_Identificacion='" + numero + "'";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static void EliminarSeguridad(String numero_Identificacion)
        {
            string oMySql = "update seguridad_usuario set estado = 0 where numero_Identificacion = " + numero_Identificacion;

            try
            {
                ConexionDAO.getInstance().EjecutarConsultaDataTable(oMySql);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static DataTable getDatosIac()
        {
            string oSql = "select * from datos_iac";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static DataTable getnombre()
        {
            string oSql = "select * from colaborador where estado = 1";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static DataTable getDatosIns()
        {
            string oSql = "select * from datos_institucion";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static DataTable getColabor()
        {
            string oSql = "select * from colaborador where estado = 1";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable getColabor(string id)
        {
            string oSql = "select * from colaborador where numero_Identificacion like '" + id + "';";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static DataTable getCountries()
        {
            string oSql = "SELECT * FROM pais;";

            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {
                throw;
            }
        }

        public static void insertCountries(Pais oPais)
        {
            try
            {
                MySqlCommand command = new MySqlCommand("sp_GuardarMatricula");
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@cedula", oPais.idPais);
                command.Parameters.AddWithValue("@idCurso", oPais.iso);
                command.Parameters.AddWithValue("@idBimestre", oPais.pais);
                
                ConexionDAO.getInstance().EjecutarSqlActualizacion(command);
            }
            catch (Exception)
            {
                
                throw;
            }
        }
        public static void EliminarCol(String numero_Identificacion, string idUsuario)
        {
            string oMySql = "update colaborador set estado = 0, idUsuario = '" + idUsuario + "' where numero_Identificacion like '" + numero_Identificacion + "'";

            try
            {
                ConexionDAO.getInstance().EjecutarConsultaDataTable(oMySql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerTareas(string idColaborador)
        {
            string oSql = "select idColaborador,idTarea,tarea from tareas_colaborador where idColaborador like '" + idColaborador + "';";

            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {
                
                throw;
            }
        }

        public static DataTable obtenerArchivos(string idColaborador)
        {
            string oSql = "select idColaborador,idArchivo,rutaArchivo from archivos_colaborador where idColaborador like '" + idColaborador + "';";

            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {
                
                throw;
            }
        }

        public static void DeleteFiles(string idColobarador)
        {
            string oSql = "delete from archivos_colaborador where idColaborador like '" + idColobarador + "';";

            try
            {
                ConexionDAO.getInstance().EjecutarSqlActualizacion(oSql);
            }
            catch (Exception)
            {
                
                throw;
            }
        }
    }
}
