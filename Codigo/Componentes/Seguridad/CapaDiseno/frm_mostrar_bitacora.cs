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
using CapaDatos;
using System.IO; // Necesario para Directory, File, Path y SearchOption
using System.Windows.Forms; // Necesario para MessageBox y Help

namespace CapaDiseno
{
    //Fernando García - 0901-21-581 - INICIO
    public partial class frm_mostrar_bitacora : Form
    {
        private string idUsuario; // Variable de clase para almacenar el idUsuario
        private logica logic; // variable para el filtro de busqueda
        public frm_mostrar_bitacora(string idUsuario)
        {
            InitializeComponent();
            this.idUsuario = idUsuario;
            logic = new logica(idUsuario);

            Cbo_columna.DropDownStyle = ComboBoxStyle.DropDownList;
            Cbo_columna.SelectedIndex = -1;
            Txt_dato.Enabled = false;
            Dtp_hora.ShowUpDown = true;
            Dtp_hora.Format = DateTimePickerFormat.Custom;
            Dtp_hora.CustomFormat = "HH:mm";  // Formato de 24 horas
            Limpiar();
            // Inicializar el ComboBox con las opciones de filtrado
            Cbo_columna.Items.AddRange(new string[] { "Id", "Usuario", "Fecha", "Hora", "Host", "IP", "Acción", "Tabla" });
            Cbo_columna.SelectedIndex = 0;

            sentencia sn = new sentencia(idUsuario);
            sn.insertarBitacora(idUsuario, "Consulto bitacora", "tbl_bitacora");
            ActualizarBitacora();
        }

        private void ActualizarBitacora()
        {
            Dgv_bitacora.DataSource = logic.consultaLogicaBitacora().Tables[0];
        }

        private void Frm_mostrar_bitacora_Load(object sender, EventArgs e)
        {
            Cbo_columna.SelectedIndex = -1;
            Dgv_bitacora.ScrollBars = ScrollBars.Both;
            Dgv_bitacora.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.None;

        }

        private void button1_Click(object sender, EventArgs e)
        {
            //Se vuelve a llamar para actualizar bitacora
            ActualizarBitacora();
        }

        private void Btn_buscar_Click(object sender, EventArgs e)
        {
            if (Cbo_columna.SelectedIndex == -1)
            {
                MessageBox.Show("Por favor, seleccione un campo para buscar.", "Aviso", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }

            try
            {
                string campo = ObtenerCampoFiltro();  // Obtener el campo seleccionado
                string valor = string.Empty;  // Inicializar el valor de búsqueda

                // Determinar el valor de búsqueda según el campo seleccionado
                if (campo == "fecha_bitacora")
                {
                    valor = Dtp_dato.Value.ToString("yyyy-MM-dd");
                }
                else if (campo == "hora_bitacora")
                {
                    // Obtener el valor ingresado en el DateTimePicker de hora
                    valor = Dtp_hora.Value.ToString("HH:mm");

                    // Si solo se ingresa la hora sin minutos, usar LIKE en la consulta SQL
                    if (Dtp_hora.Value.Minute == 0)
                    {
                        valor = Dtp_hora.Value.ToString("HH") + "%";  // Solo busca por la hora, sin los minutos
                    }
                }
                else
                {
                    valor = Txt_dato.Text;
                }

                // Realizar la búsqueda en la bitácora con el campo y el valor obtenidos
                Dgv_bitacora.DataSource = logic.consultaLogicaBitacoraFiltrada(campo, valor).Tables[0];
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error al realizar la búsqueda: " + ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private string ObtenerCampoFiltro()
        {

            if (Cbo_columna.SelectedItem == null)
            {
                return "FK_id_usuario"; // Valor por defecto
            }

            switch (Cbo_columna.SelectedItem.ToString())
            {
                case "Id": return "Pk_id_bitacora";
                case "Usuario": return "FK_id_usuario";
                case "Fecha": return "fecha_bitacora";
                case "Hora": return "hora_bitacora";
                case "Host": return "host_bitacora";
                case "IP": return "ip_bitacora";
                case "Acción": return "accion_bitacora";
                case "Tabla": return "tabla";
                default: return "FK_id_usuario";
            }
        }

        private void Cbo_columna_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Si no hay un elemento seleccionado, desactiva todo
            if (Cbo_columna.SelectedIndex == -1)
            {
                Txt_dato.Enabled = false;
                Txt_dato.Visible = false;
                Dtp_dato.Visible = false;
                Dtp_hora.Visible = false;
                return;
            }

            // Si el índice es 2, oculta y desactiva todos los controles
            if (Cbo_columna.SelectedIndex == 2)
            {
                Txt_dato.Visible = false;
                Txt_dato.Enabled = false;
                Dtp_dato.Visible = true;
                Dtp_hora.Visible = false;
            }
            // Si el índice es 3, muestra el selector de horas
            else if (Cbo_columna.SelectedIndex == 3)
            {
                Txt_dato.Visible = false;
                Txt_dato.Enabled = false;
                Dtp_dato.Visible = false;
                Dtp_hora.Visible = true;
            }
            // Para cualquier otro índice, muestra el campo de texto
            else
            {
                Txt_dato.Visible = true;
                Txt_dato.Enabled = true;
                Dtp_dato.Visible = false;
                Dtp_hora.Visible = false;
            }
        }

        private void Btn_borrarfiltros_Click(object sender, EventArgs e)
        {
            ActualizarBitacora();
            Limpiar();
        }

        private void Limpiar()
        {
            try
            {
                Cbo_columna.SelectedIndex = -1; // Deseleccionar
                Txt_dato.Text = string.Empty;
                Txt_dato.Enabled = false;
                Dtp_dato.Value = DateTime.Now;
                Dtp_dato.Visible = false;
                Dtp_hora.Value = DateTime.Now;
                Dtp_hora.Visible = false;
                ActualizarBitacora(); // Volver a cargar todos los datos
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error al limpiar los campos: " + ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
        //********************** KATERYN DE LEON y Gabriela Suc   ********************************************
        private void btn_ayuda_Click(object sender, EventArgs e)
        { // Define el directorio base desde donde comenzar la búsqueda
            string baseDirectory = AppDomain.CurrentDomain.BaseDirectory; // Usando el directorio base del ejecutable

            // Imprime la ruta base para verificar
            MessageBox.Show("Ruta base: " + baseDirectory);

            // Busca el archivo en el directorio base y sus subdirectorios
            string pathAyuda = FindFileInDirectory(baseDirectory, "Ayuda_Seguridad", "ayudaBitacora.chm");

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
        //********************** KATERYN DE LEON y Gabriela Suc   ********************************************
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

        //******** Fin KATERYN DE LEON y Gabriela Suc   ********************************************************************


    }
    //FIN #########################
}
