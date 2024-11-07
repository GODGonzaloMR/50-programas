// rotacion.s - Ensamblador ARM64 para rotar los elementos de un arreglo

.global rotar_arreglo

// Función que rota un arreglo a la izquierda o derecha
// Entrada: x0 = puntero al arreglo, x1 = tamaño del arreglo, x2 = número de posiciones, x3 = dirección (0 = izquierda, 1 = derecha)
rotar_arreglo:
    // Guardar registros
    stp x29, x30, [sp, -16]!
    mov x29, sp

    // Ajustar el número de posiciones para que esté dentro del tamaño del arreglo
    udiv x2, x2, x1      // x2 %= x1 (número de rotaciones efectivas)

    // Si el tamaño es 0 o la rotación es nula, regresar
    cbz x1, rotacion_done
    cbz x2, rotacion_done

    // Seleccionar dirección de rotación
    cmp x3, 0
    beq rotacion_izquierda
    b rotacion_derecha

rotacion_izquierda:
    // Guardar el primer elemento temporalmente y hacer un shift a la izquierda
    ldr x4, [x0]                 // Guardar el primer elemento en x4
    add x5, x0, 8                // Puntero al siguiente elemento

rotacion_izq_loop:
    // Desplazar elementos
    cmp x1, 1
    b.le rotacion_izq_store      // Si sólo queda un elemento, almacenar x4
    ldr x6, [x5]                 // Cargar el siguiente elemento
    str x6, [x0], 8              // Desplazar a la izquierda
    mov x5, x0                   // Mover puntero
    sub x1, x1, 1
    b rotacion_izq_loop

rotacion_izq_store:
    str x4, [x0]
    b rotacion_done

rotacion_derecha:
    // Guardar el último elemento temporalmente y hacer un shift a la derecha
    add x5, x0, x1, lsl #3       // Puntero al último elemento
    sub x5, x5, 8                // Ajustar para último índice
    ldr x4, [x5]                 // Guardar último elemento en x4

rotacion_der_loop:
    // Desplazar elementos
    cmp x1, 1
    b.le rotacion_der_store      // Si sólo queda un elemento, almacenar x4
    ldr x6, [x5, -8]             // Cargar el elemento anterior
    str x6, [x5]                 // Desplazar a la derecha
    mov x5, x5                   // Ajustar puntero
    sub x1, x1, 1
    b rotacion_der_loop

rotacion_der_store:
    str x4, [x5]
    b rotacion_done

rotacion_done:
    // Restaurar registros y retornar
    ldp x29, x30, [sp], 16
    ret
