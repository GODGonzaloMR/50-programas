// Autor: Cortez Huerta Gonzalo
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que covierte emteros a hexadecimal

// Equivalente en C#:
/*
using System;
using System.Runtime.InteropServices;

class Entero
{
    // Declaración de la función en la biblioteca compartida
    [DllImport("libcalculations.so")]
    public static extern void entero_a_ascii(long numero, byte[] buffer, int baseNum);

    static void Main()
    {
        Console.Write("Ingrese el número entero a convertir: ");
        long numero = Convert.ToInt64(Console.ReadLine());

        Console.Write("Ingrese la base (por ejemplo, 10 para decimal, 16 para hexadecimal): ");
        int baseNum = Convert.ToInt32(Console.ReadLine());

        // Crear un buffer suficientemente grande para almacenar el resultado ASCII
        byte[] buffer = new byte[20];

        // Llamar a la función ensambladora para convertir el número
        entero_a_ascii(numero, buffer, baseNum);

        // Buscar el índice del byte nulo (0) para evitar errores de conversión
        int nullIndex = Array.IndexOf(buffer, (byte)0);
        if (nullIndex == -1) nullIndex = buffer.Length;  // Si no hay byte nulo, usa toda la longitud

        // Convertir el buffer de bytes a una cadena en C#, solo hasta el byte nulo
        string resultado = System.Text.Encoding.ASCII.GetString(buffer, 0, nullIndex);
        
        Console.WriteLine($"El número {numero} en base {baseNum} es: {resultado}");
    }
}
*/
.global entero_a_ascii
entero_a_ascii:
    mov x3, x0          // x3 = número a convertir
    mov x4, x2          // x4 = base
    mov x5, x1          // x5 = puntero al buffer
    mov x6, #0          // x6 = índice en el buffer

convertir_digito:
    // Divide x3 entre x4 y guarda el resultado en x7
    udiv x7, x3, x4
    // Calcula el residuo (x3 % x4)
    msub x8, x7, x4, x3 // x8 = x3 - (x7 * x4)

    // Convierte el residuo a ASCII
    cmp x8, #9
    ble convertir_numero // Si el residuo es <= 9

    // Para valores de 10 a 15, convertimos a 'A' (10) a 'F' (15)
    add x8, x8, #'A' - 10
    b guardar_caracter

convertir_numero:
    add x8, x8, #'0' // Convierte 0-9 a ASCII

guardar_caracter:
    // Guarda el carácter en el buffer
    strb w8, [x5, x6]
    add x6, x6, #1    // Incrementa el índice en el buffer

    // Actualiza x3 para la siguiente iteración
    mov x3, x7
    cbnz x3, convertir_digito // Si x3 no es cero, repite

    // Termina la cadena con un byte nulo
    mov w8, #0
    strb w8, [x5, x6]

    // Invertir el buffer (opcional)
    mov x9, x1          // x9 = inicio del buffer
    sub x10, x6, #1     // x10 = final del buffer (sin incluir el byte nulo)

invertir:
    cmp x9, x10
    b.ge fin            // Terminar si x9 >= x10

    ldrb w11, [x9]      // Cargar byte en x9
    ldrb w12, [x10]     // Cargar byte en x10
    strb w12, [x9]      // Intercambiar bytes
    strb w11, [x10]

    add x9, x9, #1
    sub x10, x10, #1
    b invertir

fin:
    ret
