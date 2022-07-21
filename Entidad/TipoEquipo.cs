using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Entidad;

namespace Entidad
{
    public class TipoEquipo
    {
        public int idTipoEquipo {set;get;}
        public string TipoEquipop { set; get; }
        public string observaciones { set; get; }

        public TipoEquipo()
        {
            idTipoEquipo = 0;
            TipoEquipop = "";
            observaciones = "";
        }

    }
}
