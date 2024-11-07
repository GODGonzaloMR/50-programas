// Autor: Cortez Huerta Gonzalo
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que hace Desplazamientos a la izquierda y derecha

// Equivalente en C#:
/*
using System;
using System.Runtime.InteropServices;

class Datos
{
    [DllImport("libcalculations.so", CallingConvention = CallingConvention.Cdecl)]
    public static extern long desplazar_izquierda(long numero, long desplazamiento);

    [DllImport("libcalculations.so", CallingConvention = CallingConvention.Cdecl)]
    public static extern long desplazar_derecha(long numero, long desplazamiento);

    static void Main(string[] args)
    {
        Console.Write("Ingrese un número entero: ");
        long numero = Convert.ToInt64(Console.ReadLine());

        Console.Write("Ingrese el número de posiciones a desplazar: ");
        long desplazamiento = Convert.ToInt64(Console.ReadLine());

        long resultadoIzquierda = desplazar_izquierda(numero, desplazamiento);
        long resultadoDerecha = desplazar_derecha(numero, desplazamiento);

        Console.WriteLine($"El resultado de {numero} desplazado a la izquierda {desplazamiento} posiciones es: {resultadoIzquierda}");
        Console.WriteLine($"El resultado de {numero} desplazado a la derecha {desplazamiento} posiciones es: {resultadoDerecha}");
    }
}
*/
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
