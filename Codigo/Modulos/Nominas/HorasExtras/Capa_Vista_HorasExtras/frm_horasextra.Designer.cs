
namespace Capa_Vista_HorasExtras
{
    partial class frm_horasextra
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
            this.label1 = new System.Windows.Forms.Label();
            this.Cbo_mes = new System.Windows.Forms.ComboBox();
            this.Txt_calculohoras = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(209, 150);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(50, 25);
            this.label1.TabIndex = 0;
            this.label1.Text = "Mes";
            // 
            // Cbo_mes
            // 
            this.Cbo_mes.FormattingEnabled = true;
            this.Cbo_mes.Location = new System.Drawing.Point(328, 143);
            this.Cbo_mes.Name = "Cbo_mes";
            this.Cbo_mes.Size = new System.Drawing.Size(216, 32);
            this.Cbo_mes.TabIndex = 1;
            this.Cbo_mes.SelectedIndexChanged += new System.EventHandler(this.Cbo_mes_SelectedIndexChanged);
            // 
            // Txt_calculohoras
            // 
            this.Txt_calculohoras.Location = new System.Drawing.Point(380, 236);
            this.Txt_calculohoras.Name = "Txt_calculohoras";
            this.Txt_calculohoras.Size = new System.Drawing.Size(205, 29);
            this.Txt_calculohoras.TabIndex = 2;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(128, 240);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(195, 25);
            this.label2.TabIndex = 3;
            this.label2.Text = "Calculo Horas Extras";
            this.label2.Click += new System.EventHandler(this.label2_Click);
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(110, 60);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(538, 32);
            this.label3.TabIndex = 4;
            this.label3.Text = "Formulario de Calculo de Horas Extras";
            // 
            // frm_horasextra
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(11F, 24F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.LightGray;
            this.ClientSize = new System.Drawing.Size(743, 421);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.Txt_calculohoras);
            this.Controls.Add(this.Cbo_mes);
            this.Controls.Add(this.label1);
            this.Name = "frm_horasextra";
            this.Text = "frm_horasextra";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.ComboBox Cbo_mes;
        private System.Windows.Forms.TextBox Txt_calculohoras;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
    }
}