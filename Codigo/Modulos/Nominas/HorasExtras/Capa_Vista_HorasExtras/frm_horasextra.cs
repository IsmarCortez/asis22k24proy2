using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

using Capa_Controlador_HorasExtras;

namespace Capa_Vista_HorasExtras
{
    public partial class frm_horasextra : Form

    {

        private readonly Controlador controlador = new Controlador();
        //*******************************Kateryn De Leon************************************************
        public frm_horasextra()
        {
            InitializeComponent();
            CargarMeses();

            Cbo_mes.SelectedIndex = -1;  // Inicia sin ninguna selección para evitar disparos innecesarios
       
        }

        private void label2_Click(object sender, EventArgs e)
        {

        }
        // Método para llenar el ComboBox con los meses del año
        private void CargarMeses()
        {
            // Lista de meses 
            string[] meses = { "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre" };

            // Agregar los meses al ComboBox
            Cbo_mes.Items.AddRange(meses);

            // Seleccionar el primer mes como predeterminado
            Cbo_mes.SelectedIndex = 0;
        }
        private void Cbo_mes_SelectedIndexChanged(object sender, EventArgs e)
        {
          

            if (Cbo_mes.SelectedIndex != -1)
            {
                string mesSeleccionado = Cbo_mes.SelectedItem.ToString();
                decimal totalHorasExtras = controlador.ObtenerHorasExtras(mesSeleccionado);

                // Establece el formato en quetzales "Q"
                CultureInfo Quetzal = new CultureInfo("es-GT");


                Txt_calculohoras.Text = totalHorasExtras.ToString("C2", Quetzal); // Formato de moneda Quetzal
            }
         }
        //************************************************************************************
        private void Btn_generacionhorasextras_Click(object sender, EventArgs e)
        {

        }
    }
}
