.section .data
.section .text
.global suma_naturales

suma_naturales:
    mov x2, 0              // Inicializar el acumulador (x2) a 0
    mov x3, 1              // Inicializar el contador (x3) a 1

loop:
    cmp x3, x0             // Comparar contador (x3) con N (x0)
    bgt end                // Si x3 > N, salir del bucle
    add x2, x2, x3         // Sumar contador (x3) al acumulador (x2)
    add x3, x3, 1          // Incrementar el contador (x3)
    b loop                 // Volver al inicio del bucle

end:
    mov x0, x2             // Mover el resultado a x0 para devolverlo
    ret                     // Retornar
