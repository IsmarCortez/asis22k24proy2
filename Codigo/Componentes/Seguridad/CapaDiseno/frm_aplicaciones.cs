using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using CapaLogica;
using System.Data.Odbc;

using System.IO; // Necesario para Directory, File, Path y SearchOption
using System.Windows.Forms; // Necesario para MessageBox y Help

namespace CapaDiseno
{

    public partial class frm_aplicaciones : Form
    {

        logica logic;

        //###################  lo que hizo Karla  Sofia Gómez Tobar #######################
        public frm_aplicaciones(string idUsuario)
        {
            InitializeComponent();
            btn_cancel.Enabled = false;
            btn_ingresar.Enabled = false;
            btn_actualizar.Enabled = false;
            btn_modif.Enabled = false;
            btn_eliminar.Enabled = false;
            logic = new logica(idUsuario);
            txt_idaplicacion.Enabled = false;
            txt_nombre.Enabled = false;
            txt_descripcion.Enabled = false;
            Gpb_estado.Enabled = false;
        }
        //###################  termina lo que hizo  Karla  Sofia Gómez Tobar #######################
        public frm_aplicaciones()
        {
        }

        //###################  lo que hizo Karla  Sofia Gómez Tobar #######################
        void limpiar()
        {
            txt_idaplicacion.Text = "";
            txt_nombre.Text = "";
            txt_descripcion.Text = "";
            txt_buscar.Text = "";
            Rdb_activo.Checked = false;
            Rdb_inactivo.Checked = false;
            txt_idaplicacion.Focus();
        }

        //###################  termina lo que hizo  Karla  Sofia Gómez Tobar #######################
        private void GroupBox2_Enter(object sender, EventArgs e)
        {

        }

        private void Frm_aplicaciones_Load(object sender, EventArgs e)
        {

        }


        private void Btn_salir_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void GroupBox1_Enter(object sender, EventArgs e)
        {

        }

        //###################  lo que hizo Karla  Sofia Gómez Tobar #######################
        private void btn_salir_Click_1(object sender, EventArgs e)
        {
            limpiar();
            this.Close();
        }
        //###################  termina lo que hizo  Karla  Sofia Gómez Tobar ######################


        //###################  lo que hizo Karla  Sofia Gómez Tobar #######################
        private void btn_bsucarap_Click(object sender, EventArgs e)
        {
            string aplicacion = txt_buscar.Text;

            if (string.IsNullOrWhiteSpace(aplicacion))
            {
                MessageBox.Show("Por favor, ingrese un ID de una aplicacion.");
                return;
            }

            try
            {
                DataTable dtAplicacion = logic.consultaLogicaAplicaciones(aplicacion);

                if (dtAplicacion == null || dtAplicacion.Rows.Count == 0)
                {
                    MessageBox.Show("No se encontraro la aplicacion.");
                    return;
                }

                foreach (DataRow row in dtAplicacion.Rows)
                {
                    if (row[0] != DBNull.Value) txt_idaplicacion.Text = row[0].ToString();
                    if (row[1] != DBNull.Value) txt_nombre.Text = row[1].ToString();
                    if (row[2] != DBNull.Value) txt_descripcion.Text = row[2].ToString();
                    if (row[3] != DBNull.Value)
                    {
                        string estado = row[3].ToString();
                        if (estado == "1")
                        {
                            Rdb_activo.Checked = true;
                            Rdb_inactivo.Checked = false;
                        }
                        else if (estado == "0")
                        {
                            Rdb_activo.Checked = false;
                            Rdb_inactivo.Checked = true;
                        }
                    }
                }

                btn_modif.Enabled = true;
                btn_ingresar.Enabled = false;
                txt_idaplicacion.Enabled = false;
                txt_nombre.Enabled = false;
                txt_descripcion.Enabled = false;
                Rdb_activo.Enabled = false;
                Rdb_inactivo.Enabled = false;
                btn_eliminar.Enabled = true;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
                Console.WriteLine(ex);
            }
        }

        //###################  lo que hizo Karla  Sofia Gómez Tobar #######################
        private void btn_nuevo_Click_1(object sender, EventArgs e)
        {
            Rdb_activo.Checked = true;
            Gpb_estado.Enabled = true;
            btn_nuevo.Enabled = false;
            btn_actualizar.Enabled = false;
            gb_buscar.Enabled = false;
            btn_modif.Enabled = false;
            btn_ingresar.Enabled = true;
            btn_cancel.Enabled = true;
            txt_idaplicacion.Enabled = true;
            txt_nombre.Enabled = true;
            txt_descripcion.Enabled = true;



            try
            {
                DataTable dtValidarID = logic.validarIDAplicacion();
                if (dtValidarID == null || dtValidarID.Rows.Count == 0)
                {

                    return;
                }
                foreach (DataRow row in dtValidarID.Rows)
                {
                    if (row[0] != DBNull.Value)
                    {
                        txt_idaplicacion.Text = row[0].ToString();
                    }
                }

            }
            catch (Exception ex)
            {

                Console.WriteLine(ex);
                return;
            }
        }
        //###################  termina lo que hizo  Karla  Sofia Gómez Tobar #######################


        //###################  lo que hizo Karla  Sofia Gómez Tobar #######################
        private void btn_ingresar_Click_1(object sender, EventArgs e)
        {
            txt_nombre.Enabled = false;
            txt_descripcion.Enabled = false;

            if (txt_nombre.Text == "")
            {

                MessageBox.Show("Falta Nombre de Aplicacion");
                btn_nuevo.Enabled = true;
                txt_nombre.Enabled = false;
                txt_descripcion.Enabled = false;
            }
            else if (txt_descripcion.Text == "")
            {
                MessageBox.Show("Falta Descripcion de Aplicacion");
                btn_nuevo.Enabled = true;
                txt_nombre.Enabled = false;
                txt_descripcion.Enabled = false;
            }

            else
            {
                string estado = "";
                if (Rdb_activo.Checked)
                {
                    estado = "1";
                }

                if (Rdb_inactivo.Checked)
                {
                    estado = "0";
                }
                else
                {
                    estado = "1";
                }

                logic.insertaraplicaciones(txt_idaplicacion.Text.ToString(), txt_nombre.Text.ToString(), txt_descripcion.Text.ToString(), estado.ToString());
                MessageBox.Show("Modulo Ingresado Correctamente");
                limpiar();
                gb_buscar.Enabled = true;
                btn_ingresar.Enabled = false;
                btn_nuevo.Enabled = true;
                txt_idaplicacion.Enabled = false;
            }
        }
        //###################  termina lo que hizo  Karla  Sofia Gómez Tobar #######################

        //esto fue echo por Carlos hernandez
        private void btn_modif_Click_1(object sender, EventArgs e)
        {
            Rdb_activo.Checked = true;
            Gpb_estado.Enabled = true;
            btn_nuevo.Enabled = false;
            btn_actualizar.Enabled = true;
            gb_buscar.Enabled = false;
            btn_modif.Enabled = false;
            btn_ingresar.Enabled = false;
            btn_cancel.Enabled = true;
            txt_idaplicacion.Enabled = false;
            txt_nombre.Enabled = true;
            txt_descripcion.Enabled = true;
        }
        //termina lo que hizo carlos hernandez 
        private void btn_actualizar_Click_1(object sender, EventArgs e)
        {
            if (txt_nombre.Text == "")
            {

                MessageBox.Show("Falta Nombre de Aplicacion");
                btn_nuevo.Enabled = true;
                txt_nombre.Enabled = false;
                txt_descripcion.Enabled = false;
            }
            else if (txt_descripcion.Text == "")
            {
                MessageBox.Show("Falta Descripcion de Aplicacion");
                btn_nuevo.Enabled = true;
                txt_nombre.Enabled = false;
                txt_descripcion.Enabled = false;
            }

            else
            {
                string estado = "";
                if (Rdb_activo.Checked)
                {
                    estado = "1";
                }

                if (Rdb_inactivo.Checked)
                {
                    estado = "0";
                }
                else
                {
                    estado = "1";
                }

                logic.actualizaraplicaciones(txt_idaplicacion.Text.ToString(), txt_nombre.Text.ToString(), txt_descripcion.Text.ToString(), estado.ToString());
                MessageBox.Show("Modulo Modificado Correctamente");
                limpiar();
                btn_cancel.Enabled = false;
                btn_bsucarap.Enabled = true;
                btn_nuevo.Enabled = true;
                btn_ingresar.Enabled = false;
                btn_actualizar.Enabled = false;
                btn_modif.Enabled = false;
                btn_eliminar.Enabled = false;
                txt_idaplicacion.Enabled = false;
                txt_nombre.Enabled = false;
                txt_descripcion.Enabled = false;
                Gpb_estado.Enabled = false;
            }
        }

        //aqui inica lo que hizo Carlos Hernandez
        private void btn_eliminar_Click_1(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txt_idaplicacion.Text))
            {
                // Confirmar antes de eliminar
                var confirmResult = MessageBox.Show("¿Estás seguro de eliminar este perfil?",
                                                    "Confirmar Eliminación",
                                                    MessageBoxButtons.YesNo);

                if (confirmResult == DialogResult.Yes)
                {
                    // Llamar al método de la capa lógica para eliminar el perfil
                    logic.eliminaraplicaciones(txt_idaplicacion.Text);

                    // Opcionalmente, puedes desactivar botones o limpiar campos después de la eliminación
                    txt_buscar.Enabled = true;
                    btn_bsucarap.Enabled = false;
                    btn_modif.Enabled = false;
                    btn_nuevo.Enabled = true;
                    txt_idaplicacion.Enabled = false;
                    txt_descripcion.Enabled = false;
                    Gpb_estado.Enabled = false;
                    limpiar();  // Limpiar campos
                }
            }
            else
            {
                MessageBox.Show("No se ha seleccionado un perfil para eliminar.");
            }
        }
        //aqui termina la parte de Carlos Hernandez

        //###################  lo que hizo Karla  Sofia Gómez Tobar #######################
        private void btn_cancel_Click_1(object sender, EventArgs e)
        {
            limpiar();
            btn_nuevo.Enabled = true;
            gb_buscar.Enabled = true;
            btn_bsucarap.Enabled = true;
            btn_cancel.Enabled = false;
            btn_ingresar.Enabled = false;
            btn_actualizar.Enabled = false;
            btn_modif.Enabled = false;
            txt_idaplicacion.Enabled = false;
            txt_nombre.Enabled = false;
            txt_descripcion.Enabled = false;
            Gpb_estado.Enabled = false;

        }
        //###################  termina lo que hizo  Karla  Sofia Gómez Tobar #######################


        //****************************KATERYN DE LEON-******************************
        private void btn_ayuda_Click_1(object sender, EventArgs e)
        {
            // Help.ShowHelp(this, "C:\\Ayuda_Seguridad\\" + "MantenimientoAplicaciones.chm", "Mantenimiento_Aplicaciones.html");


            // Define el directorio base desde donde comenzar la búsqueda
            string baseDirectory = AppDomain.CurrentDomain.BaseDirectory; // Usando el directorio base del ejecutable

            // Imprime la ruta base para verificar
            MessageBox.Show("Ruta base: " + baseDirectory);

            // Busca el archivo en el directorio base y sus subdirectorios
            string pathAyuda = FindFileInDirectory(baseDirectory, "Ayuda_Seguridad", "frmAplicaciones.chm");

            // Imprimir la ruta generada para verificar
            MessageBox.Show("Ruta de ayuda: " + pathAyuda);

            // Verifica si el archivo existe antes de intentar abrirlo
            if (!string.IsNullOrEmpty(pathAyuda))
            {
                MessageBox.Show("El archivo sí está.");
                // Abre el archivo de ayuda .chm
                Help.ShowHelp(this, pathAyuda);
            }
            else
            {
                // Si el archivo no existe, muestra un mensaje de error
                MessageBox.Show("El archivo de ayuda no se encontró.");
            }
        }

        //**********************KATERYN DE LEON ******************************
        private string FindFileInDirectory(string rootDirectory, string folderName, string fileName)
        {
            try
            {
                // Imprime la ruta raíz para verificar
                MessageBox.Show("Buscando en: " + rootDirectory);

                // Busca la carpeta y el archivo
                foreach (string directory in Directory.GetDirectories(rootDirectory, folderName, SearchOption.AllDirectories))
                {
                    MessageBox.Show("Carpeta encontrada: " + directory); // Imprime las carpetas encontradas
                    string filePath = Path.Combine(directory, fileName);
                    if (File.Exists(filePath))
                    {
                        return filePath; // Devuelve la primera coincidencia encontrada
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error al buscar el archivo: " + ex.Message);
            }
            return null; // No se encontró el archivo
        }

        //*************FIN KATERYN DE LEON***********************************************************

    }
}
