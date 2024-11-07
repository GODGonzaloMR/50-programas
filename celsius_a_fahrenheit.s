// Autor: Cortez Huerta Gonzalo
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que convierte celcius a fahrenheit

// Equivalente en C#:
/*
using System;
using System.Runtime.InteropServices;

class Program
{
    // Importar la función celsius_a_fahrenheit de la biblioteca compartida
    [DllImport("libcelsius.so")]
    public static extern long celsius_a_fahrenheit(long celsius);

    static void Main()
    {
        Console.Write("Ingresa la temperatura en Celsius: ");
        if (long.TryParse(Console.ReadLine(), out long celsius))
        {
            long fahrenheit = celsius_a_fahrenheit(celsius);
            Console.WriteLine($"{celsius}°C es igual a {fahrenheit}°F");
        }
        else
        {
            Console.WriteLine("Entrada no válida.");
        }
    }
}
*/
.section .data
.section .text
.global celsius_a_fahrenheit

celsius_a_fahrenheit:
    // Multiplicación de Celsius * 9
    mov x1, #9              // Cargar 9 en x1
    mul x0, x0, x1          // Celsius * 9

    // División por 5
    mov x1, #5              // Cargar 5 en x1
    udiv x0, x0, x1         // (Celsius * 9) / 5

    // Sumar 32
    add x0, x0, #32         // ((Celsius * 9) / 5) + 32

    ret
 
