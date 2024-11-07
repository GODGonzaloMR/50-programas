// Autor: Cortez Huerta Gonzalo
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que hace Generación de números aleatorios (con semilla)

// Equivalente en C#:
/*
using System;
using System.Runtime.InteropServices;

class RandomGenerator
{
    // Importar la función de ensamblador para generar un número pseudoaleatorio
    [DllImport("semilla.so")]
    public static extern int GenerarAleatorio(int semilla);

    static void Main()
    {
        Console.Write("Introduce una semilla: ");
        int semilla = int.Parse(Console.ReadLine());

        Console.Write("¿Cuántos números aleatorios deseas generar? ");
        int cantidad = int.Parse(Console.ReadLine());

        Console.WriteLine("Números aleatorios generados:");
        for (int i = 0; i < cantidad; i++)
        {
            semilla = GenerarAleatorio(semilla);  // Actualiza la semilla para el siguiente número
            Console.WriteLine(semilla);
        }
    }
}
*/
.global GenerarAleatorio

GenerarAleatorio:
    // w0 contiene la semilla de entrada

    // Cargar el valor 1103515245 en w1 usando instrucciones separadas
    movz w1, 0x49E3        // Parte inferior del número (16 bits)
    movk w1, 0x4E35, lsl #16  // Parte superior del número (añadir a los bits altos)

    mov w2, 12345          // Incremento

    // Realizar el cálculo: semilla = (semilla * 1103515245 + 12345) & 0x7FFFFFFF
    mul w0, w0, w1         // Multiplica semilla por 1103515245
    add w0, w0, w2         // Suma 12345
    and w0, w0, 0x7FFFFFFF // Asegurarse de que esté en el rango de 0 a 2^31-1
    ret
