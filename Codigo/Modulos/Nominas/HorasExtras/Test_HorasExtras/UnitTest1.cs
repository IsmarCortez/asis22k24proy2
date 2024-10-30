using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;

namespace Test_HorasExtras
{
    [TestClass]
    public class UnitTest1
    {
        [TestMethod]
        public void TestHorasExtras()
        {

            // Arrange: Preparar datos de prueba
            decimal salario = 5000.00m; // Ejemplo de salario mensual yo le puse 5000
            decimal cantidadHorasExtras = 10; // Cantidad de horas extras trabajadas en el mes

            // Cálculo del valor esperado de horas extras
            decimal pagoPorHora = salario / 30 / 8;
            decimal expectedPagoHorasExtras = pagoPorHora * 1.5m * cantidadHorasExtras;

            // Act: Ejecutar el cálculo del pago de horas extras
            decimal resultado = pagoPorHora * 1.5m * cantidadHorasExtras;

            // Assert: Comprobar que el resultado sea el esperado
            Assert.AreEqual(expectedPagoHorasExtras, resultado, "El cálculo de horas extras no es correcto.");
            Console.WriteLine($"Valor esperado de horas extras: {expectedPagoHorasExtras}"); //para que se pueda ver el resultado y tiene que da 312.500



        }


    }
}
