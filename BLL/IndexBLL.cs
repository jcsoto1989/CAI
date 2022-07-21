using DAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class IndexBLL
    {
        public static DataTable getEventos()
        {
            try
            {
                return IndexDAL.getEventos();
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable getEventos(string mes, string anno, string idEspacio)
        {
            try
            {
                return IndexDAL.getEventos(mes, anno, idEspacio);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable getEspacioEvento(string mes, string anno)
        {
            try
            {
                return IndexDAL.getEspacioEvento(mes, anno);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerEspacios()
        {
            try
            {
                return IndexDAL.obtenerEspacios();
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerUsoMensual(int mes, int idEspacio, int anno)
        {
            try
            {
                return IndexDAL.obtenerUsoMensual(mes, idEspacio, anno);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerEstadistica(string idEvento, string idPeriodo, string mes, string anno, string idEspacio)
        {
            try
            {
                return IndexDAL.obtenerEstadistica(idEvento, idPeriodo, mes, anno, idEspacio);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerFechaEventos()
        {
            try
            {
                return IndexDAL.obtenerFechaEventos();
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerEventosFinalizado()
        {
            try
            {
                return IndexDAL.obtenerEventosFinalizado();
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerEventosDiarios()
        {
            try
            {
                return IndexDAL.obtenerEventosDiarios();
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerEventosProximos()
        {
            try
            {
                return IndexDAL.obtenerEventosProximos();
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerEventosPorTerminar()
        {
            try
            {
                return IndexDAL.obtenerEventosPorTerminar();
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerDatosGrafico(string idEspaciop)
        {
            int idEspacio = Convert.ToInt32(idEspaciop);
            try
            {
                return IndexDAL.obtenerDatosGrafico(idEspacio);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static string obtenerUsoMensual(int idEspacio, int idMes)
        {
            try
            {
                return IndexDAL.obtenerUsoMensual(idEspacio, idMes);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static string getPais()
        {
            try
            {
                return IndexDAL.getPais();
            }
            catch (Exception)
            {

                throw;
            }
        }

    }
}
