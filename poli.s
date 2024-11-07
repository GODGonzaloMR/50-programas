.section .data
.section .text
.global es_palindromo

// Función para verificar si una cadena es un palíndromo
// Parámetro de entrada: x0 (puntero a la cadena)
// Retorno: x0 = 1 si es palíndromo, x0 = 0 si no lo es

es_palindromo:
    // Encuentra la longitud de la cadena
    mov x1, x0             // x1 apunta al inicio de la cadena
find_end:
    ldrb w2, [x1], #1      // Leer el siguiente byte (carácter) y avanzar
    cbz w2, check_palindrome // Si llegamos al final ('\0'), comenzar verificación

    b find_end             // Continuar hasta encontrar el final

check_palindrome:
    sub x1, x1, #2         // Retroceder una posición (x1 apunta al último carácter)
    mov x2, x1             // x2 apunta al final de la cadena
    mov x3, x0             // x3 apunta al inicio de la cadena

compare_loop:
    cmp x3, x2             // Comparar el inicio con el final
    bge is_palindrome      // Si se cruzan, es un palíndromo

    ldrb w4, [x3]          // Leer carácter desde el inicio
    ldrb w5, [x2]          // Leer carácter desde el final
    cmp w4, w5             // Comparar caracteres
    bne not_palindrome     // Si no son iguales, no es palíndromo

    add x3, x3, #1         // Avanzar el inicio
    sub x2, x2, #1         // Retroceder el final

    b compare_loop         // Repetir la comparación

is_palindrome:
    mov w0, 1              // Retornar 1 si es palíndromo
    ret

not_palindrome:
    mov w0, 0              // Retornar 0 si no es palíndromo
    ret
