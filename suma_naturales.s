// Autor: Cortez Huerta Gonzalo
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que Suma de los N primeros números naturales

// Equivalente en C#:
/*
using System;
using System.Runtime.InteropServices;

class Program
{
    // Importar las funciones desde la biblioteca compartida
    [DllImport("libcalculations.so")]
    public static extern long suma(long a, long b);

    [DllImport("libcalculations.so")]
    public static extern long resta(long a, long b);

    [DllImport("libcalculations.so")]
    public static extern long multiplicacion(long a, long b);

    [DllImport("libcalculations.so")]
    public static extern long division(long a, long b);

    [DllImport("libcalculations.so")]
    public static extern long suma_naturales(long n);  // Nueva función para la suma de N

    static void Main()
    {
        Console.Write("Ingresa el valor de N: ");
        if (long.TryParse(Console.ReadLine(), out long n))
        {
            long resultadoSumaNaturales = suma_naturales(n);
            Console.WriteLine($"La suma de los primeros {n} números naturales es: {resultadoSumaNaturales}");

            // Ejemplo de uso de otras funciones
            Console.Write("Ingresa el primer número: ");
            if (long.TryParse(Console.ReadLine(), out long num1))
            {
                Console.Write("Ingresa el segundo número: ");
                if (long.TryParse(Console.ReadLine(), out long num2))
                {
                    long resultadoSuma = suma(num1, num2);
                    Console.WriteLine($"La suma de {num1} y {num2} es: {resultadoSuma}");

                    long resultadoResta = resta(num1, num2);
                    Console.WriteLine($"La resta de {num1} y {num2} es: {resultadoResta}");

                    long resultadoMultiplicacion = multiplicacion(num1, num2);
                    Console.WriteLine($"La multiplicación de {num1} y {num2} es: {resultadoMultiplicacion}");

                    long resultadoDivision = division(num1, num2);
                    Console.WriteLine($"La división de {num1} y {num2} es: {resultadoDivision}");
                }
                else
                {
                    Console.WriteLine("Entrada no válida para el segundo número.");
                }
            }
            else
            {
                Console.WriteLine("Entrada no válida para el primer número.");
            }
        }
        else
        {
            Console.WriteLine("Entrada no válida para N.");
        }
    }
}
*/
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
