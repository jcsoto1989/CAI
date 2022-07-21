using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidad
{
    public class Matricula
    {
        public int idTipoIdentificacion { set; get; }
        public string idPersona { set; get; }
        public int idEvento { set; get; }
        public int idPeriodo { set; get; }
        public string banco { set; get; }
        public double monto { set; get; }
        public string numComprobante { set; get; }
        public string fechaComprobante { set; get; }
        public string poliza { set; get; }
        public string fechaPoliza { set; get; }
        public string observaciones { set; get; }
        public string situacionEspecial { set; get; }
        public bool estado { set; get; }

        public Matricula()
        {
            idTipoIdentificacion = 0;
            idPersona = "";
            idEvento = 0;
            idPeriodo = 0;
            banco = "";
            monto = 0;
            numComprobante = "";
            fechaComprobante = "01/01/0001";
            poliza = "";
            fechaPoliza = "01/01/0001";
            observaciones = "";
            situacionEspecial = "";
            estado = true;

        }
    }
}
