// Autor: Cortez Huerta Gonzalo
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que hace un ordenamiento por mezcla (Meger Sort)

// Equivalente en C#:
/*

using System;
using System.Runtime.InteropServices;

class Program
{
    // Importar la función de ordenamiento por mezcla desde la biblioteca compartida
    [DllImport("libcalculations.so")]
    public static extern void merge_sort(int[] arr, int n);

    static void Main()
    {
        // Solicitar el tamaño del arreglo
        Console.Write("Ingresa la cantidad de elementos en el arreglo: ");
        int n = int.Parse(Console.ReadLine());
        int[] arreglo = new int[n];

        // Rellenar el arreglo con valores proporcionados por el usuario
        Console.WriteLine("Ingresa los elementos:");
        for (int i = 0; i < n; i++)
        {
            Console.Write($"Elemento {i + 1}: ");
            arreglo[i] = int.Parse(Console.ReadLine());
        }

        // Llamar a la función para ordenar el arreglo
        merge_sort(arreglo, arreglo.Length);

        // Mostrar el arreglo ordenado
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
.global merge_sort
.global merge

// merge_sort(int* arr, int n)
// x0: puntero al array
// x1: tamaño del array
merge_sort:
    stp x29, x30, [sp, #-16]!    // Guardar frame pointer y link register
    stp x19, x20, [sp, #-16]!    // Guardar registros que preservaremos
    stp x21, x22, [sp, #-16]!

    // Guardar parámetros
    mov x19, x0                   // Guardar puntero al array
    mov x20, x1                   // Guardar tamaño

    // Verificar caso base
    cmp x20, #2                   // Si tamaño < 2, ya está ordenado
    b.lt .Lend_merge_sort

    // Calcular punto medio
    lsr x21, x20, #1             // mid = size / 2

    // Primera llamada recursiva (primera mitad)
    mov x0, x19                   // array
    mov x1, x21                   // tamaño = mid
    bl merge_sort

    // Segunda llamada recursiva (segunda mitad)
    add x0, x19, x21, lsl #2     // array + mid
    sub x1, x20, x21             // tamaño = size - mid
    bl merge_sort

    // Merge
    mov x0, x19                   // array original
    mov x1, x21                   // mid
    mov x2, x20                   // size
    bl merge

.Lend_merge_sort:
    ldp x21, x22, [sp], #16      // Restaurar registros
    ldp x19, x20, [sp], #16
    ldp x29, x30, [sp], #16
    ret

// merge(int* arr, int mid, int size)
// x0: puntero al array
// x1: mid
// x2: size total
merge:
    // Primero guardar todos los registros que necesitamos
    stp x29, x30, [sp, #-16]!    // Guardar frame pointer y link register
    stp x19, x20, [sp, #-16]!    // Guardar registros que usaremos
    stp x21, x22, [sp, #-16]!
    stp x23, x24, [sp, #-16]!
    stp x25, x26, [sp, #-16]!
    
    // Establecer frame pointer
    mov x29, sp
    
    // Guardar parámetros en registros preservados
    mov x19, x0                   // array original
    mov x20, x1                   // mid
    mov x21, x2                   // size total
    
    // Calcular y reservar espacio para array temporal
    mov x3, x21                   // Copiar size
    lsl x3, x3, #2               // Multiplicar por 4 (tamaño de int)
    sub sp, sp, x3               // Reservar espacio en el stack
    mov x25, sp                  // Guardar puntero al array temporal

    // Inicializar índices
    mov x22, #0                   // i = 0 (índice para primera mitad)
    mov x23, x20                  // j = mid (índice para segunda mitad)
    mov x24, #0                   // k = 0 (índice para array temporal)

.Lmerge_loop:
    // Verificar si hemos terminado alguna mitad
    cmp x22, x20                 // i >= mid?
    b.ge .Lcopy_right_half
    cmp x23, x21                 // j >= size?
    b.ge .Lcopy_left_half

    // Cargar y comparar elementos
    ldr w3, [x19, x22, lsl #2]   // arr[i]
    ldr w4, [x19, x23, lsl #2]   // arr[j]
    cmp w3, w4
    b.gt .Lcopy_from_right

.Lcopy_from_left:
    str w3, [x25, x24, lsl #2]   // temp[k] = arr[i]
    add x22, x22, #1             // i++
    add x24, x24, #1             // k++
    b .Lmerge_loop

.Lcopy_from_right:
    str w4, [x25, x24, lsl #2]   // temp[k] = arr[j]
    add x23, x23, #1             // j++
    add x24, x24, #1             // k++
    b .Lmerge_loop

.Lcopy_left_half:
    cmp x22, x20                 // Quedan elementos en la izquierda?
    b.ge .Lcopy_back
    ldr w3, [x19, x22, lsl #2]   // arr[i]
    str w3, [x25, x24, lsl #2]   // temp[k] = arr[i]
    add x22, x22, #1             // i++
    add x24, x24, #1             // k++
    b .Lcopy_left_half

.Lcopy_right_half:
    cmp x23, x21                 // Quedan elementos en la derecha?
    b.ge .Lcopy_back
    ldr w4, [x19, x23, lsl #2]   // arr[j]
    str w4, [x25, x24, lsl #2]   // temp[k] = arr[j]
    add x23, x23, #1             // j++
    add x24, x24, #1             // k++
    b .Lcopy_right_half

.Lcopy_back:
    // Copiar desde temp_array al array original
    mov x22, #0                  // i = 0
.Lcopy_back_loop:
    cmp x22, x21                 // i >= size?
    b.ge .Lmerge_end
    ldr w3, [x25, x22, lsl #2]   // temp[i]
    str w3, [x19, x22, lsl #2]   // arr[i] = temp[i]
    add x22, x22, #1             // i++
    b .Lcopy_back_loop

.Lmerge_end:
    // Restaurar stack pointer y registros
    mov sp, x29                  // Restaurar stack pointer usando frame pointer
    ldp x25, x26, [sp], #16     // Restaurar registros en orden inverso
    ldp x23, x24, [sp], #16
    ldp x21, x22, [sp], #16
    ldp x19, x20, [sp], #16
    ldp x29, x30, [sp], #16
    ret
