using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidad
{
    public class Iac
    {
        public int idIAC { set; get; }
        public string nombre { set; get; }
        public string direccion { set; get; }
        public string email { set; get; }
        public string telefono1 { set; get; }
        public string ext1 { set; get; }
        public string telefono2 { set; get; }
        public string ext2 { set; get; }
        public string telefono3 { set; get; }
        public string ext3 { set; get; }
        public string rutaLogo { set; get; }

        public Iac()
        {
            idIAC = 0;
            nombre = "";
            direccion = "";
            email = "";
            telefono1 = "";
            ext1 = "";
            telefono2 = "";
            ext2 = "";
            telefono3 = "";
            ext3 = "";
            rutaLogo = "";
        }
    }
    public class Iac_ins
    {
        public int codigo_institucion { set; get; }
        public string nombre_Institucion { set; get; }
        public string nombre_Departamento { set; get; }
        public int idpais { set; get; }
        public string telefono_Institucion { set; get; }
        public string direccion { set; get; }
        public string idRepresentante { set; get; }
        public string rutaLogo_Institucion { set; get; }
        public string rutaLogo_departamento { set; get; }

        public Iac_ins()
        {
            codigo_institucion = 0;
            nombre_Institucion = "";
            nombre_Departamento = "";
            idpais = 0;
            telefono_Institucion = "";
            direccion = "";
            idRepresentante = "";
            rutaLogo_Institucion = "";
            rutaLogo_departamento = "";
        }
    }
    public class Iac_col
    {
        public string numero_Identificacion { set; get; }
        public string nombre_Completo { set; get; }
        public int idPuesto { set; get; }
        public string email { set; get; }
        public string tel_Oficina { set; get; }
        public string ext_Oficina { set; get; }
        public string celular { set; get; }
        public string sexo { set; get; }
        public string Ruta_Foto { set; get; }
        public bool estado { set; get; }
        public DateTime fecha_Nacimiento { set; get; }
        public DateTime fecha_Ingreso_IAC { set; get; }

        public Iac_col()
        {
            numero_Identificacion = "";
            nombre_Completo = "";
            idPuesto = 0;
            email = "";
            tel_Oficina = "";
            ext_Oficina = "";
            celular = "";
            sexo = "";
            Ruta_Foto = "";
            estado = true;
            fecha_Ingreso_IAC = DateTime.Now;
            fecha_Nacimiento = DateTime.Now;
        }
    }
}
