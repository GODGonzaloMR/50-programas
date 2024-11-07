.section .data
    mensaje_left: .asciz "Desplazamiento a la izquierda: %ld\n"
    mensaje_right: .asciz "Desplazamiento a la derecha: %ld\n"

.section .text
.global desplazar_izquierda
.global desplazar_derecha

desplazar_izquierda:
    // Entrada: x0 = número, x1 = desplazamiento
    // Salida: x0 = resultado
    lsl x0, x0, x1   // Desplazamiento a la izquierda
    ret

desplazar_derecha:
    // Entrada: x0 = número, x1 = desplazamiento
    // Salida: x0 = resultado
    lsr x0, x0, x1   // Desplazamiento a la derecha
    ret
