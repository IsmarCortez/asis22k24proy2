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
    public partial class frm_modulos : Form
    {
        logica logic;

        public frm_modulos(string idUsuario)
        {
            InitializeComponent();
            btn_modif.Enabled = false;
            btn_actualizar.Enabled = false;
            btn_cancel.Enabled = false;
            btn_eliminar.Enabled = false; //se agrega
            logic = new logica(idUsuario);
            txtcodigo.Enabled = false;
            txtnombre.Enabled = false;
            txtdesc.Enabled = false;
            btn_ingresar.Enabled = false;
            gbestado.Enabled = false;
        }

        public frm_modulos()
        {
        }

        void limpiar()
        {
            tbx_buscarmodulo.Text = "";
            txtcodigo.Text = "";
            txtdesc.Text = "";
            txtnombre.Text = "";
            rbhabilitado.Checked = false;
            rbinhabilitado.Checked = false;
            txtcodigo.Focus();
        }


        private void Frm_modulos_Load(object sender, EventArgs e)
        {

        }

        //Trabajado por María José Véliz Ochoa, 9959-21-5909
        private void btn_bsucarmodulo_Click_1(object sender, EventArgs e)
        {
            string modulo = tbx_buscarmodulo.Text;

            if (string.IsNullOrWhiteSpace(modulo))
            {
                MessageBox.Show("Por favor, ingrese un ID de módulo.");
                return;
            }
            //Para errores null del DataTable
            try
            {
                DataTable dtModulos = logic.ConsultaLogicaModulo(modulo);

                if (dtModulos == null || dtModulos.Rows.Count == 0)
                {
                    MessageBox.Show("No se encontraron módulos.");
                    return;
                }

                foreach (DataRow row in dtModulos.Rows)
                {// Asigna el valor de cada columna a su respectivo control en la interfaz si no es nulo
                    if (row[0] != DBNull.Value) txtcodigo.Text = row[0].ToString();
                    if (row[1] != DBNull.Value) txtnombre.Text = row[1].ToString();
                    if (row[2] != DBNull.Value) txtdesc.Text = row[2].ToString();
                    if (row[3] != DBNull.Value)
                    {
                        string estado = row[3].ToString();
                        if (estado == "1")
                        {
                            rbhabilitado.Checked = true;
                            rbinhabilitado.Checked = false;
                        }
                        else if (estado == "0")
                        {
                            rbhabilitado.Checked = false;
                            rbinhabilitado.Checked = true;
                        }
                    }
                }

                btn_modif.Enabled = true;
                btn_ingresar.Enabled = false;
                txtcodigo.Enabled = false;
                txtnombre.Enabled = false;
                txtdesc.Enabled = false;
                rbhabilitado.Enabled = false;
                rbinhabilitado.Enabled = false;
                btn_cancel.Enabled = true;
                btn_eliminar.Enabled = true; //se agrega

            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
                Console.WriteLine(ex);
            }
        }

        //Trabajado por María José Véliz Ochoa, 9959-21-5909

        private void btn_nuevo_Click_1(object sender, EventArgs e)
        {
            btn_nuevo.Enabled = false;
            btn_actualizar.Enabled = false;
            gbbuscar.Enabled = false;
            btn_modif.Enabled = false;
            rbhabilitado.Checked = true;
            gbestado.Enabled = true;
            txtnombre.Enabled = true;
            txtdesc.Enabled = true;
            btn_ingresar.Enabled = true;
            btn_cancel.Enabled = true;
            //habilitando para ingresar id
            txtcodigo.Enabled = true;
            btn_eliminar.Enabled = false; //se agrega


            //para errores tipo null
            try
            {
                DataTable dtValidarID = logic.validarIDModulos();
                if (dtValidarID == null || dtValidarID.Rows.Count == 0)
                {
                    //txtcodigo.Text = ""; // Asigna un valor por defecto si no se encuentra ningún ID
                    return;
                }
                foreach (DataRow row in dtValidarID.Rows)
                {
                    if (row[0] != DBNull.Value)
                    {
                        txtcodigo.Text = row[0].ToString();
                    }
                }

            }
            catch (Exception ex)
            {

                Console.WriteLine(ex);
                return;
            }
        }
        // FIN ####################################

        private void btn_ingresar_Click_1(object sender, EventArgs e)
        {
            txtnombre.Enabled = false;
            txtdesc.Enabled = false;


            if (txtnombre.Text == "")
            {
                MessageBox.Show("Falta Nombre de Modulo");
                btn_nuevo.Enabled = true;
                txtnombre.Enabled = false;
                txtdesc.Enabled = false;

            }
            else if (txtdesc.Text == "")
            {
                MessageBox.Show("Falta Descripcion del modulo");
                btn_nuevo.Enabled = true;
                txtnombre.Enabled = false;
                txtdesc.Enabled = false;

            }

            else
            {
                string estado = "";
                if (rbhabilitado.Checked)
                {
                    estado = "1";
                }

                if (rbinhabilitado.Checked)
                {
                    estado = "0";
                }
                else
                {
                    estado = "1";
                }

                logic.ingresarmodulos(txtcodigo.Text.ToString(), txtnombre.Text.ToString(), txtdesc.Text.ToString(), estado.ToString());
                MessageBox.Show("Modulo Ingresado Correctamente");
                limpiar();
                gbbuscar.Enabled = true;
                btn_nuevo.Enabled = true;
                btn_ingresar.Enabled = false;
                txtcodigo.Enabled = false;
                btn_eliminar.Enabled = false; //se agrega
            }
        }

        private void btn_actualizar_Click_1(object sender, EventArgs e)
        {
            if (txtnombre.Text == "")
            {
                MessageBox.Show("Falta Nombre de Modulo");

                btn_nuevo.Enabled = true;
                txtnombre.Enabled = false;
                txtdesc.Enabled = false;


            }
            else if (txtdesc.Text == "")
            {
                MessageBox.Show("Falta Descripcion del modulo");

                btn_nuevo.Enabled = true;
                txtnombre.Enabled = false;
                txtdesc.Enabled = false;

            }

            else
            {
                string estado = "";
                if (rbhabilitado.Checked)
                {
                    estado = "1";
                }

                if (rbinhabilitado.Checked)
                {
                    estado = "0";
                }
                else
                {
                    estado = "1";
                }

                logic.Actualizarmodulo(txtcodigo.Text.ToString(), txtnombre.Text.ToString(), txtdesc.Text.ToString(), estado.ToString());
                MessageBox.Show("Modulo Actualizado Correctamente");
                btn_modif.Enabled = false;
                btn_actualizar.Enabled = false;
                btn_cancel.Enabled = false;
                btn_ingresar.Enabled = false;
                gbestado.Enabled = false;
                btn_nuevo.Enabled = true;
                txtcodigo.Enabled = false;
                txtnombre.Enabled = false;
                txtdesc.Enabled = false;
                btn_eliminar.Enabled = false; //se agrega  ALyson #####################
                limpiar();
            }
        }

        private void btn_modif_Click_1(object sender, EventArgs e)
        {
            txtcodigo.Enabled = false;
            btn_cancel.Enabled = true;
            btn_actualizar.Enabled = true;
            btn_modif.Enabled = false;
            txtnombre.Enabled = true;
            txtdesc.Enabled = true;
            rbhabilitado.Enabled = true;
            rbinhabilitado.Enabled = true;
            btn_nuevo.Enabled = false;
            gbestado.Enabled = true;
            btn_eliminar.Enabled = false; //se agrega
        }

        private void btn_eliminar_Click_1(object sender, EventArgs e)
        {
            // Deshabilitar botones y campos según sea necesario
            btn_nuevo.Enabled = true;
            btn_actualizar.Enabled = false;
            gbbuscar.Enabled = true;
            btn_modif.Enabled = false;
            rbhabilitado.Checked = false;
            gbestado.Enabled = false;
            txtnombre.Enabled = false;
            txtdesc.Enabled = false;
            btn_ingresar.Enabled = false;
            btn_cancel.Enabled = false;
            txtcodigo.Enabled = false;
            btn_eliminar.Enabled = false;

            // Validar el estado seleccionado
            string estado;
            if (rbhabilitado.Checked)
            {
                estado = "1"; // Habilitado
            }
            else if (rbinhabilitado.Checked)
            {
                estado = "0"; // Inhabilitado
            }
            else
            {
                // Asignar un valor predeterminado si ninguno está seleccionado
                estado = "0"; // O "1", dependiendo de tu lógica
            }

            // Validar que se haya ingresado el ID del módulo
            if (string.IsNullOrEmpty(txtcodigo.Text))
            {
                MessageBox.Show("Falta ID del Módulo");
                return; // Salir del método si falta el ID
            }

            try
            {
                // Llamar al método de la lógica de negocio para realizar el borrado lógico
                logic.EliminarModulo(txtcodigo.Text.ToString(), txtnombre.Text.ToString(), txtdesc.Text.ToString(), estado);

                MessageBox.Show("Módulo eliminado correctamente.");
                limpiar(); // Limpia los campos del formulario
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error al intentar eliminar el módulo: " + ex.Message);
            }
        }
        // FIN BOTON ELIMINAR ####################################


        //María José para deshabilitar txt código
        private void btn_cancel_Click_1(object sender, EventArgs e)
        {
            limpiar();
            btn_modif.Enabled = false;
            btn_actualizar.Enabled = false;
            btn_cancel.Enabled = false;
            btn_ingresar.Enabled = false;
            txtnombre.Enabled = false;
            txtdesc.Enabled = false;
            gbbuscar.Enabled = true;
            btn_nuevo.Enabled = true;
            gbestado.Enabled = false;
            txtcodigo.Enabled = false;
            btn_eliminar.Enabled = false; //se agrega
        }
        //termina
        private void button1_Click_1(object sender, EventArgs e)
        {
            limpiar();
            this.Close();
        }
        //********************** KATERYN DE LEON y Gabriela Suc ******************************
        private void btn_ayuda_Click_1(object sender, EventArgs e)
        {
            //Help.ShowHelp(this, "C:\\Ayuda_Seguridad\\" + "MantenimientoModulos.chm", "AyudaMantenimientoModulos.html");


            // Define el directorio base desde donde comenzar la búsqueda
            string baseDirectory = AppDomain.CurrentDomain.BaseDirectory; // Usando el directorio base del ejecutable

            // Imprime la ruta base para verificar
            MessageBox.Show("Ruta base: " + baseDirectory);

            // Busca el archivo en el directorio base y sus subdirectorios
            string pathAyuda = FindFileInDirectory(baseDirectory, "Ayuda_Seguridad", "AyudaModulos.chm");

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
        //********************** KATERYN DE LEON y Gabriela Suc  ******************************
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

        //******** FIN KATERYN DE LEON y Gabriela Suc   ********************************************************************
    }
}

