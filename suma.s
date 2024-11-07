// Autor: Cortez Huerta Gonzalo
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que suma dos números

// Equivalente en C#:
/*
using System;
using System.Runtime.InteropServices;

class Program
{
    [DllImport("libcalculations.so")]
    public static extern long suma(long a, long b);

    static void Main()
    {
        Console.Write("Ingresa el primer número: ");
        if (long.TryParse(Console.ReadLine(), out long num1))
        {
            Console.Write("Ingresa el segundo número: ");
            if (long.TryParse(Console.ReadLine(), out long num2))
            {
                long resultado = suma(num1, num2);
                Console.WriteLine($"La suma de {num1} y {num2} es: {resultado}");
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
.global suma

suma:
    add x0, x0, x1   // x0 = x0 + x1, almacena el resultado en x0
    ret
