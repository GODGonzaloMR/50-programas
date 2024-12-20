// Autor: Cortez Huerta Gonzalo
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que Mide el tiempo de ejecución de una función

// Equivalente en C#:
/*
using System;
using System.Runtime.InteropServices;
using System.Diagnostics;

class Program
{
    [DllImport("tiempo.so")]
    public static extern ulong FuncionDePrueba(ulong iteraciones);

    static void Main()
    {
        try
        {
            Console.Write("Introduce el número de iteraciones: ");
            if (ulong.TryParse(Console.ReadLine(), out ulong iteraciones))
            {
                // Crear el cronómetro
                Stopwatch cronometro = new Stopwatch();

                // Calentar la CPU (opcional)
                FuncionDePrueba(1000);
                
                Console.WriteLine("\nIniciando medición de tiempo...");
                
                // Iniciar medición
                cronometro.Start();
                
                // Llamar a la función
                ulong resultado = FuncionDePrueba(iteraciones);
                
                // Detener medición
                cronometro.Stop();

                // Mostrar resultados
                Console.WriteLine($"\nResultados de la medición:");
                Console.WriteLine($"Tiempo transcurrido: {cronometro.ElapsedMilliseconds} ms");
                Console.WriteLine($"Tiempo por iteración: {(double)cronometro.ElapsedTicks / iteraciones:F6} ticks");
                Console.WriteLine($"Resultado del cálculo: {resultado}");
            }
            else
            {
                Console.WriteLine("Por favor, ingresa un número válido.");
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error: {ex.Message}");
        }
    }
}
*/
.global FuncionDePrueba

// Función de prueba que realiza operaciones matemáticas en un bucle
// Parámetro x0: número de iteraciones
// Retorna: resultado de las operaciones
FuncionDePrueba:
    // Guardar registros
    stp x29, x30, [sp, #-16]!
    stp x19, x20, [sp, #-16]!
    
    // Guardar el número de iteraciones
    mov x19, x0
    
    // Inicializar acumulador y constantes
    mov x1, #1          // Acumulador
    mov x3, #7          // Constante para multiplicación
    mov x4, #3          // Constante para división
    
bucle:
    // Verificar si quedan iteraciones
    cbz x19, fin
    
    // Realizar algunas operaciones matemáticas
    add x1, x1, x1      // x1 = x1 + x1
    lsr x2, x1, #1      // x2 = x1 >> 1
    add x1, x1, x2      // x1 = x1 + x2
    mul x1, x1, x3      // x1 = x1 * 7
    udiv x1, x1, x4     // x1 = x1 / 3
    
    // Decrementar contador
    sub x19, x19, #1
    
    // Continuar bucle
    b bucle
    
fin:
    // Mover resultado a x0 para retorno
    mov x0, x1
    
    // Restaurar registros
    ldp x19, x20, [sp], #16
    ldp x29, x30, [sp], #16
    ret
