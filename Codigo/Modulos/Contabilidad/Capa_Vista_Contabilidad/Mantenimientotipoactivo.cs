using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Capa_Vista_Contabilidad
{
    public partial class Mantenimientotipoactivo : Form
    {
        public Mantenimientotipoactivo()
        {
            InitializeComponent();

      //      string idusuario = Interfac_V3.UsuarioSesion.GetIdUsuario();
            string[] alias = { "pkid", "TipoActivo","Estado"};

            string idusuario = Interfac_V3.UsuarioSesion.GetIdUsuario();
            string[] alias = { "pkid", "TipoActivo", "Estado" };

            navegador1.AsignarAlias(alias);
            navegador1.AsignarSalida(this);
            navegador1.AsignarColorFondo(Color.LightBlue);
            navegador1.AsignarColorFuente(Color.BlueViolet);
            navegador1.ObtenerIdAplicacion("1000");
            navegador1.AsignarAyuda("1");

       //     navegador1.ObtenerIdUsuario(idusuario);
            navegador1.AsignarTabla("tbl_tipoactivo");

            navegador1.ObtenerIdUsuario(idusuario);
            navegador1.AsignarTabla("tbl_tipoactivofijo");

            navegador1.AsignarNombreForm("tipo activo");
        }
    }
}
