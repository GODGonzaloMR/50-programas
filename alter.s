// Autor: Cortez Huerta Gonzalo
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que establece, borra y alterna bits

// Equivalente en C#:
/*
using System;
using System.Runtime.InteropServices;

class Alter
{
    // Declaración de las funciones en ensamblador
    [DllImport("libcalculations.so", CallingConvention = CallingConvention.Cdecl)]
    public static extern long establecer_bit(long valor, long n);
    
    [DllImport("libcalculations.so", CallingConvention = CallingConvention.Cdecl)]
    public static extern long borrar_bit(long valor, long n);
    
    [DllImport("libcalculations.so", CallingConvention = CallingConvention.Cdecl)]
    public static extern long alternar_bit(long valor, long n);

    static void Main()
    {
        Console.WriteLine("Ingrese un número entero:");
        long valor = Convert.ToInt64(Console.ReadLine());
        
        Console.WriteLine("Ingrese la posición del bit (0, 1, 2,...):");
        long n = Convert.ToInt64(Console.ReadLine());

        long resultadoEstablecer = establecer_bit(valor, n);
        Console.WriteLine($"Número después de establecer el bit en la posición {n}: {resultadoEstablecer}");
        
        long resultadoBorrar = borrar_bit(valor, n);
        Console.WriteLine($"Número después de borrar el bit en la posición {n}: {resultadoBorrar}");
        
        long resultadoAlternar = alternar_bit(valor, n);
        Console.WriteLine($"Número después de alternar el bit en la posición {n}: {resultadoAlternar}");
    }
}
*/
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
