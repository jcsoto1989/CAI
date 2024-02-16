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
using System.Collections;

namespace DAL
{
    public class ProcesosDAL
    {
        /*************************************************************************************************/
        /*                                        Espacio - Evento                                       */
        /*************************************************************************************************/

        public static void GuardarEspacioEvento(ArrayList oLstEspacio, int idEvento, int idPeriodo)
        {
            try
            {
                List<MySqlCommand> lstComandos = new List<MySqlCommand>();

                MySqlCommand oCommandd = new MySqlCommand("delete from evento_espacio where idEvento = @idEventop and idPeriodo = @idPeriodop;");
                oCommandd.CommandType = CommandType.Text;
                oCommandd.Parameters.AddWithValue("@idEventop", idEvento);
                oCommandd.Parameters.AddWithValue("@idPeriodop", idPeriodo);
                lstComandos.Add(oCommandd);


                foreach (EspacioEvento oItem in oLstEspacio)
                {
                    MySqlCommand oCommand = new MySqlCommand("sp_GuardarEventoEspacio");
                    oCommand.CommandType = CommandType.StoredProcedure;
                    oCommand.Parameters.AddWithValue("@idEventop", oItem.idEvento);
                    oCommand.Parameters.AddWithValue("@idEspaciop", oItem.idEspacio);
                    oCommand.Parameters.AddWithValue("@idPeriodop", oItem.idPeriodo);
                    oCommand.Parameters.AddWithValue("@fechap", oItem.fecha);
                    oCommand.Parameters.AddWithValue("@horaIniciop", oItem.horaInicio);
                    oCommand.Parameters.AddWithValue("@horaFinalp", oItem.horaFinal);
                    oCommand.Parameters.AddWithValue("@idTipoIdp", oItem.idTipoIdpersona);
                    oCommand.Parameters.AddWithValue("@idEncargadop", oItem.idEncargado);
                    oCommand.Parameters.AddWithValue("@controlPCp", oItem.ControlPC);
                    lstComandos.Add(oCommand);
                }

                ConexionDAO.getInstance().EjecutarSqlActualizacion(lstComandos);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerEspacioEvento(int idEvento, int idPeriodo)
        {
            string oSql = "Select idEvento,idEspacio,idPeriodo,fecha as Column2,horaInicio as Column3,horaFinal as Column4,idTipoId,idEncargado as Column5,idUsuariop, controlPC from evento_espacio where idEvento = " + idEvento + " and idPeriodo = " + idPeriodo;

            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static DataTable obtenerEspacioEvento(int idEvento)
        {
            string oSql = "select ee.idPeriodo, p.periodo_descripcion from evento_espacio ee inner join periodo p on ee.idPeriodo = p.idPeriodo where idEvento = " + idEvento + " group by idPeriodo";

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
        /*                                             Evento                                            */
        /*************************************************************************************************/

        public static DataTable obtenerEvento(int estado)
        {
            string oSql;
            if (estado == 1)
            {
            oSql = "select e.idEvento, e.nombre_Evento, e.idTipoEvento, tp.tipoEvento_descripcion, e.estado, e.idUsuario,e.idInstitucion,i.nombre_institucion,e.observaciones from evento e inner join tipo_evento tp on e.idTipoEvento = tp.idTipoEvento inner join institucion i on i.idInstitucion = e.idInstitucion where e.estado = " + estado;
            }
            else
            {
            oSql = "select e.idEvento, e.nombre_Evento, e.idTipoEvento, tp.tipoEvento_descripcion, e.estado, e.idUsuario,e.idInstitucion,i.nombre_institucion,e.observaciones from evento e inner join tipo_evento tp on e.idTipoEvento = tp.idTipoEvento inner join institucion i on i.idInstitucion = e.idInstitucion  ";
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
        public static void GuardarEvento(evento oevento, string idUser)
        {
            try
            {
                MySqlCommand command = new MySqlCommand("sp_GuardarEvento");
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@idEventop", oevento.idEvento);
                command.Parameters.AddWithValue("@nombre_Eventop", oevento.nombre_Evento);
                command.Parameters.AddWithValue("@idTipoEventop", oevento.idTipoEvento);
                command.Parameters.AddWithValue("@estadop", oevento.estado);
                command.Parameters.AddWithValue("@idUsuariop", idUser);
                command.Parameters.AddWithValue("@idInstitucionp", oevento.idInstitucion);
                command.Parameters.AddWithValue("@observacionesp", oevento.observaciones);

                ConexionDAO.getInstance().EjecutarSqlActualizacion(command);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static void EliminarEvento(int idEvento, string idUser)
        {
            string oMySql = "update evento set estado = 0, idUsuario = '" + idUser + "' where idEvento = '" + idEvento + "'";

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
        /*                                               Persona                                         */
        /*************************************************************************************************/

        public static DataTable obtenerTipoIdentificacion(int estado)
        {
            string oSql = "select idTipoIdentificacion,descripcion,observaciones,estado,idUsuario from tipo_identificacion_persona where estado = " + estado;
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerPais()
        {
            string oSql = "select idPais, iso, nombre from pais";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
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
                MySqlCommand command = new MySqlCommand("sp_GuardarPersona");
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@idTipoIdentificacionp", oPersona.tipoIdPersona);
                command.Parameters.AddWithValue("@numero_identificacionp", oPersona.idPersona);
                command.Parameters.AddWithValue("@nombre_Completop", oPersona.nombre_Completo);
                command.Parameters.AddWithValue("@celularp", oPersona.celular);
                command.Parameters.AddWithValue("@telefonop", oPersona.telefono);
                command.Parameters.AddWithValue("@emailp", oPersona.email);
                command.Parameters.AddWithValue("@estadoCivilp", oPersona.estadoCivil);
                command.Parameters.AddWithValue("@fecha_Nacimientop", oPersona.fechaNacimiento);
                command.Parameters.AddWithValue("@direccionp", oPersona.direccion);
                command.Parameters.AddWithValue("@sexop", oPersona.sexo);
                command.Parameters.AddWithValue("@idPaisp", oPersona.pais);
                command.Parameters.AddWithValue("@nombre_Completo_Emergenciap", oPersona.ContactoEmergencia);
                command.Parameters.AddWithValue("@telefono_Contactop", oPersona.telContacto);
                command.Parameters.AddWithValue("@observaciones_personap", oPersona.observaciones);
                command.Parameters.AddWithValue("@estadop", oPersona.estado);
                command.Parameters.AddWithValue("@idUsuariop", idUser);
                ConexionDAO.getInstance().EjecutarSqlActualizacion(command);
            }
            catch (Exception)
            {
                throw;
            }
        }

        public static DataTable obtenerPersona()
        {
            String oSql = @"select idTipoIdentificacion,numero_identificacion,nombre_Completo,celular,telefono,email,estadoCivil,fecha_Nacimiento,direccion,sexo,idPais,nombre_Completo_Emergencia,telefono_Contacto,observaciones_Persona,estado,idUsuario from persona where estado = 1 order by nombre_Completo";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {
                throw;
            }
        }
        public static DataTable obtenerPersonaIdentificacion()
        {
            String oSql = @"select idTipoIdentificacion,numero_identificacion,nombre_Completo,celular,telefono,email,estadoCivil,fecha_Nacimiento,direccion,sexo,idPais,nombre_Completo_Emergencia,telefono_Contacto,observaciones_Persona,estado,idUsuario from persona where estado = 1 order by numero_identificacion ASC";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {
                throw;
            }
        }

        public static DataTable obtenerPersona(int TipoID, string ID, int estado)
        {
            String oSql = @"select idTipoIdentificacion,numero_identificacion,nombre_Completo,celular,telefono,email,estadoCivil,fecha_Nacimiento,direccion,sexo,idPais,nombre_Completo_Emergencia,telefono_Contacto,observaciones_Persona,estado,idUsuario from persona where estado = " + estado + " and idTipoIdentificacion = " + TipoID + " and numero_identificacion like '" + ID + "'  order by nombre_Completo";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {
                throw;
            }
        }
        public static DataTable obtenerPersonaPorId(string id, int estado)
        {
            String oSql = @"select idTipoIdentificacion,numero_identificacion,nombre_Completo,celular,telefono,email,estadoCivil,fecha_Nacimiento,direccion,sexo,idPais,nombre_Completo_Emergencia,telefono_Contacto,observaciones_Persona,estado,idUsuario from persona where numero_identificacion = '" + id + "'  order by nombre_Completo";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {
                throw;
            }
        }

        public static DataTable obtenerPersona(string ID)
        {
            String oSql = @"select idTipoIdentificacion,numero_identificacion,nombre_Completo,celular,telefono,email,estadoCivil,fecha_Nacimiento,direccion,sexo,pa.nombre,nombre_Completo_Emergencia,telefono_Contacto,observaciones_Persona,pe.estado,pe.idUsuario,ei.poliza,ei.fechaPoliza from persona pe inner join pais pa on pe.idPais = pa.idPais inner join evento_inscripcion ei on ei.idPersona = pe.numero_identificacion where numero_identificacion like '" + ID + "'  group by numero_identificacion order by nombre_Completo";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {
                throw;
            }
        }

        public static DataTable getPersona(string Identificacion)
        {
            string oSql = @"SELECT              numero_identificacion,nombre_Completo,email,sexo,fecha_Nacimiento,celular,idInstitucion,idOcupacion,observaciones_Persona,estado,idTipoPersona FROM persona where numero_identificacion like '" + Identificacion + "'; ";

            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable getSexo()
        {
            string oSql = "select sexoId,descripcion from sexo;";

            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static void EliminarPersona(string idTipoIdentificacion, string idPersona, string idUser)
        {
            string oMySql = "update persona set estado = 0, idUsuario = '" + idUser + "' where numero_Identificacion like '" + idPersona + "' and idTipoIdentificacion = " + idTipoIdentificacion + ";";
            try
            {
                ConexionDAO.getInstance().EjecutarConsultaDataTable(oMySql);
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
                List<MySqlCommand> olstCommand = new List<MySqlCommand>();

                foreach (Persona oPersona in oLstPersona)
                {
                    MySqlCommand command = new MySqlCommand("sp_GuardarPersona");
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@idTipoIdentificacionp", oPersona.tipoIdPersona);
                    command.Parameters.AddWithValue("@numero_identificacionp", oPersona.idPersona);
                    command.Parameters.AddWithValue("@nombre_Completop", oPersona.nombre_Completo);
                    command.Parameters.AddWithValue("@celularp", oPersona.celular);
                    command.Parameters.AddWithValue("@telefonop", oPersona.telefono);
                    command.Parameters.AddWithValue("@emailp", oPersona.email);
                    command.Parameters.AddWithValue("@estadoCivilp", oPersona.estadoCivil);
                    command.Parameters.AddWithValue("@fecha_Nacimientop", oPersona.fechaNacimiento);
                    command.Parameters.AddWithValue("@direccionp", oPersona.direccion);
                    command.Parameters.AddWithValue("@sexop", oPersona.sexo);
                    command.Parameters.AddWithValue("@idPaisp", oPersona.pais);
                    command.Parameters.AddWithValue("@nombre_Completo_Emergenciap", oPersona.ContactoEmergencia);
                    command.Parameters.AddWithValue("@telefono_Contactop", oPersona.telContacto);
                    command.Parameters.AddWithValue("@observaciones_personap", oPersona.observaciones);
                    command.Parameters.AddWithValue("@estadop", oPersona.estado);
                    command.Parameters.AddWithValue("@idUsuariop", idUser);
                    olstCommand.Add(command);
                }


                foreach (Matricula oMatricula in oLstMatricula)
                {
                    MySqlCommand command = new MySqlCommand("sp_GuardarEventoInscripcion");
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.AddWithValue("@idTipoIdp", oMatricula.idTipoIdentificacion);
                    command.Parameters.AddWithValue("@idPersonap", oMatricula.idPersona);
                    command.Parameters.AddWithValue("@idEventop", oMatricula.idEvento);
                    command.Parameters.AddWithValue("@idPeriodop", oMatricula.idPeriodo);
                    command.Parameters.AddWithValue("@bancop", oMatricula.banco);
                    command.Parameters.AddWithValue("@montop", oMatricula.monto);
                    command.Parameters.AddWithValue("@numComprobantep", oMatricula.numComprobante);
                    command.Parameters.AddWithValue("@fechaComprobantep", Convert.ToDateTime(oMatricula.fechaComprobante));
                    command.Parameters.AddWithValue("@polizap", oMatricula.poliza);
                    command.Parameters.AddWithValue("@fechaPolizap", Convert.ToDateTime(oMatricula.fechaPoliza));
                    command.Parameters.AddWithValue("@observacionesp", oMatricula.observaciones);
                    command.Parameters.AddWithValue("@situacionEspecialp", oMatricula.situacionEspecial);
                    command.Parameters.AddWithValue("@estadop", oMatricula.estado);
                    command.Parameters.AddWithValue("@idUsuariop", idUser);
                    olstCommand.Add(command);
                }

                return ConexionDAO.getInstance().EjecutarSqlActualizacion(olstCommand);
            }
            catch (Exception)
            {

                throw;
            }
        }

        /*************************************************************************************************/
        /*                                             Inscripcion                                       */
        /*************************************************************************************************/

        public static DataTable obtenerMatriculados()
        {
            string oSql = "select idTipoId,idPersona,idEvento,idPeriodo,banco,monto,numComprobante,fechaComprobante,poliza,fechaPoliza,observaciones,estado from evento_inscripcion";

            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static DataSet obtenerUltimaMatricula(int pTipoId, string pIdentificacion)
        {
           
            string oSql = "select * from evento_inscripcion WHERE IdTipoId = " + pTipoId + " AND IdPersona = " +"'" +pIdentificacion+"'" + " ORDER BY fechaPoliza  DESC LIMIT 1";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataSet(oSql); 
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerMatriculados(int idEvento, int idPeriodo)
        {
            string oSql = "select e.idTipoId, e.idPersona, p.nombre_Completo, idEvento, idPeriodo, banco, monto, numComprobante, fechaComprobante, poliza, fechaPoliza, observaciones, situacionEspecial, e.estado from evento_inscripcion e inner join persona p on e.IdPersona = p.numero_identificacion and e.idTipoId = p.idTipoIdentificacion where idEvento = " + idEvento + " and idPeriodo = " + idPeriodo + " order by p.nombre_Completo";

            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerMatriculados(int idEvento, int idPeriodo, int tipoID, string ID)
        {
            string oSql = "select e.idTipoId, e.idPersona, p.nombre_Completo, idEvento, idPeriodo, banco, monto, numComprobante, fechaComprobante, poliza, fechaPoliza, observaciones, situacionEspecial, e.estado from evento_inscripcion e inner join persona p on e.IdPersona = p.numero_identificacion and e.idTipoId = p.idTipoIdentificacion where idEvento = " + idEvento + " and idPeriodo = " + idPeriodo + " and e.idTipoId = " + tipoID + " and e.idPersona like '" + ID + "'";

            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
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
                MySqlCommand command = new MySqlCommand("sp_GuardarEventoInscripcion");
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@idTipoIdp", oMatricula.idTipoIdentificacion);
                command.Parameters.AddWithValue("@idPersonap", oMatricula.idPersona);
                command.Parameters.AddWithValue("@idEventop", oMatricula.idEvento);
                command.Parameters.AddWithValue("@idPeriodop", oMatricula.idPeriodo);
                command.Parameters.AddWithValue("@bancop", oMatricula.banco);
                command.Parameters.AddWithValue("@montop", oMatricula.monto);
                command.Parameters.AddWithValue("@numComprobantep", oMatricula.numComprobante);
                command.Parameters.AddWithValue("@fechaComprobantep", Convert.ToDateTime(oMatricula.fechaComprobante));
                command.Parameters.AddWithValue("@polizap", oMatricula.poliza);
                command.Parameters.AddWithValue("@fechaPolizap", Convert.ToDateTime(oMatricula.fechaPoliza));
                command.Parameters.AddWithValue("@observacionesp", oMatricula.observaciones);
                command.Parameters.AddWithValue("@situacionEspecialp", oMatricula.situacionEspecial);
                command.Parameters.AddWithValue("@estadop", oMatricula.estado);
                command.Parameters.AddWithValue("@idUsuariop", idUser);

                ConexionDAO.getInstance().EjecutarSqlActualizacion(command);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataSet boletaMatricula(string cedula, string idEvento, string idPeriodo)
        {
            string oSql = "SELECT nombre_Completo,numero_Identificacion,celular,telefono,fecha_Nacimiento,estadoCivil,direccion,email,nombre_Completo_Emergencia,telefono_Contacto,nombre_Evento,monto,fechaComprobante,banco,numComprobante,observaciones,sexo,paisNombre,situacionEspecial FROM view_boletamatricula WHERE numero_Identificacion like '" + cedula + "' and idEvento like '" + idEvento + "' and idPeriodo like '" + idPeriodo + "'";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataSet(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static int eliminarInscripcion(int idTipoId, string idPersona, int idEvento, int idPeriodo)
        {
            string oSql = "delete from evento_inscripcion where idTipoId = " + idTipoId + " and IdPersona like '" + idPersona + "' and idEvento = " + idEvento + " and idPeriodo = " + idPeriodo + ";";

            try
            {
                return ConexionDAO.getInstance().EjecutarSqlActualizacion(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        /*************************************************************************************************/
        /*                                               Periodo                                         */
        /*************************************************************************************************/

        public static DataTable obtenerPeriodo(int estado)
        {
            String oSql = "";
            if(estado == 2)
            { oSql = "select idPeriodo,periodo_descripcion,observaciones,estado from Periodo"; } else { 
            oSql = "select idPeriodo,periodo_descripcion,observaciones,estado from Periodo where estado = " + estado;
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

        public static void GuardarPeriodo(periodo operiodo, string idUser)
        {
            try
            {
                MySqlCommand command = new MySqlCommand("sp_GuardarPeriodo");
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@idPeriodop", operiodo.idPeriodo);
                command.Parameters.AddWithValue("@periodo_descripcionp", operiodo.periodo_descripcion);
                command.Parameters.AddWithValue("@observacionesp", operiodo.observaciones);
                command.Parameters.AddWithValue("@estadop", operiodo.estado);
                command.Parameters.AddWithValue("@idUsuariop", idUser);

                ConexionDAO.getInstance().EjecutarSqlActualizacion(command);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static void EliminarPeriodo(int idPeriodo, string idUser)
        {
            string oMySql = "update periodo set estado = 0, idUsuario = '" + idUser + "' where idPeriodo = '" + idPeriodo + "'";

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
        /*                                               Tipo Evento                                     */
        /*************************************************************************************************/

        public static void GuardarTipoEvento(tipo_evento otipoevento, string idUser)
        {
            try
            {
                MySqlCommand command = new MySqlCommand("sp_GuardarTipoEvento");
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@idTipoEventop", otipoevento.idTipoEvento);
                command.Parameters.AddWithValue("@tipoEvento_descripcionp", otipoevento.tipoEvento_descripcion);
                command.Parameters.AddWithValue("@observacionesp", otipoevento.observaciones);
                command.Parameters.AddWithValue("@estadop", otipoevento.estado);
                command.Parameters.AddWithValue("@idUsuariop", idUser);

                ConexionDAO.getInstance().EjecutarSqlActualizacion(command);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static DataTable obtenerTipoEvento(int estado)
        {
            string oSql = "select idTipoEvento,tipoEvento_descripcion,observaciones,estado, idUsuario from tipo_evento where estado = " + estado;
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static void EliminarTipoEvento(int idTipoEvento, string idUser)
        {
            string oMySql = "update tipo_evento set estado = 0, idUsuario = '" + idUser + "' where idTipoEvento = '" + idTipoEvento + "'";

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
        /*                                             Asistencia                                        */
        /*************************************************************************************************/

        public static DataTable obtenerAsistencia(int idEvento, int idPeriodo, DateTime fecha)
        {
            string oSql = "select idAsistencia, ea.idTipoIdentificacion, identificacion, p.nombre_Completo, idEvento, idPeriodo, fecha, horaIngreso, horaSalida, NumPC from evento_asistencia ea inner join persona p on ea.idTipoIdentificacion = p.idTipoIdentificacion and ea.identificacion = p.numero_identificacion where idEvento = " + idEvento + " and idPeriodo = " + idPeriodo + " and fecha like '" + fecha.ToString("yyyy-MM-dd") + "';";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
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
                MySqlCommand command = new MySqlCommand("sp_GuardarAsistenciaWeb");
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@idTipoIdentificacionp", oAsistencia.idTipoID);
                command.Parameters.AddWithValue("@identificacionp", oAsistencia.ID);
                command.Parameters.AddWithValue("@idEventop", oAsistencia.idEvento);
                command.Parameters.AddWithValue("@idPeriodop", oAsistencia.idPeriodo);
                command.Parameters.AddWithValue("@fechap", oAsistencia.fecha);
                command.Parameters.AddWithValue("@horaIngresop", oAsistencia.horaIngreso);
                command.Parameters.AddWithValue("@horaSalidap", oAsistencia.horaSalida);
                command.Parameters.AddWithValue("@numPCp", oAsistencia.numPC);

                ConexionDAO.getInstance().EjecutarSqlActualizacion(command);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static void EliminarAsistencia(int idAsistencia)
        {
            string oSql = "delete from evento_asistencia where idAsistencia = " + idAsistencia;
            try
            {
                ConexionDAO.getInstance().EjecutarSqlActualizacion(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }
        /************************************************** FIN ******************************************/

    }
}
