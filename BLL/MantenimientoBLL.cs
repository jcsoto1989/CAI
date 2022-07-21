using System;
using Entidad;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL;

namespace BLL
{
    public class MantenimientoBLL
    {
        // Puesto Part
        public static void GuardarPuesto(Puesto oPuesto, string idUser)
        {
            try
            {

                MantenimientoDAL.GuardarPuesto(oPuesto,idUser);
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
                return MantenimientoDAL.obtenerPuestos();
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static void eliminarPuesto(int IdPuesto, string idUser)
        {
            try
            {
                MantenimientoDAL.EliminarPuesto(IdPuesto, idUser);
            }
            catch (Exception)
            {

                throw;
            }
        }

        //Tipo Equipo Part
        public static DataTable getTipoEquipo()
        {
            try
            {
                return MantenimientoDAL.getTipoEquipo();
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
                MantenimientoDAL.GuardarTipoEquipo(oTipoEquipo, idUser);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static void eliminarTipoEquipo(int IdTipoEquipo, string idUser)
        {
            try
            {
                MantenimientoDAL.EliminarTipoEquipo(IdTipoEquipo, idUser);
            }
            catch (Exception)
            {

                throw;
            }
        }


        //Equipo Part
        public static DataTable getEquipo()
        {
            try
            {
                return MantenimientoDAL.getEquipo();
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static DataTable getEquipo(String idEquipo)
        {
            try
            {
                return MantenimientoDAL.getEquipo(idEquipo);
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
                MantenimientoDAL.GuardarEquipo(oEquipo, idUser);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static void eliminarEquipo(string idEquipo, string idUser)
        {
            try
            {
                MantenimientoDAL.EliminarEquipo(idEquipo, idUser);
            }
            catch (Exception)
            {

                throw;
            }
        }


        public static DataTable getMarcaDDL()
        {
            try
            {
                return MantenimientoDAL.getMarcaDDL();
            }
            catch (Exception)
            {
                throw;
            }
        }
        public static DataTable getEspacioDDL()
        {
            try
            {
                return MantenimientoDAL.getEspacioDDL();
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static DataTable getCondicionDDL()
        {
            try
            {
                return MantenimientoDAL.getCondicionDDL();
            }
            catch (Exception)
            {

                throw;
            }
        }

        //Espacio Part
        public static DataTable getEspacio()
        {
            try
            {
                return MantenimientoDAL.getEspacio();
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable getEspacio(string idEspacio)
        {
            try
            {
                return MantenimientoDAL.getEspacio(Convert.ToInt32(idEspacio));
            }
            catch (Exception)
            {
                
                throw;
            }
        }

        public static DataTable getEspaciosTipoEquipo()
        {
            try
            {
                return MantenimientoDAL.getEspacio();
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable getEncargadoDDL()
        {
            try
            {
                return MantenimientoDAL.getEncargadoDDL();
            }
            catch (Exception)
            {
                throw;
            }
        }
        public static DataTable getListTipoEquipo(int idEspacio)
        {
            try
            {
                return MantenimientoDAL.getListTipoEquipo(idEspacio);
            }
            catch (Exception)
            {
                throw;
            }
        }
        public static DataTable getTipoEquipoDDL()
        {
            try
            {
                return MantenimientoDAL.getTipoEquipoDDL();
            }
            catch (Exception)
            {
                throw;
            }
        }
        public static DataTable getEspacioTipoEquipoDetail(int idEspacio)
        {
            try
            {
                return MantenimientoDAL.getEspacioTipoEquipoDetail(idEspacio);
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
                MantenimientoDAL.GuardarEspacio(oEspacio, oTipoEquipoEspacio, idUser);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static void eliminarEspacio(int IdEspacio, string idUser)
        {
            try
            {
                MantenimientoDAL.EliminarEspacio(IdEspacio, idUser);
            }
            catch (Exception)
            {

                throw;
            }
        }
       

        //Institucion Part
        public static DataTable getInstitucion()
        {
            try
            {
                return MantenimientoDAL.getInstitucion();
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
                MantenimientoDAL.GuardarInstitucion(oInstitucion, idUser);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static void eliminarInstitucion(int IdInstitucion, string idUser)
        {
            try
            {
                MantenimientoDAL.EliminarInstitucion(IdInstitucion, idUser);
            }
            catch (Exception)
            {

                throw;
            }
        }

        //Marca Part
        public static DataTable getMarca()
        {
            try
            {
                return MantenimientoDAL.getMarcaEquipo();
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static void GuardarMarcaEquipo(MarcaEquipo oMarca, string idUser)
        {
            try
            {
                MantenimientoDAL.GuardarMarcaEquipo(oMarca, idUser);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static void eliminarMarcaEquipo(int IdMarcaEquipo, string idUser)
        {
            try
            {
                MantenimientoDAL.EliminarMarcaEquipo(IdMarcaEquipo, idUser);
            }
            catch (Exception)
            {

                throw;
            }
        }

        //Condicion Equipo Part
        public static DataTable getCondicion()
        {
            try
            {
                return MantenimientoDAL.getCondicion();
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
                MantenimientoDAL.GuardarCondicion(oCondicion, idUser);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static void eliminarCondicion(int IdCondicion, string idUser)
        {
            try
            {
                MantenimientoDAL.EliminarCondicion(IdCondicion, idUser);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
