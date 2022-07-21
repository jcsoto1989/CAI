using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidad
{
    public class Espacio
    {
        public int idEspacio { set; get; }
        public string Espaciop { set; get; }
        public string Ubicacion { set; get; }
        public string idEncargado { set; get; }

        public Espacio()
        {
            idEspacio = 0;
            Espaciop = "";
            Ubicacion = "";
            idEncargado = "";
        }

        public Espacio(int idEspaciop,string Espaciopp,string Ubicacionp,string idEncargadop)
        {
            idEspacio = idEspaciop;
            Espaciop = Espaciopp;
            Ubicacion = Ubicacionp;
            idEncargado = idEncargadop;
        }
    }
}
