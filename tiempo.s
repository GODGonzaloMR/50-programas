.global FuncionDePrueba

// Función de prueba que realiza operaciones matemáticas en un bucle
// Parámetro x0: número de iteraciones
// Retorna: resultado de las operaciones
FuncionDePrueba:
    // Guardar registros
    stp x29, x30, [sp, #-16]!
    stp x19, x20, [sp, #-16]!
    
    // Guardar el número de iteraciones
    mov x19, x0
    
    // Inicializar acumulador y constantes
    mov x1, #1          // Acumulador
    mov x3, #7          // Constante para multiplicación
    mov x4, #3          // Constante para división
    
bucle:
    // Verificar si quedan iteraciones
    cbz x19, fin
    
    // Realizar algunas operaciones matemáticas
    add x1, x1, x1      // x1 = x1 + x1
    lsr x2, x1, #1      // x2 = x1 >> 1
    add x1, x1, x2      // x1 = x1 + x2
    mul x1, x1, x3      // x1 = x1 * 7
    udiv x1, x1, x4     // x1 = x1 / 3
    
    // Decrementar contador
    sub x19, x19, #1
    
    // Continuar bucle
    b bucle
    
fin:
    // Mover resultado a x0 para retorno
    mov x0, x1
    
    // Restaurar registros
    ldp x19, x20, [sp], #16
    ldp x29, x30, [sp], #16
    ret
