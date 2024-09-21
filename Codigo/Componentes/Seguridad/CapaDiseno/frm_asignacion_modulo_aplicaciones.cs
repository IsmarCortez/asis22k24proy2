using CapaLogica;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

using System.IO; // Necesario para Directory, File, Path y SearchOption
using System.Windows.Forms; // Necesario para MessageBox y Help


namespace CapaDiseno
{
    public partial class frm_asignacion_modulo_aplicaciones : Form
    {
        /******************************Ismar Leonel Cortez Sanchez*******************************************************/
        logica logica2;

        public frm_asignacion_modulo_aplicaciones(String idUsuario)
        {
            InitializeComponent();
            logica2 = new logica(idUsuario); // Inicializa logica2 con idUsuario
            string tabla = "tbl_modulos";
            string campo1 = "Pk_id_modulos";
            string campo2 = "nombre_modulo";

            string tablaApli = "tbl_aplicaciones";
            string campo1Apli = "Pk_id_aplicacion";
            string campo2Apli = "nombre_aplicacion";


            // Llama al método para llenar el ComboBox
            llenarseModulos(tabla, campo1, campo2);
            llenarseApli(tablaApli, campo1Apli, campo2Apli);

            // Asocia el evento SelectedIndexChanged después de poblar el ComboBox
            cmb_modulo.SelectedIndexChanged += new EventHandler(cmb_modulo_SelectedIndexChanged);
            cmb_apli.SelectedIndexChanged += new EventHandler(cmb_apli_SelectedIndexChanged2);
        }

        public frm_asignacion_modulo_aplicaciones() { }

        private void frm_asignacion_modulo_aplicaciones_Load(object sender, EventArgs e) { }


        /*********************************Ismar Leonel Cortez Sanchez -0901-21-560*****************************************/
        /**************************************Combo box inteligente 1*****************************************************/

        public void llenarseModulos(string tabla, string campo1, string campo2)
        {
            // Obtén los datos para el ComboBox
            var dt2 = logica2.enviar(tabla, campo1, campo2);

            // Limpia el ComboBox antes de llenarlo
            cmb_modulo.Items.Clear();

            foreach (DataRow row in dt2.Rows)
            {
                // Agrega el elemento mostrando el formato "ID-Nombre"
                cmb_modulo.Items.Add(new ComboBoxItem
                {
                    Value = row[campo1].ToString(),
                    Display = row[campo2].ToString()
                });
            }

            // Configura AutoComplete para el ComboBox con el formato deseado
            AutoCompleteStringCollection coleccion = new AutoCompleteStringCollection();
            foreach (DataRow row in dt2.Rows)
            {
                coleccion.Add(Convert.ToString(row[campo1]) + "-" + Convert.ToString(row[campo2]));
                coleccion.Add(Convert.ToString(row[campo2]) + "-" + Convert.ToString(row[campo1]));
            }

            cmb_modulo.AutoCompleteCustomSource = coleccion;
            cmb_modulo.AutoCompleteMode = AutoCompleteMode.SuggestAppend;
            cmb_modulo.AutoCompleteSource = AutoCompleteSource.CustomSource;
        }

        // Clase auxiliar para almacenar Value y Display
        public class ComboBoxItem
        {
            public string Value { get; set; }
            public string Display { get; set; }

            // Sobrescribir el método ToString para mostrar "ID-Nombre" en el ComboBox
            public override string ToString()
            {
                return $"{Value}-{Display}"; // Formato "ID-Nombre"
            }
        }

        private void cmb_modulo_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cmb_modulo.SelectedItem != null)
            {
                // Obtener el valor del ValueMember seleccionado
                var selectedItem = (ComboBoxItem)cmb_modulo.SelectedItem;
                string valorSeleccionado = selectedItem.Value;
                // Mostrar el valor en un MessageBox
                MessageBox.Show($"Valor seleccionado: {valorSeleccionado}", "Valor Seleccionado");
            }
        }
        /***************************************************************************************************/



        /*********************************Ismar Leonel Cortez Sanchez -0901-21-560*****************************************/
        /**************************************Combo box inteligente 2*****************************************************/

        public void llenarseApli(string tabla, string campo1, string campo2)
        {
            // Obtén los datos para el ComboBox
            var dt2 = logica2.enviar2(tabla, campo1, campo2);

            // Limpia el ComboBox antes de llenarlo
            cmb_apli.Items.Clear();

            foreach (DataRow row in dt2.Rows)
            {
                // Agrega el elemento mostrando el formato "ID-Nombre"
                cmb_apli.Items.Add(new ComboBoxItem
                {
                    Value = row[campo1].ToString(),
                    Display = row[campo2].ToString()
                });
            }

            // Configura AutoComplete para el ComboBox con el formato deseado
            AutoCompleteStringCollection coleccion2 = new AutoCompleteStringCollection();
            foreach (DataRow row in dt2.Rows)
            {
                coleccion2.Add(Convert.ToString(row[campo1]) + "-" + Convert.ToString(row[campo2]));
                coleccion2.Add(Convert.ToString(row[campo2]) + "-" + Convert.ToString(row[campo1]));
            }

            cmb_apli.AutoCompleteCustomSource = coleccion2;
            cmb_apli.AutoCompleteMode = AutoCompleteMode.SuggestAppend;
            cmb_apli.AutoCompleteSource = AutoCompleteSource.CustomSource;
        }

        // Clase auxiliar para almacenar Value y Display
        public class ComboBoxItem2
        {
            public string Value { get; set; }
            public string Display { get; set; }

            // Sobrescribir el método ToString para mostrar "ID-Nombre" en el ComboBox
            public override string ToString()
            {
                return $"{Value}-{Display}"; // Formato "ID-Nombre"
            }
        }

        private void cmb_apli_SelectedIndexChanged2(object sender, EventArgs e)
        {
            if (cmb_modulo.SelectedItem != null)
            {
                // Obtener el valor del ValueMember seleccionado
                var selectedItem = (ComboBoxItem)cmb_apli.SelectedItem;
                string valorSeleccionado = selectedItem.Value;
                // Mostrar el valor en un MessageBox
                MessageBox.Show($"Valor seleccionado: {valorSeleccionado}", "Valor Seleccionado");
            }
        }

        //*********************KATERYN DE LEON**********************************************
        //boton ver
        private void btn_ver_Click(object sender, EventArgs e)
        {
            try
            {
                // Llamar a la capa lógica para obtener los datos de la asignación (modulo-aplicación)
                DataTable dtResultado = logica2.consultaLogicaAsigncacionModuloAplicaciones();

                if (dtResultado != null && dtResultado.Rows.Count > 0)
                {
                    // Asignar el DataTable al DataGridView
                    dgv_asignaciones_modulo_aplicacion.DataSource = dtResultado;
                }
                else
                {
                    MessageBox.Show("No se encontraron datos.");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error al buscar los datos: {ex.Message}");
            }
        }
        // *******************************KATERYN DE LEON******************************/
        //boton crear
        private void btn_crear_Click(object sender, EventArgs e)
        {   
            try
            {
                // Obtener los valores seleccionados de los ComboBox
                var selectedModulo = (ComboBoxItem)cmb_modulo.SelectedItem;
                var selectedAplicacion = (ComboBoxItem)cmb_apli.SelectedItem;

                if (selectedModulo != null && selectedAplicacion != null)
                {
                    // Obtener nombres
                    string nombreModulo = selectedModulo.Display;
                    string nombreAplicacion = selectedAplicacion.Display;

                    // Obtener o insertar módulo y aplicación
                    int idModulo = logica2.ObtenerOInsertarModulo(nombreModulo);
                    int idAplicacion = logica2.ObtenerOInsertarAplicacion(nombreAplicacion);

                    if (idModulo > 0 && idAplicacion > 0)
                    {
                        // Insertar en la tabla intermedia
                        bool resultado = logica2.InsertarLogicaAsignacionModuloAplicacion(idModulo, idAplicacion);

                        if (resultado)
                        {
                            MessageBox.Show("Asignación creada exitosamente.");
                            
                        }
                        else
                        {
                            MessageBox.Show("Error al crear la asignación.");
                        }
                    }
                    else
                    {
                        MessageBox.Show("No se pudieron obtener los IDs del módulo o la aplicación.");
                    }
                }
                else
                {
                    MessageBox.Show("Por favor, selecciona un módulo y una aplicación válidos.");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error al crear la asignación: {ex.Message}");
            }


        }

        private void cmb_modulo_SelectedIndexChanged_1(object sender, EventArgs e)
        {
            //*******************************************KATERYN DE LEON**********************************************
            //****************ComboBox1 (Modulos) ********************

            if (cmb_modulo.SelectedItem != null)
            {
                // Obtener el valor del ComboBoxItem seleccionado
                var selectedItem = (ComboBoxItem)cmb_modulo.SelectedItem;
                string valorSeleccionado = selectedItem.Value;

                // Mostrar el valor en el TextBox txt_modulo
                txt_modulo.Text = $"{selectedItem.Value}-{selectedItem.Display}";

                // O solo el nombre del módulo (Display)
                // txt_modulo.Text = selectedItem.Display;
            }
        }
        //*******************************************************************************/

        private void cmb_apli_SelectedIndexChanged(object sender, EventArgs e)
        {  //*************************************KATERYN DE LEON**********************************************
           //****************ComboBox2 (Aplicaciones)********************

            if (cmb_apli.SelectedItem != null)
            {
                // Obtener el valor del ComboBoxItem2 seleccionado
                var selectedItem = (ComboBoxItem)cmb_apli.SelectedItem;
                string valorSeleccionado = selectedItem.Value;

                // Mostrar el valor en el TextBox txt_aplicacion
                txt_aplicacion.Text = $"{selectedItem.Value}-{selectedItem.Display}";

                // O solo el nombre de la aplicación (Display)
                // txt_aplicacion.Text = selectedItem.Display;
            }

        }

        private void btn_salir_Click(object sender, EventArgs e)
        {
            this.Close();
        }
        //**********************KATERYN DE LEON ******************************
        private void btn_ayuda_Click(object sender, EventArgs e)
        {
            // Help.ShowHelp(this, "C:\\Ayuda_Seguridad\\" + "CreacionUsuario.chm", "Creacion_Usuario.html");

            // Define el directorio base desde donde comenzar la búsqueda
            string baseDirectory = AppDomain.CurrentDomain.BaseDirectory; // Usando el directorio base del ejecutable

            // Imprime la ruta base para verificar
            MessageBox.Show("Ruta base: " + baseDirectory);

            // Busca el archivo en el directorio base y sus subdirectorios
            string pathAyuda = FindFileInDirectory(baseDirectory, "Ayuda_Seguridad", "frmAsignancionModuloAplicaciones.chm");

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

        //****************************************************************************

    }

    /***************************************************************************************************/
}

    

