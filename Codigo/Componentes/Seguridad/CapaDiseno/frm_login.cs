using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using CapaDatos;
using CapaLogica;
using System.Security.Cryptography;

using System.IO; // Necesario para Directory, File, Path y SearchOption
using System.Windows.Forms; // Necesario para MessageBox y Help

namespace CapaDiseno
{
    public partial class frm_login : Form
    {
        public string bExito = "Pendiente";

        public frm_login()
        {
            InitializeComponent();
            Txt_clave.UseSystemPasswordChar = true;

            // Vincula el evento KeyPress
            Txt_clave.KeyPress += new KeyPressEventHandler(Txt_clave_KeyPress);
        }

        string nombreUsuario = "";
        public string obtenerNombreUsuario()
        {
            nombreUsuario = Txt_usuario.Text;
            return nombreUsuario;
        }

        //Fernando García 0901-21-581 y Brandon Boch 0901-21-13093//


        private void Frm_login_FormClosing(object sender, FormClosingEventArgs e)
        {
            
        }


        private void Btn_entrar_Click_1(object sender, EventArgs e)
        {
            ProcedimientoLogin procedimientoLogin = new ProcedimientoLogin();

            if (Txt_usuario.Text.Trim() == "")
            {
                MessageBox.Show("Debe ingresar un usuario");
            }
            else
            {
                if (Txt_clave.Text.Trim() == "")
                {
                    MessageBox.Show("Debe ingresar su contraseña");
                }
                else
                {
                    try
                    {
                        // Hashear la contraseña antes de enviarla al procedimiento
                        string claveHasheada = HashPasswordSHA256(Txt_clave.Text.Trim());

                        bool bExisteUsuario = procedimientoLogin.llamarProcedimiento(Txt_usuario.Text, claveHasheada);

                        if (bExisteUsuario)
                        {
                            // Ocultar el formulario de login en lugar de cerrarlo
                            this.Hide();

                            sentencia s = new sentencia();
                            s.insertarBitacora(Txt_usuario.Text.Trim(), "Se logeo al sistema", "Login");

                            // Pasa el nombre de usuario al constructor de MDI_Seguridad
                            MDI_Seguridad formMDI = new MDI_Seguridad(Txt_usuario.Text);
                            formMDI.Show();
                        }
                        else
                        {
                            MessageBox.Show("Usuario o Contraseña Incorrecta", "Verificación de Login", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                        }
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine(ex);
                        MessageBox.Show("No se pudo conectar a la base de datos", "Error de conexión", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                    }
                }
            }
        }

        // Método para hashear la contraseña usando SHA-256
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

        private void Btn_cancelar_Click_1(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void Cb_ver_password_CheckedChanged_1(object sender, EventArgs e)
        {
            if (Cb_ver_password.Checked == false)
            {
                Txt_clave.UseSystemPasswordChar = true;
            }
            else
            {
                Txt_clave.UseSystemPasswordChar = false;
            }
        }
        //********************** KATERYN DE LEON y Gabriela Suc ******************************
        private void button1_Click(object sender, EventArgs e)
        { //boton guardar
            //Help.ShowHelp(this, "C:\\Ayuda_Seguridad\\" + "ayudaLogin.chm", "login.html");
            
            // Define el directorio base desde donde comenzar la búsqueda
            string baseDirectory = AppDomain.CurrentDomain.BaseDirectory; // Usando el directorio base del ejecutable

            // Imprime la ruta base para verificar
            MessageBox.Show("Ruta base: " + baseDirectory);

            // Busca el archivo en el directorio base y sus subdirectorios
            string pathAyuda = FindFileInDirectory(baseDirectory, "Ayuda_Seguridad", "AyudaLogin.chm");

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
        { // parte del boton guardar
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

        private void Btn_olvidocontrasenia_Click_1(object sender, EventArgs e)
        {
            // Mostrar el formulario de entrada con una pregunta
            using (var frm_cambio_contrasenia = new frm_cambio_contrasenia("Por favor, ingresa tu usuario:"))
            {
                if (frm_cambio_contrasenia.ShowDialog() == DialogResult.OK)
                {
                    // Obtener el resultado del formulario
                    string nombre = frm_cambio_contrasenia.Resultado;
                    MessageBox.Show("El nombre ingresado es: " + nombre);
                }
                /*else
                {
                    MessageBox.Show("Entrada cancelada.");
                }*/
            }
        }

        private void Txt_clave_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == (char)Keys.Enter)
            {
                Btn_entrar_Click_1(sender, e); // Llama al método de login al presionar Enter
            }
        }

        private void frm_login_Load(object sender, EventArgs e)
        {

        }
    }
}
