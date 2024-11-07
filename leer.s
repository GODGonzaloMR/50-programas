// Autor: Cortez Huerta Gonzalo
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que Lee entradas desde el teclado

// Equivalente en C#:
/*
using System;
using System.Runtime.InteropServices;

class Program
{
    // Declaración de la función externa
    [DllImport("leer.so", CallingConvention = CallingConvention.Cdecl)]
    public static extern long LeerEntrada();

    static void Main()
    {
        Console.WriteLine("Introduce un número:");
        long numero = LeerEntrada();
        Console.WriteLine($"Número leído: {numero}");
    }
}
*/
.global LeerEntrada

LeerEntrada:
    // Reservar espacio en el stack
    sub sp, sp, #16
    
    // Leer entrada (syscall read)
    mov x0, #0          // stdin
    ldr x1, =buffer     // dirección del buffer
    mov x2, #16         // tamaño máximo a leer
    mov x8, #63         // syscall read
    svc #0
    
    // Convertir string a número
    ldr x1, =buffer     // dirección del buffer
    mov x2, #0          // inicializar resultado
    mov x3, #10         // base decimal

convert_loop:
    ldrb w4, [x1], #1   // cargar byte y avanzar puntero
    cmp w4, #10         // comparar con newline
    beq end_convert     // si es newline, terminar
    
    sub w4, w4, #'0'    // convertir ASCII a número
    mul x2, x2, x3      // resultado * 10
    sxtw x4, w4         // extender w4 a 64 bits
    add x2, x2, x4      // sumar dígito actual
    
    b convert_loop

end_convert:
    mov x0, x2          // mover resultado a x0
    add sp, sp, #16     // restaurar stack
    ret

.data
buffer: .space 16       // buffer para entrada
