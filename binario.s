// Autor: Cortez Huerta Gonzalo
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que convierte de binario a decimal

// Equivalente en C#:
/*
using System;
using System.Runtime.InteropServices;
using System.Text.RegularExpressions;

class Program
{
    [DllImport("binario.so", EntryPoint = "binary_to_decimal")]
    private static extern long BinaryToDecimal(string binary);

    [DllImport("binario.so", EntryPoint = "get_error")]
    private static extern int GetError();

    static void Main()
    {
        while (true)
        {
            Console.WriteLine("\nConversor de Binario a Decimal");
            Console.WriteLine("1. Convertir número binario");
            Console.WriteLine("0. Salir");
            Console.Write("Seleccione una opción: ");

            if (int.TryParse(Console.ReadLine(), out int opcion))
            {
                switch (opcion)
                {
                    case 1:
                        Console.Write("\nIngrese un número binario (solo 0s y 1s): ");
                        string entrada = Console.ReadLine()?.Trim();

                        if (string.IsNullOrEmpty(entrada))
                        {
                            Console.WriteLine("Error: Entrada vacía.");
                            break;
                        }

                        // Verificar longitud máxima (64 bits)
                        if (entrada.Length > 64)
                        {
                            Console.WriteLine("Error: El número binario no puede tener más de 64 dígitos.");
                            break;
                        }

                        // Verificar que solo contenga 0s y 1s
                        if (!Regex.IsMatch(entrada, "^[01]+$"))
                        {
                            Console.WriteLine("Error: El número debe contener solo 0s y 1s.");
                            break;
                        }

                        long resultado = BinaryToDecimal(entrada);
                        
                        if (GetError() != 0 || resultado == -1)
                        {
                            Console.WriteLine("Error al convertir el número.");
                            break;
                        }

                        Console.WriteLine($"\nNúmero binario: {entrada}");
                        Console.WriteLine($"Número decimal: {resultado}");
                        
                        // Mostrar información adicional
                        Console.WriteLine($"Cantidad de bits: {entrada.Length}");
                        Console.WriteLine($"Primer bit (MSB): {entrada[0]}");
                        Console.WriteLine($"Último bit (LSB): {entrada[entrada.Length - 1]}");
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
    error_flag: .word 0        // Flag para indicar error en la entrada

.text
.align 2
.global binary_to_decimal
.global get_error
.global clear_error

// Función para convertir binario a decimal
// Entrada: x0 = dirección del string binario
// Salida: x0 = número decimal resultante
binary_to_decimal:
    stp     x29, x30, [sp, -48]!
    mov     x29, sp
    stp     x19, x20, [sp, 16]     // Guardar registros que usaremos
    stp     x21, x22, [sp, 32]

    // Inicializar registros
    mov     x19, x0                 // Guardar dirección del string
    mov     x20, #0                 // Resultado decimal
    mov     x21, #0                 // Índice actual
    mov     x22, #1                 // Valor de potencia de 2

    // Limpiar flag de error
    bl      clear_error

validate_loop:
    // Cargar carácter actual
    ldrb    w0, [x19, x21]
    
    // Si es null (fin del string), terminar validación
    cbz     w0, start_conversion
    
    // Verificar si es '0' o '1'
    cmp     w0, #'0'
    b.lt    invalid_input
    cmp     w0, #'1'
    b.gt    invalid_input
    
    // Siguiente carácter
    add     x21, x21, #1
    b       validate_loop

invalid_input:
    // Marcar error y retornar
    bl      set_error
    mov     x0, #-1
    b       end_conversion

start_conversion:
    // x21 ahora tiene la longitud del string
    mov     x22, #1                 // Reiniciar potencia de 2
    mov     x20, #0                 // Reiniciar resultado
    
convert_loop:
    // Si ya procesamos todos los dígitos, terminar
    cbz     x21, end_conversion
    
    // Decrementar índice para procesar desde el último dígito
    sub     x21, x21, #1
    
    // Cargar dígito actual
    ldrb    w0, [x19, x21]
    
    // Si es '1', sumar la potencia actual
    cmp     w0, #'1'
    b.ne    next_digit
    
    // Sumar potencia actual al resultado
    add     x20, x20, x22
    
next_digit:
    // Multiplicar potencia por 2
    lsl     x22, x22, #1
    b       convert_loop

end_conversion:
    mov     x0, x20                 // Mover resultado a x0
    
    // Restaurar registros
    ldp     x19, x20, [sp, 16]
    ldp     x21, x22, [sp, 32]
    ldp     x29, x30, [sp], 48
    ret

// Función para establecer error
set_error:
    adrp    x0, error_flag
    add     x0, x0, :lo12:error_flag
    mov     w1, #1
    str     w1, [x0]
    ret

// Función para limpiar error
clear_error:
    adrp    x0, error_flag
    add     x0, x0, :lo12:error_flag
    str     wzr, [x0]
    ret

// Función para obtener estado de error
get_error:
    adrp    x0, error_flag
    add     x0, x0, :lo12:error_flag
    ldr     w0, [x0]
    ret
