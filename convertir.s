// Autor: Cortez Huerta Gonzalo
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que convierte de decimal a binario

// Equivalente en C#:
/*
using System;
using System.Runtime.InteropServices;
using System.Text;

class Program
{
    [DllImport("convertir.so", EntryPoint = "decimal_to_binary")]
    private static extern void DecimalToBinary(long number);

    [DllImport("convertir.so", EntryPoint = "get_bit")]
    private static extern long GetBit(int index);

    [DllImport("convertir.so", EntryPoint = "get_size")]
    private static extern int GetSize();

    static string GetBinaryString(long number)
    {
        DecimalToBinary(number);
        int size = GetSize();
        StringBuilder result = new StringBuilder();

        // Construir el string binario desde el último bit hasta el primero
        for (int i = size - 1; i >= 0; i--)
        {
            result.Append(GetBit(i));
        }

        return result.ToString();
    }

    static void Main()
    {
        while (true)
        {
            Console.WriteLine("\nConversor de Decimal a Binario");
            Console.WriteLine("1. Convertir número");
            Console.WriteLine("0. Salir");
            Console.Write("Seleccione una opción: ");

            if (int.TryParse(Console.ReadLine(), out int opcion))
            {
                switch (opcion)
                {
                    case 1:
                        Console.Write("\nIngrese un número decimal (0-9223372036854775807): ");
                        if (long.TryParse(Console.ReadLine(), out long numero))
                        {
                            if (numero < 0)
                            {
                                Console.WriteLine("Por favor, ingrese un número positivo.");
                                break;
                            }

                            string binario = GetBinaryString(numero);
                            Console.WriteLine($"\nNúmero decimal: {numero}");
                            Console.WriteLine($"Número binario: {binario}");
                            
                            // Mostrar información adicional
                            Console.WriteLine($"Cantidad de bits: {binario.Length}");
                            if (binario.Length > 0)
                            {
                                Console.WriteLine($"Bit más significativo: {binario[0]}");
                                Console.WriteLine($"Bit menos significativo: {binario[binario.Length - 1]}");
                            }
                        }
                        else
                        {
                            Console.WriteLine("Error: Ingrese un número válido.");
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
    binary_array: .skip 64      // Espacio para 64 bits (suficiente para un long)
    result_size: .word 0        // Cantidad de bits en el resultado

.text
.align 2
.global decimal_to_binary
.global get_bit
.global get_size

// Función para convertir decimal a binario
// Entrada: x0 = número decimal
decimal_to_binary:
    stp     x29, x30, [sp, -32]!
    mov     x29, sp
    str     x19, [sp, 16]      // Guardar x19 para usarlo
    
    mov     x19, x0            // Guardar número original en x19
    
    // Reiniciar contador de bits
    adrp    x0, result_size
    add     x0, x0, :lo12:result_size
    str     wzr, [x0]
    
    // Si el número es 0, manejar caso especial
    cbnz    x19, conversion_loop
    
    // Caso especial para 0
    adrp    x0, binary_array
    add     x0, x0, :lo12:binary_array
    strb    wzr, [x0]
    
    adrp    x0, result_size
    add     x0, x0, :lo12:result_size
    mov     w1, #1
    str     w1, [x0]
    b       end_conversion

conversion_loop:
    // Mientras el número no sea 0
    cbz     x19, end_conversion
    
    // Obtener el bit actual (número & 1)
    and     w1, w19, #1
    
    // Obtener índice actual
    adrp    x2, result_size
    add     x2, x2, :lo12:result_size
    ldr     w3, [x2]
    
    // Guardar el bit en el array
    adrp    x4, binary_array
    add     x4, x4, :lo12:binary_array
    strb    w1, [x4, x3]
    
    // Incrementar contador
    add     w3, w3, #1
    str     w3, [x2]
    
    // Dividir número entre 2 (shift right)
    lsr     x19, x19, #1
    
    b       conversion_loop

end_conversion:
    ldr     x19, [sp, 16]      // Restaurar x19
    ldp     x29, x30, [sp], 32
    ret

// Función para obtener un bit específico del resultado
// Entrada: x0 = índice del bit
// Salida: x0 = valor del bit (0 o 1)
get_bit:
    stp     x29, x30, [sp, -16]!
    mov     x29, sp
    
    // Verificar que el índice sea válido
    adrp    x1, result_size
    add     x1, x1, :lo12:result_size
    ldr     w1, [x1]
    cmp     w0, w1
    b.ge    invalid_index
    
    // Obtener el bit del array
    adrp    x1, binary_array
    add     x1, x1, :lo12:binary_array
    ldrb    w0, [x1, x0]
    
    ldp     x29, x30, [sp], 16
    ret

invalid_index:
    mov     x0, #-1            // Retornar -1 para índice inválido
    ldp     x29, x30, [sp], 16
    ret

// Función para obtener el tamaño del resultado binario
// Salida: x0 = cantidad de bits
get_size:
    adrp    x0, result_size
    add     x0, x0, :lo12:result_size
    ldr     w0, [x0]
    ret
