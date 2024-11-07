.global operaciones_bits

.section .text
operaciones_bits:
    // x0 = primer número
    // x1 = segundo número
    // x2 = puntero para resultado AND
    // x3 = puntero para resultado OR
    // x4 = puntero para resultado XOR
    
    // Guardar registros
    stp x29, x30, [sp, #-16]!
    
    // Realizar operación AND
    and x5, x0, x1
    str x5, [x2]    // Guardar resultado AND
    
    // Realizar operación OR
    orr x5, x0, x1
    str x5, [x3]    // Guardar resultado OR
    
    // Realizar operación XOR
    eor x5, x0, x1
    str x5, [x4]    // Guardar resultado XOR
    
    // Restaurar registros y retornar
    ldp x29, x30, [sp], #16
    ret
