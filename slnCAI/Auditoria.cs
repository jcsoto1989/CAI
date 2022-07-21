using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace slnCAI
{
    public class Auditoria
    {
        public string Usuario { set; get; }
        public string Pagina { set; get; }
        public string Tab { set; get; }
        public string Movimiento { set; get; }
        public DateTime fecha { set; get; }
        public string valorOriginal { set; get; }
        public string valorNuevo { set; get; }

        public Auditoria()
        {
            Usuario = "";
            Pagina = "";
            Tab = "";
            Movimiento = "";
            fecha = DateTime.Now;
            valorOriginal = "";
            valorNuevo = "";
        }

        public Auditoria(string usuariop, string paginap, string tabp, string movimientop, DateTime fechap, string valorOriginalp, string valorNuevop)
        {
            Usuario = usuariop;
            Pagina = paginap;
            Tab = tabp;
            Movimiento = movimientop;
            fecha = fechap;
            valorOriginal = valorOriginalp;
            valorNuevo = valorNuevop;
        }
    }
}