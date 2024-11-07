// Autor: Cortez Huerta Gonzalo
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que Implementa una pila usando un arreglo

// Equivalente en C#:
/*
// pila.cs - C# para invocar el ensamblador ARM64 y manejar una pila
using System;
using System.Runtime.InteropServices;

class Program
{
    // Importar las funciones desde el ensamblador
    [DllImport("pila.so", EntryPoint = "init_pila")]
    private static extern void InitPila();

    [DllImport("pila.so", EntryPoint = "push")]
    private static extern long Push(long value);

    [DllImport("pila.so", EntryPoint = "pop")]
    private static extern long Pop();

    [DllImport("pila.so", EntryPoint = "is_empty")]
    private static extern int IsEmpty();

    static void Main()
    {
        InitPila();
        int option;

        do
        {
            Console.WriteLine("\nMenu:");
            Console.WriteLine("1. Apilar");
            Console.WriteLine("2. Desapilar");
            Console.WriteLine("3. Verificar si la pila está vacía");
            Console.WriteLine("0. Salir");
            Console.Write("Seleccione una opción: ");
            option = Convert.ToInt32(Console.ReadLine());

            switch (option)
            {
                case 1:
                    Console.Write("Ingrese un valor a apilar: ");
                    long value = Convert.ToInt64(Console.ReadLine());
                    long result = Push(value);
                    if (result == -1)
                    {
                        Console.WriteLine("Error: Desbordamiento de pila.");
                    }
                    else
                    {
                        Console.WriteLine($"{value} apilado.");
                    }
                    break;

                case 2:
                    long poppedValue = Pop();
                    if (poppedValue == -1)
                    {
                        Console.WriteLine("Error: Pila vacía.");
                    }
                    else
                    {
                        Console.WriteLine($"Desapilado: {poppedValue}");
                    }
                    break;

                case 3:
                    if (IsEmpty() == 1)
                    {
                        Console.WriteLine("La pila está vacía.");
                    }
                    else
                    {
                        Console.WriteLine("La pila no está vacía.");
                    }
                    break;

                case 0:
                    Console.WriteLine("Saliendo...");
                    break;

                default:
                    Console.WriteLine("Opción no válida.");
                    break;
            }
        } while (option != 0);
    }
}
*/
.data
    // Estructura de datos para la pila
    .align 3                    // Alineamiento a 8 bytes
    stack_array: .skip 800      // Espacio para 100 elementos de 8 bytes
    stack_count: .word 0        // Contador de elementos
    .equ MAX_SIZE, 100         // Constante para tamaño máximo

.text
.align 2
.global init_pila
.global push
.global pop
.global is_empty

// Función para inicializar la pila
init_pila:
    stp     x29, x30, [sp, -16]!   // Guardar frame pointer y link register
    mov     x29, sp
    
    adrp    x0, stack_count        // Cargar dirección de stack_count
    add     x0, x0, :lo12:stack_count
    str     wzr, [x0]              // Inicializar contador a 0
    
    ldp     x29, x30, [sp], 16
    ret

// Función para apilar (push)
push:
    stp     x29, x30, [sp, -16]!
    mov     x29, sp
    
    // Verificar si hay espacio
    adrp    x1, stack_count
    add     x1, x1, :lo12:stack_count
    ldr     w2, [x1]               // Cargar contador actual
    cmp     w2, MAX_SIZE
    b.ge    push_overflow
    
    // Calcular dirección donde guardar
    adrp    x3, stack_array
    add     x3, x3, :lo12:stack_array
    lsl     x4, x2, #3             // Multiplicar índice por 8
    str     x0, [x3, x4]           // Guardar valor
    
    // Incrementar contador
    add     w2, w2, #1
    str     w2, [x1]
    
    mov     x0, #0                 // Retorno exitoso
    ldp     x29, x30, [sp], 16
    ret

push_overflow:
    mov     x0, #-1                // Código de error
    ldp     x29, x30, [sp], 16
    ret

// Función para desapilar (pop)
pop:
    stp     x29, x30, [sp, -16]!
    mov     x29, sp
    
    // Verificar si hay elementos
    adrp    x1, stack_count
    add     x1, x1, :lo12:stack_count
    ldr     w2, [x1]
    cbz     w2, pop_empty
    
    // Calcular dirección del elemento a extraer
    sub     w2, w2, #1             // Decrementar contador
    str     w2, [x1]               // Guardar nuevo contador
    
    adrp    x3, stack_array
    add     x3, x3, :lo12:stack_array
    lsl     x4, x2, #3             // Multiplicar índice por 8
    ldr     x0, [x3, x4]           // Cargar valor
    
    ldp     x29, x30, [sp], 16
    ret

pop_empty:
    mov     x0, #-1                // Código de error
    ldp     x29, x30, [sp], 16
    ret

// Función para verificar si está vacía
is_empty:
    adrp    x1, stack_count
    add     x1, x1, :lo12:stack_count
    ldr     w0, [x1]
    cmp     w0, #0
    cset    w0, eq                 // Establecer 1 si está vacía, 0 si no
    ret
