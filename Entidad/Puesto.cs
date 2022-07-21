using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidad
{
    public class Puesto
    {
        public int idPuesto { set; get; }
        public string puesto { set; get; }
        public string observaciones { set; get; }

        public Puesto()
        {
            idPuesto = 0;
            puesto = "";
            observaciones = "";
        }
    }
}
