// Autor: Cortez Huerta Gonzalo
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que calcula el Máximo Común Divisor (MCD)

// Equivalente en C#:
/*
using System;
using System.Runtime.InteropServices;

class MCDCalculator
{
    // Importar la función en ensamblador
    [DllImport("libcalculations.so", CallingConvention = CallingConvention.Cdecl)]
    public static extern long calcular_mcd(long a, long b);

    static void Main()
    {
        Console.Write("Ingrese el primer número: ");
        long a = Convert.ToInt64(Console.ReadLine());

        Console.Write("Ingrese el segundo número: ");
        long b = Convert.ToInt64(Console.ReadLine());

        long result = calcular_mcd(a, b);
        Console.WriteLine($"El MCD de {a} y {b} es: {result}");
    }
}
*/
.section .text
.global calcular_mcd

calcular_mcd:
    // Preservar registros
    stp x29, x30, [sp, #-16]!
    
    // x0: primer número
    // x1: segundo número
    
    // Verificar que x1 no sea 0
    cmp x1, #0
    beq .fin
    
.loop:
    // Algoritmo de Euclides
    udiv x2, x0, x1     // x2 = x0 / x1
    msub x2, x2, x1, x0 // x2 = x0 - (x2 * x1) [remainder]
    mov x0, x1          // x0 = x1
    mov x1, x2          // x1 = remainder
    
    cmp x1, #0          // Comparar si el remainder es 0
    bne .loop           // Si no es 0, continuar el loop
    
.fin:
    // Restaurar registros y retornar
    ldp x29, x30, [sp], #16
    ret
