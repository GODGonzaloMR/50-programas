// Autor: Cortez Huerta Gonzalo
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que permite Escribir en un archivo

// Equivalente en C#:
/*
using System;
using System.Runtime.InteropServices;

class Program
{
    [DllImport("escribir.so", CallingConvention = CallingConvention.Cdecl)]
    public static extern void EscribirArchivo(long numero);

    static void Main()
    {
        Console.WriteLine("Introduce un número para escribir en el archivo:");
        if (long.TryParse(Console.ReadLine(), out long numero))
        {
            EscribirArchivo(numero);
            Console.WriteLine($"El número {numero} ha sido escrito en salida.txt");
        }
        else
        {
            Console.WriteLine("Error: Entrada inválida");
        }
    }
}
*/
.global EscribirArchivo

EscribirArchivo:
    // Preservar registros
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    
    // Guardar argumentos
    str x0, [sp, #-16]!    // Guardar número a escribir
    
    // Abrir archivo (syscall open)
    adr x0, filename       // nombre del archivo
    mov x1, #0x441        // Flags: O_WRONLY|O_CREAT|O_TRUNC
    mov x2, #0666         // Permisos
    mov x8, #56          // syscall open
    svc #0
    
    // Guardar file descriptor
    mov x19, x0
    
    // Convertir número a string
    ldr x0, [sp]         // Recuperar número
    adr x1, buffer       // Buffer donde escribiremos
    mov x2, #0          // Contador de dígitos
    mov x3, #10         // Divisor (base 10)
    
convert_loop:
    udiv x4, x0, x3     // x4 = número / 10
    msub x5, x4, x3, x0 // x5 = número % 10
    add x5, x5, #'0'    // Convertir a ASCII
    strb w5, [x1, x2]   // Guardar dígito
    add x2, x2, #1      // Incrementar contador
    mov x0, x4          // Actualizar número
    cbnz x0, convert_loop // Si número != 0, continuar
    
    // Agregar newline
    mov w5, #10         // Carácter newline
    strb w5, [x1, x2]   // Guardar newline
    add x2, x2, #1      // Incrementar contador
    
    // Escribir al archivo (syscall write)
    mov x0, x19         // File descriptor
    adr x1, buffer      // Buffer con el string
    mov x8, #64         // syscall write
    svc #0
    
    // Cerrar archivo (syscall close)
    mov x0, x19         // File descriptor
    mov x8, #57         // syscall close
    svc #0
    
    // Restaurar stack y retornar
    add sp, sp, #16     // Liberar espacio del número
    ldp x29, x30, [sp], #16
    ret

.data
filename: .asciz "salida.txt"    // Nombre del archivo
buffer: .space 32                // Buffer para convertir número a string
