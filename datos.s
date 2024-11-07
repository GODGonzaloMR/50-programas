// Autor: Cortez Huerta Gonzalo
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que hace Operaciones AND, OR, XOR a nivel de bits

// Equivalente en C#:
/*
using System;
using System.Runtime.InteropServices;

class Datos
{
    [DllImport("libcalculations.so", CallingConvention = CallingConvention.Cdecl)]
    public static extern void operaciones_bits(long num1, long num2, out long resultAND, out long resultOR, out long resultXOR);

    static void Main()
    {
        Console.WriteLine("Operaciones a nivel de bits");
        Console.WriteLine("==========================");
        
        // Solicitar números
        Console.Write("Ingrese el primer número: ");
        long num1 = long.Parse(Console.ReadLine());
        
        Console.Write("Ingrese el segundo número: ");
        long num2 = long.Parse(Console.ReadLine());
        
        // Variables para almacenar resultados
        long resultAND, resultOR, resultXOR;
        
        // Realizar operaciones
        operaciones_bits(num1, num2, out resultAND, out resultOR, out resultXOR);
        
        // Mostrar resultados en decimal y binario
        Console.WriteLine("\nResultados:");
        Console.WriteLine($"AND: {resultAND} (Binario: {Convert.ToString(resultAND, 2).PadLeft(64, '0')})");
        Console.WriteLine($"OR:  {resultOR} (Binario: {Convert.ToString(resultOR, 2).PadLeft(64, '0')})");
        Console.WriteLine($"XOR: {resultXOR} (Binario: {Convert.ToString(resultXOR, 2).PadLeft(64, '0')})");
    }
}
*/
.global operaciones_bits

.section .text
operaciones_bits:
    // x0 = primer número
    // x1 = segundo número
    // x2 = puntero para resultado AND
    // x3 = puntero para resultado OR
    // x4 = puntero para resultado XOR
    
    // Guardar registros
    stp x29, x30, [sp, #-16]!
    
    // Realizar operación AND
    and x5, x0, x1
    str x5, [x2]    // Guardar resultado AND
    
    // Realizar operación OR
    orr x5, x0, x1
    str x5, [x3]    // Guardar resultado OR
    
    // Realizar operación XOR
    eor x5, x0, x1
    str x5, [x4]    // Guardar resultado XOR
    
    // Restaurar registros y retornar
    ldp x29, x30, [sp], #16
    ret
