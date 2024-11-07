// Autor: Cortez Huerta Gonzalo
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que encuentra el máximo en un arreglo

// Equivalente en C#:
/*
using System;
using System.Runtime.InteropServices;

class Program
{
    // Importar la función de encontrar el máximo desde la biblioteca compartida
    [DllImport("libcalculations.so")]
    public static extern int encontrar_maximo(int[] arr, int n);

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

        // Llamar a la función para encontrar el máximo en el arreglo
        int maximo = encontrar_maximo(arreglo, arreglo.Length);

        // Mostrar el valor máximo
        Console.WriteLine($"El valor máximo en el arreglo es: {maximo}");
    }
}
*/
.section .data
.section .text
.global encontrar_maximo

// Función para encontrar el máximo en un arreglo
// Parámetros de entrada: x0 (puntero al arreglo), x1 (número de elementos)
// Retorno: x0 contiene el valor máximo

encontrar_maximo:
    cbz x1, fin             // Si el tamaño es 0, regresar de inmediato (sin elementos)

    ldr w2, [x0], #4        // Cargar el primer elemento del arreglo en w2 y avanzar el puntero
    sub x1, x1, #1          // Decrementar el contador de elementos

buscar_max:
    cbz x1, fin             // Si ya no hay más elementos, salir del bucle

    ldr w3, [x0], #4        // Cargar el siguiente elemento en w3 y avanzar el puntero
    cmp w3, w2              // Comparar el elemento actual con el máximo
    ble siguiente           // Si el actual es menor o igual, pasar al siguiente
    mov w2, w3              // Si el actual es mayor, actualizar el máximo

siguiente:
    sub x1, x1, #1          // Decrementar el contador de elementos
    b buscar_max            // Repetir el ciclo para el siguiente elemento

fin:
    mov w0, w2              // Colocar el máximo encontrado en w0 (resultado)
    ret                     // Retornar
