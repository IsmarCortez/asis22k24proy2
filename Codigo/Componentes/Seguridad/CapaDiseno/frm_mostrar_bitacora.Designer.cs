namespace CapaDiseno
{
    partial class frm_mostrar_bitacora
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.Dgv_bitacora = new System.Windows.Forms.DataGridView();
            this.Txt_dato = new System.Windows.Forms.TextBox();
            this.Cbo_columna = new System.Windows.Forms.ComboBox();
            this.Lbl_columna = new System.Windows.Forms.Label();
            this.Lbl_dato = new System.Windows.Forms.Label();
            this.Dtp_dato = new System.Windows.Forms.DateTimePicker();
            this.Btn_borrarfiltros = new System.Windows.Forms.Button();
            this.Btn_buscar = new System.Windows.Forms.Button();
            this.Btn_actualizar = new System.Windows.Forms.Button();
            this.Dtp_hora = new System.Windows.Forms.DateTimePicker();
            this.btn_ayuda = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.Dgv_bitacora)).BeginInit();
            this.SuspendLayout();
            // 
            // Dgv_bitacora
            // 
            this.Dgv_bitacora.AllowUserToAddRows = false;
            this.Dgv_bitacora.AllowUserToDeleteRows = false;
            this.Dgv_bitacora.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill;
            this.Dgv_bitacora.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.Dgv_bitacora.Location = new System.Drawing.Point(19, 97);
            this.Dgv_bitacora.Name = "Dgv_bitacora";
            this.Dgv_bitacora.ReadOnly = true;
            this.Dgv_bitacora.RowHeadersWidth = 62;
            this.Dgv_bitacora.RowTemplate.Height = 28;
            this.Dgv_bitacora.Size = new System.Drawing.Size(1068, 487);
            this.Dgv_bitacora.TabIndex = 0;
            // 
            // Txt_dato
            // 
            this.Txt_dato.Location = new System.Drawing.Point(472, 46);
            this.Txt_dato.Name = "Txt_dato";
            this.Txt_dato.Size = new System.Drawing.Size(229, 35);
            this.Txt_dato.TabIndex = 2;
            // 
            // Cbo_columna
            // 
            this.Cbo_columna.FormattingEnabled = true;
            this.Cbo_columna.Location = new System.Drawing.Point(155, 46);
            this.Cbo_columna.Name = "Cbo_columna";
            this.Cbo_columna.Size = new System.Drawing.Size(226, 35);
            this.Cbo_columna.TabIndex = 3;
            this.Cbo_columna.SelectedIndexChanged += new System.EventHandler(this.Cbo_columna_SelectedIndexChanged);
            // 
            // Lbl_columna
            // 
            this.Lbl_columna.AutoSize = true;
            this.Lbl_columna.Location = new System.Drawing.Point(160, 20);
            this.Lbl_columna.Name = "Lbl_columna";
            this.Lbl_columna.Size = new System.Drawing.Size(298, 27);
            this.Lbl_columna.TabIndex = 5;
            this.Lbl_columna.Text = "Selecciona una columna";
            // 
            // Lbl_dato
            // 
            this.Lbl_dato.AutoSize = true;
            this.Lbl_dato.Location = new System.Drawing.Point(510, 20);
            this.Lbl_dato.Name = "Lbl_dato";
            this.Lbl_dato.Size = new System.Drawing.Size(189, 27);
            this.Lbl_dato.TabIndex = 6;
            this.Lbl_dato.Text = "Ingresa un dato";
            // 
            // Dtp_dato
            // 
            this.Dtp_dato.Location = new System.Drawing.Point(455, 46);
            this.Dtp_dato.Name = "Dtp_dato";
            this.Dtp_dato.Size = new System.Drawing.Size(258, 35);
            this.Dtp_dato.TabIndex = 7;
            this.Dtp_dato.Visible = false;
            // 
            // Btn_borrarfiltros
            // 
            this.Btn_borrarfiltros.BackgroundImage = global::CapaDiseno.Properties.Resources.borrar;
            this.Btn_borrarfiltros.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Zoom;
            this.Btn_borrarfiltros.FlatAppearance.BorderSize = 0;
            this.Btn_borrarfiltros.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.Btn_borrarfiltros.Location = new System.Drawing.Point(797, 25);
            this.Btn_borrarfiltros.Margin = new System.Windows.Forms.Padding(0);
            this.Btn_borrarfiltros.Name = "Btn_borrarfiltros";
            this.Btn_borrarfiltros.Size = new System.Drawing.Size(54, 53);
            this.Btn_borrarfiltros.TabIndex = 8;
            this.Btn_borrarfiltros.UseVisualStyleBackColor = true;
            this.Btn_borrarfiltros.Click += new System.EventHandler(this.Btn_borrarfiltros_Click);
            // 
            // Btn_buscar
            // 
            this.Btn_buscar.BackgroundImage = global::CapaDiseno.Properties.Resources.buscar;
            this.Btn_buscar.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Zoom;
            this.Btn_buscar.FlatAppearance.BorderSize = 0;
            this.Btn_buscar.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.Btn_buscar.Location = new System.Drawing.Point(741, 25);
            this.Btn_buscar.Margin = new System.Windows.Forms.Padding(0);
            this.Btn_buscar.Name = "Btn_buscar";
            this.Btn_buscar.Size = new System.Drawing.Size(54, 53);
            this.Btn_buscar.TabIndex = 4;
            this.Btn_buscar.UseVisualStyleBackColor = true;
            this.Btn_buscar.Click += new System.EventHandler(this.Btn_buscar_Click);
            // 
            // Btn_actualizar
            // 
            this.Btn_actualizar.BackgroundImage = global::CapaDiseno.Properties.Resources.actualizar;
            this.Btn_actualizar.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Zoom;
            this.Btn_actualizar.FlatAppearance.BorderSize = 0;
            this.Btn_actualizar.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.Btn_actualizar.Location = new System.Drawing.Point(874, 25);
            this.Btn_actualizar.Margin = new System.Windows.Forms.Padding(0);
            this.Btn_actualizar.Name = "Btn_actualizar";
            this.Btn_actualizar.Size = new System.Drawing.Size(54, 53);
            this.Btn_actualizar.TabIndex = 1;
            this.Btn_actualizar.UseVisualStyleBackColor = true;
            this.Btn_actualizar.Click += new System.EventHandler(this.button1_Click);
            // 
            // Dtp_hora
            // 
            this.Dtp_hora.Location = new System.Drawing.Point(455, 46);
            this.Dtp_hora.Name = "Dtp_hora";
            this.Dtp_hora.Size = new System.Drawing.Size(258, 35);
            this.Dtp_hora.TabIndex = 9;
            this.Dtp_hora.Visible = false;
            // 
            // btn_ayuda
            // 
            this.btn_ayuda.Image = global::CapaDiseno.Properties.Resources.icons8_ayuda_30;
            this.btn_ayuda.ImageAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.btn_ayuda.Location = new System.Drawing.Point(948, 33);
            this.btn_ayuda.Name = "btn_ayuda";
            this.btn_ayuda.Size = new System.Drawing.Size(86, 36);
            this.btn_ayuda.TabIndex = 257;
            this.btn_ayuda.Text = "Ayuda";
            this.btn_ayuda.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btn_ayuda.UseVisualStyleBackColor = true;
            this.btn_ayuda.Click += new System.EventHandler(this.btn_ayuda_Click);
            // 
            // frm_mostrar_bitacora
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(14F, 27F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1104, 596);
            this.Controls.Add(this.btn_ayuda);
            this.Controls.Add(this.Dtp_hora);
            this.Controls.Add(this.Btn_borrarfiltros);
            this.Controls.Add(this.Dtp_dato);
            this.Controls.Add(this.Lbl_dato);
            this.Controls.Add(this.Lbl_columna);
            this.Controls.Add(this.Btn_buscar);
            this.Controls.Add(this.Cbo_columna);
            this.Controls.Add(this.Txt_dato);
            this.Controls.Add(this.Btn_actualizar);
            this.Controls.Add(this.Dgv_bitacora);
            this.Font = new System.Drawing.Font("Century Gothic", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.Name = "frm_mostrar_bitacora";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Bitacora";
            this.Load += new System.EventHandler(this.Frm_mostrar_bitacora_Load);
            ((System.ComponentModel.ISupportInitialize)(this.Dgv_bitacora)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataGridView Dgv_bitacora;
        private System.Windows.Forms.Button Btn_actualizar;
        private System.Windows.Forms.TextBox Txt_dato;
        private System.Windows.Forms.ComboBox Cbo_columna;
        private System.Windows.Forms.Button Btn_buscar;
        private System.Windows.Forms.Label Lbl_columna;
        private System.Windows.Forms.Label Lbl_dato;
        private System.Windows.Forms.DateTimePicker Dtp_dato;
        private System.Windows.Forms.Button Btn_borrarfiltros;
        private System.Windows.Forms.DateTimePicker Dtp_hora;
        private System.Windows.Forms.Button btn_ayuda;
    }
}