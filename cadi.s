.global LongestCommonPrefix

// Función para encontrar el prefijo común más largo
LongestCommonPrefix:
    stp x29, x30, [sp, -16]!   // Guardar el frame anterior y el link register
    mov x29, sp                 // Crear un nuevo frame
    mov x3, x0                  // Dirección de la primera cadena
    mov x4, x1                  // Dirección de la segunda cadena
    mov w5, 0                   // Contador de caracteres en común

compara_caracteres:
    uxtw x6, w5                 // Expandir w5 a 64 bits en x6
    ldrb w7, [x3, x6]           // Leer el carácter de la primera cadena
    ldrb w8, [x4, x6]           // Leer el carácter de la segunda cadena
    cmp w7, w8                  // Comparar los caracteres
    b.ne fin                    // Si no son iguales, fin del prefijo común
    cmp w7, 0                   // Si encontramos un nulo, también terminar
    b.eq fin
    add w5, w5, 1               // Incrementar el contador de caracteres en común
    b compara_caracteres

fin:
    mov w0, w5                  // El resultado es el número de caracteres en común
    ldp x29, x30, [sp], 16      // Restaurar el frame y el link register
    ret
