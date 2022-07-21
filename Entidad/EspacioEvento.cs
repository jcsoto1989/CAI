using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidad
{
    public class EspacioEvento
    {

        public int idEvento { set; get; }
        public int idPeriodo { set;get;}
        public int idTipoIdpersona { set; get; }
        public int idEspacio { set; get; }
        public string fecha { set; get; }
        public string horaInicio { set; get; }
        public string horaFinal { set; get; }
        public string idEncargado { set; get; }
        public bool ControlPC { set; get; }

        public EspacioEvento()
        {
            idEvento = 0;
            idPeriodo = 0;
            idTipoIdpersona = 0;
            idEspacio = 0;
            fecha = "";
            horaInicio = "";
            horaFinal = "";
            idEncargado = "";
            ControlPC = true;
        }
    }
}
