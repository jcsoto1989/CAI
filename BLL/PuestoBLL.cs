using DAL;
using Entidad;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class PuestoBLL
    {
        public static void GuardarPuesto(Puesto oPuesto)
        {
            try
            {
                PuestoDAL.GuardarPuesto(oPuesto);
            }
            catch (Exception)
            {
                
                throw;
            }
        }

        public static DataTable obtenerPuestos()
        {
            try
            {
                return PuestoDAL.obtenerPuestos();
            }
            catch (Exception)
            {
                
                throw;
            }
        }

        public static void eliminarPuesto(int IdPuesto)
        {
            try
            {
                PuestoDAL.EliminarPuesto(IdPuesto);
            }
            catch (Exception)
            {
                
                throw;
            }
        }
    }
}
