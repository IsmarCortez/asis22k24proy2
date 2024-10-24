using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Capa_Vista_Nominas
{
    public partial class frm_genanticipo : Form
    {
        private static frm_genanticipo instancia = null;
        public static frm_genanticipo ventana_unica()
        {
            if (instancia == null || instancia.IsDisposed)
            {
                instancia = new frm_genanticipo();
            }
            return instancia;
        }

        public frm_genanticipo()
        {
            InitializeComponent();

            string idUsuario = Interfac_V3.UsuarioSesion.GetIdUsuario();

            string[] alias = { "pk_registro_anticipos", "Cantidad", "Descripción", "Mes", "fk_clave_empleado", "Estado" };

            navegador1.AsignarAlias(alias);
            navegador1.AsignarSalida(this);
            navegador1.AsignarColorFondo(Color.LightGray);
            navegador1.AsignarColorFuente(Color.Black);
            navegador1.AsignarTabla("tbl_control_anticipos");
            navegador1.ObtenerIdAplicacion("1000");
            navegador1.ObtenerIdUsuario(idUsuario);
            navegador1.AsignarAyuda("1");
            navegador1.AsignarNombreForm("Anticipos");


            navegador1.AsignarComboConTabla("tbl_empleados", "pk_clave", "nombre", 1);
        }

        private void navegador1_Load(object sender, EventArgs e)
        {

        }

        private void frm_genanticipo_Load(object sender, EventArgs e)
        {

        }
    }
}
