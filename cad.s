// Autor: Cortez Huerta Gonzalo
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que calcula la longitud de una cadena

// Equivalente en C#:
/*
using System;
using System.Runtime.InteropServices;

class Cad
{
    [DllImport("libcalculations.so", CallingConvention = CallingConvention.Cdecl)]
    public static extern long longitud_cadena(byte[] cadena);

    static void Main()
    {
        Console.WriteLine("Ingrese una cadena: ");
        string input = Console.ReadLine();
        byte[] cadena = System.Text.Encoding.ASCII.GetBytes(input + '\0'); // Agregar terminador nulo

        long longitud = longitud_cadena(cadena);
        Console.WriteLine($"La longitud de la cadena es: {longitud}");
    }
}
*/
.global longitud_cadena

.section .text
longitud_cadena:
    mov x1, 0                      // Inicializar contador a 0

.loop:
    ldrb w2, [x0, x1]             // Cargar el siguiente byte de la cadena
    cmp w2, #0                     // Comparar con 0 (fin de cadena)
    beq .done                      // Si es 0, saltar a la sección done
    add x1, x1, #1                 // Incrementar contador
    b .loop                        // Volver al inicio del bucle

.done:
    mov x0, x1                     // Retornar la longitud en x0
    ret
