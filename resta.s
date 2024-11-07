.section .data
.section .text
.global resta

resta:
    sub x0, x0, x1   // x0 = x0 - x1, almacena el resultado en x0
    ret
