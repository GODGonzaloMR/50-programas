.section .data
.section .text
.global busqueda_binaria

// Función para realizar una búsqueda binaria en un arreglo ordenado
// Parámetros de entrada: x0 (puntero al arreglo), x1 (número de elementos), x2 (valor a buscar)
// Retorno: x0 contiene el índice del elemento si se encuentra, o -1 si no está presente

busqueda_binaria:
    mov x3, 0               // Índice inicial (left)
    sub x4, x1, 1           // Índice final (right) = tamaño - 1

bucle:
    cmp x3, x4              // Si left > right, salir del bucle (elemento no encontrado)
    bgt no_encontrado

    add x5, x3, x4          // Calcular el índice medio
    lsr x5, x5, 1           // x5 = (left + right) / 2

    ldr w6, [x0, x5, lsl #2] // Cargar el valor en el índice medio
    cmp w6, w2              // Comparar el valor en el medio con el valor buscado

    beq encontrado          // Si es igual, se encontró el elemento
    blt mover_izquierda     // Si es menor, mover right a la izquierda del medio

    // Si el valor buscado es mayor, mover left a la derecha del medio
    add x3, x5, 1           
    b bucle

mover_izquierda:
    sub x4, x5, 1           // Mover right a la izquierda del medio
    b bucle

encontrado:
    mov x0, x5              // Colocar el índice encontrado en x0
    ret

no_encontrado:
    mov x0, -1              // Si no se encontró, retornar -1
    ret
