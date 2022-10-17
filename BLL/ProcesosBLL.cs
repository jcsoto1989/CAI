using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL;
using Entidad;
using System.Collections;

namespace BLL
{
    public class ProcesosBLL
    {

        /*******************************************************************************************/
        /**********                           Pestaña Evento                              **********/
        /*******************************************************************************************/

        public static void GuardarEspacioEvento(ArrayList oLstEspacio,int idEvento, int idPeriodo)
        {
            try
            {
                ProcesosDAL.GuardarEspacioEvento(oLstEspacio,idEvento,idPeriodo);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerEspacioEvento(int idEvento, int idPeriodo)
        {
            try
            {
                return ProcesosDAL.obtenerEspacioEvento(idEvento, idPeriodo);
            }
            catch (Exception)
            {
                
                throw;
            }
        }

        public static DataTable obtenerEspacioEvento(int idEvento)
        {
            try
            {
                 return ProcesosDAL.obtenerEspacioEvento(idEvento);
            }
            catch (Exception)
            {
                
                throw;
            }
        }

        public static DataTable obtenerEvento(int estado)
        {
            try
            {
                return ProcesosDAL.obtenerEvento(estado);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static void GuardarEvento(evento oEvento, string idUser)
        {
            try
            {
                ProcesosDAL.GuardarEvento(oEvento, idUser);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static void EliminarEvento(int idEvento, string idUser)
        {
            try
            {
                ProcesosDAL.EliminarEvento(idEvento, idUser);
            }
            catch (Exception)
            {

                throw;
            }
        }
        /*******************************************************************************************/
        /**********                           Pestaña Persona                             **********/
        /*******************************************************************************************/

        public static DataTable obtenerPersona()
        {
            try
            {
                return ProcesosDAL.obtenerPersona();
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static DataTable obtenerPersonaIdentificacion()
        {
            try
            {
                return ProcesosDAL.obtenerPersonaIdentificacion();
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static DataTable obtenerPersona(int TipoID, string ID, int estado)
        {
            try
            {
                return ProcesosDAL.obtenerPersona(TipoID, ID, estado);
            }
            catch (Exception)
            {
                
                throw;
            }
        }
        public static void GuardarPersona(Persona oPersona, string idUser)
        {
            try
            {
                ProcesosDAL.GuardarPersona(oPersona, idUser);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static DataTable obtenerTipoIdentificacion(int estado)
        {
            try
            {
                return ProcesosDAL.obtenerTipoIdentificacion(estado);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerPais()
        {
            try
            {
                return ProcesosDAL.obtenerPais();
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static void EliminarPersona(string idTipoIdentificacion, string idPersona, string idUser)
        {
            try
            {
                ProcesosDAL.EliminarPersona(idTipoIdentificacion, idPersona, idUser);
            }
            catch (Exception)
            {
                
                throw;
            }
        }

        public static int guardarExcel(ArrayList oLstPersona, ArrayList oLstMatricula, string idUser)
        {
            try
            {
                return ProcesosDAL.guardarExcel(oLstPersona, oLstMatricula, idUser);
            }
            catch (Exception)
            {
                
                throw;
            }
        }

        /*******************************************************************************************/
        /**********                           Pestaña Inscipcion                          **********/
        /*******************************************************************************************/
        public static DataTable obtenerMatriculados(int idEvento, int idPeriodo)
        {
            try
            {
                return ProcesosDAL.obtenerMatriculados(idEvento, idPeriodo);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerMatriculados(int idEvento, int idPeriodo, int tipoID, string ID)
        {
            try
            {
                return ProcesosDAL.obtenerMatriculados(idEvento, idPeriodo, tipoID, ID);
            }
            catch (Exception)
            {
                
                throw;
            }
        }
        public static DataTable getPersona( string ID)
        {
            try
            {
                return ProcesosDAL.getPersona(ID);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static void GuardarInscripcion(Matricula oMatricula, string idUser)
        {
            try
            {
                ProcesosDAL.GuardarInscripcion(oMatricula, idUser);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataSet obtenerBoletaMatricula(string cedula, string idEvento, string idPeriodo)
        {
            try
            {
                return ProcesosDAL.boletaMatricula(cedula, idEvento, idPeriodo);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static int eliminarInscripcion(int idTipoId, string idPersona, int idEvento, int idPeriodo)
        {
            try
            {
                return ProcesosDAL.eliminarInscripcion(idTipoId, idPersona, idEvento, idPeriodo);
            }
            catch (Exception)
            {
                
                throw;
            }
        }

        /*******************************************************************************************/
        /**********                           Pestaña Periodo                             **********/
        /*******************************************************************************************/

        public static DataTable obtenerPeriodo(int estado)
        {
            try
            {
                return ProcesosDAL.obtenerPeriodo(estado);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static void GuardarPeriodo(periodo operiodo, string idUser)
        {
            try
            {
                ProcesosDAL.GuardarPeriodo(operiodo, idUser);
            }
            catch (Exception)
            {
                throw;
            }
        }

        public static void EliminarPeriodo(int idPeriodo, string idUser)
        {
            try
            {
                ProcesosDAL.EliminarPeriodo(idPeriodo, idUser);
            }
            catch (Exception)
            {

                throw;
            }
        }


        /*******************************************************************************************/
        /**********                           Pestaña Tipo Evento                         **********/
        /*******************************************************************************************/
        public static void GuardarTipoEvento(tipo_evento otipoevento, string idUser)
        {
            try
            {
                ProcesosDAL.GuardarTipoEvento(otipoevento, idUser);
            }
            catch (Exception)
            {
                throw;
            }
        }
        public static DataTable obtenerTipoEvento(int estado)
        {
            try
            {
                return ProcesosDAL.obtenerTipoEvento(estado);
            }
            catch (Exception)
            {
                throw;
            }
        }
        public static void EliminarTipoEvento(int idTipoEvento, string idUser)
        {
            try
            {
                ProcesosDAL.EliminarTipoEvento(idTipoEvento, idUser);
            }
            catch (Exception)
            {

                throw;
            }
        }


        /*******************************************************************************************/
        /**********                           Pestaña Asistencia                          **********/
        /*******************************************************************************************/
        public static DataTable obtenerAsistencia(int idEvento, int idPeriodo, DateTime fecha)
        {
            try
            {
                return ProcesosDAL.obtenerAsistencia(idEvento, idPeriodo, fecha);
            }
            catch (Exception)
            {
                
                throw;
            }
        }

        public static void GuardarAsistencia(Asistencia oAsistencia)
        {
            try
            {
                ProcesosDAL.GuardarAsistencia(oAsistencia);
            }
            catch (Exception)
            {
                
                throw;
            }
        }

        public static void EliminarAsistencia(int idAsistencia)
        {
            try
            {
                ProcesosDAL.EliminarAsistencia(idAsistencia);
            }
            catch (Exception)
            {
                
                throw;
            }
        }
        /*******************************************************************************************/
        /**********                                  FIN                                  **********/
        /*******************************************************************************************/

    }
}

