using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Capa_Vista_Logistica
{
    public partial class MantenimientoNav : Form
    {
        //Metodo realizado Ammy Patricia Catun Lopez 0901-21-4857
        public MantenimientoNav()
        {
            InitializeComponent();
            string idUsuario = Interfac_V3.UsuarioSesion.GetIdUsuario();
            string[] alias = { "id_vehiculo", "numeroPlaca", "marca", "color", "descripcion", "horaLlegada", "horaSalida", "totalBultos", "pesoTotal", "id_chofer", "Estado" };
            navegador1.AsignarAlias(alias);
            navegador1.AsignarSalida(this);
            navegador1.AsignarColorFondo(Color.CadetBlue);
            navegador1.AsignarColorFuente(Color.Black);
            navegador1.AsignarTabla("tbl_vehiculos");
            navegador1.ObtenerIdAplicacion("9007");
           navegador1.ObtenerIdUsuario(idUsuario);
            navegador1.AsignarAyuda("1");
            navegador1.AsignarNombreForm("Mantenimiento de Vehiculos");

        }
    }
}
