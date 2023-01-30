using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAO;

namespace DAL
{
    public class ReporteDAL
    {


        public static DataTable obtenerPersonasIncritas(int idEvento, int idPeriodo)
        {
            string oSql = "select ei.idTipoId, ei.IdPersona, p.nombre_Completo, p.celular, p.fecha_Nacimiento from persona p inner join evento_inscripcion ei on p.idTipoIdentificacion = ei.idTipoId and p.numero_identificacion = ei.IdPersona where ei.idEvento = " + idEvento + " and ei.idPeriodo = " + idPeriodo + " order by nombre_Completo;";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerEspacioEvento(int idEvento, int idPeriodo, string fecha)
        {
            string oSql = "select e.Espacio, ee.fecha from evento_espacio ee inner join espacio e on e.idEspacio = ee.idEspacio where ee.idEvento = " + idEvento + " and ee.idPeriodo = " + idPeriodo + " and ee.fecha like '" + fecha + "' ";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerEspacioxEvento(string mes, string anno)
        {
            string oSql = "select ee.idEspacio, e.Espacio from evento_espacio ee inner join espacio e on ee.idEspacio = e.idEspacio where month(ee.fecha) = " + mes + "  and year(ee.fecha) = " + anno + " group by ee.idEspacio";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable getUsoMensualSexo(string mes, string anno, int idEvento)
        {
            string oSql = "select p.sexo, count(sexo) from evento_asistencia ea inner join evento e on e.idEvento = ea.idEvento inner join evento_espacio ee on ee.idEvento = ea.idEvento and ee.idPeriodo = ea.idPeriodo and ee.idEvento = e.idEvento and ea.fecha = ee.fecha inner join persona p on p.idTipoIdentificacion = ea.idTipoIdentificacion and p.numero_identificacion = ea.identificacion where month(ea.fecha) = " + mes + " and e.idEvento = " + idEvento + " and year(ea.fecha) = " + anno + " group by p.sexo";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }

        }

        public static DataTable getEventoxEspacio(string mes, string anno, string idEspacio)
        {
            string oSql = @"select e.idEvento, e.nombre_Evento from evento_espacio ee inner join evento e on ee.idEvento = e.idEvento where month(ee.fecha) = " + mes + " and year(ee.fecha) = " + anno + " and ee.idEspacio = " + idEspacio + " group by e.idEvento";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable getUsoMensualFechas(string mes, string anno, string idEspacio, string idEvento)
        {
            string oSql = "select ea.fecha, min(ea.horaIngreso) as 'HoraEntrada', max(ea.horaSalida) as 'HoraSalida', COUNT(IF(p.sexo = 'male', 1, NULL)) 'H', COUNT(IF(p.sexo = 'female', 1, NULL)) 'M', count(p.sexo) as 'Total' from evento_asistencia ea inner join evento e on e.idEvento = ea.idEvento inner join evento_espacio ee on ee.idEvento = ea.idEvento and ee.idPeriodo = ea.idPeriodo and ee.idEvento = e.idEvento and ea.fecha = ee.fecha inner join persona p on p.idTipoIdentificacion = ea.idTipoIdentificacion and p.numero_identificacion = ea.identificacion WHERE month(ea.fecha) = " + mes + " and e.idEvento = " + idEvento + " and year(ea.fecha) = " + anno + " and ee.idEspacio = " + idEspacio + " group by ea.fecha;";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable ConsultarPersona(string ID)
        {
            string oSql = "select e.nombre_Evento, pe.periodo_descripcion, min(fecha) as fechaInicio,max(fecha) as fechaFinal from persona p inner join evento_inscripcion ei on p.idTipoIdentificacion = ei.idTipoId and ei.IdPersona = p.numero_identificacion inner join evento e on e.idEvento = ei.idEvento inner join periodo pe on pe.idPeriodo = ei.idPeriodo inner join evento_espacio ee on e.idEvento = ee.idEvento where p.numero_identificacion like '" + ID + "' group by nombre_Evento; ";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable ConsultarPersona(string tipoId, string busqueda)
        {
            string oSql = "";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable getInventario(string idEspacio, string idEncargado, string idTipoEquipo, string idCondicion)
        {
            string oSql = "select * from view_reporteinv where idEspacio like '%" + idEspacio + "%' and idEncargado like '%" + idEncargado + "%' and idtipoEquipo like '%" + idTipoEquipo + "%' and idcondicion like '%" + idCondicion + "%'";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable getEventos(string idEvento, string idEspacio, string idPeriodo)
        {
            string oSql = "select ee.idEvento,e.nombre_Evento,es.Espacio,ee.fecha,ee.horaInicio,ee.horaFinal,ee.IdEncargado, pe.nombre_Completo from evento_espacio ee inner join evento e on ee.idEvento = e.idEvento inner join espacio es on es.idEspacio = ee.idEspacio inner join periodo p on p.idPeriodo = ee.idPeriodo inner join persona pe on pe.numero_identificacion = ee.IdEncargado where ee.idEvento like '%" + idEvento + "%'  and ee.idPeriodo like '%" + idPeriodo + "%' and ee.idEspacio like '%" + idEspacio + "%'";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable getEventosEspacios(string idEspacio, string idPeriodo)
        {
            string oSql = "select ee.idEvento, e.nombre_Evento from evento_espacio ee inner join evento e on ee.idEvento = e.idEvento where ee.idEspacio like '%" + idEspacio + "%' and ee.idPeriodo like '%" + idPeriodo + "%' group by e.nombre_Evento order by ee.idEvento; ";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable getFechasCurso(int idEvento, int idPeriodo)
        {
            string oSql = "select fecha from evento_espacio where idEvento = " + idEvento + " and idPeriodo = " + idPeriodo;
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable getAsistencia(int idEvento, int idPeriodo, string fecha, string ID)
        {
            string oSql = "select horaIngreso,horaSalida from evento_asistencia where idEvento = " + idEvento + " and idPeriodo = " + idPeriodo + " and identificacion = " + ID + " and fecha = '" + fecha + "';";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }


        /*Viaja version*/
        public static DataTable obtenerAnno()
        {
            string oSql = @"select year(date_range) as Anno from (select (date_add((select min(fecha_Inicio) from evento), INTERVAL (0) month)) as date_range from mysql.help_topic a limit 0,1000) a where a.date_range between (select min(fecha_Inicio) from evento) and last_day((select max(fecha_final) from evento)) and year(date_range) like '%%' group by anno;";

            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerMes(String Anno)
        {
            string oSql = @"CALL `db_cai`.`sp_obtenerMesesEvento`('" + Anno + "');";

            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerUsoEspacio(int idEspacio, int idMes, int anno)
        {
            string oSql = "CALL `db_cai`.`sp_UsoEspacios`(1, " + idMes + ", " + anno + ", " + idEspacio + ");";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerHoraEspacio(int idEvento, int idMes, int anno)
        {
            string oSql = "select sec_to_time(avg(time_to_sec(timediff(hora_final,hora_inicio))))  from evento_diario where idEvento like '%" + idEvento + "%' and month(fecha_EventoDiario) like '%" + idMes + "%' and year(fecha_EventoDiario) like '%" + anno + "%';";

            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerUsoMensual(int asistencia, int idMes, int anno)
        {
            string oSql = "CALL `db_cai`.`sp_GraficoMensual`(" + asistencia + "," + idMes + "," + anno + ");";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerEquipos(string idcondicion, string idEspacio, string estado)
        {
            string oSql = "";

            if (estado.Equals(""))
            {
                oSql = @"Select e.idEquipo, e.placa, m.marca, e.modelo, e.descripcion, t.tipoEquipo, s.Espacio, d.condicion, e.observaciones, e.estado FROM equipo e join tipo_equipo t on t.idTipoEquipo = e.idTipoEquipo join marca_equipo m on m.idMarca = e.idMarca join espacio s on e.idEspacio = s.idEspacio join colaborador c on e.idEncargado = c.numero_Identificacion join condicion_equipo d on e.idCondicion = d.idCondicion where d.idCondicion like '%" + idcondicion + "%' and s.idEspacio like '%" + idEspacio + "%';";
            }
            else
            {
                oSql = @"Select e.idEquipo, e.placa, m.marca, e.modelo, e.descripcion, t.tipoEquipo, s.Espacio, d.condicion, e.observaciones, e.estado FROM equipo e join tipo_equipo t on t.idTipoEquipo = e.idTipoEquipo join marca_equipo m on m.idMarca = e.idMarca join espacio s on e.idEspacio = s.idEspacio join colaborador c on e.idEncargado = c.numero_Identificacion join condicion_equipo d on e.idCondicion = d.idCondicion where d.idCondicion like '%" + idcondicion + "%' and s.idEspacio like '%" + idEspacio + "%' and e.estado = '" + estado + "';";
            }


            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerInventario(string idEspacio)
        {
            string oSql = @"Select e.placa, concat(e.descripcion,'. ',m.marca,'. ',e.modelo,'. S/N:',e.serie,'. #', e.idEquipo) as descripcion, d.condicion, s.Espacio, e.observaciones, e.costoEquipo, c.nombre_Completo,  CASE WHEN e.estado = 0 then 'Inactivo' WHEN e.estado = 1 then 'Activo' end as Estado FROM equipo e join tipo_equipo t on t.idTipoEquipo = e.idTipoEquipo join marca_equipo m on m.idMarca = e.idMarca join espacio s on e.idEspacio = s.idEspacio join colaborador c on e.idEncargado = c.numero_Identificacion join condicion_equipo d on e.idCondicion = d.idCondicion where s.idEspacio like '%" + idEspacio + "%' order by s.idEspacio;;";

            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerEventos(string idEspacio, string idTipoEvento, string idPeriodo, DateTime fecha, string mes, string anno, int opcionFecha)
        {
            string oSql = @"select e.nombre_Evento, p.nombre_Completo, es.Espacio, e.descripcion, DATE_FORMAT(e.fecha_inicio, '%d/%m/%y') as fecha_Inicio, DATE_FORMAT(e.fecha_final, '%d/%m/%y') as fecha_Final, e.hora_inicio, e.hora_final, e.cantidad_participantes,ins.nombre_institucion  from evento e inner join tipo_evento tp on e.idTipoEvento = tp.idTipoEvento inner join espacio es on es.idEspacio = e.idEspacio inner join institucion ins on ins.idInstitucion = e.idInstitucion inner join evento_tipopersona etp on etp.idEvento = e.idEvento inner join persona p on p.numero_identificacion = etp.numero_identificacion where etp.idTipoPersona = 3 and e.idEspacio like '%" + idEspacio + "%' and  e.idTipoEvento like '%" + idTipoEvento + "%' and e.idPeriodo like '%" + idPeriodo + "%' and e.estado = 1";

            switch (opcionFecha)
            {
                case 1:
                    oSql += " and '" + fecha.ToString("yy-MM-dd") + "' between fecha_inicio and fecha_final;";
                    break;
                case 2:
                    oSql += " and '" + anno + "' between year(fecha_inicio) and year(fecha_final)";
                    break;
                case 3:
                    oSql += "and '" + anno + "' between year(fecha_inicio) and year(fecha_final);";
                    break;
                case 4:
                    oSql += " and '" + anno + "' between year(fecha_inicio) and year(fecha_final)";
                    oSql += " and '" + mes + "' between month(fecha_inicio) and month(fecha_final);";
                    break;
                default:
                    break;
            }


            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerFechaEvento(string idEvento)
        {
            string oSql = "select date_format(fecha_EventoDiario,'%d/%m/%y') as Fecha, fecha_EventoDiario from evento_diario where idEvento = '" + idEvento + "';";

            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerParticipantes(string idEvento, string fecha)
        {
            string oSql = @"select e.nombre_Evento, p.nombre_Completo as nombre, p.sexo from asistencia_participantes a inner join evento_diario ed on a.idEventoDiario = ed.idEventoDiario inner join evento e on e.idEvento = ed.idEvento inner join persona p on p.numero_identificacion = a.numero_Identificacion where ed.idEvento = '" + idEvento + "' and ed.fecha_EventoDiario like '" + fecha + "' and a.Asistencia = 1 order by p.nombre_Completo;";

            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }

        }

        public static DataTable obtenerEventosDiarios(string anno, string idmes)
        {
            string oSql = @"SELECT fecha_EventoDiario,hora_inicio,hora_final,Espacio,nombre_Evento,nombre_institucion,Encargado,Mujeres,Hombres,Total,promedio FROM db_cai.vw_eventodiarios where year(fecha_EventoDiario) like '%" + anno + "%'  and month(fecha_EventoDiario) like '%" + idmes + "%' order by fecha_EventoDiario;";

            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerAnnoEvtDrs()
        {
            string oSql = "select year(fecha_EventoDiario) as anno from db_cai.vw_eventodiarios group by anno order by anno;";

            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtnerMesEvtDrs(string anno)
        {
            string oSql = @"select monthname(fecha_EventoDiario) as Mes, month(fecha_EventoDiario) as IdMes from db_cai.vw_eventodiarios where year(fecha_EventoDiario) like '%" + anno + "%' group by Mes order by idMes;";

            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerEncabezado()
        {
            string oSql = @"select rutaLogo_Institucion,nombre_Institucion,iac.nombre,nombre_Departamento, iac.rutaLogo, telefono_Institucion, iac.telefono1, iac.direccion, iac.ext1, iac.email,rutaLogo_departamento from datos_institucion ins inner join datos_iac  iac on iac.idIAC = ins.codigo_institucion;";

            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
