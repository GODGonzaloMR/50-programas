// Autor: Cortez Huerta Gonzalo
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que hace un ordenamineto por selección

// Equivalente en C#:
/*
using System;
using System.Runtime.InteropServices;

class Program
{
    [DllImport("libcalculations.so")]
    public static extern void ordenamiento_seleccion(int[] arr, int n);

    static void Main()
    {
        Console.Write("Ingresa la cantidad de elementos en el arreglo: ");
        int n = int.Parse(Console.ReadLine());
        int[] arreglo = new int[n];

        Console.WriteLine("Ingresa los elementos:");
        for (int i = 0; i < n; i++)
        {
            Console.Write($"Elemento {i + 1}: ");
            arreglo[i] = int.Parse(Console.ReadLine());
        }

        // Llamar a la función para ordenar el arreglo
        ordenamiento_seleccion(arreglo, n);

        Console.WriteLine("Arreglo ordenado:");
        foreach (int num in arreglo)
        {
            Console.Write(num + " ");
        }
        Console.WriteLine();
    }
}
*/
.section .data
.section .text
.global ordenamiento_seleccion

ordenamiento_seleccion:
    mov x2, x1              // Guardar el tamaño del arreglo en x2 para el bucle externo

bucle_externo:
    cmp x2, 1               // Si hay 1 o menos elementos, ya está ordenado
    ble fin_bucle_externo   // Salir si el arreglo tiene 0 o 1 elementos

    mov x3, 0               // Reiniciar el índice del bucle externo
    mov x4, x3               // Suponer que el mínimo es el índice actual

bucle_interno:
    add x5, x3, 1            // x5 es el índice del siguiente elemento
    cmp x5, x2               // Comparar x5 con el tamaño del arreglo
    bge intercambio           // Si es mayor o igual, realizar el intercambio

    ldr w6, [x0, x5, lsl #2]  // Cargar el siguiente elemento
    ldr w7, [x0, x4, lsl #2]  // Cargar el elemento mínimo actual
    cmp w6, w7                // Comparar el siguiente elemento con el mínimo

    blt actualizar_minimo     // Si el siguiente elemento es menor, actualizar el mínimo
    b siguiente_elemento

actualizar_minimo:
    mov x4, x5                // Actualizar el índice mínimo

siguiente_elemento:
    add x3, x3, 1             // Incrementar el índice del bucle interno
    b bucle_interno           // Volver al inicio del bucle interno

intercambio:
    cmp x4, x3                // Comparar el índice mínimo con el índice actual
    beq siguiente_bucle       // Si son iguales, no hacer nada

    // Intercambiar elementos
    ldr w6, [x0, x3, lsl #2]  // Cargar el elemento en el índice actual
    ldr w7, [x0, x4, lsl #2]  // Cargar el elemento mínimo
    str w7, [x0, x3, lsl #2]  // Guardar el mínimo en la posición actual
    str w6, [x0, x4, lsl #2]  // Guardar el actual en la posición del mínimo

siguiente_bucle:
    sub x2, x2, 1             // Decrementar el tamaño del bucle externo
    b bucle_externo            // Volver al inicio del bucle externo

fin_bucle_externo:
    ret                        // Terminar la función
