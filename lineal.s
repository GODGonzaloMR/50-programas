// Autor: Cortez Huerta Gonzalo
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que hace una Función para realizar una búsqueda lineal en un arreglo

// Equivalente en C#:
/*
using System;
using System.Runtime.InteropServices;

class Program
{
    // Importar la función de búsqueda lineal desde la biblioteca compartida
    [DllImport("libcalculations.so")]
    public static extern int busqueda_lineal(int[] arr, int n, int valor);

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

        // Pedir el valor a buscar
        Console.Write("Ingresa el valor a buscar en el arreglo: ");
        int valor = int.Parse(Console.ReadLine());

        // Llamar a la función para realizar la búsqueda lineal
        int indice = busqueda_lineal(arreglo, arreglo.Length, valor);

        // Mostrar el resultado
        if (indice >= 0)
        {
            Console.WriteLine($"El valor {valor} se encuentra en el índice {indice}.");
        }
        else
        {
            Console.WriteLine($"El valor {valor} no se encuentra en el arreglo.");
        }
    }
}
*/
.section .data
.section .text
.global busqueda_lineal

// Función para realizar una búsqueda lineal en un arreglo
// Parámetros de entrada: x0 (puntero al arreglo), x1 (número de elementos), x2 (valor a buscar)
// Retorno: x0 contiene el índice del elemento si se encuentra, o -1 si no está presente

busqueda_lineal:
    mov w3, -1             // Configurar -1 como valor de retorno por defecto (no encontrado)
    cbz x1, fin            // Si el tamaño es 0, regresar de inmediato (arreglo vacío)

buscar:
    ldr w4, [x0], #4       // Cargar el siguiente elemento en w4 y avanzar el puntero
    cmp w4, w2             // Comparar el elemento actual con el valor buscado
    beq encontrado         // Si son iguales, ir a la etiqueta "encontrado"

    sub x1, x1, #1         // Decrementar el contador de elementos
    add w3, w3, #1         // Incrementar el índice
    cbnz x1, buscar        // Si hay más elementos, continuar la búsqueda

    mov w3, -1             // Si no se encontró, establecer el retorno en -1

fin:
    mov w0, w3             // Colocar el índice en w0
    ret                    // Retornar

encontrado:
    ret                    // Retornar con el índice actual en w3
