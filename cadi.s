// Autor: Cortez Huerta Gonzalo
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que encuentra el prefijo común más largo en cadenas

// Equivalente en C#:
/*
using System;
using System.Runtime.InteropServices;

class Program
{
    [DllImport("cadena.so")]
    public static extern int LongestCommonPrefix(string str1, string str2);

    public static string FindLongestCommonPrefix(string[] strings)
    {
        if (strings.Length == 0)
            return "";

        string prefix = strings[0];

        for (int i = 1; i < strings.Length; i++)
        {
            int commonLength = LongestCommonPrefix(prefix, strings[i]);
            prefix = prefix.Substring(0, commonLength);

            if (prefix == "")
                break;
        }

        return prefix;
    }

    static void Main()
    {
        Console.WriteLine("Introduce el número de cadenas:");
        int n = int.Parse(Console.ReadLine());

        string[] strings = new string[n];
        for (int i = 0; i < n; i++)
        {
            Console.Write($"Cadena {i + 1}: ");
            strings[i] = Console.ReadLine();
        }

        string longestPrefix = FindLongestCommonPrefix(strings);
        Console.WriteLine("El prefijo común más largo es: " + longestPrefix);
    }
}
*/
.global LongestCommonPrefix

// Función para encontrar el prefijo común más largo
LongestCommonPrefix:
    stp x29, x30, [sp, -16]!   // Guardar el frame anterior y el link register
    mov x29, sp                 // Crear un nuevo frame
    mov x3, x0                  // Dirección de la primera cadena
    mov x4, x1                  // Dirección de la segunda cadena
    mov w5, 0                   // Contador de caracteres en común

compara_caracteres:
    uxtw x6, w5                 // Expandir w5 a 64 bits en x6
    ldrb w7, [x3, x6]           // Leer el carácter de la primera cadena
    ldrb w8, [x4, x6]           // Leer el carácter de la segunda cadena
    cmp w7, w8                  // Comparar los caracteres
    b.ne fin                    // Si no son iguales, fin del prefijo común
    cmp w7, 0                   // Si encontramos un nulo, también terminar
    b.eq fin
    add w5, w5, 1               // Incrementar el contador de caracteres en común
    b compara_caracteres

fin:
    mov w0, w5                  // El resultado es el número de caracteres en común
    ldp x29, x30, [sp], 16      // Restaurar el frame y el link register
    ret
