.section .data
.section .text
.global factorial

factorial:
    // Guardar el enlace de retorno y los registros que usaremos
    stp x29, x30, [sp, -16]!    // Guardar frame pointer y link register
    stp x20, x19, [sp, -16]!    // Guardar registros que usaremos
    
    mov x19, x0                  // Guardar n en x19
    
    // Si n <= 1, el factorial es 1
    cmp x0, 1
    ble end
    
    // Preparar para la llamada recursiva
    sub x0, x19, 1              // x0 = n - 1
    bl factorial                 // Llamar factorial(n - 1)
    
    // Multiplicar el resultado por n
    mul x0, x0, x19             // resultado = factorial(n-1) * n
    
    // Restaurar registros y retornar
    ldp x20, x19, [sp], 16      // Recuperar registros guardados
    ldp x29, x30, [sp], 16      // Recuperar frame pointer y link register
    ret

end:
    mov x0, 1                    // Retornar 1 si n <= 1
    ldp x20, x19, [sp], 16      // Recuperar registros guardados
    ldp x29, x30, [sp], 16      // Recuperar frame pointer y link register
    ret
