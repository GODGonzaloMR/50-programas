// Autor: Cortez Huerta Gonzalo
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que hace una suma de matrices

// Equivalente en C#:
/*
using System;
using System.Runtime.InteropServices;

class Matriz
{
    // Declaración de la función de suma de matrices
    [DllImport("libcalculations.so")]
    public static extern void suma_matrices(int[] A, int[] B, int[] C, long rows, long cols);

    static void Main(string[] args)
    {
        // Definir el número de filas y columnas
        long rows = 2; // Cambia esto al número de filas que necesites
        long cols = 3; // Cambia esto al número de columnas que necesites

        // Inicializar las matrices A y B
        int[] A = new int[rows * cols];
        int[] B = new int[rows * cols];
        int[] C = new int[rows * cols]; // Matriz para almacenar el resultado

        // Leer los elementos de la matriz A
         Console.WriteLine("Ingrese los elementos de la matriz A:");
        for (long i = 0; i < rows; i++)
        {
            for (long j = 0; j < cols; j++)
            {
                Console.Write($"Elemento A[{i},{j}]: ");
                A[i * cols + j] = int.Parse(Console.ReadLine());
            }
        }

        // Leer los elementos de la matriz B
        Console.WriteLine("Ingrese los elementos de la matriz B:");
        for (long i = 0; i < rows; i++)
        {
            for (long j = 0; j < cols; j++)
            {
                Console.Write($"Elemento B[{i},{j}]: ");
                B[i * cols + j] = int.Parse(Console.ReadLine());
            }
        }

        // Llamar a la función de suma de matrices
        suma_matrices(A, B, C, rows, cols);

        // Mostrar la matriz resultante C
        Console.WriteLine("La matriz resultante C (A + B) es:");
        for (long i = 0; i < rows; i++)
        {
            for (long j = 0; j < cols; j++)
            {
                Console.Write(C[i * cols + j] + "\t");
            }
            Console.WriteLine();
        }
    }
}
*/
.section .text
.global suma_matrices

suma_matrices:
    // Se espera que A, B, C sean punteros a enteros y rows y cols sean los tamaños de la matriz
    // A: x0, B: x1, C: x2, rows: x3, cols: x4

    // Inicializar índices
    mov x5, #0         // i = 0
outer_loop:
    cmp x5, x3         // Comparar i con rows
    bge end_outer_loop // Si i >= rows, salir del bucle

    mov x6, #0         // j = 0
inner_loop:
    cmp x6, x4         // Comparar j con cols
    bge end_inner_loop // Si j >= cols, salir del bucle

    // Calcular el índice en la matriz
    mul x7, x5, x4     // x7 = i * cols
    add x7, x7, x6     // x7 = i * cols + j

    // C = A + B
    ldr w8, [x0, x7, lsl #2] // Cargar A[i][j]
    ldr w9, [x1, x7, lsl #2] // Cargar B[i][j]
    add w10, w8, w9    // w10 = A[i][j] + B[i][j]
    str w10, [x2, x7, lsl #2] // Guardar en C[i][j]

    add x6, x6, #1     // j++
    b inner_loop        // Repetir el bucle interno

end_inner_loop:
    add x5, x5, #1     // i++
    b outer_loop        // Repetir el bucle externo

end_outer_loop:
    ret
