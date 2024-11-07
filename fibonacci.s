// Autor: Cortez Huerta Gonzalo
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que hace una secuencia en FIBONACCI

// Equivalente en C#:
/*
using System;

class Program
{
    static void MostrarSecuenciaFibonacci(int n)
    {
        if (n < 0)
        {
            Console.WriteLine("Por favor ingrese un número no negativo.");
            return;
        }

        Console.WriteLine($"\nSecuencia de Fibonacci hasta el término {n}:");
        Console.Write("0");  // Primer término

        if (n == 0) 
        {
            Console.WriteLine();
            return;
        }

        long prev = 0;
        long current = 1;
        
        Console.Write(" → 1");  // Segundo término

        for (int i = 2; i <= n; i++)
        {
            try
            {
                long next = checked(prev + current);  // Usar checked para detectar overflow
                Console.Write($" → {next}");
                prev = current;
                current = next;
            }
            catch (OverflowException)
            {
                Console.WriteLine("\n\nEl cálculo ha excedido el límite de números manejables.");
                break;
            }
        }
        Console.WriteLine("\n");
    }

    static void Main()
    {
        while (true)
        {
            Console.Write("Ingrese el número de términos de Fibonacci a mostrar (0 para salir): ");
            
            if (int.TryParse(Console.ReadLine(), out int n))
            {
                if (n == 0) break;
                MostrarSecuenciaFibonacci(n);
            }
            else
            {
                Console.WriteLine("Por favor ingrese un número válido.");
            }
        }
    }
}
*/
.section .data
.section .text
.global fibonacci

fibonacci:
    cmp x0, 0                  // Comparar n con 0
    beq end                    // Si n == 0, retornar 0
    cmp x0, 1                  // Comparar n con 1
    beq one                    // Si n == 1, retornar 1

    // Preparar para la llamada recursiva
    sub x1, x0, 1              // x1 = n - 1
    mov x0, x1                 // Pasar n - 1 a x0
    bl fibonacci               // Llamar a fibonacci(n - 1)
    mov x2, x0                 // Guardar resultado de fibonacci(n - 1)

    sub x1, x0, 2              // x1 = n - 2
    mov x0, x1                 // Pasar n - 2 a x0
    bl fibonacci               // Llamar a fibonacci(n - 2)

    add x0, x0, x2             // x0 = fibonacci(n - 1) + fibonacci(n - 2)
    ret

one:
    mov x0, 1                  // Retornar 1 si n == 1
    ret

end:
    mov x0, 0                  // Retornar 0 si n == 0
    ret
