using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Capa_Vista_Banco
{
    public partial class frm_nav_movimientosBancarios : Form
    {
        public frm_nav_movimientosBancarios()
        {
            InitializeComponent();
            string idUsuario = Interfac_V3.UsuarioSesion.GetIdUsuario();
            string[] alias = { "ID", "Cuenta No.", "Fecha", "Tipo Movimiento", "Monto", "Descripción", "Metodo Pago", "Estado" };
            navegador1.AsignarAlias(alias);
            navegador1.AsignarSalida(this);
            navegador1.AsignarColorFondo(Color.CadetBlue);
            navegador1.AsignarColorFuente(Color.Black);
            navegador1.AsignarTabla("tbl_movimientobancario");
            navegador1.ObtenerIdAplicacion("7000");
            navegador1.ObtenerIdUsuario(idUsuario);
            navegador1.AsignarAyuda("1");
            navegador1.AsignarNombreForm("MOVIMIENTO BANCARIO");
        }

        private void frm_nav_movimientosBancarios_Load(object sender, EventArgs e)
        {

        }
    }
}
