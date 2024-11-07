// Autor: Cortez Huerta Gonzalo
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que divide dos números

// Equivalente en C#:
/*
using System;
using System.Runtime.InteropServices;

class Program
{
    // Importar las funciones desde la biblioteca compartida
    [DllImport("libcalculations.so")]
    public static extern long suma(long a, long b);

    [DllImport("libcalculations.so")]
    public static extern long resta(long a, long b);

    [DllImport("libcalculations.so")]
    public static extern long multiplicacion(long a, long b);

    [DllImport("libcalculations.so")]
    public static extern long division(long a, long b);  // Nueva función de división

    static void Main()
    {
        Console.Write("Ingresa el primer número: ");
        if (long.TryParse(Console.ReadLine(), out long num1))
        {
            Console.Write("Ingresa el segundo número: ");
            if (long.TryParse(Console.ReadLine(), out long num2))
            {
                long resultadoSuma = suma(num1, num2);
                Console.WriteLine($"La suma de {num1} y {num2} es: {resultadoSuma}");

                long resultadoResta = resta(num1, num2);
                Console.WriteLine($"La resta de {num1} y {num2} es: {resultadoResta}");

                long resultadoMultiplicacion = multiplicacion(num1, num2);
                Console.WriteLine($"La multiplicación de {num1} y {num2} es: {resultadoMultiplicacion}");

                long resultadoDivision = division(num1, num2);
                Console.WriteLine($"La división de {num1} y {num2} es: {resultadoDivision}");
            }
            else
            {
                Console.WriteLine("Entrada no válida para el segundo número.");
            }
        }
        else
        {
            Console.WriteLine("Entrada no válida para el primer número.");
        }
    }
}
*/
.section .data
.section .text
.global division

division:
    // Verificar si el divisor (x1) es cero
    cbz x1, divisor_cero // Si x1 es cero, saltar a divisor_cero
    sdiv x0, x0, x1      // x0 = x0 / x1, almacena el resultado en x0
    ret                   // Retornar

divisor_cero:
    mov x0, 0            // Si el divisor es cero, retornar 0
    ret
