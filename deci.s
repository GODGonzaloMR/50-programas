// Autor: Cortez Huerta Gonzalo
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que convierte de decimal a hexadecimal

// Equivalente en C#:
/*
using System;
using System.Runtime.InteropServices;
using System.Text;

class Program
{
    [DllImport("deci.so", EntryPoint = "decimal_to_hex")]
    private static extern void DecimalToHex(long number);

    [DllImport("deci.so", EntryPoint = "get_hex_char")]
    private static extern char GetHexChar(int index);

    [DllImport("deci.so", EntryPoint = "get_length")]
    private static extern int GetLength();

    static string GetHexString(long number)
    {
        DecimalToHex(number);
        int length = GetLength();
        StringBuilder result = new StringBuilder();

        for (int i = 0; i < length; i++)
        {
            result.Append(GetHexChar(i));
        }

        return result.ToString();
    }

    static void Main()
    {
        while (true)
        {
            Console.WriteLine("\nConversor de Decimal a Hexadecimal");
            Console.WriteLine("1. Convertir número");
            Console.WriteLine("2. Ver tabla de conversión (0-15)");
            Console.WriteLine("0. Salir");
            Console.Write("Seleccione una opción: ");

            if (int.TryParse(Console.ReadLine(), out int opcion))
            {
                switch (opcion)
                {
                    case 1:
                        Console.Write("\nIngrese un número decimal positivo: ");
                        if (long.TryParse(Console.ReadLine(), out long numero))
                        {
                            if (numero < 0)
                            {
                                Console.WriteLine("Por favor, ingrese un número positivo.");
                                break;
                            }

                            string hexadecimal = GetHexString(numero);
                            Console.WriteLine($"\nNúmero decimal: {numero}");
                            Console.WriteLine($"Número hexadecimal: 0x{hexadecimal}");
                            
                            // Información adicional
                            Console.WriteLine($"Longitud: {hexadecimal.Length} dígitos");
                            if (hexadecimal.Length > 0)
                            {
                                Console.WriteLine($"Dígito más significativo: {hexadecimal[0]}");
                                Console.WriteLine($"Dígito menos significativo: {hexadecimal[hexadecimal.Length - 1]}");
                            }
                        }
                        else
                        {
                            Console.WriteLine("Error: Ingrese un número válido.");
                        }
                        break;

                    case 2:
                        Console.WriteLine("\nTabla de conversión (0-15):");
                        Console.WriteLine("Decimal -> Hexadecimal");
                        Console.WriteLine("--------------------");
                        for (int i = 0; i <= 15; i++)
                        {
                            string hex = GetHexString(i);
                            Console.WriteLine($"{i,7} -> 0x{hex}");
                        }
                        break;

                    case 0:
                        Console.WriteLine("Saliendo del programa...");
                        return;

                    default:
                        Console.WriteLine("Opción no válida.");
                        break;
                }
            }
            else
            {
                Console.WriteLine("Error: Ingrese un número válido.");
            }
        }
    }
}
*/
.data
    .align 3
    hex_array: .skip 32         // Buffer para almacenar resultado hexadecimal
    result_length: .word 0      // Longitud del resultado
    hex_chars: .ascii "0123456789ABCDEF"  // Caracteres hexadecimales

.text
.align 2
.global decimal_to_hex
.global get_hex_char
.global get_length

// Función para convertir decimal a hexadecimal
// Entrada: x0 = número decimal
decimal_to_hex:
    stp     x29, x30, [sp, -48]!
    mov     x29, sp
    stp     x19, x20, [sp, 16]
    stp     x21, x22, [sp, 32]

    mov     x19, x0            // Guardar número original
    
    // Reiniciar contador de longitud
    adrp    x0, result_length
    add     x0, x0, :lo12:result_length
    str     wzr, [x0]
    
    // Si el número es 0, manejar caso especial
    cbnz    x19, conversion_loop
    
    // Caso especial para 0
    adrp    x0, hex_array
    add     x0, x0, :lo12:hex_array
    mov     w1, '0'
    strb    w1, [x0]
    
    adrp    x0, result_length
    add     x0, x0, :lo12:result_length
    mov     w1, #1
    str     w1, [x0]
    b       end_conversion

conversion_loop:
    // Mientras el número no sea 0
    cbz     x19, reverse_result
    
    // Obtener residuo (número & 0xF)
    and     x20, x19, #0xF
    
    // Obtener carácter hexadecimal correspondiente
    adrp    x21, hex_chars
    add     x21, x21, :lo12:hex_chars
    ldrb    w20, [x21, x20]
    
    // Guardar carácter en el array
    adrp    x21, result_length
    add     x21, x21, :lo12:result_length
    ldr     w22, [x21]
    
    adrp    x0, hex_array
    add     x0, x0, :lo12:hex_array
    strb    w20, [x0, x22]
    
    // Incrementar longitud
    add     w22, w22, #1
    str     w22, [x21]
    
    // Dividir número entre 16
    lsr     x19, x19, #4
    
    b       conversion_loop

reverse_result:
    // Invertir el resultado ya que se generó al revés
    adrp    x0, hex_array
    add     x0, x0, :lo12:hex_array
    adrp    x1, result_length
    add     x1, x1, :lo12:result_length
    ldr     w1, [x1]           // w1 = longitud
    
    mov     x2, #0             // índice inicio
    sub     w3, w1, #1         // índice final
    
reverse_loop:
    cmp     w2, w3
    b.ge    end_conversion
    
    // Intercambiar caracteres
    ldrb    w4, [x0, x2]
    ldrb    w5, [x0, x3]
    strb    w5, [x0, x2]
    strb    w4, [x0, x3]
    
    add     w2, w2, #1
    sub     w3, w3, #1
    b       reverse_loop

end_conversion:
    ldp     x19, x20, [sp, 16]
    ldp     x21, x22, [sp, 32]
    ldp     x29, x30, [sp], 48
    ret

// Función para obtener un carácter del resultado
// Entrada: x0 = índice
// Salida: x0 = carácter en esa posición
get_hex_char:
    stp     x29, x30, [sp, -16]!
    mov     x29, sp
    
    adrp    x1, result_length
    add     x1, x1, :lo12:result_length
    ldr     w1, [x1]
    cmp     w0, w1
    b.ge    invalid_index
    
    adrp    x1, hex_array
    add     x1, x1, :lo12:hex_array
    ldrb    w0, [x1, x0]
    
    ldp     x29, x30, [sp], 16
    ret

invalid_index:
    mov     x0, #0
    ldp     x29, x30, [sp], 16
    ret

// Función para obtener la longitud del resultado
get_length:
    adrp    x0, result_length
    add     x0, x0, :lo12:result_length
    ldr     w0, [x0]
    ret
