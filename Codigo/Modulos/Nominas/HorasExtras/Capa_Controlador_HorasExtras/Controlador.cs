using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Capa_Modelo_HorasExtras;

namespace Capa_Controlador_HorasExtras
{
    public class Controlador
    {
 
            //*******************************Kateryn De Leon***********************
        private readonly Sentencia sn = new Sentencia();

        public decimal ObtenerHorasExtras(string mes)
        {
            return sn.CalcularHorasExtras(mes);

        }
   

    }
    //************************************************************************************
}
