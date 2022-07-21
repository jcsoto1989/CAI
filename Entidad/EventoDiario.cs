using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidad
{
    public class EventoDiario
    {
        public int idEventoDiario { set; get; }
        public int idEvento { set; get; }
        public DateTime fechaEventoDiario { set; get; }
        public DateTime horaInicio { set; get; }
        public DateTime horaFinal { set; get; }
        public string idEncargado { set; get; }
        public string observaciones { set; get; }

        public List<AsistenciaParticipante> oLstAsistencia { set; get; }

        public EventoDiario()
        {
            idEventoDiario = 0;
            idEvento = 0;
            fechaEventoDiario = DateTime.Now;
            horaInicio = DateTime.Now;
            horaFinal = DateTime.Now;
            idEncargado = "";
            observaciones = "";
            oLstAsistencia = new List<AsistenciaParticipante>();
        }
    }
}
