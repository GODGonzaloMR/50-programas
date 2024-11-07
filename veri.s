.global EsArmstrong
    
// x0: número de entrada
// x1: copia del número para trabajar
// x2: suma de potencias
// x3: contador de dígitos
// x4: dígito actual
// x5: base para potencia
// x6: resultado de potencia
// x7: contador para potencia

EsArmstrong:
    // Guardar registros
    stp x29, x30, [sp, #-16]!
    stp x19, x20, [sp, #-16]!
    
    mov x19, x0                  // Guardar número original
    mov x1, x0                   // Copiar número para contar dígitos
    mov x3, 0                    // Inicializar contador de dígitos

contar_digitos:
    cbz x1, preparar_calculo     // Si x1 es 0, terminar conteo
    udiv x1, x1, #10            // Dividir por 10
    add x3, x3, #1              // Incrementar contador
    b contar_digitos

preparar_calculo:
    mov x1, x19                 // Restaurar número original
    mov x2, #0                  // Inicializar suma de potencias

procesar_digitos:
    cbz x1, verificar           // Si no hay más dígitos, verificar resultado
    
    // Obtener último dígito
    mov x4, x1                  // Copiar número actual
    udiv x4, x4, #10           // Dividir por 10
    msub x4, x4, #10, x1       // x4 = x1 - (x4 * 10) -> último dígito
    udiv x1, x1, #10           // Actualizar número removiendo último dígito
    
    // Calcular potencia
    mov x5, x4                  // Base = dígito
    mov x6, #1                  // Resultado inicial = 1
    mov x7, x3                  // Contador = número de dígitos

calcular_potencia:
    cbz x7, sumar_potencia     // Si contador es 0, sumar resultado
    mul x6, x6, x5             // Multiplicar por base
    sub x7, x7, #1             // Decrementar contador
    b calcular_potencia

sumar_potencia:
    add x2, x2, x6             // Sumar potencia al total
    b procesar_digitos

verificar:
    cmp x2, x19                // Comparar suma con número original
    cset w0, eq                // Establecer resultado (1 si igual, 0 si no)
    
    // Restaurar registros
    ldp x19, x20, [sp], #16
    ldp x29, x30, [sp], #16
    ret
