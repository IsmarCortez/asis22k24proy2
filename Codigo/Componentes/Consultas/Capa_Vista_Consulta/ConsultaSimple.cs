using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Capa_Controlador_Consulta;
using System.Data.Odbc;

/*

    Forma creada por Carlos González y Salvador Martínez

 */

namespace Capa_Vista_Consulta
{
    public partial class ConsultaSimple : Form
    {
        consultaControlador csControlador = new consultaControlador();
        private string[] datos;
        private string[] tipos;
        public string BD;
        private string consultaSeleccionada;

        public ConsultaSimple(string Tabla)
        {
            InitializeComponent();
            BD = Tabla;
            tipos = new string[] { "nombre_consulta", "tipo_consulta", "consulta_SQLE", "consulta_estatus" };
            csControlador.CargarTablas(cboTabla2, BD);
            csControlador.CargarTablas(cboEditarTabla2, BD);
            cboTabla2.SelectedIndexChanged += new EventHandler(cboTabla_SelectedIndexChanged);
            ActualizarComboBox();
            csControlador.obtenerNombresConsultas(cboEditarNombreConsulta2);
            cboEditarTabla2.SelectedIndexChanged += new EventHandler(cboTablaEditar_SelectedIndexChanged);
            cboEditarNombreConsulta2.SelectedIndexChanged += new EventHandler(cboConsultas_SelectedIndexChanged);
            //Agregado por sebastian luna
            var tt = new ToolTip();
            tt.SetToolTip(btnCancelarEditar2, "Borrar");
            tt.SetToolTip(btnEditar2, "Editar");
            tt.SetToolTip(btnEditarSimple2, "Agregar");
            tt.SetToolTip(btnEditarCampoSimple2, "Agregar Campos");
            tt.SetToolTip(btnCancelarEditarSimple2, "Cancelar");
            tt.SetToolTip(btnConsultarEditar2, "Consultar");
            tt.SetToolTip(btnNuevo2, "Agregar");
            tt.SetToolTip(btnAgregarConsultaSimple2, "Agregar Campos");
            tt.SetToolTip(btnCancelarSimple2, "Cancelar");
            tt.SetToolTip(btnCancelar2, "Cancelar");
            tt.SetToolTip(btnCrear2, "Crear");
            tt.SetToolTip(btnConsultar2, "Consultar");
        }
        private void ActualizarComboBox()
        {
            csControlador.obtenerNombresConsultas(cboEditarNombreConsulta2);
        }
        string tabla = "tbl_consultaInteligente";
        private void cboTabla_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Verifica si se ha seleccionado una tabla
            if (!string.IsNullOrEmpty(cboTabla2.Text))
            {
                // Llama al método para llenar el segundo ComboBox con las columnas de la tabla seleccionada
                csControlador.obtenerColumbasPorTabla(cboCampos2, cboTabla2.Text);
            }
        }
        private void ConsultaSimple_Load(object sender, EventArgs e)
        {

        }

        private void btnNuevo2_Click(object sender, EventArgs e)
        {
            //boton agregar, consulta simple
            datos = new string[] { txtNombreConsulta2.Text, "0", cboTabla2.Text, chbTodosCampos2.Text, txtQueryFinal2.Text, "1" };
            string camposSeleccionados;// Inicializamos la variable para los campos que se mostrarán en el query
            if (chbTodosCampos2.Checked)// Verificamos si el CheckBox de 'Todos los campos' está marcado
            {
                camposSeleccionados = "*";// Si está marcado, mostramos "Todos los campos"
            }
            else
            {
                // Si no está marcado, verificamos si hay un campo seleccionado en el ComboBox
                if (!string.IsNullOrEmpty(cboCampos2.Text))
                {
                    // Si hay un campo seleccionado, lo mostramos
                    camposSeleccionados = cboCampos2.Text;
                }
                else
                {
                    // Si no hay campo seleccionado, dejamos un valor vacío o un mensaje de advertencia
                    MessageBox.Show("Debe seleccionar o un campo o todos", "Advertencia", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }
            }

            if (string.IsNullOrEmpty(txtQuery2.Text))
            {
                // Si txtQuery está vacío, asignamos el valor inicial
                txtQuery2.Text = camposSeleccionados + " + " + txtAlias2.Text + " + ";
                datos[4] = txtQuery2.Text;
            }
            else
            {
                // Si txtQuery ya tiene texto, agregamos el nuevo valor sin repetir el nombre de la consulta y el tipo
                txtQuery2.Text += Environment.NewLine + camposSeleccionados + " + " + txtAlias2.Text + " + ";
                datos[4] += txtQuery2.Text;
            }
            // Procesar los datos en la tabla correspondiente
            csControlador.ingresar(tipos, datos, tabla);
        }

        private void btnAgregarConsultaSimple2_Click(object sender, EventArgs e)
        {
            string queryGenerado = csControlador.GenerarQuerySimple(datos);
            txtQueryFinal2.Text = queryGenerado;
        }

        private void btnCancelarSimple2_Click(object sender, EventArgs e)
        {
            datos = new string[0];
            txtNombreConsulta2.Clear();
            cboTabla2.ResetText();
            cboCampos2.ResetText();
            txtAlias2.Clear();
            chbTodosCampos2.Checked = false;
            txtQuery2.Clear();
        }

        private void btnCrear2_Click(object sender, EventArgs e)
        {
            csControlador.InsertarDatos(tipos, datos, tabla);
            ActualizarComboBox();
        }

        private void btnCancelar2_Click(object sender, EventArgs e)
        {
            datos = new string[0];
            txtNombreConsulta2.Clear();
            cboTabla2.ResetText();
            cboCampos2.ResetText();
            txtAlias2.Clear();
            chbTodosCampos2.Checked = false;
            txtQuery2.Clear();
            txtQueryFinal2.Clear();
            dgvConsultar2.DataSource = null;
            dgvConsultar2.Rows.Clear();
        }

        private void btnConsultar2_Click(object sender, EventArgs e)
        {
            consultaControlador controlador = new consultaControlador();
            string querySeleccionado = txtNombreConsulta2.Text;
            controlador.BuscarQuerySeleccionado(querySeleccionado, dgvConsultar2, txtQueryFinal2);
        }

        private void button1_Click(object sender, EventArgs e)
        {

        }

        private void btnCancelarEditar_Click(object sender, EventArgs e)
        {

        }

        private void btnEditar_Click_1(object sender, EventArgs e)
        {

        }

        private void chbEditarDescendente_CheckedChanged(object sender, EventArgs e)
        {

        }

        private void btnEditarOrdenar_Click(object sender, EventArgs e)
        {

        }

        private void checkBox6_CheckedChanged(object sender, EventArgs e)
        {

        }

        private void btnEditarComparacion_Click(object sender, EventArgs e)
        {

        }

        private void btnEditarLogico_Click(object sender, EventArgs e)
        {

        }

        private void cboQuery2_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void button17_Click(object sender, EventArgs e)
        {

        }

        private void btnEditarCampoSimple_Click(object sender, EventArgs e)
        {

        }

        private void btnEditarSimple_Click(object sender, EventArgs e)
        {

        }

        private void btnEditarSimple2_Click(object sender, EventArgs e)
        {
            //boton agregar, consulta simple
            // Datos que se van a procesar
            datos = new string[] { cboEditarNombreConsulta2.Text, "0", cboEditarTabla2.Text, chbTodosCampos2.Text, txtQueryEditadoFinal2.Text, "1" };
            // Inicializamos la variable para los campos que se mostrarán en el query
            string camposSeleccionados;
            // Verificamos si el CheckBox de 'Todos los campos' está marcado
            if (chbEditarTodosCampos2.Checked)
            {
                // Si está marcado, mostramos "Todos los campos"
                camposSeleccionados = "*";
            }
            else
            {
                // Si no está marcado, verificamos si hay un campo seleccionado en el ComboBox
                if (!string.IsNullOrEmpty(cboEditarCampo2.Text))
                {
                    // Si hay un campo seleccionado, lo mostramos
                    camposSeleccionados = cboEditarCampo2.Text;
                }
                else
                {
                    // Si no hay campo seleccionado, dejamos un valor vacío o un mensaje de advertencia
                    MessageBox.Show("Debe seleccionar o un campo o todos", "Advertencia", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }
            }
            if (string.IsNullOrEmpty(txtQueryEditado2.Text))
            {
                // Si txtQuery está vacío, asignamos el valor inicial
                txtQueryEditado2.Text = camposSeleccionados + " + " + txtEditarAlias2.Text + " + ";
                datos[4] = txtQueryEditado2.Text;
            }
            else
            {
                // Si txtQuery ya tiene texto, agregamos el nuevo valor sin repetir el nombre de la consulta y el tipo
                txtQueryEditado2.Text += Environment.NewLine + camposSeleccionados + " + " + txtEditarAlias2.Text + " + ";
                datos[4] += txtQueryEditado2.Text;
            }
            // Procesar los datos en la tabla correspondiente
            csControlador.ingresar(tipos, datos, tabla);
        }

        private void btnEditarCampoSimple2_Click(object sender, EventArgs e)
        {

            string queryGenerado = csControlador.GenerarQuerySimple(datos);
            txtQueryEditadoFinal2.Text = queryGenerado;



        }

        private void btnCancelarEditarSimple2_Click(object sender, EventArgs e)
        {

            datos = new string[0];
            cboEditarTabla2.ResetText();
            cboEditarCampo2.ResetText();
            txtEditarAlias2.Clear();
            chbTodosCampos2.Checked = false;
            txtQueryEditado2.Clear();




        }

        private void btnEditar2_Click(object sender, EventArgs e)
        {
            // Asegúrate de que consultaSeleccionada tiene un valor válido
            if (string.IsNullOrEmpty(consultaSeleccionada))
            {
                MessageBox.Show("Debe seleccionar una consulta para editar.", "Advertencia", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            // Actualiza datos con la consulta seleccionada
            datos[0] = consultaSeleccionada; // Suponiendo que datos[0] es el nombre de la consulta
            // Procesar los datos en la tabla correspondiente
            csControlador.ActualizarDatos(tipos, datos, tabla);
            ActualizarComboBox();





        }

        private void btnCancelarEditar2_Click(object sender, EventArgs e)
        {
            datos = new string[0];
            cboEditarTabla2.ResetText();
            cboEditarCampo2.ResetText();
            txtEditarAlias2.Clear();
            chbEditarTodosCampos2.Checked = false;
            txtQueryEditado2.Clear();
            txtQueryEditadoFinal2.Clear();


        }

        private void btnConsultarEditar2_Click(object sender, EventArgs e)
        {
            consultaControlador controlador = new consultaControlador();
            string querySeleccionado = cboEditarNombreConsulta2.SelectedItem.ToString();
            controlador.BuscarQuerySeleccionado(querySeleccionado, dgvMostrar2, txtQueryEditadoFinal2);


        }



            private void cboTablaEditar_SelectedIndexChanged(object sender, EventArgs e)
            {
                // Verifica si se ha seleccionado una tabla
                if (!string.IsNullOrEmpty(cboEditarTabla2.Text))
                {
                    // Llama al método para llenar el segundo ComboBox con las columnas de la tabla seleccionada
                    csControlador.obtenerColumbasPorTabla(cboEditarCampo2, cboEditarTabla2.Text);


                }
        }

        private void cboConsultas_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Captura el nombre de la consulta seleccionada
           
            string nombreConsulta2 = cboEditarNombreConsulta2.Text;
            // Guardar el nombre de la consulta en una variable de instancia
           
            consultaSeleccionada = nombreConsulta2;
        }

        private void groupBox8_Enter(object sender, EventArgs e)
        {

        }
    }
}
