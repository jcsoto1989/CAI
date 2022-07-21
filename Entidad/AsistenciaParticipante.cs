using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidad
{
    public class AsistenciaParticipante
    {
        public int idEventoDiario { set; get; }
        public string numeroIdentificacion { set; get; }
        public bool Asistencia { set; get; }

        public AsistenciaParticipante()
        {
            idEventoDiario = 0;
            numeroIdentificacion = "";
            Asistencia = false;
        }

        public AsistenciaParticipante(int idEventoDiariop, string numeroIdentificacionp, bool estadop)
        {
            idEventoDiario = idEventoDiariop;
            numeroIdentificacion = numeroIdentificacionp;
            Asistencia = estadop;
        }
    }
}
