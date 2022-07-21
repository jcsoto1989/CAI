using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidad
{
    public class Participant
    {
        public int idEvento { set; get; }
        public int idTipoPersona { set; get; }
        public string numero_identificacion { set; get; }

        public Participant()
        {
            idEvento = 0;
            idTipoPersona = 0;
            numero_identificacion = "";
        }
    }
}
