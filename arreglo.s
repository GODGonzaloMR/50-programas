.section .data
.section .text
.global encontrar_maximo

// Función para encontrar el máximo en un arreglo
// Parámetros de entrada: x0 (puntero al arreglo), x1 (número de elementos)
// Retorno: x0 contiene el valor máximo

encontrar_maximo:
    cbz x1, fin             // Si el tamaño es 0, regresar de inmediato (sin elementos)

    ldr w2, [x0], #4        // Cargar el primer elemento del arreglo en w2 y avanzar el puntero
    sub x1, x1, #1          // Decrementar el contador de elementos

buscar_max:
    cbz x1, fin             // Si ya no hay más elementos, salir del bucle

    ldr w3, [x0], #4        // Cargar el siguiente elemento en w3 y avanzar el puntero
    cmp w3, w2              // Comparar el elemento actual con el máximo
    ble siguiente           // Si el actual es menor o igual, pasar al siguiente
    mov w2, w3              // Si el actual es mayor, actualizar el máximo

siguiente:
    sub x1, x1, #1          // Decrementar el contador de elementos
    b buscar_max            // Repetir el ciclo para el siguiente elemento

fin:
    mov w0, w2              // Colocar el máximo encontrado en w0 (resultado)
    ret                     // Retornar
