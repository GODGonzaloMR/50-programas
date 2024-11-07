// Autor: Cortez Huerta Gonzalo
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que verifica si un número es primo

// Equivalente en C#:
/*
using System;
using System.Runtime.InteropServices;

class Program
{
    // Importar función de verificación de número primo desde la biblioteca compartida
    [DllImport("libcalculations.so")]
    public static extern bool es_primo(long n);  // Importación de la función es_primo

    static void Main()
    {
        // Verificar si un número es primo
        Console.Write("Ingresa un número para verificar si es primo: ");
        if (long.TryParse(Console.ReadLine(), out long numero) && numero >= 2)
        {
            bool resultado = es_primo(numero);
            Console.WriteLine(resultado ? $"{numero} es primo." : $"{numero} no es primo.");
        }
        else
        {
            Console.WriteLine("Entrada no válida. Debe ser un número entero mayor o igual a 2.");
        }
    }
}
*/
.section .data
.section .text
.global es_primo

es_primo:
    cmp x0, 2                 // Comparar n con 2
    blt not_prime             // Si n < 2, no es primo
    cmp x0, 2                 // Comparar n con 2 nuevamente
    beq is_prime              // Si n == 2, es primo

    mov x1, 2                 // Inicializar divisor en 2

check_division:
    mul x2, x1, x1            // Calcular divisor^2 en x2
    cmp x2, x0                // Si divisor^2 > n, no más divisores posibles
    bgt is_prime

    // Verificar si n % divisor == 0
    mov x2, x0                // Copiar n a x2
    udiv x2, x2, x1           // x2 = n / divisor
    msub x3, x2, x1, x0       // x3 = n - (x2 * divisor)
    cbz x3, not_prime         // Si n % divisor == 0, no es primo

    add x1, x1, 1             // Incrementar divisor
    b check_division          // Repetir el ciclo

is_prime:
    mov w0, 1                 // Retornar 1 si es primo
    ret

not_prime:
    mov w0, 0                 // Retornar 0 si no es primo
    ret
