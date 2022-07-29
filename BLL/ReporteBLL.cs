using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL;

namespace BLL
{
    public class ReporteBLL
    {
        public static DataTable obtenerPersonasIncritas(int idEvento, int idPeriodo)
        {
            try
            {
                return ReporteDAL.obtenerPersonasIncritas(idEvento, idPeriodo);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerEspacioEvento(int idEvento, int idPeriodo, string fecha)
        {
            try
            {
                return ReporteDAL.obtenerEspacioEvento(idEvento, idPeriodo, fecha);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerEspacioxEvento(string mes, string anno)
        {
            try
            {
                return ReporteDAL.obtenerEspacioxEvento(mes, anno);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable getEventoxEspacio(string mes, string anno, string idEspacio)
        {
            try
            {
                return ReporteDAL.getEventoxEspacio(mes, anno, idEspacio);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable getUsoMensualSexo(string mes, string anno, int idEvento)
        {
            try
            {
                return ReporteDAL.getUsoMensualSexo(mes, anno, idEvento);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable getUsoMensualFechas(string mes, string anno, string idEspacio, string idEvento)
        {
            try
            {
                return ReporteDAL.getUsoMensualFechas(mes, anno, idEspacio, idEvento);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable getAsistencia(int idEvento, int idPeriodo)
        {
            DataTable dt = new DataTable();
            return dt;
        }

        public static DataTable getFechasCurso(int idEvento, int idPeriodo)
        {
            try
            {
                return ReporteDAL.getFechasCurso(idEvento, idPeriodo);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable getAsistencia(int idEvento, int idPeriodo, string fecha, string ID)
        {
            try
            {
                return ReporteDAL.getAsistencia(idEvento, idPeriodo, fecha, ID);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable getInventario(string idEspacio, string idEncargado, string idTipoEquipo, string idCondicion)
        {
            try
            {
                return ReporteDAL.getInventario(idEspacio, idEncargado, idTipoEquipo, idCondicion);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static DataTable getEventosEspacios(string idEspacio, string idPeriodo)
        {
            try
            {
                return ReporteDAL.getEventosEspacios(idEspacio, idPeriodo);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static DataTable getEventos(string idEvento, string idEspacio, string idPeriodo)
        {
            try
            {
                return ReporteDAL.getEventos(idEvento, idEspacio, idPeriodo);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable ConsultarPersona(string tipoId, string busqueda)
        {
            try
            {
                return ReporteDAL.ConsultarPersona(tipoId, busqueda);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerPersona(string ID)
        {
            try
            {
                return ProcesosDAL.obtenerPersona(ID);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable ConsultarPersona(string busqueda)
        {
            try
            {
                return ReporteDAL.ConsultarPersona(busqueda);
            }
            catch (Exception)
            {

                throw;
            }
        }



        /*Viaje Version*/
        public static DataTable obtenerAnno()
        {
            try
            {
                return ReporteDAL.obtenerAnno();
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerMes(String Anno)
        {
            try
            {
                return ReporteDAL.obtenerMes(Anno);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerUsoEspacio(int idEspacio, int idMes, int anno)
        {
            try
            {
                return ReporteDAL.obtenerUsoEspacio(idEspacio, idMes, anno);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerHoraEspacio(int idEvento, int idMes, int anno)
        {
            try
            {
                return ReporteDAL.obtenerHoraEspacio(idEvento, idMes, anno);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerUsoMensual(int asistencia, int idMes, int anno)
        {
            try
            {
                return ReporteDAL.obtenerUsoMensual(asistencia, idMes, anno);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerEquipos(string idcondicion, string idEspacio, string estado)
        {
            try
            {
                return ReporteDAL.obtenerEquipos(idcondicion, idEspacio, estado);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerInventario(string idEspacio)
        {
            try
            {
                return ReporteDAL.obtenerInventario(idEspacio);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerEventos(string idEspacio, string idTipoEvento, string idPeriodo, DateTime fecha, string mes, string anno, int opcionFecha)
        {
            try
            {
                return ReporteDAL.obtenerEventos(idEspacio, idTipoEvento, idPeriodo, fecha, mes, anno, opcionFecha);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerFechaEvento(string idEvento)
        {
            try
            {
                return ReporteDAL.obtenerFechaEvento(idEvento);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerParticipantes(string idEvento, string fecha)
        {
            try
            {
                return ReporteDAL.obtenerParticipantes(idEvento, fecha);

            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerEventosDiarios(string anno, string idMes)
        {
            try
            {
                return ReporteDAL.obtenerEventosDiarios(anno, idMes);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerAnnoEvtDrs()
        {
            try
            {
                return ReporteDAL.obtenerAnnoEvtDrs();
            }
            catch (Exception)
            {

                throw;
            }

        }

        public static DataTable obtnerMesEvtDrs(string anno)
        {
            try
            {
                return ReporteDAL.obtnerMesEvtDrs(anno);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerEncabezado()
        {
            try
            {
                return ReporteDAL.obtenerEncabezado();
            }
            catch (Exception)
            {

                throw;
            }
        }

        
    }
}
