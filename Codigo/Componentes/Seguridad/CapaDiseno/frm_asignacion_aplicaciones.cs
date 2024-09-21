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


/*---------------------------Creador: Allan Letona------------------------------*/

namespace CapaDiseno
{
    public partial class frm_asignacion_aplicaciones : Form
    {
        logica logic;

        //########## INICIA ALYSON RODRIGUEZ 9959-21-829
        public frm_asignacion_aplicaciones(string idUsuario)
        {
            InitializeComponent();
            logic = new logica(idUsuario);
            
        }
        //####  FINALIZA ALYSON RODRIGUEZ 9959-21-829

        public frm_asignacion_aplicaciones()
        {
        }


        //María José Véliz 
        // Método para cargar los usuarios
        private void CargarUsuarios()
        {
            try
            {
                DataTable dtPerfiles = logic.consultaLogicaUsuarios();
                cbo_usuarios.Items.Clear();
                foreach (DataRow row in dtPerfiles.Rows)
                {
                    cbo_usuarios.Items.Add(row[0].ToString());
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error al cargar usuarios: " + ex.Message);
            }
        }
        //termina

        //Trabajado María José Véliz
        private void Frm_asignacion_aplicaciones_Load(object sender, EventArgs e)
        {
            CargarUsuarios();
            CargarModulos();
        }           
        //termina

        void limpieza()
        {
            cbo_usuarios.Text = " ";
            cbo_modulos.Text = " ";
            cbo_aplicaciones.Text = " ";
        }

        // TRABAJADO POR ALYSON RODRIGURZ 9959-21-829
        // Método para cargar los módulos 
        private void CargarModulos()
        {
            try
            {
                DataTable dtModulos = logic.consultaLogicaModulos();
                cbo_modulos.Items.Clear();
                foreach (DataRow row in dtModulos.Rows)
                {
                    cbo_modulos.Items.Add(row[0].ToString());
                }
                cbo_modulos.SelectedIndexChanged += new EventHandler(Cbo_modulos_SelectedIndexChanged);
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error al cargar módulos: " + ex.Message);
            }
        }
        //FIN ALYSON RODRIGURZ 9959-21-829

        // TRABAJADO POR ALYSON RODRIGURZ 9959-21-829
        // Método para cargar aplicaciones según el módulo seleccionado
        private void CargarAplicaciones(string nombreModulo)
        {
            try
            {
                DataTable dtAplicaciones = logic.consultaLogicaAplicaciones(nombreModulo);
                cbo_aplicaciones.Items.Clear();
                foreach (DataRow row in dtAplicaciones.Rows)
                {
                    cbo_aplicaciones.Items.Add(row["nombre_aplicacion"].ToString());
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error al cargar aplicaciones: " + ex.Message);
            }
        }
        //FIN ALYSON RODRIGURZ 9959-21-829


        // TRABAJADO POR ALYSON RODRIGURZ 9959-21-829
        private void Cbo_modulos_SelectedIndexChanged(object sender, EventArgs e)
        {

            // Limpiar las aplicaciones antes de agregar nuevas

            if (cbo_modulos.SelectedIndex != -1)
            {
                string moduloSeleccionado = cbo_modulos.SelectedItem.ToString();
                CargarAplicaciones(moduloSeleccionado);
            }

        }
        //FIN ALYSON RODRIGURZ 9959-21-829



        //Trabajado María José Véliz
        private void Cbo_aplicaciones_SelectedIndexChanged(object sender, EventArgs e)
        {

            if (cbo_aplicaciones.SelectedItem != null)
            {
                string nombreAplicacion = cbo_aplicaciones.SelectedItem.ToString();
                Console.WriteLine("Aplicación seleccionada: " + nombreAplicacion);
            }

        }
        //Termina


        public static int iContadorFila = 0;
        //Trabajado María José Véliz
        private void Btn_agregar_Click(object sender, EventArgs e)
        {

            if (cbo_aplicaciones.SelectedItem == null || cbo_usuarios.SelectedItem == null)
            {
                MessageBox.Show("Faltan Datos Por Seleccionar", "Verificación", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            }
            else
            {
                bool bUsuario_aplicacion_existente = false;

                string sUsuario = cbo_usuarios.SelectedItem.ToString();
                string sAplicacion = cbo_aplicaciones.SelectedItem.ToString();



                if (iContadorFila == 0)
                {
                    dgv_asignaciones.Rows.Add(sUsuario, sAplicacion);

                    iContadorFila++;


                }
                else
                {
                    foreach (DataGridViewRow Fila in dgv_asignaciones.Rows)
                    {
                        if (Fila.Cells[0].Value.ToString() == cbo_usuarios.SelectedItem.ToString() && Fila.Cells[1].Value.ToString() == cbo_aplicaciones.SelectedItem.ToString())

                        {
                            bUsuario_aplicacion_existente = true;
                        }
                    }

                    if (bUsuario_aplicacion_existente == true)
                    {
                        MessageBox.Show("Ya existe una relacion del usuario con la aplicacion");
                    }
                    else
                    {
                        dgv_asignaciones.Rows.Add(sUsuario, sAplicacion);
                        iContadorFila++;
                    }
                }

                limpieza();
            }

        }
        //Tremina


        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


        private void Btn_remover_Click(object sender, EventArgs e)
        {
            if (iContadorFila > 0)
            {
                dgv_asignaciones.Rows.RemoveAt(dgv_asignaciones.CurrentRow.Index);
                iContadorFila--;
            }
            else
            {
                MessageBox.Show("No hay relaciones que eliminar");
            }
        }

        // INICIO ALYSON RODRIGUEZ 9959-21-829 
        private void Btn_finalizar_Click(object sender, EventArgs e)
        {

            string sIngresar;
            string sConsulta;
            string sModificar;
            string sEliminar;
            string sImprimir;
            try
            {
                foreach (DataGridViewRow Fila in dgv_asignaciones.Rows)
                {
                    string sUsuario = Fila.Cells[0].Value.ToString();
                    string sAplicacion = Fila.Cells[1].Value.ToString();


                    bool cheked = ((bool)(Fila.Cells["Ingresar"].EditedFormattedValue));
                    if (cheked)
                        sIngresar = "1";
                    else
                        sIngresar = "0";

                    bool chekedM = ((bool)(Fila.Cells["Modificar"].EditedFormattedValue));
                    if (chekedM)
                        sModificar = "1";
                    else
                        sModificar = "0";

                    bool chekedE = ((bool)(Fila.Cells["Eliminar"].EditedFormattedValue));
                    if (chekedE)
                        sEliminar = "1";
                    else
                        sEliminar = "0";

                    bool chekedC = ((bool)(Fila.Cells["Consultar"].EditedFormattedValue));
                    if (chekedC)
                        sConsulta = "1";
                    else
                        sConsulta = "0";

                    bool chekedI = ((bool)(Fila.Cells["Imprimir"].EditedFormattedValue));
                    if (chekedI)
                        sImprimir = "1";
                    else
                        sImprimir = "0";

                    // Mostrar mensaje con los datos de cada fila antes de insertar
                    MessageBox.Show(
                        $"Datos de la fila:\n" +
                        $"Usuario: {sUsuario}\n" +
                        $"Aplicación: {sAplicacion}\n" +
                        $"Ingresar: {sIngresar}\n" +
                        $"Consultar: {sConsulta}\n" +
                        $"Modificar: {sModificar}\n" +
                        $"Eliminar: {sEliminar}\n" +
                        $"Imprimir: {sImprimir}",
                        "Datos de la Fila",
                        MessageBoxButtons.OK,
                        MessageBoxIcon.Information
                    );

                    DataTable dtAplicaciones = logic.consultaLogicaPermisosUsuarioAplicacion(sUsuario, sAplicacion, sIngresar, sConsulta, sModificar, sEliminar, sImprimir);

                }

                MessageBox.Show("Datos ingresados exitosamente");
                limpieza();
                dgv_asignaciones.Rows.Clear();
                iContadorFila = 0;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex);
            }
        }
        // FINALIZA ALYSON RODRIGUEZ 9959-21-829 


        //Trabajado María José Véliz
        // Método para configurar CheckBoxColumns en el DataGridView
        private void ConfigurarColumnasCheckBox()
        {
            if (dgv_asignaciones.Columns["Ingresar"] is DataGridViewCheckBoxColumn)
            {
                ((DataGridViewCheckBoxColumn)dgv_asignaciones.Columns["Ingresar"]).TrueValue = 1;
                ((DataGridViewCheckBoxColumn)dgv_asignaciones.Columns["Ingresar"]).FalseValue = 0;
            }

            if (dgv_asignaciones.Columns["Consultar"] is DataGridViewCheckBoxColumn)
            {
                ((DataGridViewCheckBoxColumn)dgv_asignaciones.Columns["Consultar"]).TrueValue = 1;
                ((DataGridViewCheckBoxColumn)dgv_asignaciones.Columns["Consultar"]).FalseValue = 0;
            }

            if (dgv_asignaciones.Columns["Modificar"] is DataGridViewCheckBoxColumn)
            {
                ((DataGridViewCheckBoxColumn)dgv_asignaciones.Columns["Modificar"]).TrueValue = 1;
                ((DataGridViewCheckBoxColumn)dgv_asignaciones.Columns["Modificar"]).FalseValue = 0;
            }

            if (dgv_asignaciones.Columns["Eliminar"] is DataGridViewCheckBoxColumn)
            {
                ((DataGridViewCheckBoxColumn)dgv_asignaciones.Columns["Eliminar"]).TrueValue = 1;
                ((DataGridViewCheckBoxColumn)dgv_asignaciones.Columns["Eliminar"]).FalseValue = 0;
            }

            if (dgv_asignaciones.Columns["Imprimir"] is DataGridViewCheckBoxColumn)
            {
                ((DataGridViewCheckBoxColumn)dgv_asignaciones.Columns["Imprimir"]).TrueValue = 1;
                ((DataGridViewCheckBoxColumn)dgv_asignaciones.Columns["Imprimir"]).FalseValue = 0;
            }
        }
        //Termina

        private void Dgv_asignaciones_CellContentClick(object sender, DataGridViewCellEventArgs e)
        { 
           
        }

        private void Btn_salir_Click(object sender, EventArgs e)
        {
            
            this.Close();
        }


        //**********************KATERYN DE LEON ******************************
        private void Btn_ayuda_Click(object sender, EventArgs e)
        {
            //Help.ShowHelp(this, "C:\\Ayuda_Seguridad\\" + "AyudaAsignacionAplicacionesUsuarios.chm", "Asignacion_Aplicaciones_Usuarios.html");

            // Define el directorio base desde donde comenzar la búsqueda
            string baseDirectory = AppDomain.CurrentDomain.BaseDirectory; // Usando el directorio base del ejecutable

            // Imprime la ruta base para verificar
            MessageBox.Show("Ruta base: " + baseDirectory);

            // Busca el archivo en el directorio base y sus subdirectorios
            string pathAyuda = FindFileInDirectory(baseDirectory, "Ayuda_Seguridad", "frmAsignacionAplicaciones.chm");

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

        //****************************************************************************


    }
}
