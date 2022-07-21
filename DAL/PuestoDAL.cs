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
    public class PuestoDAL
    {
        public static void GuardarPuesto(Puesto oPuesto)
        {
            try
            {
                MySqlCommand command = new MySqlCommand("sp_GuardarPuesto");
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@idPuestop", oPuesto.idPuesto);
                command.Parameters.AddWithValue("@Puestop", oPuesto.puesto);
                command.Parameters.AddWithValue("@Observacionesp", oPuesto.observaciones);

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

        public static void EliminarPuesto(int idPuesto)
        {
            string oMySql = "update Puesto set estado = 0 where idPuesto = " + idPuesto;

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
