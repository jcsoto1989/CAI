using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entidad;
using MySql.Data.MySqlClient;
using System.Data;
using DAO;

namespace DAL
{
    public class MantenimientoDAL
    {

        //Puesto Part
        public static void GuardarPuesto(Puesto oPuesto, string idUser)
        {
            try
            {
                MySqlCommand command = new MySqlCommand("sp_GuardarPuesto");
                command.CommandType = CommandType.StoredProcedure;
                
                command.Parameters.AddWithValue("@idPuestop", oPuesto.idPuesto);
                command.Parameters.AddWithValue("@Puestop", oPuesto.puesto);
                command.Parameters.AddWithValue("@Observacionesp", oPuesto.observaciones);
                command.Parameters.AddWithValue("@idUsuariop", idUser);

                ConexionDAO.getInstance().EjecutarSqlActualizacion(command);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable obtenerPuestos()
        {
            string oMySql = "select idPuesto,puesto,observaciones from puesto where estado = 1";

            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oMySql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static void EliminarPuesto(int idPuesto, string idUser)
        {
            string oMySql = "update Puesto set estado = 0, idUsuario = '" + idUser + "' where idPuesto = " + idPuesto;

            try
            {
                ConexionDAO.getInstance().EjecutarConsultaDataTable(oMySql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        //Tipo Equipo Part
        public static DataTable getTipoEquipo()
        {
            String oSql = "Select * from Tipo_Equipo where estado = 1";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static void GuardarTipoEquipo(TipoEquipo oTipoEquipo, string idUser)
        {
            try
            {
                MySqlCommand command = new MySqlCommand("sp_GuardarTipoEquipo");
                command.CommandType = CommandType.StoredProcedure;
                
                command.Parameters.AddWithValue("@idTipoEquipop", oTipoEquipo.idTipoEquipo);
                command.Parameters.AddWithValue("@TipoEquipop", oTipoEquipo.TipoEquipop);
                command.Parameters.AddWithValue("@Observacionesp", oTipoEquipo.observaciones);
                command.Parameters.AddWithValue("@idUsuariop", idUser);

                ConexionDAO.getInstance().EjecutarSqlActualizacion(command);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static void EliminarTipoEquipo(int idTipoEquipo, string idUser)
        {
            string oMySql = "update tipo_equipo set estado = 0, idUsuario = '"+idUser+"' where idTipoEquipo = " + idTipoEquipo;

            try
            {
                ConexionDAO.getInstance().EjecutarConsultaDataTable(oMySql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        //Equipo Part
        public static DataTable getEquipo()
        {
            String oSql = " Select e.idEquipo, e.placa, e.serie, m.idMarca, m.marca, e.modelo, e.descripcion, " +
                "t.idTipoEquipo, t.tipoEquipo, e.costoEquipo, s.idEspacio, s.Espacio, c.numero_Identificacion, " +
                "c.nombre_Completo, d.idCondicion, d.condicion, e.observaciones, e.estado " +
                "FROM equipo e join tipo_equipo t on t.idTipoEquipo = e.idTipoEquipo " +
                "join marca_equipo m on m.idMarca = e.idMarca " +
                "join espacio s on e.idEspacio = s.idEspacio " +
                "join colaborador c on e.idEncargado = c.numero_Identificacion " +
                "join condicion_equipo d on e.idCondicion = d.idCondicion " +
                "where e.estado = 1";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {
                throw;
            }
        }

        public static DataTable getEquipo(string idEquipo)
        {
            String oSql = " Select e.idEquipo, e.placa, e.serie, m.idMarca, m.marca, e.modelo, e.descripcion, " +
                "t.idTipoEquipo, t.tipoEquipo, e.costoEquipo, s.idEspacio, s.Espacio, c.numero_Identificacion, " +
                "c.nombre_Completo, d.idCondicion, d.condicion, e.observaciones, e.estado " +
                "FROM equipo e join tipo_equipo t on t.idTipoEquipo = e.idTipoEquipo " +
                "join marca_equipo m on m.idMarca = e.idMarca " +
                "join espacio s on e.idEspacio = s.idEspacio " +
                "join colaborador c on e.idEncargado = c.numero_Identificacion " +
                "join condicion_equipo d on e.idCondicion = d.idCondicion " +
                "where e.estado = 1 and e.idEquipo like '" + idEquipo + "';";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {
                throw;
            }
        }
        public static void GuardarEquipo(Equipo oEquipo, string idUser)
        {
            try
            {
                MySqlCommand command = new MySqlCommand("sp_GuardarEquipo");
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@idEquipop", oEquipo.idEquipo);
                command.Parameters.AddWithValue("@placap", oEquipo.Placap);
                command.Parameters.AddWithValue("@seriep", oEquipo.Seriep);
                command.Parameters.AddWithValue("@idMarcap", oEquipo.Marcap);
                command.Parameters.AddWithValue("@Estadop", oEquipo.Estadop);
                command.Parameters.AddWithValue("@modelop", oEquipo.Modelop);
                command.Parameters.AddWithValue("@descripp", oEquipo.Descripp);
                command.Parameters.AddWithValue("@idTipoEquipop", oEquipo.TipoEquipop);
                command.Parameters.AddWithValue("@costop", oEquipo.Costop);
                command.Parameters.AddWithValue("@idEspaciop", oEquipo.Espaciop);
                command.Parameters.AddWithValue("@idEncargadop", oEquipo.Encargadop);
                command.Parameters.AddWithValue("@idCondicionp", oEquipo.Condicionp);
                command.Parameters.AddWithValue("@Observacionp", oEquipo.Observacionp);
                command.Parameters.AddWithValue("@idUsuariop", idUser);

                ConexionDAO.getInstance().EjecutarSqlActualizacion(command);
            }
            catch (Exception)
            {

                throw;
            }
        }


        public static DataTable getMarcaDDL()
        {
            string oSql = "select idMarca, marca from marca_equipo where estado = 1";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable getEspacioDDL()
        {
            string oSql = "select idEspacio, Espacio from espacio where estado = 1";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable getCondicionDDL()
        {
            string oSql = "select idCondicion, condicion from condicion_equipo where estado = 1";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static void EliminarEquipo(string idEquipo, string idUser)
        {
            string oMySql = "update equipo set estado = 0, idUsuario = '" + idUser + "' where idEquipo = '" + idEquipo + "';";

            try
            {
                ConexionDAO.getInstance().EjecutarConsultaDataTable(oMySql);
            }
            catch (Exception)
            {

                throw;
            }
        }


        //Espacio Part
        public static DataTable getEspacio()
        {
            String oSql = "Select e.idEspacio, e.Espacio, e.ubicacion, c.numero_Identificacion, c.nombre_Completo " +
                "from espacio e join colaborador c on e.idEncargado = c.numero_Identificacion " +
                "where e.estado = 1";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable getEspacio(int idEspacio)
        {
            String oSql = "Select e.idEspacio, e.Espacio, e.ubicacion, c.numero_Identificacion, c.nombre_Completo " +
                "from espacio e join colaborador c on e.idEncargado = c.numero_Identificacion " +
                "where e.estado = 1 and e.idEspacio = " + idEspacio + ";";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable getEncargadoDDL()
        {
            string oSql = "select numero_Identificacion, nombre_Completo from colaborador where estado = 1";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static DataTable getListTipoEquipo(int idEspacio)
        {
            string oSql = "select t.idTipoEquipo, t.tipoEquipo " +
                "FROM tipo_equipo t join tipoequipo_espacio e on t.idTipoEquipo = e.idTipoEquipo where e.idEspacio = " + idEspacio + " and e.estado = 1";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static DataTable getTipoEquipoDDL()
        {
            string oSql = "select idTipoEquipo, tipoEquipo from tipo_equipo where estado = 1";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static DataTable getEspacioTipoEquipoDetail(int idEspacio)
        {
            string oSql = "select t.idTipoEquipo, t.tipoEquipo, e.cantidad, e.observaciones from tipo_equipo t inner join tipoequipo_espacio e on t.idTipoEquipo = e.idTipoEquipo where e.estado = 1 and e.idEspacio = " + idEspacio;
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static void GuardarEspacio(Espacio oEspacio, List<TipoEquipoEspacio> oTipoEquipoEspacio, string idUser)
        {
            try
            {
                List<MySqlCommand> oCommand = new List<MySqlCommand>();

                MySqlCommand command = new MySqlCommand("sp_GuardarEspacio");
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@idEspaciop", oEspacio.idEspacio);
                command.Parameters.AddWithValue("@Espaciop", oEspacio.Espaciop);
                command.Parameters.AddWithValue("@Ubicacionp", oEspacio.Ubicacion);
                command.Parameters.AddWithValue("@idEncargadop", oEspacio.idEncargado);
                command.Parameters.AddWithValue("@idUsuariop", idUser);


                ConexionDAO.getInstance().EjecutarSqlActualizacion(command);

                if (oTipoEquipoEspacio.Count != 0)
                {
                    String id = ConexionDAO.getInstance().EjecutarSQLScalar("select max(idEspacio) from espacio;");

                    if (oEspacio.idEspacio == 0)
                    {
                        ConexionDAO.getInstance().EjecutarSqlActualizacion("delete from tipoequipo_espacio where idEspacio = " + id + ";");
                    }
                    else
                    {
                        ConexionDAO.getInstance().EjecutarSqlActualizacion("delete from tipoequipo_espacio where idEspacio = " + oEspacio.idEspacio + ";");
                    }
                    

                    foreach (TipoEquipoEspacio oTipoEqpEsp in oTipoEquipoEspacio)
                    {
                        MySqlCommand commandTP = new MySqlCommand("sp_GuardarTipoEquipoEspacio");
                        commandTP.CommandType = CommandType.StoredProcedure;

                        commandTP.Parameters.AddWithValue("@idTipoEquipop", oTipoEqpEsp.idTipoEquipo);
                        if (oEspacio.idEspacio == 0)
                        {
                            commandTP.Parameters.AddWithValue("@idEspaciop", id);
                        }
                        else
                        {
                            commandTP.Parameters.AddWithValue("@idEspaciop", oEspacio.idEspacio);
                        }
                        
                        commandTP.Parameters.AddWithValue("@cantidadp", oTipoEqpEsp.cantidad);
                        commandTP.Parameters.AddWithValue("@observacionesp", oTipoEqpEsp.observaciones);
                        commandTP.Parameters.AddWithValue("@idUsuariop", idUser);
                        oCommand.Add(commandTP);
                    }
                }
                ConexionDAO.getInstance().EjecutarSqlActualizacion(oCommand);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static void EliminarEspacio(int idEspacio, string idUser)
        {
            string oMySql = "update espacio set estado = 0, idUsuario = '" + idUser + "' where idEspacio = " + idEspacio;

            try
            {
                ConexionDAO.getInstance().EjecutarConsultaDataTable(oMySql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        //Institucion Part
        public static DataTable getInstitucion()
        {
            String oSql = "Select * from institucion where estado = 1";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static void GuardarInstitucion(Instituciones oInstitucion, string idUser)
        {
            try
            {
                MySqlCommand command = new MySqlCommand("sp_GuardarInstitucion");
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@idInstitucionp", oInstitucion.idInstitucion);
                command.Parameters.AddWithValue("@nombre_institucionp", oInstitucion.nombre_institucion);
                command.Parameters.AddWithValue("@Observacionesp", oInstitucion.observaciones);
                command.Parameters.AddWithValue("@idUsuariop", idUser);

                ConexionDAO.getInstance().EjecutarSqlActualizacion(command);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static void EliminarInstitucion(int idInstitucion, string idUser)
        {
            string oMySql = "update institucion set estado = 0, idUsuario = '" + idUser + "' where idInstitucion = " + idInstitucion;

            try
            {
                ConexionDAO.getInstance().EjecutarConsultaDataTable(oMySql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        //Marca Part
        public static DataTable getMarcaEquipo()
        {
            String oSql = "Select * from marca_equipo where estado = 1";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static void GuardarMarcaEquipo(MarcaEquipo oMarcaEquipo, string idUser)
        {
            try
            {
                MySqlCommand command = new MySqlCommand("sp_GuardarMarcaEquipo");
                command.CommandType = CommandType.StoredProcedure;
                
                command.Parameters.AddWithValue("@idMarcaEquipop", oMarcaEquipo.idMarcaEquipo);
                command.Parameters.AddWithValue("@MarcaEquipop", oMarcaEquipo.Marca);
                command.Parameters.AddWithValue("@Observacionesp", oMarcaEquipo.observaciones);
                command.Parameters.AddWithValue("@idUsuariop", idUser);

                ConexionDAO.getInstance().EjecutarSqlActualizacion(command);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static void EliminarMarcaEquipo(int idMarcaEquipo, string idUser)
        {
            string oMySql = "update marca_equipo set estado = 0, idUsuario = '" + idUser + "' where idMarca = " + idMarcaEquipo;

            try
            {
                ConexionDAO.getInstance().EjecutarConsultaDataTable(oMySql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        //Condicion Part
        public static DataTable getCondicion()
        {
            String oSql = "Select * from condicion_equipo where estado = 1";
            try
            {
                return ConexionDAO.getInstance().EjecutarConsultaDataTable(oSql);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static void GuardarCondicion(Condicion oCondicion, string idUser)
        {
            try
            {
                MySqlCommand command = new MySqlCommand("sp_GuardarCondicion");
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@idCondicionp", oCondicion.idCondicion);
                command.Parameters.AddWithValue("@Condicionp", oCondicion.Condicionp);
                command.Parameters.AddWithValue("@Observacionesp", oCondicion.observaciones);
                command.Parameters.AddWithValue("@idUsuariop", idUser);

                ConexionDAO.getInstance().EjecutarSqlActualizacion(command);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static void EliminarCondicion(int idCondicion, string idUser)
        {
            string oMySql = "update condicion_equipo set estado = 0,idUsuario = '"+ idUser +"' where idCondicion = " + idCondicion;

            try
            {
                ConexionDAO.getInstance().EjecutarConsultaDataTable(oMySql);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
