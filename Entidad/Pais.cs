using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidad
{
    public class Pais
    {
        public int idPais { set; get; }
        public string iso { set; get; }
        public string pais { set; get; }

        public Pais()
        {
            idPais = 0;
            iso = "";
            pais = "";
        }
    }
}
