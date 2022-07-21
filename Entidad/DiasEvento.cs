using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidad
{
    public class DiasEvento
    {
        public int idEvento { set; get; }
        public int idDia { set; get; }
        public bool estado { set; get; }

        public DiasEvento()
        {
            idEvento = 0;
            idDia = 0;
            estado = false;
        }

    }
}
