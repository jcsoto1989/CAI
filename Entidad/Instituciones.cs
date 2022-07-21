using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidad
{
    public class Instituciones
    {
        public int idInstitucion { set; get; }
        public string nombre_institucion { set; get; }
        public string observaciones { set; get; }

        public Instituciones()
        {
            idInstitucion = 0;
            nombre_institucion = "";
            observaciones = "";
        }
    }
}
