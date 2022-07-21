using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidad
{
    public class Equipo
    {
        public string idEquipo { set; get; }
        public string Placap { set; get; }
        public string Seriep { set; get; }
        public string Estadop { set; get; }
        public string Marcap { set; get; }
        public string Modelop { set; get; }
        public string Descripp { set; get; }
        public string TipoEquipop { set; get; }
        public string Costop { set; get; }
        public string Espaciop { set; get; }
        public string Encargadop { set; get; }
        public string Condicionp { set; get; }
        public string Observacionp { set; get; }
        public List<TipoEquipo> oTipoEquipo { set; get; }
        public Equipo()
        {
            idEquipo = "";
            Placap = "";
            Seriep = "";
            Estadop = "";
            Marcap = "";
            Modelop = "";
            Descripp = "";
            TipoEquipop = "";
            Costop = "";
            Espaciop = "";
            Encargadop = "";
            Condicionp = "";
            Observacionp = "";
            oTipoEquipo = new List<TipoEquipo>();
        }
    }
}
