using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidad
{
    public class Asistencia
    {
        public int idAsistencia { set; get; }
        public int idTipoID { set; get; }
        public string ID { set; get; }
        public int idEvento { set; get; }
        public int idPeriodo { set; get; }
        public DateTime fecha { set; get; }
        public string horaIngreso { set; get; }
        public string horaSalida { set; get; }
        public string numPC { set; get; }

        public Asistencia()
        {
            idAsistencia = 0;
            idTipoID = 0;
            ID = "";
            idEvento = 0;
            idPeriodo = 0;
            fecha = DateTime.Now;
            horaIngreso = DateTime.Now.ToShortTimeString();
            horaSalida = DateTime.Now.ToShortTimeString();
            numPC = "";
        }
    }
}
