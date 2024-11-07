// trans.s - Transposición de una matriz
// Entrada: Puntero a la matriz de entrada, puntero a la matriz de salida, filas y columnas de la matriz

.global transponer_matriz

transponer_matriz:
    // Registros de entrada:
    // x0 - puntero a la matriz de entrada
    // x1 - puntero a la matriz de salida
    // x2 - número de filas (m)
    // x3 - número de columnas (n)

    mov x4, #0          // Índice fila (i)
1:
    cmp x4, x2          // ¿i >= m?
    bge fin             // Si i >= m, fin del bucle

    mov x5, #0          // Índice columna (j)
2:
    cmp x5, x3          // ¿j >= n?
    bge siguiente_fila  // Si j >= n, pasar a la siguiente fila

    // Calcular el índice en la matriz original
    mul x6, x4, x3      // x6 = i * n
    add x6, x6, x5      // x6 = i * n + j
    ldr w7, [x0, x6, LSL #2] // Cargar elemento de entrada

    // Calcular el índice transpuesto
    mul x8, x5, x2      // x8 = j * m
    add x8, x8, x4      // x8 = j * m + i
    str w7, [x1, x8, LSL #2] // Guardar elemento en la matriz transpuesta

    add x5, x5, #1      // j++
    b 2b                // Repetir columna

siguiente_fila:
    add x4, x4, #1      // i++
    b 1b                // Repetir fila

fin:
    ret
