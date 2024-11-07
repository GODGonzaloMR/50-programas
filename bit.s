// Autor: Cortez Huerta Gonzalo
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que cuenta los bits activados en un número

// Equivalente en C#:
/*
using System;
using System.Runtime.InteropServices;

class BitCounter
{
    // Importar la función en ensamblador
    [DllImport("libcalculations.so", CallingConvention = CallingConvention.Cdecl)]
    public static extern long contar_bits(long number);

    static void Main()
    {
        Console.Write("Ingrese un número: ");
        long number = Convert.ToInt64(Console.ReadLine());

        long result = contar_bits(number);
        Console.WriteLine($"El número de bits activados en {number} es: {result}");
    }
}
*/
.section .text
.global contar_bits

contar_bits:
    mov x1, 0          // Contador de bits activados
    mov x2, x0         // Copia el número a x2

.loop:
    and x3, x2, #1     // Verifica el bit menos significativo
    add x1, x1, x3     // Incrementa el contador si el bit es 1
    lsr x2, x2, #1     // Desplaza a la derecha
    cbnz x2, .loop     // Si x2 no es cero, continúa

    mov x0, x1         // El resultado se almacena en x0
    ret
