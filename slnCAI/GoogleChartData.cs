using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace slnCAI
{
    public partial class GoogleChartData
    {
        public int SLID { get; set; }
        public string Espacio { get; set; }
        public int Cantidad { get; set; }

        public GoogleChartData(string espaciop, int cantidadp)
        {
            Espacio = espaciop;
            Cantidad = cantidadp;
        }
    }
}
