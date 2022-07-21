using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidad
{
    public class SeguridadPermiso
    {
        public int idRol { set; get; }
        public int idPermiso { set; get; }
        public bool estado { set; get; }

        public SeguridadPermiso(int idRolp, int idPermisop, bool estadop)
        {
            idRol = idRolp;
            idPermiso = idPermisop;
            estado = estadop;
        }

        public SeguridadPermiso()
        {
            idRol = 0;
            idPermiso = 0;
            estado = false;
        }
    }
}
