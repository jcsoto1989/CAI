﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidad
{
    public class MarcaEquipo
    {
        public int idMarcaEquipo { set; get; }
        public string Marca { set; get; }
        public string observaciones { set; get; }

        public MarcaEquipo()
        {
            idMarcaEquipo = 0;
            Marca = "";
            observaciones = "";
        }
    }
}