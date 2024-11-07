.section .text
.global suma_matrices

suma_matrices:
    // Se espera que A, B, C sean punteros a enteros y rows y cols sean los tamaños de la matriz
    // A: x0, B: x1, C: x2, rows: x3, cols: x4

    // Inicializar índices
    mov x5, #0         // i = 0
outer_loop:
    cmp x5, x3         // Comparar i con rows
    bge end_outer_loop // Si i >= rows, salir del bucle

    mov x6, #0         // j = 0
inner_loop:
    cmp x6, x4         // Comparar j con cols
    bge end_inner_loop // Si j >= cols, salir del bucle

    // Calcular el índice en la matriz
    mul x7, x5, x4     // x7 = i * cols
    add x7, x7, x6     // x7 = i * cols + j

    // C = A + B
    ldr w8, [x0, x7, lsl #2] // Cargar A[i][j]
    ldr w9, [x1, x7, lsl #2] // Cargar B[i][j]
    add w10, w8, w9    // w10 = A[i][j] + B[i][j]
    str w10, [x2, x7, lsl #2] // Guardar en C[i][j]

    add x6, x6, #1     // j++
    b inner_loop        // Repetir el bucle interno

end_inner_loop:
    add x5, x5, #1     // i++
    b outer_loop        // Repetir el bucle externo

end_outer_loop:
    ret
