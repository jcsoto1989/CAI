using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using Entidad;
using DAL;

namespace BLL
{
    public class SeguridadBLL
    {
        public static void GuardarSeguridad(SeguridadUsuario oSeguridad, string idUser)
        {
            try
            {
                SeguridadDAL.GuardarUsuario(oSeguridad,idUser);
            }
            catch (Exception)
            {
                throw;
            }
        }
        public static void GuardarSeguridadRol(SeguridadRol oSeguridad, string idUser)
        {
            try
            {
                SeguridadDAL.GuardarRol(oSeguridad,idUser);
            }
            catch (Exception)
            {
                throw;
            }
        }

        public static DataTable getUsers()
        {
            try
            {
                return SeguridadDAL.getUsers();
            }
            catch (Exception)
            {
                throw;
            }
        }

        public static DataTable getUsers(string idUsuario)
        {
            try
            {
                return SeguridadDAL.getUsers(idUsuario);
            }
            catch (Exception)
            {
                throw;
            }
        }

        public static void activarUsuario(string numero_identificacion, int estado)
        {
            try
            {
                SeguridadDAL.activarUsuario(numero_identificacion, estado);
            }
            catch (Exception)
            {
                
                throw;
            }
        }

        public static DataTable getRol()
        {
            try
            {
                return SeguridadDAL.getRol();
            }
            catch (Exception)
            {
                throw;
            }
        }

        public static void eliminarSeguridad(String numero, string idUser)
        {
            try
            {
                SeguridadDAL.EliminarUsuario(numero,idUser);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static void eliminarSeguridadRol(int idRol, string idUser)
        {
            try
            {
                SeguridadDAL.EliminarRol(idRol,idUser);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable getPermition()
        {
            try
            {
                return SeguridadDAL.getPermition();
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static void guardarPermiso(int idRol, int idPermiso, bool estado, string idUser)
        {
            try
            {
                SeguridadDAL.GuardarPermisoRol(idRol, idPermiso, estado,idUser);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable getPermition(int idRol)
        {
            try
            {
                return SeguridadDAL.getPermition(idRol);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable getMenu(int idRol, string pagina)
        {
            try
            {
                return SeguridadDAL.getMenu(idRol, pagina);
            }
            catch (Exception)
            {
                
                throw;
            }
        }

        public static bool VerificarUsuario(string User)
        {
            try
            {
                return SeguridadDAL.VerificarUsuario(User);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static bool VerificarUsuario(string User, string Password)
        {
            try
            {
                return SeguridadDAL.VerificarUsuario(User, Password);
            }
            catch (Exception)
            {
                
                throw;
            }
        }

        public static DataTable getInfoUsuario(string User, string Password)
        {
            try
            {
                return SeguridadDAL.getInfoUsuario(User, Password);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static string crearBackup(string ruta)
        {
            try
            {
                return SeguridadDAL.crearbackup(ruta);
                
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
                SeguridadDAL.restaurarBackup(ruta);
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
                SeguridadDAL.restaurarBackup(ruta,database);
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
                return SeguridadDAL.ComprobarConexion();
            }
            catch (Exception)
            {
                
                throw;
            }
        }

        public static void ConfiguracionInicial(string Id, string Nombre, string sex, string Puesto, string fechaNacimiento, string fecha2, string user, string password, string idUser)
        {
            try
            {
                SeguridadDAL.ConfiguracionInicial(Id, Nombre, sex, Puesto, fechaNacimiento, fecha2, user, password, idUser);
            }
            catch (Exception)
            {
                
                throw;
            }
        }


        public static void UsuarioActivo(int estado, string id)
        {
            try
            {
                SeguridadDAL.UsuarioActivo(estado, id);
            }
            catch (Exception)
            {
                
                throw;
            }
        }

        public static int numeroIngresos(string User, string Password)
        {
            try
            {
                return SeguridadDAL.numeroIngresos(User, Password);
            }
            catch (Exception)
            {
                throw;
            }
        }

        public static int numeroIngresos(string idUsuario)
        {
            try
            {
                return SeguridadDAL.numeroIngresos(idUsuario);
            }
            catch (Exception)
            {
                throw;
            }
        }

        public static void actualizarNumeroIngresos(string idUsuario)
        {
            try
            {
                SeguridadDAL.actualizarNumeroIngresos(idUsuario);
            }
            catch (Exception)
            {
                
                throw;
            }
        }


        public static int CambiarContrasenna(string idUsuario, string password, string idUser)
        {
            try
            {
                return SeguridadDAL.cambiarContrasenna(idUsuario, password,idUser);
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
            try
            {
                return SeguridadDAL.getBitacora();
            }
            catch (Exception)
            {
                
                throw;
            }
        }

    }
}
