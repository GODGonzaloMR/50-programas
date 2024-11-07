.global establecer_bit
.global borrar_bit
.global alternar_bit

// Establecer un bit en la posición 'n'
establecer_bit:
    lsl x2, x1, #1       // x2 = 1 << n
    orr x0, x0, x2      // resultado = valor | (1 << n)
    ret

// Borrar un bit en la posición 'n'
borrar_bit:
    lsl x2, x1, #1       // x2 = 1 << n
    neg x2, x2           // x2 = -(1 << n) (obtener complemento)
    and x0, x0, x2      // resultado = valor & ~(1 << n)
    ret

// Alternar un bit en la posición 'n'
alternar_bit:
    lsl x2, x1, #1       // x2 = 1 << n
    eor x0, x0, x2      // resultado = valor ^ (1 << n)
    ret
