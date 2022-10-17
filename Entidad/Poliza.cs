using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidad
{
    public class Poliza
    {
        public int idPoliza { set; get; }
        public int idPersona { set; get; }
        public string numeroPoliza { set; get; }
        public string fechaPago { set; get; }
        public int estado { set; get; }
        public Poliza()
        {
            idPoliza = 0;
            idPersona = 0;
            numeroPoliza = "";
            fechaPago = "";
            numeroPoliza = "";
            estado = 1;
        }
    }
}
