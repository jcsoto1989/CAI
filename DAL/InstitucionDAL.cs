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
    public class InstitucionDAL
    {
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
        public static void GuardarInstitucion(Instituciones oInstitucion)
        {
            try
            {
                MySqlCommand command = new MySqlCommand("sp_GuardarInstitucion");
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@idInstitucionp", oInstitucion.idInstitucion);
                command.Parameters.AddWithValue("@nombre_institucionp", oInstitucion.nombre_institucion);
                command.Parameters.AddWithValue("@Observacionesp", oInstitucion.observaciones);

                ConexionDAO.getInstance().EjecutarSqlActualizacion(command);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static void EliminarInstitucion(int idInstitucion)
        {
            string oMySql = "update institucion set estado = 0 where idInstitucion = " + idInstitucion;

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
