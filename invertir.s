// Autor: Cortez Huerta Gonzalo
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que invierte los elementos de un arreglo

// Equivalente en C#:
/*
// invertir.cs - C# para invocar el ensamblador ARM64 y invertir los elementos de un arreglo
using System;
using System.Runtime.InteropServices;

class Program
{
    // Importar la función invertir_arreglo desde el archivo ensamblador
    [DllImport("invertir.so", EntryPoint = "invertir_arreglo")]
    private static extern void InvertirArreglo(long[] arreglo, long tamaño);

    static void Main()
    {
        Console.WriteLine("Introduce el número de elementos en el arreglo:");
        int n = Convert.ToInt32(Console.ReadLine());
        long[] arreglo = new long[n];

        Console.WriteLine("Introduce los elementos del arreglo:");
        for (int i = 0; i < n; i++)
        {
            Console.Write($"Elemento {i + 1}: ");
            arreglo[i] = Convert.ToInt64(Console.ReadLine());
        }

        // Llamar a la función de ensamblador para invertir el arreglo
        InvertirArreglo(arreglo, n);

        Console.WriteLine("Arreglo invertido:");
        foreach (long elemento in arreglo)
        {
            Console.Write(elemento + " ");
        }
        Console.WriteLine();
    }
}
*/
// invertir.s - Ensamblador ARM64 para invertir los elementos de un arreglo

.global invertir_arreglo

// Función que invierte un arreglo
// Entrada: x0 = puntero al arreglo, x1 = tamaño del arreglo
invertir_arreglo:
    // Guardar registros
    stp x29, x30, [sp, -16]!
    mov x29, sp

    // Calcular los límites iniciales
    mov x2, x0           // x2 = puntero al inicio del arreglo
    add x3, x0, x1, lsl #3  // x3 = puntero al final del arreglo (x1 * 8 bytes para enteros de 64 bits)
    sub x3, x3, 8        // Ajustar x3 para que apunte al último elemento

invertir_loop:
    // Comparar los punteros para ver si se cruzaron
    cmp x2, x3
    b.ge invertir_done   // Si se cruzaron, terminar

    // Intercambiar los elementos apuntados por x2 y x3
    ldr x4, [x2]         // Cargar el valor en x2 en x4
    ldr x5, [x3]         // Cargar el valor en x3 en x5
    str x5, [x2]         // Almacenar x5 en la posición de x2
    str x4, [x3]         // Almacenar x4 en la posición de x3

    // Mover los punteros hacia el centro
    add x2, x2, 8        // Avanzar x2 al siguiente elemento
    sub x3, x3, 8        // Retroceder x3 al elemento anterior
    b invertir_loop      // Repetir el bucle

invertir_done:
    // Restaurar registros y retornar
    ldp x29, x30, [sp], 16
    ret
