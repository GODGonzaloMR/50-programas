// Autor: Cortez Huerta Gonzalo
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que invierte una cadena

// Equivalente en C#:
/*
using System;
using System.Runtime.InteropServices;
using System.Text;

class Program
{
    // Importar la función de invertir cadena desde la biblioteca compartida
    [DllImport("libcalculations.so")]
    public static extern void invertir_cadena(StringBuilder str);

    static void Main()
    {
        // Pedir al usuario que ingrese una cadena
        Console.Write("Ingresa una cadena para invertir: ");
        string input = Console.ReadLine();

        // Convertir la cadena a StringBuilder (mutable)
        StringBuilder cadena = new StringBuilder(input);

        // Llamar a la función para invertir la cadena
        invertir_cadena(cadena);

        // Mostrar la cadena invertida
        Console.WriteLine($"Cadena invertida: {cadena}");
    }
}
*/
.section .data
.section .text
.global invertir_cadena

// Función para invertir una cadena en lugar
// Parámetro de entrada: x0 (puntero a la cadena)
// Devuelve: nada (cadena invertida en el mismo lugar)

invertir_cadena:
    // Encuentra la longitud de la cadena
    mov x1, x0             // x1 apunta al inicio de la cadena
find_end:
    ldrb w2, [x1], #1      // Leer el siguiente byte (carácter) y avanzar
    cbz w2, reverse        // Si llegamos al final ('\0'), saltar a la inversión

    b find_end             // Continuar hasta encontrar el final

reverse:
    sub x1, x1, #2         // Retroceder una posición (x1 apunta al último carácter)
    mov x2, x1             // x2 apunta al final de la cadena
    mov x3, x0             // x3 apunta al inicio de la cadena

swap_loop:
    cmp x3, x2             // Comparar el inicio con el final
    bge end_reverse        // Si se cruzan, termina la inversión

    ldrb w4, [x3]          // Leer carácter desde el inicio
    ldrb w5, [x2]          // Leer carácter desde el final
    strb w5, [x3]          // Escribir carácter del final en el inicio
    strb w4, [x2]          // Escribir carácter del inicio en el final

    add x3, x3, #1         // Avanzar el inicio
    sub x2, x2, #1         // Retroceder el final

    b swap_loop            // Repetir el intercambio

end_reverse:
    ret                    // Retornar
