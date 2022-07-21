using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidad
{
    public class periodo
    {
        public int idPeriodo { set; get; }
        public string periodo_descripcion { set; get; }
        public string observaciones { set; get; }
        public bool estado { set; get; }

        public periodo()
        {
            idPeriodo = 0;
            periodo_descripcion = "";
            observaciones = "";
            estado = true;
        }
    }
    public class tipo_evento
    {
        public int idTipoEvento { set; get; }
        public string tipoEvento_descripcion { set; get; }
        public string observaciones { set; get; }

        public bool estado { set; get; }

        public tipo_evento()
        {
            idTipoEvento = 0;
            tipoEvento_descripcion = "";
            observaciones = "";
            estado = true;
        }
    }

    public class ocupacion
    {
        public int idOcupacion { set; get; }
        public string descripcion_Ocupacion { set; get; }
        public string observaciones_Ocupacion { set; get; }
        public ocupacion()
        {
            idOcupacion = 0;
            descripcion_Ocupacion = "";
            observaciones_Ocupacion = "";
        }
    }
    public class tipo_persona
    {
        public int idTipoPersona { set; get; }
        public string descripcion { set; get; }
        public string observaciones { set; get; }
        public tipo_persona()
        {
            idTipoPersona = 0;
            descripcion = "";
            observaciones = "";
        }
    }
    public class evento
    {
        public int idEvento { set; get; }
        public string nombre_Evento { set; get; }
        public int idTipoEvento { set; get; }
        public bool estado { set; get; }

        public int idInstitucion { set; get; }
        public string observaciones { set; get; }
        
        public evento()
        {
            idEvento = 0;
            nombre_Evento = "";
            idTipoEvento = 0;
            estado = true;
            idInstitucion = 0;
            observaciones = "";
        }
    }
    public class evento_diario
    {
        public int idEventoDiario { set; get; }
        public int idEvento { set; get; }
        public DateTime fecha_EventoDiario { set; get; }
        public DateTime hora_inicio { set; get; }
        public DateTime hora_final { set; get; }
        public string idEncargado { set; get; }
        public string observaciones_EventoDiario { set; get; }
        public evento_diario()
        {
            idEventoDiario = 0;
            idEvento = 0;
            fecha_EventoDiario = DateTime.Now;
            hora_inicio = DateTime.Now;
            hora_final = DateTime.Now;
            idEncargado = "";
            observaciones_EventoDiario = "";
        }
    }

}
