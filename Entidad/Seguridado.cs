using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidad
{
    public class SeguridadUsuario
    {
        public string numero_Identificacion { set; get; }
        public string nombre_Completo { set; get; }
        public string usuario { set; get; }
        public string contrasenna { set; get; }
        public int idRol_Usuario { set; get; }

        public SeguridadUsuario()
        {
            numero_Identificacion = "";
            nombre_Completo = "";
            usuario = "";
            contrasenna = "";
            idRol_Usuario = 0;
        }
    }
    public class SeguridadRol
    {
        public int idRol { set; get; }
        public string rol { set; get; }
        public string descripcion { set; get; }

        public SeguridadRol()
        {
            idRol = 0;
            rol = "";
            descripcion = "";
            
        }
    }
}
