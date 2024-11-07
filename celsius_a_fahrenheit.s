# Convertir temperatura de Celsius a Fahrenheit
```assembly
/*=======================================================
 * Programa:     temperatura.s
 * Autor:        Cortez Huerta  Gonzalo
 * Fecha:        06 de noviembre de 2024
 * Descripción:  Convierte una temperatura de Celsius a Fahrenheit usando 
 *               ensamblador ARM64 en RaspbianOS.
 * Compilación:  as -o celsius_a_fahrenheit.o celsius_a_fahrenheit.s
 *               gcc -o celsius_a_fahrenheit celsius_a_fahrenheit.o
 * Ejecución:    ./celsius_a_fahrenheit.s
 * Versión:      1.0
 *
 * Código equivalente en c:
 * -----------------------------------------------------
 * #include <stdio.h> 
 * int main() { 
 *     float celsius, fahrenheit; 
 *     printf("Ingresa la temperatura en Celsius: "); 
 *     scanf("%f", &celsius); 
 *     fahrenheit = (celsius * 9 / 5) + 32; 
 *     printf("Temperatura en Fahrenheit: %.2f\n", fahrenheit); 
 *     return 0; 
 * } 
 * -----------------------------------------------------
 =========================================================*/
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
 ```
