// Autor: Cortez Huerta Gonzalo
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que encuentra el mínimo en un arreglo

// Equivalente en C#:
/*
using System;
using System.Runtime.InteropServices;

class Program
{
    // Importar la función de encontrar el mínimo desde la biblioteca compartida
    [DllImport("libcalculations.so")]
    public static extern int encontrar_minimo(int[] arr, int n);

    static void Main()
    {
        // Definir un arreglo de ejemplo
        Console.Write("Ingresa la cantidad de elementos en el arreglo: ");
        int n = int.Parse(Console.ReadLine());
        int[] arreglo = new int[n];

        // Rellenar el arreglo con valores del usuario
        for (int i = 0; i < n; i++)
        {
            Console.Write($"Elemento {i + 1}: ");
            arreglo[i] = int.Parse(Console.ReadLine());
        }

        // Llamar a la función para encontrar el mínimo en el arreglo
        int minimo = encontrar_minimo(arreglo, arreglo.Length);

        // Mostrar el valor mínimo
        Console.WriteLine($"El valor mínimo en el arreglo es: {minimo}");
    }
}
*/
.section .data
.section .text
.global encontrar_minimo

// Función para encontrar el mínimo en un arreglo
// Parámetros de entrada: x0 (puntero al arreglo), x1 (número de elementos)
// Retorno: x0 contiene el valor mínimo

encontrar_minimo:
    cbz x1, fin             // Si el tamaño es 0, regresar de inmediato (sin elementos)

    ldr w2, [x0], #4        // Cargar el primer elemento del arreglo en w2 y avanzar el puntero
    sub x1, x1, #1          // Decrementar el contador de elementos

buscar_min:
    cbz x1, fin             // Si ya no hay más elementos, salir del bucle

    ldr w3, [x0], #4        // Cargar el siguiente elemento en w3 y avanzar el puntero
    cmp w3, w2              // Comparar el elemento actual con el mínimo
    bge siguiente           // Si el actual es mayor o igual, pasar al siguiente
    mov w2, w3              // Si el actual es menor, actualizar el mínimo

siguiente:
    sub x1, x1, #1          // Decrementar el contador de elementos
    b buscar_min            // Repetir el ciclo para el siguiente elemento

fin:
    mov w0, w2              // Colocar el mínimo encontrado en w0 (resultado)
    ret                     // Retornar
