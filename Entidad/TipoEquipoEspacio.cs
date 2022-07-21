using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Entidad;

namespace Entidad
{
    public class TipoEquipoEspacio
    {
        public int idTipoEquipo {set;get;}
        public string descripcion { set; get; }
        public int idEspacio { set; get; }
        public int cantidad { set; get; }
        public string observaciones { set; get; }

        public TipoEquipoEspacio()
        {
            idTipoEquipo = 0;
            descripcion = "";
            idEspacio = 0;
            cantidad = 0;
            observaciones = "";
        }

        public override string ToString()
        {
            return cantidad + " - " + descripcion;
        }
    }
}
