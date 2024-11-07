.global DetectOverflow

// Función para detectar desbordamiento en suma
DetectOverflow:
    // Guardar registros
    stp x29, x30, [sp, #-16]!
    
    // Guardar los números originales
    mov w2, w0  // Primer número en w2
    mov w3, w1  // Segundo número en w3
    
    // Realizar la suma con detección de desbordamiento
    adds w4, w2, w3
    
    // Verificar desbordamiento positivo
    // Si a > 0 y b > 0 pero suma < 0, hay desbordamiento
    cmp w2, #0
    b.le check_negative
    cmp w3, #0
    b.le no_overflow
    cmp w4, #0
    b.lt overflow
    b no_overflow

check_negative:
    // Verificar desbordamiento negativo
    // Si a < 0 y b < 0 pero suma >= 0, hay desbordamiento
    cmp w2, #0
    b.ge no_overflow
    cmp w3, #0
    b.ge no_overflow
    cmp w4, #0
    b.ge overflow
    b no_overflow

overflow:
    mov w0, #1      // Retornar 1 si hay desbordamiento
    b end

no_overflow:
    mov w0, #0      // Retornar 0 si no hay desbordamiento

end:
    // Restaurar registros y retornar
    ldp x29, x30, [sp], #16
    ret
