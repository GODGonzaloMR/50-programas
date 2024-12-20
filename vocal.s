// Autor: Cortez Huerta Gonzalo
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que cuenta las vocales y consonantes

// Equivalente en C#:
/*
using System;
using System.Runtime.InteropServices;

class ConvertidorVocales
{
    // Declaración de la función en ensamblador
    [DllImport("libcalculations.so")]
    public static extern void contar_vocales_consonantes(byte[] cadena, out long vocales, out long consonantes);

    static void Main()
    {
        Console.WriteLine("Ingrese una cadena: ");
        string input = Console.ReadLine();

        // Convertir la cadena a un arreglo de bytes
        byte[] cadena = System.Text.Encoding.ASCII.GetBytes(input + '\0'); // Agregar terminador nulo

        long vocales, consonantes;
        contar_vocales_consonantes(cadena, out vocales, out consonantes);

        Console.WriteLine($"Vocales: {vocales}, Consonantes: {consonantes}");
    }
}
*/
.global contar_vocales_consonantes

.section .text
contar_vocales_consonantes:
    // x0 = puntero a la cadena
    // x1 = puntero al contador de vocales
    // x2 = puntero al contador de consonantes
    
    // Guardar registros
    stp x29, x30, [sp, #-16]!
    stp x19, x20, [sp, #-16]!  // x19 = vocales, x20 = consonantes
    
    // Inicializar contadores
    mov x19, #0     // vocales = 0
    mov x20, #0     // consonantes = 0
    mov x4, #0      // índice = 0

loop:
    // Cargar carácter actual
    ldrb w3, [x0, x4]
    
    // Si es fin de cadena, terminar
    cbz w3, done
    
    // Convertir a minúscula si es mayúscula
    sub w5, w3, #'A'
    cmp w5, #25
    bhi not_upper
    add w3, w3, #32
    
not_upper:
    // Verificar si es letra minúscula
    sub w5, w3, #'a'
    cmp w5, #25
    bhi next_char
    
    // Comprobar si es vocal
    mov w6, #'a'
    cmp w3, w6
    beq is_vowel
    mov w6, #'e'
    cmp w3, w6
    beq is_vowel
    mov w6, #'i'
    cmp w3, w6
    beq is_vowel
    mov w6, #'o'
    cmp w3, w6
    beq is_vowel
    mov w6, #'u'
    cmp w3, w6
    beq is_vowel
    
    // Si no es vocal, es consonante
    add x20, x20, #1
    b next_char
    
is_vowel:
    add x19, x19, #1
    
next_char:
    add x4, x4, #1
    b loop
    
done:
    // Guardar resultados en las direcciones proporcionadas
    str x19, [x1]    // guardar vocales
    str x20, [x2]    // guardar consonantes
    
    // Restaurar registros
    ldp x19, x20, [sp], #16
    ldp x29, x30, [sp], #16
    ret
