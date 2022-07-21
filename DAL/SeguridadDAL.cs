using DAO;
using System;
using System.Collections.Generic;
using System.Data;
using Entidad;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MySql.Data.MySqlClient;


namespace DAL
{
    public class SeguridadDAL
    {

        /*************************************************************************************************/
        /*                                              Usuarios                                         */
        /*************************************************************************************************/

        public static void GuardarUsuario(SeguridadUsuario oSeguridad, string idUser)
        {
            try
            {
                MySqlCommand command = new MySqlCommand("sp_GuardarUsuario");
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@numero", oSeguridad.numero_Identificacion);
                command.Parameters.AddWithValue("@nombre", oSeguridad.nombre_Completo);
                command.Parameters.AddWithValue("@usuariop", oSeguridad.usuario);
                command.Parameters.AddWithValue("@contrasennap", oSeguridad.contrasenna);
                command.Parameters.AddWithValue("@idrolp", oSeguridad.idRol_Usuario);
                command.Parameters.AddWithValue("@idUsuariop", idUser);

                ConexionDAO.getInstance().EjecutarSqlActualizacion(command);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static DataTable getUsers()
        {
            string oSql = @"select numero_Identificacion, nombre_Completo,usuario, idRol_Usuario, r.rol from seguridad_usuario u inner join seguridad_rol r on u.idRol_Usuario = r.idRol where u.estado = 1";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static void activarUsuario(string numero_identificacion, int estado)
        {
            string oSql = "update seguridad_usuario set estado = " +  estado + " where numero_Identificacion = '" + numero_identificacion + "';";
            try
            {
                ConexionDAO.getInstance().EjecutarSqlActualizacion(oSql);
            }
            catch (Exception)
            {
                
                throw;
            }
        }
        public static DataTable getUsers(string idUsuario)
        {
            string oSql = @"select numero_Identificacion, nombre_Completo,usuario, idRol_Usuario, r.rol from seguridad_usuario u inner join seguridad_rol r on u.idRol_Usuario = r.idRol where u.estado = 1 and numero_Identificacion = '" + idUsuario + "';";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static void EliminarUsuario(String numero_Identificacion, string idUser)
        {
            string oMySql = "update seguridad_usuario set estado = 0, idUsuario = '" + idUser + "' where numero_Identificacion = '" + numero_Identificacion + "';";

            try
            {
                ConexionDAO.getInstance().EjecutarConsultaDataTable(oMySql);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static int cambiarContrasenna(string idUsuario, string password, string idUser)
        {
            string oSql = "update seguridad_usuario set contrasenna = AES_ENCRYPT('" + password + "','14C_CR%'), ingreso = 1 where numero_Identificacion = '" + idUsuario + "' ;";

            try
            {
                return ConexionDAO.getInstance().EjecutarSqlActualizacion(oSql);
            }
            catch (Exception)
            {

                throw;
            }
            throw new NotImplementedException();
        }

        /*************************************************************************************************/
        /*                                               Roles                                           */
        /*************************************************************************************************/

        public static void GuardarRol(SeguridadRol oSeguridad, string idUser)
        {
            try
            {
                MySqlCommand command = new MySqlCommand("sp_GuardarRol");
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@idrolp", oSeguridad.idRol);
                command.Parameters.AddWithValue("@Rolp", oSeguridad.rol);
                command.Parameters.AddWithValue("@descriptionp", oSeguridad.descripcion);
                command.Parameters.AddWithValue("@idUsuariop", idUser);

                ConexionDAO.getInstance().EjecutarSqlActualizacion(command);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static DataTable getRol()
        {
            string oSql = "select idRol, rol, descripcion from seguridad_rol where estado = 1";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static void EliminarRol(int idRol, string idUser)
        {
            string oMySql = "update seguridad_rol set estado = 0, idUsuario = '" + idUser + "' where idRol = " + idRol;

            try
            {
                ConexionDAO.getInstance().EjecutarConsultaDataTable(oMySql);
            }
            catch (Exception)
            {

                throw;
            }
        }


        /*************************************************************************************************/
        /*                                              Permisos                                         */
        /*************************************************************************************************/

        public static void GuardarPermisoRol(int idRol, int idPermiso, bool estado, string idUser)
        {
            try
            {
                MySqlCommand command = new MySqlCommand("sp_GuardarRolPermiso");
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@idRolp", idRol);
                command.Parameters.AddWithValue("@idPermisop", idPermiso);
                command.Parameters.AddWithValue("@estadop", estado);
                command.Parameters.AddWithValue("@idUsuariop", idUser);

                ConexionDAO.getInstance().EjecutarSqlActualizacion(command);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static DataTable getPermition()
        {
            string oSql = "SELECT idPermiso,permiso,pagina FROM seguridad_permiso where estado = 1;";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static DataTable getPermition(int idRol)
        {
            string oSql = "SELECT p.pagina, r.idPermiso, r.estado FROM seguridad_permiso p inner join seguridad_rol_permiso r on p.idPermiso = r.idpermiso where r.idRol = " + idRol;

            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        /*************************************************************************************************/
        /*                                             Respaldos                                         */
        /*************************************************************************************************/

        public static string crearbackup(string ruta)
        {
            try
            {
                return ConexionDAO.getInstance().crearBackup(ruta);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static void restaurarBackup(string ruta)
        {
            try
            {
                ConexionDAO.getInstance().restaurarbackup(ruta);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static void restaurarBackup(string ruta, string database)
        {
            try
            {
                ConexionDAO.getInstance().restaurarbackup(ruta, database);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static Boolean ComprobarConexion()
        {
            try
            {
                return ConexionDAO.getInstance().testConnection();
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static void ConfiguracionInicial(string Id, string Nombre, string sex, string Puesto, string fechaNacimiento, string fecha2, string user, string password, string idUser)
        {
            List<MySqlCommand> oComandos = new List<MySqlCommand>();
            
            MySqlCommand oCommandPuesto = new MySqlCommand("CALL `sp_GuardarPuesto`(1, '" + Puesto + "', '', '" + idUser + "');");

            MySqlCommand oCommandCol = new MySqlCommand("CALL `sp_DatosIacCol`('" + Id + "', '" + Nombre + "', 1, '', '', '', '', '" + sex + "', '" + fechaNacimiento + "', '" + fecha2 + "', ''," + 1 + ",'" +  idUser + "');");

            MySqlCommand oCommandUsuario = new MySqlCommand("CALL `sp_GuardarUsuario`('" + Id + "', '" + Nombre + "', '" + user + "', '" + password + "', 1, '" + idUser + "');");

            MySqlCommand oCommandPerm1 = new MySqlCommand("CALL `sp_GuardarRolPermiso`(1, 5, 1,'" + idUser + "');");

            MySqlCommand oCommandPerm2 = new MySqlCommand("CALL `sp_GuardarRolPermiso`(1, 25, 1, '" + idUser + "');");

            oComandos.Add(oCommandPuesto);
            oComandos.Add(oCommandCol);
            oComandos.Add(oCommandUsuario);
            oComandos.Add(oCommandPerm1);
            oComandos.Add(oCommandPerm2);

            try
            {
                ConexionDAO.getInstance().EjecutarSqlActualizacion(oComandos);
            }
            catch (Exception)
            {

                throw;
            }


        }

        /*************************************************************************************************/
        /*                                           Inicio Sesion                                       */
        /*************************************************************************************************/

        public static DataTable getMenu(int idRol, string pagina)
        {
            string oSql = @"select r.idpermiso,r.idRol,r.estado,p.permiso,p.url from seguridad_rol_permiso r inner join seguridad_permiso p on r.idpermiso = p.idPermiso where r.idRol = " + idRol + " and p.pagina like '" + pagina + "' and r.estado = 1;";

            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static bool VerificarUsuario(string User)
        {
            string oSql = "select count(*) from seguridad_usuario where usuario = '" + User + "';";

            try
            {
                if (Convert.ToInt32(ConexionDAO.getInstance().EjecutarSQLScalar(oSql)) != 0)
                {
                    return true;
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
        public static bool VerificarUsuario(string User, string Password)
        {
            string oSql = "select count(*) from seguridad_usuario where usuario = '" + User + "' and binary contrasenna like aes_encrypt('" + Password + "','14C_CR%');";

            try
            {
                if (Convert.ToInt32(ConexionDAO.getInstance().EjecutarSQLScalar(oSql)) != 0)
                {
                    return true;
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
        public static int numeroIngresos(string User, string Password)
        {
            string oSql = "select ingreso from seguridad_usuario where usuario = '" + User + "' and binary contrasenna like aes_encrypt('" + Password + "','14C_CR%');";
            try
            {
                return Convert.ToInt32(ConexionDAO.getInstance().EjecutarSQLScalar(oSql));
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static int numeroIngresos(string idUsuario)
        {
            string oSql = "select ingreso from seguridad_usuario where numero_identificacion = '" + idUsuario + "';";
            try
            {
                return Convert.ToInt32(ConexionDAO.getInstance().EjecutarSQLScalar(oSql));
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static void actualizarNumeroIngresos(string idUsuario)
        {
            int i = SeguridadDAL.numeroIngresos(idUsuario);
            string oSql1 = "update seguridad_usuario set ingreso = " + i++ + " where numero_Identificacion = '" + idUsuario + "';";

            try
            {
                ConexionDAO.getInstance().EjecutarSqlActualizacion(oSql1);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static DataTable getInfoUsuario(string User, string Password)
        {
            string oSql = "select numero_Identificacion,idRol_Usuario from seguridad_usuario where usuario = '" + User + "' and binary contrasenna like aes_encrypt('" + Password + "','14C_CR%');";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static void UsuarioActivo(int estado, string id)
        {
            string oSql = "update seguridad_usuario set activo = " + estado + " where numero_Identificacion = '" + id + "';";

            try
            {
                ConexionDAO.getInstance().EjecutarSqlActualizacion(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        /*************************************************************************************************/
        /*                                             Bitacora                                          */
        /*************************************************************************************************/

        public static DataTable getBitacora()
        {
            string oSql = "SELECT numero_Identificacion, fecha_Accion, hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues FROM seguridad_bitacora ";

            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {
                
                throw;
            }
        }


        /*********************************************** FIN *********************************************/

    }
}
