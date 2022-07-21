using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidad
{
    public class Tarea_Colaborador
    {
        public string idColaborador { set; get; }
        public string tarea { set; get; }

        public Tarea_Colaborador(string idColaboradorp, string tareap)
        {
            idColaborador = idColaboradorp;
            tarea = tareap;
        }

        public Tarea_Colaborador()
        {
            idColaborador = "";
            tarea = "";
        }

        public override string ToString()
        {
            return tarea;
        }
    }
}
