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
    public class TipoEquipoBLL
    {
        public static DataTable getTipoEquipo()
        {
            try
            {
                return TipoEquipoDAL.getTipoEquipo();
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
                TipoEquipoDAL.GuardarTipoEquipo(oTipoEquipo);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static void eliminarTipoEquipo(int IdTipoEquipo)
        {
            try
            {
                TipoEquipoDAL.EliminarTipoEquipo(IdTipoEquipo);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable getespacio()
        {
            try
            {
                return TipoEquipoDAL.getEspacio();
            }
            catch (Exception)
            {
                
                throw;
            }
        }
    }
}
