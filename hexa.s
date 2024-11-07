// hexa.s - Convierte un carácter hexadecimal en decimal (simplificado)

.global hex_char_to_dec

// Convierte un carácter hexadecimal a decimal
// Entrada: w0 (carácter hexadecimal, como 'A' o 'F')
// Salida: w0 (valor decimal)
hex_char_to_dec:
    cmp w0, '0'
    blt invalid_hex               // Si es menor que '0', no es hexadecimal
    cmp w0, '9'
    ble convert_digit             // Si está entre '0' y '9', es dígito decimal

    cmp w0, 'A'
    blt invalid_hex               // Si es menor que 'A', no es hexadecimal
    cmp w0, 'F'
    ble convert_upper_letter      // Si está entre 'A' y 'F', es letra mayúscula

    cmp w0, 'a'
    blt invalid_hex               // Si es menor que 'a', no es hexadecimal
    cmp w0, 'f'
    ble convert_lower_letter      // Si está entre 'a' y 'f', es letra minúscula

invalid_hex:
    mov w0, -1                    // Retornar -1 si no es válido
    ret

convert_digit:
    sub w0, w0, '0'               // Convertir '0'-'9' a 0-9
    ret

convert_upper_letter:
    sub w0, w0, 'A'               // Convertir 'A'-'F' a 10-15
    add w0, w0, 10
    ret

convert_lower_letter:
    sub w0, w0, 'a'               // Convertir 'a'-'f' a 10-15
    add w0, w0, 10
    ret
