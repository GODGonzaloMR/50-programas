// Autor: Cortez Huerta Gonzalo
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que hace una Conversión de ASCII a entero

// Equivalente en C#:
/*
using System;
using System.Runtime.InteropServices;

class AsciiConversion
{
    // Importar la función de ensamblador
    [DllImport("libcalculations.so")]
    public static extern int ascii_a_entero(string cadena);

    static void Main()
    {
        Console.Write("Ingrese una cadena numérica: ");
        string cadena = Console.ReadLine();

        // Llamada a la función de ensamblador para la conversión
        int numero = ascii_a_entero(cadena);

        Console.WriteLine($"El número entero es: {numero}");
    }
}
*/
// ascii.s - Conversión de ASCII a entero
// Entrada: Puntero a la cadena de entrada (en x0)
// Salida: El entero convertido en w0

.global ascii_a_entero

ascii_a_entero:
    mov w1, #0           // Inicializar el resultado en 0
    mov x2, #0           // Índice de posición en la cadena (64 bits para el offset)

1:
    ldrb w3, [x0, x2]    // Leer el siguiente carácter de la cadena (con offset en x2)
    cmp w3, #0           // ¿Es el final de la cadena (valor nulo)?
    beq fin              // Si es el final de la cadena, salir del bucle

    sub w3, w3, #'0'     // Convertir ASCII a dígito (restar '0')
    
    // Multiplicar el resultado acumulado por 10
    mov w4, #10          // Usar un registro temporal para la constante 10
    mul w1, w1, w4       // Multiplicar w1 por 10 usando w4
    add w1, w1, w3       // Sumar el dígito al resultado acumulado

    add x2, x2, #1       // Avanzar al siguiente carácter
    b 1b                 // Repetir

fin:
    mov w0, w1           // Colocar el resultado en w0 para retornar
    ret
