.section .data
.section .text
.global fibonacci

fibonacci:
    cmp x0, 0                  // Comparar n con 0
    beq end                    // Si n == 0, retornar 0
    cmp x0, 1                  // Comparar n con 1
    beq one                    // Si n == 1, retornar 1

    // Preparar para la llamada recursiva
    sub x1, x0, 1              // x1 = n - 1
    mov x0, x1                 // Pasar n - 1 a x0
    bl fibonacci               // Llamar a fibonacci(n - 1)
    mov x2, x0                 // Guardar resultado de fibonacci(n - 1)

    sub x1, x0, 2              // x1 = n - 2
    mov x0, x1                 // Pasar n - 2 a x0
    bl fibonacci               // Llamar a fibonacci(n - 2)

    add x0, x0, x2             // x0 = fibonacci(n - 1) + fibonacci(n - 2)
    ret

one:
    mov x0, 1                  // Retornar 1 si n == 1
    ret

end:
    mov x0, 0                  // Retornar 0 si n == 0
    ret
