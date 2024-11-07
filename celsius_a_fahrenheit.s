// Autor: Cortez Huerta Gonzalo
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que convierte celcius a fahrenheit

// Equivalente en C#:
/*

*/
.section .data
.section .text
.global celsius_a_fahrenheit

celsius_a_fahrenheit:
    // Multiplicación de Celsius * 9
    mov x1, #9              // Cargar 9 en x1
    mul x0, x0, x1          // Celsius * 9

    // División por 5
    mov x1, #5              // Cargar 5 en x1
    udiv x0, x0, x1         // (Celsius * 9) / 5

    // Sumar 32
    add x0, x0, #32         // ((Celsius * 9) / 5) + 32

    ret
 
