// Autor: Cortez Huerta Gonzalo
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que da el factorial de un número

// Equivalente en C#:
/*
using System;
using System.Runtime.InteropServices;

class Program
{
    [DllImport("libcalculations.so")]
    public static extern long factorial(long n);

    static void MostrarFactorial(long n)
    {
        Console.Write($"{n}! = ");
        
        // Mostrar el proceso
        for (long i = n; i >= 1; i--)
        {
            Console.Write(i);
            if (i > 1)
                Console.Write(" × ");
        }
        
        // Calcular y mostrar el resultado
        long resultado = factorial(n);
        Console.WriteLine($" = {resultado}");
    }

    static void Main()
    {
        while (true)
        {
            Console.Write("\nIngresa un número para calcular su factorial (0-20, o -1 para salir): ");
            
            if (long.TryParse(Console.ReadLine(), out long n))
            {
                if (n == -1) break;
                
                if (n >= 0 && n <= 20)
                {
                    try
                    {
                        MostrarFactorial(n);
                    }
                    catch (Exception e)
                    {
                        Console.WriteLine($"Error: {e.Message}");
                    }
                }
                else
                {
                    Console.WriteLine("Por favor ingresa un número entre 0 y 20.");
                }
            }
            else
            {
                Console.WriteLine("Entrada no válida.");
            }
        }
    }
}
*/
.section .data
.section .text
.global factorial

factorial:
    // Guardar el enlace de retorno y los registros que usaremos
    stp x29, x30, [sp, -16]!    // Guardar frame pointer y link register
    stp x20, x19, [sp, -16]!    // Guardar registros que usaremos
    
    mov x19, x0                  // Guardar n en x19
    
    // Si n <= 1, el factorial es 1
    cmp x0, 1
    ble end
    
    // Preparar para la llamada recursiva
    sub x0, x19, 1              // x0 = n - 1
    bl factorial                 // Llamar factorial(n - 1)
    
    // Multiplicar el resultado por n
    mul x0, x0, x19             // resultado = factorial(n-1) * n
    
    // Restaurar registros y retornar
    ldp x20, x19, [sp], 16      // Recuperar registros guardados
    ldp x29, x30, [sp], 16      // Recuperar frame pointer y link register
    ret

end:
    mov x0, 1                    // Retornar 1 si n <= 1
    ldp x20, x19, [sp], 16      // Recuperar registros guardados
    ldp x29, x30, [sp], 16      // Recuperar frame pointer y link register
    ret
