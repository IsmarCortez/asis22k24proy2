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
using System.Security.Cryptography;
using System.IO; // Necesario para Directory, File, Path y SearchOption
using System.Windows.Forms; // Necesario para MessageBox y Help

/*---------------------------Creador: Diego Gomez------------------------------*/
namespace CapaDiseno
{
    public partial class frm_usuarios : Form
    {
        logica logica1;
        
        bool boton_ingreso = false;
        bool boton_eliminar = false;
        bool boton_modificar = false;

        public frm_usuarios(string idUsuario)
        {
            InitializeComponent();
            logica1 = new logica(idUsuario);
        }

        public frm_usuarios()
        {
        }

        private void Dgv_asignaciones_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void Label2_Click(object sender, EventArgs e)
        {

        }

        

        private void DataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        string buscar;


        void limpiar()
        {
            txt_id.Text = "";
            txt_nombreusername.Text = "";
            txt_buscar.Text = "";
            txt_clave.Text = "";
            txt_apellido.Text = "";
            txt_nomb.Text = "";

            txt_correo.Text = "";
            rb_habilitado.Checked = false;
            rb_inhabilitado.Checked = false;
            dataGridView1.Columns.Clear();
            //txt_estadousuario.Text = "";
            // txt_pregunta.Text = "";
            txt_respuesta.Text = "";
        }

        private void Button1_Click_1(object sender, EventArgs e)
        {
            //**************************************KaterynDeLeon*********************/
            //BOTON BUSCAR
          

            buscar = txt_buscar.Text.Trim();

            try
            {
                // Obtiene el DataTable desde la lógica de búsqueda
                DataTable dtusuario = logica1.buscar(buscar);

                // Verifica si el DataTable tiene datos
                if (dtusuario == null || dtusuario.Rows.Count == 0)
                {
                    MessageBox.Show("No existe el registro que buscas.");
                }
                else
                {
                    // Asigna el DataTable como el origen de datos del DataGridView
                    dataGridView1.DataSource = dtusuario;

                    // Mensaje indicando que los datos fueron buscados correctamente
                    MessageBox.Show("Los datos fueron buscados correctamente.");

                    // Habilita los botones necesarios para continuar la operación
                    txt_nomb.Enabled = true;
                    txt_apellido.Enabled = true;
                    txt_correo.Enabled = true;
                    txt_estadousuario.Enabled = true;
                    txt_pregunta.Enabled = true;
                    txt_respuesta.Enabled = true;
                    button3.Enabled = true;
                    button2.Enabled = true;
                    btn_salir.Enabled = true;
                    btn_guardar.Enabled = true;
                    button4.Enabled = true;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error al buscar: " + ex.Message);
                return;
            }
        }

        private void GroupBox3_Enter(object sender, EventArgs e)
        {

        }

        private void Frm_usuarios_Load(object sender, EventArgs e)
        {
            txt_buscar.Enabled = true;
            txt_id.Enabled = false;
            btn_buscar.Enabled = true;
            txt_nombreusername.Enabled = false;
            txt_clave.Enabled = false;
            txt_apellido.Enabled = false;

            txt_nombreusername.Enabled = false;
            txt_nomb.Enabled = false;

            txt_correo.Enabled = false;
            txt_estadousuario.Enabled = false;
            txt_pregunta.Enabled = false;
            txt_respuesta.Enabled = false;
        }


        //---------------------------------------------------- Inicio: GABRIELA SUC ----------------------------------------------------

        private void Button2_Click(object sender, EventArgs e)
        {   //Botón ELIMINAR

            // Obtener el ID del usuario del TextBox
            string idUsuario = txt_buscar.Text;

            // Validar que el campo no esté vacío
            if (string.IsNullOrEmpty(idUsuario))
            {
                MessageBox.Show("Por favor, ingrese el ID del usuario.");
                return;
            }

            // Confirmar si desea eliminar el usuario
            DialogResult dialogResult = MessageBox.Show("¿Está seguro que desea eliminar este usuario?", "Confirmación", MessageBoxButtons.YesNo);
            if (dialogResult == DialogResult.Yes)
            {
                // Llamar a la capa lógica para cambiar el estado del usuario
                bool resultado = logica1.EliminarUsuario(idUsuario);

                if (resultado)
                {
                    MessageBox.Show("El usuario ha sido eliminado correctamente (cambiado a estado Inactivo).");
                    limpiar(); // Limpiar los campos después de la actualización
                }
                else
                {
                    MessageBox.Show("Hubo un error al intentar eliminar el usuario.");
                }
            }
            else
            {
                MessageBox.Show("El usuario no ha sido eliminado.");
            }


        }


        private void Button3_Click(object sender, EventArgs e)
        {

            // Botón MODIFICAR

            // Preguntar si está seguro de modificar
            DialogResult result = MessageBox.Show("¿Está seguro de modificar este registro?", "Confirmar Modificación", MessageBoxButtons.YesNo);

            if (result == DialogResult.Yes)
            {
                // Obtener los valores de los TextBox
                string nombre = txt_nomb.Text.Trim();
                string apellido = txt_apellido.Text.Trim();
                string correo = txt_correo.Text.Trim();
                string respuesta = txt_respuesta.Text.Trim();

                // Determinar el estado del usuario con los RadioButton
                int estado_usuario = rb_habilitado.Checked ? 1 : 0;

                // Obtener el id del usuario
                string idUsuario = txt_buscar.Text.Trim();

                // Llamar a la lógica para realizar la modificación
                bool exito = logica1.ModificarUsuario(idUsuario, nombre, apellido, correo, estado_usuario, respuesta);

                if (exito)
                {
                    MessageBox.Show("Registro modificado con éxito.");
                    limpiar();
                }
                else
                {
                    MessageBox.Show("Error al intentar modificar el registro.");
                }
            }
        }

        //---------------------------------------------------- Fin: GABRIELA SUC ----------------------------------------------------

        public string id, nombre, apellido, clave, correo, estadousuario, pregunta, respuesta;

        private void txt_estadousuario_TextChanged(object sender, EventArgs e)
        {

        }
        //********************** KATERYN DE LEON y Gabriela Suc ******************************
        private void Btn_ayuda_Click(object sender, EventArgs e)
        {
            //Help.ShowHelp(this, "C:\\Ayuda_Seguridad\\" + "CreacionUsuario.chm", "Creacion_Usuario.html");
            // Define el directorio base desde donde comenzar la búsqueda
            string baseDirectory = AppDomain.CurrentDomain.BaseDirectory; // Usando el directorio base del ejecutable

            // Imprime la ruta base para verificar
            MessageBox.Show("Ruta base: " + baseDirectory);

            // Busca el archivo .chm en el directorio base y sus subdirectorios
            string pathAyuda = FindFileInDirectory(baseDirectory, "Ayuda_Seguridad", "ayudaUsuarios.chm");

            // Imprimir la ruta generada para verificar
            MessageBox.Show("Ruta de ayuda: " + pathAyuda);

            // Verifica si el archivo existe antes de intentar abrirlo
            if (!string.IsNullOrEmpty(pathAyuda))
            {
                MessageBox.Show("El archivo sí está.");
                // Abre el archivo de ayuda .chm en la sección especificada
                Help.ShowHelp(this, pathAyuda, "Asignacion_Aplicaciones_Perfiles.html");
            }
            else
            {
                // Si el archivo no existe, muestra un mensaje de error
                MessageBox.Show("El archivo de ayuda no se encontró.");
            }
        }
        //********************** KATERYN DE LEON y Gabriela Suc ******************************
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
        //************************************** Fin KATERYN DE LEON y Gabriela Suc *********************************************************************

        private void txt_id_TextChanged(object sender, EventArgs e)
        {

        }

        private void txt_id_KeyPress(object sender, KeyPressEventArgs e)
        {
            validar.CampoAlfanumerico(e);
        }

        private void Button4_Click(object sender, EventArgs e)
        {
            //BOTON NUEVO

            txt_id.Enabled = false;

            txt_clave.Enabled = true;
            txt_nomb.Enabled = true;
            txt_apellido.Enabled = true;
            txt_nombreusername.Enabled = true;

            txt_buscar.Enabled = true;
            btn_buscar.Enabled = true;
            button2.Enabled = false;
            button3.Enabled = false;
            boton_ingreso = true;
            btn_guardar.Enabled = true;



            txt_correo.Enabled = true;
            txt_estadousuario.Enabled = true;
            txt_pregunta.Enabled = true;
            txt_respuesta.Enabled = true;


            //limpiar

            limpiar();

        }


        private string HashPasswordSHA256(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder builder = new StringBuilder();
                for (int i = 0; i < bytes.Length; i++)
                {
                    builder.Append(bytes[i].ToString("x2"));
                }
                return builder.ToString();
            }
        }

        private void Button1_Click(object sender, EventArgs e)
        {
            //**********************Kateryn De León************************/
            // BOTON GUARDAR

            nombre = txt_nomb.Text;////nombre usuario
            apellido = txt_apellido.Text;
            id = txt_nombreusername.Text;// nombre username

            clave = txt_clave.Text;

            correo = txt_correo.Text;  // Nueva línea para el correo
            DateTime fechaActual = DateTime.Now;
            string fecha = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"); ;
            // estadousuario = txt_estadousuario.Text;  // Nueva línea para el estado del usuario
            string estadousuario = "";//guarda lo del txt

            pregunta = txt_pregunta.Text;  // Nueva línea para la pregunta de seguridad
            respuesta = txt_respuesta.Text;  // Nueva línea para la respuesta de seguridad

            // int boton;

            if (txt_nomb.Text == " " || txt_nombreusername.Text == "" || txt_apellido.Text == "" || txt_clave.Text == "")//corregir aca
            {
                MessageBox.Show("Faltan Campos Por Llenar", "Verificación", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            }
            else if (clave.Length < 8)
            {
                MessageBox.Show("La contraseña debe de contener 8 caracteres como mínimo", "Verificación", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            }
            else
            {
                if (boton_ingreso == true)//boton_ingreso
                {
                    // boton = 1;

                    try
                    {
                        // Hash de la clave con SHA-256
                        string claveHasheada = HashPasswordSHA256(clave);

                        // Asegúrate de pasar la clave hasheada a la lógica

                        if (rb_habilitado.Checked)
                        {
                            estadousuario = "1";
                        }

                        if (rb_inhabilitado.Checked)
                        {
                            estadousuario = "0";
                        }
                        else
                        {
                            estadousuario = "1";
                        }

                        // Asegúrate de pasar todos los parámetros necesarios
                        DataTable dtusuario = logica1.usuarios(nombre, apellido, id, claveHasheada, correo, fecha, estadousuario, pregunta, respuesta);
                        string mensaje = //$"ID: {idd}\n" +//id del guardar
                       $"Nombre: {nombre}\n" +
                       $"Apellido: {apellido}\n" +
                       $"UserName: {id}\n" +
                       $"Clave Hasheada: {claveHasheada}\n" +
                       $"Correo: {correo}\n" +
                       $"Estado Usuario: {estadousuario}\n" +
                       $"Pregunta: {pregunta}\n" +
                       $"Respuesta: {respuesta}";

                        // Mostrar el mensaje en un MessageBox
                        MessageBox.Show(mensaje, "Detalles del Usuario", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        MessageBox.Show("Usuario Creado");
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine(ex);
                        return;
                    }
                }


                limpiar();
                txt_clave.Enabled = true;
                txt_nomb.Enabled = true;
                txt_apellido.Enabled = true;
                txt_nombreusername.Enabled = true;

                txt_buscar.Enabled = true;

                btn_buscar.Enabled = true;
                button2.Enabled = true;
                button3.Enabled = true;
                button4.Enabled = true;

                txt_correo.Enabled = true;
                txt_estadousuario.Enabled = true;
                txt_pregunta.Enabled = true;
                txt_respuesta.Enabled = true;
            }
        }

        private void Btn_salir_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
