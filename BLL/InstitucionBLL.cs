using System;
using Entidad;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using DAL;

namespace BLL
{
    public class InstitucionBLL
    {
        public static DataTable getInstitucion()
        {
            try
            {
                return InstitucionDAL.getInstitucion();
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
                InstitucionDAL.GuardarInstitucion(oInstitucion);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static void eliminarInstitucion(int IdInstitucion)
        {
            try
            {
                InstitucionDAL.EliminarInstitucion(IdInstitucion);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
