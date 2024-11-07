.section .data
.section .text
.global busqueda_lineal

// Función para realizar una búsqueda lineal en un arreglo
// Parámetros de entrada: x0 (puntero al arreglo), x1 (número de elementos), x2 (valor a buscar)
// Retorno: x0 contiene el índice del elemento si se encuentra, o -1 si no está presente

busqueda_lineal:
    mov w3, -1             // Configurar -1 como valor de retorno por defecto (no encontrado)
    cbz x1, fin            // Si el tamaño es 0, regresar de inmediato (arreglo vacío)

buscar:
    ldr w4, [x0], #4       // Cargar el siguiente elemento en w4 y avanzar el puntero
    cmp w4, w2             // Comparar el elemento actual con el valor buscado
    beq encontrado         // Si son iguales, ir a la etiqueta "encontrado"

    sub x1, x1, #1         // Decrementar el contador de elementos
    add w3, w3, #1         // Incrementar el índice
    cbnz x1, buscar        // Si hay más elementos, continuar la búsqueda

    mov w3, -1             // Si no se encontró, establecer el retorno en -1

fin:
    mov w0, w3             // Colocar el índice en w0
    ret                    // Retornar

encontrado:
    ret                    // Retornar con el índice actual en w3
