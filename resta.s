// Autor: Cortez Huerta Gonzalo
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que resta dos numeros

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
    public static extern long resta(long a, long b);  // Nueva función resta

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
.global resta

resta:
    sub x0, x0, x1   // x0 = x0 - x1, almacena el resultado en x0
    ret
