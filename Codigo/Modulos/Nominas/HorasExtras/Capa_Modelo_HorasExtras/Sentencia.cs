using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Data.Odbc;

namespace Capa_Modelo_HorasExtras
{


        public  class Sentencia {

        private Conexion cn = new Conexion();//conexion con la BD

        //*******************************Kateryn De Leon************************************************
        public decimal CalcularHorasExtras(string mes)
        {
            decimal totalHorasExtras = 0;

            using (var connection = cn.conectar())
            {
                if(connection.State == System.Data.ConnectionState.Closed)
            {
                    connection.Open();
                }

                // Consulta para obtener el salario y cantidad de horas por empleado para el mes especificado
                string query = @"
                 SELECT e.pk_clave, c.contratos_salario, h.horas_cantidad_horas
                FROM tbl_horas_extra h
                INNER JOIN tbl_empleados e ON e.pk_clave = h.fk_clave_empleado
                INNER JOIN tbl_contratos c ON e.pk_clave = c.fk_clave_empleado
                WHERE h.horas_mes = ?";

                using (var command = new OdbcCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@mes", mes);

                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            int fkClaveEmpleado = reader.GetInt32(0);
                            decimal salario = reader.GetDecimal(1);
                            decimal cantidadHoras = reader.GetDecimal(2);
                            decimal pagoHoraExtra = (salario / 30 / 8) * 1.5m * cantidadHoras;

                            totalHorasExtras += pagoHoraExtra;
                            // Llama al método para insertar o actualizar cada registro de horas extras
                            GuardarHorasExtrasEmpleado(connection, fkClaveEmpleado, pagoHoraExtra);


                        }
                    }
                }  
                
                // Para asegurarse de que la conexión esté cerrada después de ejecutar el comando
                if (connection.State == System.Data.ConnectionState.Open) {
                    connection.Close();
                }
            }

            return totalHorasExtras;
        }
        private void GuardarHorasExtrasEmpleado(OdbcConnection connection, int fkClaveEmpleado, decimal pagoHoraExtra)
        {
             // consulta donde inserta el regirto en la tbl_dedu_perp_emp
            string queryInsertUpdate = @"
            INSERT IGNORE INTO tbl_dedu_perp_emp (Fk_clave_empleado, Fk_dedu_perp, dedu_perp_emp_cantidad, estado)
            VALUES (?, (SELECT pk_dedu_perp FROM tbl_dedu_perp WHERE dedu_perp_concepto = 'Horas Extras' LIMIT 1), ?, 1)
            ON DUPLICATE KEY UPDATE 
                dedu_perp_emp_cantidad = VALUES(dedu_perp_emp_cantidad), 
                estado = 1;";

            using (var command = new OdbcCommand(queryInsertUpdate, connection))
            {
                command.Parameters.AddWithValue("@Fk_clave_empleado", fkClaveEmpleado);
                command.Parameters.AddWithValue("@dedu_perp_emp_cantidad", pagoHoraExtra);

                command.ExecuteNonQuery();
            }
        }

        //************************************************************************************

    }
}
