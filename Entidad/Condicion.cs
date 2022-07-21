﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidad
{
    public class Condicion
    {
        public int idCondicion { set; get; }
        public string Condicionp { set; get; }
        public string observaciones { set; get; }

        public Condicion()
        {
            idCondicion = 0;
            Condicionp = "";
            observaciones = "";
        }
    }
}