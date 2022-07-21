using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL;
using Entidad;

namespace BLL
{
    public class iacBLL
    {

        public static DataTable CancelarIac()
        {
            try
            {
                return iacDAL.CancelarIac();
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static DataTable CancelarIns()
        {
            try
            {
                return iacDAL.CancelarIns();
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static DataTable CancelarCol(String numero)
        {
            try
            {
                return iacDAL.CancelarCol(numero);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable getCountries()
        {
            try
            {
                return iacDAL.getCountries();
            }
            catch (Exception)
            {
                throw;
            }
        }
        public static DataTable getnombre()
        {
            try
            {
                return iacDAL.getnombre();
            }
            catch (Exception)
            {
                throw;
            }
        }
        public static DataTable getDatosIac()
        {
            try
            {
                return iacDAL.getDatosIac();
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static DataTable getDatosIns()
        {
            try
            {
                return iacDAL.getDatosIns();
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static DataTable getColabor()
        {
            try
            {
                return iacDAL.getColabor();
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable getColabor(string id)
        {
            try
            {
                return iacDAL.getColabor(id);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static void GuardarIac(Iac oIac, string idUser)
        {
            try
            {
                iacDAL.GuardarIac(oIac,idUser);
            }
            catch (Exception)
            {
                throw;
            }
        }
        public static void GuardarIacIns(Iac_ins oIac, string idUser)
        {
            try
            {
                iacDAL.GuardarIacIns(oIac,idUser);
            }
            catch (Exception)
            {
                throw;
            }
        }
        public static void GuardarIacCol(Iac_col oIac, string idUser)
        {
            try
            {
                iacDAL.GuardarIacCol(oIac,idUser);
            }
            catch (Exception)
            {
                throw;
            }
        }

        public static void GuardarTareaCol(string idColaborador, string tarea, int idTarea, string idUser)
        {
            try
            {
                iacDAL.GuardarTareaCol(idColaborador, tarea, idTarea,idUser);
            }
            catch (Exception)
            {
                
                throw;
            }
        }

        public static void GuardarArchivoCol(string idColaborador, string rutaArchivo, int idArchivo, string idUser)
        {
            try
            {
                iacDAL.GuardarArchivoCol(idColaborador, rutaArchivo, idArchivo, idUser);
            }
            catch (Exception)
            {

                throw;
            }
        }


        public static void eliminarCol(String numero, string idUsuario)
        {
            try
            {
                iacDAL.EliminarCol(numero,idUsuario);
            }
            catch (Exception)
            {
                throw;
            }
        }

        public static DataTable obtenerTareas(string idColaborador)
        {
            try
            {
                return iacDAL.obtenerTareas(idColaborador);
            }
            catch (Exception)
            {
                
                throw;
            }
        }

        public static DataTable obtenerArchivos(string idColaborador)
        {
            try
            {
                return iacDAL.obtenerArchivos(idColaborador);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static void DeleteFiles(string idColobarador)
        {
            try
            {
                iacDAL.DeleteFiles(idColobarador);
            }
            catch (Exception)
            {
                
                throw;
            }
        }
    }
}
