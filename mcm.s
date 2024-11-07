// Autor: Cortez Huerta Gonzalo
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que calcula  Mínimo Común Múltiplo (MCM)

// Equivalente en C#:
/*
// mcm.cs - C# para invocar el ensamblador ARM64 y calcular el MCM
using System;
using System.Runtime.InteropServices;

class Program
{
    // Importar la función mcm desde el archivo ensamblador
    [DllImport("mcm.so", EntryPoint = "mcm")]
    private static extern long MCM(long a, long b);

    static void Main()
    {
        Console.WriteLine("Introduce dos números:");
        Console.Write("a: ");
        long a = Convert.ToInt64(Console.ReadLine());
        Console.Write("b: ");
        long b = Convert.ToInt64(Console.ReadLine());

        long result = MCM(a, b);
        Console.WriteLine($"El MCM de {a} y {b} es: {result}");
    }
}
*/
// mcm.s - Ensamblador ARM64 para calcular el MCM

.global mcm

// Calcula el MCM de dos números a y b
mcm:
    // Guardar registros
    stp x29, x30, [sp, -16]!
    mov x29, sp

    // Guardar valores iniciales en registros para el cálculo
    mov x2, x0          // x2 = a
    mov x3, x1          // x3 = b

    // Calcular el producto a * b y guardarlo en x4
    mul x4, x2, x3      // x4 = a * b

    // Llamar a la función mcd para obtener el MCD
    bl mcd              // Resultado del MCD está en x0 después de la llamada

    // Dividir el producto (a * b) entre el MCD para obtener el MCM
    udiv x0, x4, x0     // MCM almacenado en x0

    // Restaurar registros y retornar
    ldp x29, x30, [sp], 16
    ret

// Función para calcular el MCD usando el Algoritmo de Euclides
mcd:
    // x0 = a, x1 = b
    cmp x1, 0
    b.eq mcd_done
mcd_loop:
    mov x2, x1
    udiv x3, x0, x1     // x3 = x0 / x1
    msub x1, x3, x1, x0 // x1 = x0 - (x3 * x1)
    mov x0, x2
    cbnz x1, mcd_loop
mcd_done:
    ret
