// Autor: Cortez Huerta Gonzalo
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que es una Calculadora simple (Suma, Resta, Multiplicación, División)

// Equivalente en C#:
/*
using System;
using System.Runtime.InteropServices;

class SimpleCalculator
{
    // Importar las funciones de ensamblador
    [DllImport("simple.so")] public static extern int Sumar(int a, int b);
    [DllImport("simple.so")] public static extern int Restar(int a, int b);
    [DllImport("simple.so")] public static extern int Multiplicar(int a, int b);
    [DllImport("simple.so")] public static extern int Dividir(int a, int b);

    static void Main()
    {
        Console.Write("Introduce el primer número: ");
        int num1 = int.Parse(Console.ReadLine());
        
        Console.Write("Introduce el segundo número: ");
        int num2 = int.Parse(Console.ReadLine());

        Console.WriteLine("Selecciona la operación: ");
        Console.WriteLine("1 - Suma");
        Console.WriteLine("2 - Resta");
        Console.WriteLine("3 - Multiplicación");
        Console.WriteLine("4 - División");
        int opcion = int.Parse(Console.ReadLine());

        int resultado = 0;
        
        switch (opcion)
        {
            case 1:
                resultado = Sumar(num1, num2);
                Console.WriteLine($"Resultado: {num1} + {num2} = {resultado}");
                break;
            case 2:
                resultado = Restar(num1, num2);
                Console.WriteLine($"Resultado: {num1} - {num2} = {resultado}");
                break;
            case 3:
                resultado = Multiplicar(num1, num2);
                Console.WriteLine($"Resultado: {num1} * {num2} = {resultado}");
                break;
            case 4:
                if (num2 != 0)
                {
                    resultado = Dividir(num1, num2);
                    Console.WriteLine($"Resultado: {num1} / {num2} = {resultado}");
                }
                else
                {
                    Console.WriteLine("Error: División por cero.");
                }
                break;
            default:
                Console.WriteLine("Opción inválida.");
                break;
        }
    }
}
*/
.global Sumar
.global Restar
.global Multiplicar
.global Dividir

// Suma: retorna a + b
Sumar:
    add w0, w0, w1       // Sumar el primer y segundo argumento en w0
    ret

// Resta: retorna a - b
Restar:
    sub w0, w0, w1       // Restar el segundo argumento de w0
    ret

// Multiplicación: retorna a * b
Multiplicar:
    mul w0, w0, w1       // Multiplicar w0 * w1 y almacenar en w0
    ret

// División: retorna a / b (b debe ser distinto de 0)
Dividir:
    cbz w1, div_by_zero  // Comprobar si el divisor es 0
    sdiv w0, w0, w1      // Dividir w0 / w1 y almacenar en w0
    ret
div_by_zero:
    mov w0, 0            // Si el divisor es 0, retornar 0
    ret
