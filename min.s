.section .data
.section .text
.global encontrar_minimo

// Función para encontrar el mínimo en un arreglo
// Parámetros de entrada: x0 (puntero al arreglo), x1 (número de elementos)
// Retorno: x0 contiene el valor mínimo

encontrar_minimo:
    cbz x1, fin             // Si el tamaño es 0, regresar de inmediato (sin elementos)

    ldr w2, [x0], #4        // Cargar el primer elemento del arreglo en w2 y avanzar el puntero
    sub x1, x1, #1          // Decrementar el contador de elementos

buscar_min:
    cbz x1, fin             // Si ya no hay más elementos, salir del bucle

    ldr w3, [x0], #4        // Cargar el siguiente elemento en w3 y avanzar el puntero
    cmp w3, w2              // Comparar el elemento actual con el mínimo
    bge siguiente           // Si el actual es mayor o igual, pasar al siguiente
    mov w2, w3              // Si el actual es menor, actualizar el mínimo

siguiente:
    sub x1, x1, #1          // Decrementar el contador de elementos
    b buscar_min            // Repetir el ciclo para el siguiente elemento

fin:
    mov w0, w2              // Colocar el mínimo encontrado en w0 (resultado)
    ret                     // Retornar
