.section .text
.global calcular_mcd

calcular_mcd:
    // Preservar registros
    stp x29, x30, [sp, #-16]!
    
    // x0: primer número
    // x1: segundo número
    
    // Verificar que x1 no sea 0
    cmp x1, #0
    beq .fin
    
.loop:
    // Algoritmo de Euclides
    udiv x2, x0, x1     // x2 = x0 / x1
    msub x2, x2, x1, x0 // x2 = x0 - (x2 * x1) [remainder]
    mov x0, x1          // x0 = x1
    mov x1, x2          // x1 = remainder
    
    cmp x1, #0          // Comparar si el remainder es 0
    bne .loop           // Si no es 0, continuar el loop
    
.fin:
    // Restaurar registros y retornar
    ldp x29, x30, [sp], #16
    ret
