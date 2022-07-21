using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidad
{
    public class Persona
    {
        public int tipoIdPersona { set; get; }
        public string idPersona { set; get; }
        public string nombre_Completo { set; get; }
        public string celular { set; get; }
        public string telefono { set; get; }
        public string email { set; get; }
        public string estadoCivil { set; get; }
        public string fechaNacimiento { set; get; }
        public string direccion { set; get; }
        public string sexo { set; get; }
        public int pais { set; get; }
        public string ContactoEmergencia { set; get; }
        public string telContacto { set; get; }
        public int estado { set; get; }
        public string observaciones {set;get;}

        public Persona()
        {
            tipoIdPersona = 0;
            idPersona = "";
            nombre_Completo = "";
            celular = "";
            telefono = "";
            email = "";
            estadoCivil = "";
            fechaNacimiento = "";
            direccion = "";
            sexo = "";
            pais = 0;
            ContactoEmergencia = "";
            telContacto = "";
            estado = 1;
            observaciones = "";
        }
    }
}
