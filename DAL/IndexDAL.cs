using DAO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public class IndexDAL
    {

        public static DataTable obtenerEspacios()
        {
            string oSql = "select idEspacio, Espacio from espacio";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerUsoMensual(int mes, int idEspacio, int anno)
        {
            string oSql = "select count(*) from evento_asistencia ea inner join persona p on ea.idTipoIdentificacion  = p.idTipoIdentificacion and ea.identificacion = p.numero_identificacion inner join evento_espacio ee on ea.idEvento = ee.idEvento and ea.idPeriodo = ee.idPeriodo and ee.fecha = ea.fecha where month(ea.fecha) = " + mes + " and ee.idEspacio = " + idEspacio + " and year(ea.fecha) = " + anno;
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable getEventos()
        {
            string oSql = "select e.idEvento, e.nombre_Evento from evento_inscripcion ei left join evento e on ei.idEvento = e.idEvento group by e.nombre_Evento order by e.idEvento;";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {
                throw;
            }
        }

        public static DataTable getEventos(string mes, string anno, string idEspacio)
        {
            string oSql = "select e.nombre_Evento, ee.idEvento from evento_espacio ee inner join evento e on ee.idEvento = e.idEvento where month(ee.fecha) = " + mes + " and year(ee.fecha) = " + anno + " and ee.idEspacio = " + idEspacio + " group by ee.idEvento";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {
                throw;
            }
        }

        public static DataTable getEspacioEvento(string mes, string anno)
        {
            string oSql = "select ee.idEspacio, e.Espacio from evento_espacio ee inner join espacio e on ee.idEspacio = e.idEspacio where month(ee.fecha) = " + mes + " and year(ee.fecha) = " + anno + " group by ee.idEspacio";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerFechaEventos()
        {
            string oSql = "select idEvento, nombre_Evento, idEspacio, espacio, idPeriodo, periodo_descripcion, fecha, horaInicio, horafinal, idTipoId, idEncargado, nombre_Completo from view_fechaEvento;";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerEstadistica(string idEvento, string idPeriodo, string mes, string anno, string idEspacio)
        {
            string oSql = "select e.Espacio, count(p.sexo) from evento_espacio ee inner join evento_asistencia ea on ee.idEvento = ea.idEvento and ee.idPeriodo = ea.idPeriodo and ee.fecha = ea.fecha inner join persona p on p.idTipoIdentificacion = ea.idTipoIdentificacion and p.numero_identificacion = ea.identificacion inner join espacio e on e.idEspacio = ee.idEspacio where ee.idEvento like '%" + idEvento + "%' and ee.idPeriodo like '%" + idPeriodo + "%' and month(ea.fecha) like '%" + mes + "%' and year(ea.fecha) like '%" + anno + "%' and ee.idEspacio like '%" + idEspacio + "%' group by ee.idEspacio;";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static DataTable obtenerEventosFinalizado()
        {
            string oSql = "select nombre_Evento, fecha_final as fecha from evento where estado = 1 and fecha_final < now() and  (fecha_final > date_add(now(), INTERVAL -15 day));";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerEventosDiarios()
        {
            string oSql = "select e.nombre_Evento, e.hora_inicio as hora from evento e inner join evento_dia_reserva ed on e.idEvento = ed.idEvento inner join diasemana ds on ed.idDia = ds.idDia where e.estado = 1 and DATE_FORMAT(now(), '%Y%m%d') between fecha_inicio and fecha_final and ed.idDia = dayofweek(now()) and ed.estado = 1 group by e.nombre_Evento;";

            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerEventosProximos()
        {
            string oSql = "select nombre_Evento,fecha_inicio as fecha from evento where estado = 1 and fecha_inicio >= now() and fecha_inicio <= date_add(now(), INTERVAL 30 day);";

            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerEventosPorTerminar()
        {
            string oSql = "select nombre_Evento,datediff(fecha_final,now()) as dias from evento where estado = 1 and fecha_final >= now() and fecha_final <= date_add(now(), INTERVAL 30 day);";

            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerDatosGrafico(int idEspacio)
        {
            string oSql = "CALL `db_cai`.`sp_GraficoPrincipal`(" + idEspacio + ");";

            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static string obtenerUsoMensual(int idEspacio, int idMes)
        {
            string oSql = "CALL `db_cai`.`sp_obtenerUsoMensual`(" + idEspacio + " , " + idMes + ");";

            try
            {
                return ConexionDAO.getInstance().EjecutarSQLScalar(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static string getPais()
        {
            string oSql = "select p.nombre from datos_institucion d inner join pais p on d.idpais = p.idPais;";
            try
            {
                return ConexionDAO.getInstance().EjecutarSQLScalar(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
