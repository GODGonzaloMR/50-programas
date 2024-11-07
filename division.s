.section .data
.section .text
.global division

division:
    // Verificar si el divisor (x1) es cero
    cbz x1, divisor_cero // Si x1 es cero, saltar a divisor_cero
    sdiv x0, x0, x1      // x0 = x0 / x1, almacena el resultado en x0
    ret                   // Retornar

divisor_cero:
    mov x0, 0            // Si el divisor es cero, retornar 0
    ret
