using DAO;
using System;
using Entidad;
using System.Collections.Generic;
using System.Data;
using MySql.Data.MySqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public class TipoEquipoDAL
    {
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
        public static void GuardarTipoEquipo(TipoEquipo oTipoEquipo)
        {
            try
            {
                MySqlCommand command = new MySqlCommand("sp_GuardarTipoEquipo");
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@idTipoEquipop", oTipoEquipo.idTipoEquipo);
                command.Parameters.AddWithValue("@TipoEquipop", oTipoEquipo.TipoEquipop);
                command.Parameters.AddWithValue("@Observacionesp", oTipoEquipo.observaciones);

                ConexionDAO.getInstance().EjecutarSqlActualizacion(command);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static void EliminarTipoEquipo(int idTipoEquipo)
        {
            string oMySql = "update tipo_equipo set estado = 0 where idTipoEquipo = " + idTipoEquipo;

            try
            {
                ConexionDAO.getInstance().EjecutarConsultaDataTable(oMySql);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable getEspacio()
        {
            String oSql = "Select * from Espacio where estado = 1";
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
