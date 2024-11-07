// arreglo.s - Ensamblador ARM64 para sumar los elementos de un arreglo

.global suma_arreglo

// Función que calcula la suma de un arreglo
// Entrada: x0 = puntero al arreglo, x1 = tamaño del arreglo
// Salida: x0 = suma de los elementos
suma_arreglo:
    // Guardar registros
    stp x29, x30, [sp, -16]!
    mov x29, sp

    // Inicializar la suma en x2 a 0
    mov x2, 0

suma_loop:
    // Comprobar si el tamaño (x1) es 0
    cmp x1, 0
    beq suma_done

    // Cargar el valor actual del arreglo en x3
    ldr x3, [x0], 8      // Cargar valor de x0 y avanzar el puntero en 8 bytes (para enteros de 64 bits)
    add x2, x2, x3       // Sumar el valor en x2

    // Decrementar el tamaño del arreglo
    sub x1, x1, 1
    b suma_loop          // Repetir el bucle

suma_done:
    // Mover el resultado a x0
    mov x0, x2

    // Restaurar registros y retornar
    ldp x29, x30, [sp], 16
    ret
