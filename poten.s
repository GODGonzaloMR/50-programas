// Autor: Cortez Huerta Gonzalo
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que calcula la potencia de los numeros
//  Potencia (x^n)

// Equivalente en C#:
/*
// poten.cs - C# para invocar el ensamblador ARM64 y calcular la potencia x^n
using System;
using System.Runtime.InteropServices;

class Program
{
    // Importar la función potencia desde el archivo ensamblador
    [DllImport("poten.so", EntryPoint = "potencia")]
    private static extern long Potencia(long x, long n);

    static void Main()
    {
        Console.WriteLine("Introduce la base y el exponente:");
        Console.Write("Base (x): ");
        long x = Convert.ToInt64(Console.ReadLine());
        Console.Write("Exponente (n): ");
        long n = Convert.ToInt64(Console.ReadLine());

        long result = Potencia(x, n);
        Console.WriteLine($"{x}^{n} es: {result}");
    }
}
*/
// poten.s - Ensamblador ARM64 para calcular la potencia x^n

.global potencia

// Calcula la potencia x^n (x en x0, n en x1, resultado en x0)
potencia:
    // Guardar registros
    stp x29, x30, [sp, -16]!
    mov x29, sp

    // Verificar si el exponente (n) es 0
    cmp x1, 0
    b.eq potencia_base_cero // Si n es 0, devolver 1

    // Inicializar el resultado en x2 con x (base)
    mov x2, x0

potencia_loop:
    // Decrementar el exponente (n)
    sub x1, x1, 1
    cmp x1, 0
    b.eq potencia_done      // Si n llega a 0, salir del bucle

    // Multiplicar el resultado actual por x (base)
    mul x2, x2, x0
    b potencia_loop         // Repetir el bucle

potencia_base_cero:
    mov x2, 1               // Si n es 0, x^0 = 1

potencia_done:
    // Mover el resultado a x0
    mov x0, x2

    // Restaurar registros y retornar
    ldp x29, x30, [sp], 16
    ret
