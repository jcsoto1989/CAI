using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidad
{
    public class DiaSemana
    {
        public string dia { set; get; }
        public int numDia { set; get; }

        public DiaSemana()
        {
            dia = "";
            numDia = 0;
        }

        public DiaSemana(string Diap, int numDiap)
        {
            dia = Diap;
            numDia = numDiap;
        }

    }
}
