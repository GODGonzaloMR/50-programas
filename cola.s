// Autor: Cortez Huerta Gonzalo
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que Implementa una cola usando un arreglo

// Equivalente en C#:
/*
using System;
using System.Runtime.InteropServices;

class Program
{
    // Importar funciones del ensamblador
    [DllImport("cola.so", EntryPoint = "init_cola")]
    private static extern void InitCola();

    [DllImport("cola.so", EntryPoint = "enqueue")]
    private static extern long Enqueue(long value);

    [DllImport("cola.so", EntryPoint = "dequeue")]
    private static extern long Dequeue();

    [DllImport("cola.so", EntryPoint = "is_empty")]
    private static extern int IsEmpty();

    [DllImport("cola.so", EntryPoint = "is_full")]
    private static extern int IsFull();

    static void Main()
    {
        InitCola();
        int opcion;

        do
        {
            Console.WriteLine("\nMenú Cola:");
            Console.WriteLine("1. Encolar (Enqueue)");
            Console.WriteLine("2. Desencolar (Dequeue)");
            Console.WriteLine("3. Verificar si está vacía");
            Console.WriteLine("4. Verificar si está llena");
            Console.WriteLine("0. Salir");
            Console.Write("Seleccione una opción: ");
            
            if (int.TryParse(Console.ReadLine(), out opcion))
            {
                switch (opcion)
                {
                    case 1:
                        Console.Write("Ingrese el valor a encolar: ");
                        if (long.TryParse(Console.ReadLine(), out long valor))
                        {
                            long resultado = Enqueue(valor);
                            if (resultado == -1)
                            {
                                Console.WriteLine("Error: La cola está llena.");
                            }
                            else
                            {
                                Console.WriteLine($"Valor {valor} encolado exitosamente.");
                            }
                        }
                        else
                        {
                            Console.WriteLine("Error: Ingrese un número válido.");
                        }
                        break;

                    case 2:
                        long valorDesencolado = Dequeue();
                        if (valorDesencolado == -1)
                        {
                            Console.WriteLine("Error: La cola está vacía.");
                        }
                        else
                        {
                            Console.WriteLine($"Valor desencolado: {valorDesencolado}");
                        }
                        break;

                    case 3:
                        if (IsEmpty() == 1)
                        {
                            Console.WriteLine("La cola está vacía.");
                        }
                        else
                        {
                            Console.WriteLine("La cola no está vacía.");
                        }
                        break;

                    case 4:
                        if (IsFull() == 1)
                        {
                            Console.WriteLine("La cola está llena.");
                        }
                        else
                        {
                            Console.WriteLine("La cola no está llena.");
                        }
                        break;

                    case 0:
                        Console.WriteLine("Saliendo del programa...");
                        break;

                    default:
                        Console.WriteLine("Opción no válida.");
                        break;
                }
            }
            else
            {
                Console.WriteLine("Error: Ingrese un número válido.");
                opcion = -1;
            }

        } while (opcion != 0);
    }
}
*/
.data
    .align 3                    // Alineamiento a 8 bytes
    queue_array: .skip 800      // Espacio para 100 elementos de 8 bytes
    front: .word 0             // Índice del frente de la cola
    rear: .word 0              // Índice del final de la cola
    count: .word 0             // Contador de elementos
    .equ MAX_SIZE, 100         // Tamaño máximo de la cola

.text
.align 2
.global init_cola
.global enqueue
.global dequeue
.global is_empty
.global is_full

// Inicializar cola
init_cola:
    stp     x29, x30, [sp, -16]!
    mov     x29, sp
    
    // Reiniciar todos los índices a 0
    adrp    x0, front
    add     x0, x0, :lo12:front
    str     wzr, [x0]
    
    adrp    x0, rear
    add     x0, x0, :lo12:rear
    str     wzr, [x0]
    
    adrp    x0, count
    add     x0, x0, :lo12:count
    str     wzr, [x0]
    
    ldp     x29, x30, [sp], 16
    ret

// Encolar (enqueue) - x0 contiene el valor a encolar
enqueue:
    stp     x29, x30, [sp, -16]!
    mov     x29, sp
    
    // Verificar si la cola está llena
    bl      is_full
    cbnz    w0, enqueue_full
    
    // Obtener índice rear actual
    adrp    x1, rear
    add     x1, x1, :lo12:rear
    ldr     w2, [x1]
    
    // Guardar valor en la cola
    adrp    x3, queue_array
    add     x3, x3, :lo12:queue_array
    lsl     x4, x2, #3             // Multiplicar índice por 8
    str     x0, [x3, x4]           // Guardar valor
    
    // Actualizar rear
    add     w2, w2, #1
    cmp     w2, MAX_SIZE
    csel    w2, wzr, w2, eq        // Si rear == MAX_SIZE, volver a 0
    str     w2, [x1]
    
    // Incrementar count
    adrp    x1, count
    add     x1, x1, :lo12:count
    ldr     w2, [x1]
    add     w2, w2, #1
    str     w2, [x1]
    
    mov     x0, #0                 // Éxito
    ldp     x29, x30, [sp], 16
    ret

enqueue_full:
    mov     x0, #-1                // Error: cola llena
    ldp     x29, x30, [sp], 16
    ret

// Desencolar (dequeue)
dequeue:
    stp     x29, x30, [sp, -16]!
    mov     x29, sp
    
    // Verificar si la cola está vacía
    bl      is_empty
    cbnz    w0, dequeue_empty
    
    // Obtener valor del frente
    adrp    x1, front
    add     x1, x1, :lo12:front
    ldr     w2, [x1]
    
    adrp    x3, queue_array
    add     x3, x3, :lo12:queue_array
    lsl     x4, x2, #3
    ldr     x0, [x3, x4]           // Cargar valor a retornar
    
    // Actualizar front
    add     w2, w2, #1
    cmp     w2, MAX_SIZE
    csel    w2, wzr, w2, eq        // Si front == MAX_SIZE, volver a 0
    str     w2, [x1]
    
    // Decrementar count
    adrp    x1, count
    add     x1, x1, :lo12:count
    ldr     w2, [x1]
    sub     w2, w2, #1
    str     w2, [x1]
    
    ldp     x29, x30, [sp], 16
    ret

dequeue_empty:
    mov     x0, #-1                // Error: cola vacía
    ldp     x29, x30, [sp], 16
    ret

// Verificar si está vacía
is_empty:
    adrp    x1, count
    add     x1, x1, :lo12:count
    ldr     w0, [x1]
    cmp     w0, #0
    cset    w0, eq                 // 1 si está vacía, 0 si no
    ret

// Verificar si está llena
is_full:
    adrp    x1, count
    add     x1, x1, :lo12:count
    ldr     w0, [x1]
    cmp     w0, MAX_SIZE
    cset    w0, eq                 // 1 si está llena, 0 si no
    ret
