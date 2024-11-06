# 50-programas Gonzalo Cortez Huerta 22210761
# Gist con los 50 programas https://gist.github.com/GODGonzaloMR/9f0602596ec4ad1c6d638a1ca091516d
- Gonzalo Cortez Huerta 22210761
# 1.- Convertir temperatura de Celsius a Fahrenheit	
## nano celsius_a_fahrenheit.s

```asm
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
---
## nano Program.cs
```csharp
using System;
using System.Runtime.InteropServices;

class Program
{
    // Importar la función celsius_a_fahrenheit de la biblioteca compartida
    [DllImport("libcelsius.so")]
    public static extern long celsius_a_fahrenheit(long celsius);

    static void Main()
    {
        Console.Write("Ingresa la temperatura en Celsius: ");
        if (long.TryParse(Console.ReadLine(), out long celsius))
        {
            long fahrenheit = celsius_a_fahrenheit(celsius);
            Console.WriteLine($"{celsius}°C es igual a {fahrenheit}°F");
        }
        else
        {
            Console.WriteLine("Entrada no válida.");
        }
    }
}
```
### mono Program.exe
![image](https://gist.github.com/user-attachments/assets/046a8656-bd73-4d56-8e82-7d285dbe0938)

# 2.- Suma de dos números	
## nano suma.s
```
.section .data
.section .text
.global suma

suma:
    add x0, x0, x1   // x0 = x0 + x1, almacena el resultado en x0
    ret
```
## suma.cs
```
using System;
using System.Runtime.InteropServices;

class Program
{
    [DllImport("libcalculations.so")]
    public static extern long suma(long a, long b);

    static void Main()
    {
        Console.Write("Ingresa el primer número: ");
        if (long.TryParse(Console.ReadLine(), out long num1))
        {
            Console.Write("Ingresa el segundo número: ");
            if (long.TryParse(Console.ReadLine(), out long num2))
            {
                long resultado = suma(num1, num2);
                Console.WriteLine($"La suma de {num1} y {num2} es: {resultado}");
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
}
```
### mono suma.exe
![image](https://gist.github.com/user-attachments/assets/052e4df6-5adb-492b-8b0e-1a01a1303a9e)

# 3.- Resta de dos números	
## nano resta.s
```
.section .data
.section .text
.global resta

resta:
    sub x0, x0, x1   // x0 = x0 - x1, almacena el resultado en x0
    ret
```
## nano Program.cs
```
using System;
using System.Runtime.InteropServices;

class Program
{
    // Importar las funciones desde la biblioteca compartida
    [DllImport("libcalculations.so")]
    public static extern long suma(long a, long b);

    [DllImport("libcalculations.so")]
    public static extern long resta(long a, long b);  // Nueva función resta

    static void Main()
    {
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
}
```
### mono resta.exe
![image](https://gist.github.com/user-attachments/assets/99a10381-fdc1-44cb-aa74-a6d79d5c8d1f)

# 4.- Multiplicación de dos números	
## nano multiplicacion.s
```
.section .data
.section .text
.global multiplicacion

multiplicacion:
    mul x0, x0, x1   // x0 = x0 * x1, almacena el resultado en x0
    ret
```
## nano multi.cs
```
using System;
using System.Runtime.InteropServices;

class Program
{
    // Importar las funciones desde la biblioteca compartida
    [DllImport("libcalculations.so")]
    public static extern long suma(long a, long b);

    [DllImport("libcalculations.so")]
    public static extern long resta(long a, long b);  // Función de resta

    [DllImport("libcalculations.so")]
    public static extern long multiplicacion(long a, long b);  // Nueva función multiplicación

    static void Main()
    {
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
}
```
### mono multi.exe
![image](https://gist.github.com/user-attachments/assets/e6556fd4-3bd6-4a64-983b-dfde52468443)

# 5.- División de dos números	
## nano division.s
```
.section .data
.section .text
.global division

division:
    // Verificar si el divisor (x1) es cero
    cbz x1, divisor_cero // Si x1 es cero, saltar a divisor_cero
    sdiv x0, x0, x1      // x0 = x0 / x1, almacena el resultado en x0
    ret                   // Retornar

divisor_cero:
    mov x0, 0            // Si el divisor es cero, retornar 0
    ret
```
## nano div.cs
```
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
    public static extern long division(long a, long b);  // Nueva función de división

    static void Main()
    {
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
}
```
### mono div.exe
![image](https://gist.github.com/user-attachments/assets/8d0510a9-7a96-4b17-8d7a-e6dd7b3d004e)

# 6.- Suma de los N primeros números naturales	
## nano suma_naturales.s
```
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
```
## nano naturales.cs
```
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
```
### mono naturales.exe
![image](https://gist.github.com/user-attachments/assets/5c82e4e0-3647-44f1-ae18-ecc48e977582)

# 7.- Factorial de un número	
## nano factorial.s
```
.section .data
.section .text
.global factorial

factorial:
    // Guardar el enlace de retorno y los registros que usaremos
    stp x29, x30, [sp, -16]!    // Guardar frame pointer y link register
    stp x20, x19, [sp, -16]!    // Guardar registros que usaremos
    
    mov x19, x0                  // Guardar n en x19
    
    // Si n <= 1, el factorial es 1
    cmp x0, 1
    ble end
    
    // Preparar para la llamada recursiva
    sub x0, x19, 1              // x0 = n - 1
    bl factorial                 // Llamar factorial(n - 1)
    
    // Multiplicar el resultado por n
    mul x0, x0, x19             // resultado = factorial(n-1) * n
    
    // Restaurar registros y retornar
    ldp x20, x19, [sp], 16      // Recuperar registros guardados
    ldp x29, x30, [sp], 16      // Recuperar frame pointer y link register
    ret

end:
    mov x0, 1                    // Retornar 1 si n <= 1
    ldp x20, x19, [sp], 16      // Recuperar registros guardados
    ldp x29, x30, [sp], 16      // Recuperar frame pointer y link register
    ret
```
## nano CombinedProgram.cs
```
using System;
using System.Runtime.InteropServices;

class Program
{
    [DllImport("libcalculations.so")]
    public static extern long factorial(long n);

    static void MostrarFactorial(long n)
    {
        Console.Write($"{n}! = ");
        
        // Mostrar el proceso
        for (long i = n; i >= 1; i--)
        {
            Console.Write(i);
            if (i > 1)
                Console.Write(" × ");
        }
        
        // Calcular y mostrar el resultado
        long resultado = factorial(n);
        Console.WriteLine($" = {resultado}");
    }

    static void Main()
    {
        while (true)
        {
            Console.Write("\nIngresa un número para calcular su factorial (0-20, o -1 para salir): ");
            
            if (long.TryParse(Console.ReadLine(), out long n))
            {
                if (n == -1) break;
                
                if (n >= 0 && n <= 20)
                {
                    try
                    {
                        MostrarFactorial(n);
                    }
                    catch (Exception e)
                    {
                        Console.WriteLine($"Error: {e.Message}");
                    }
                }
                else
                {
                    Console.WriteLine("Por favor ingresa un número entre 0 y 20.");
                }
            }
            else
            {
                Console.WriteLine("Entrada no válida.");
            }
        }
    }
}
```
### mono CombinedProgram.exe
![image](https://gist.github.com/user-attachments/assets/6a1c2d84-4a1f-469c-8a2e-68b1f4e91f8b)

# 8.- Serie de Fibonacci	
## nano fibonacci.s
```
.section .data
.section .text
.global fibonacci

fibonacci:
    cmp x0, 0                  // Comparar n con 0
    beq end                    // Si n == 0, retornar 0
    cmp x0, 1                  // Comparar n con 1
    beq one                    // Si n == 1, retornar 1

    // Preparar para la llamada recursiva
    sub x1, x0, 1              // x1 = n - 1
    mov x0, x1                 // Pasar n - 1 a x0
    bl fibonacci               // Llamar a fibonacci(n - 1)
    mov x2, x0                 // Guardar resultado de fibonacci(n - 1)

    sub x1, x0, 2              // x1 = n - 2
    mov x0, x1                 // Pasar n - 2 a x0
    bl fibonacci               // Llamar a fibonacci(n - 2)

    add x0, x0, x2             // x0 = fibonacci(n - 1) + fibonacci(n - 2)
    ret

one:
    mov x0, 1                  // Retornar 1 si n == 1
    ret

end:
    mov x0, 0                  // Retornar 0 si n == 0
    ret
```
## nano Fibonacci.cs
```
using System;

class Program
{
    static void MostrarSecuenciaFibonacci(int n)
    {
        if (n < 0)
        {
            Console.WriteLine("Por favor ingrese un número no negativo.");
            return;
        }

        Console.WriteLine($"\nSecuencia de Fibonacci hasta el término {n}:");
        Console.Write("0");  // Primer término

        if (n == 0) 
        {
            Console.WriteLine();
            return;
        }

        long prev = 0;
        long current = 1;
        
        Console.Write(" → 1");  // Segundo término

        for (int i = 2; i <= n; i++)
        {
            try
            {
                long next = checked(prev + current);  // Usar checked para detectar overflow
                Console.Write($" → {next}");
                prev = current;
                current = next;
            }
            catch (OverflowException)
            {
                Console.WriteLine("\n\nEl cálculo ha excedido el límite de números manejables.");
                break;
            }
        }
        Console.WriteLine("\n");
    }

    static void Main()
    {
        while (true)
        {
            Console.Write("Ingrese el número de términos de Fibonacci a mostrar (0 para salir): ");
            
            if (int.TryParse(Console.ReadLine(), out int n))
            {
                if (n == 0) break;
                MostrarSecuenciaFibonacci(n);
            }
            else
            {
                Console.WriteLine("Por favor ingrese un número válido.");
            }
        }
    }
}
```
### mono Fibonacci.exe
![image](https://gist.github.com/user-attachments/assets/541b15ba-662d-4abd-bc13-7b975c165431)

# 9.- Verificar si un número es primo	
## nano primo.s
```
.section .data
.section .text
.global es_primo

es_primo:
    cmp x0, 2                 // Comparar n con 2
    blt not_prime             // Si n < 2, no es primo
    cmp x0, 2                 // Comparar n con 2 nuevamente
    beq is_prime              // Si n == 2, es primo

    mov x1, 2                 // Inicializar divisor en 2

check_division:
    mul x2, x1, x1            // Calcular divisor^2 en x2
    cmp x2, x0                // Si divisor^2 > n, no más divisores posibles
    bgt is_prime

    // Verificar si n % divisor == 0
    mov x2, x0                // Copiar n a x2
    udiv x2, x2, x1           // x2 = n / divisor
    msub x3, x2, x1, x0       // x3 = n - (x2 * divisor)
    cbz x3, not_prime         // Si n % divisor == 0, no es primo

    add x1, x1, 1             // Incrementar divisor
    b check_division          // Repetir el ciclo

is_prime:
    mov w0, 1                 // Retornar 1 si es primo
    ret

not_prime:
    mov w0, 0                 // Retornar 0 si no es primo
    ret
```
## nano primo.cs
```
using System;
using System.Runtime.InteropServices;

class Program
{
    // Importar función de verificación de número primo desde la biblioteca compartida
    [DllImport("libcalculations.so")]
    public static extern bool es_primo(long n);  // Importación de la función es_primo

    static void Main()
    {
        // Verificar si un número es primo
        Console.Write("Ingresa un número para verificar si es primo: ");
        if (long.TryParse(Console.ReadLine(), out long numero) && numero >= 2)
        {
            bool resultado = es_primo(numero);
            Console.WriteLine(resultado ? $"{numero} es primo." : $"{numero} no es primo.");
        }
        else
        {
            Console.WriteLine("Entrada no válida. Debe ser un número entero mayor o igual a 2.");
        }
    }
}
```
### mono primo.exe
![image](https://gist.github.com/user-attachments/assets/3d444165-c0f2-4236-ab0c-b64e127ffcb4)

# 10.- Invertir una cadena	
## nano cadena.s
```
.section .data
.section .text
.global invertir_cadena

// Función para invertir una cadena en lugar
// Parámetro de entrada: x0 (puntero a la cadena)
// Devuelve: nada (cadena invertida en el mismo lugar)

invertir_cadena:
    // Encuentra la longitud de la cadena
    mov x1, x0             // x1 apunta al inicio de la cadena
find_end:
    ldrb w2, [x1], #1      // Leer el siguiente byte (carácter) y avanzar
    cbz w2, reverse        // Si llegamos al final ('\0'), saltar a la inversión

    b find_end             // Continuar hasta encontrar el final

reverse:
    sub x1, x1, #2         // Retroceder una posición (x1 apunta al último carácter)
    mov x2, x1             // x2 apunta al final de la cadena
    mov x3, x0             // x3 apunta al inicio de la cadena

swap_loop:
    cmp x3, x2             // Comparar el inicio con el final
    bge end_reverse        // Si se cruzan, termina la inversión

    ldrb w4, [x3]          // Leer carácter desde el inicio
    ldrb w5, [x2]          // Leer carácter desde el final
    strb w5, [x3]          // Escribir carácter del final en el inicio
    strb w4, [x2]          // Escribir carácter del inicio en el final

    add x3, x3, #1         // Avanzar el inicio
    sub x2, x2, #1         // Retroceder el final

    b swap_loop            // Repetir el intercambio

end_reverse:
    ret                    // Retornar
```
## nano cadena.cs
```
using System;
using System.Runtime.InteropServices;
using System.Text;

class Program
{
    // Importar la función de invertir cadena desde la biblioteca compartida
    [DllImport("libcalculations.so")]
    public static extern void invertir_cadena(StringBuilder str);

    static void Main()
    {
        // Pedir al usuario que ingrese una cadena
        Console.Write("Ingresa una cadena para invertir: ");
        string input = Console.ReadLine();

        // Convertir la cadena a StringBuilder (mutable)
        StringBuilder cadena = new StringBuilder(input);

        // Llamar a la función para invertir la cadena
        invertir_cadena(cadena);

        // Mostrar la cadena invertida
        Console.WriteLine($"Cadena invertida: {cadena}");
    }
}
```
### mono cadena.exe
![image](https://gist.github.com/user-attachments/assets/b0e544af-19bb-486f-9194-cbbdd94900f9)

# 11.- Verificar si una cadena es palíndromo
## poli.s
```
.section .data
.section .text
.global es_palindromo

// Función para verificar si una cadena es un palíndromo
// Parámetro de entrada: x0 (puntero a la cadena)
// Retorno: x0 = 1 si es palíndromo, x0 = 0 si no lo es

es_palindromo:
    // Encuentra la longitud de la cadena
    mov x1, x0             // x1 apunta al inicio de la cadena
find_end:
    ldrb w2, [x1], #1      // Leer el siguiente byte (carácter) y avanzar
    cbz w2, check_palindrome // Si llegamos al final ('\0'), comenzar verificación

    b find_end             // Continuar hasta encontrar el final

check_palindrome:
    sub x1, x1, #2         // Retroceder una posición (x1 apunta al último carácter)
    mov x2, x1             // x2 apunta al final de la cadena
    mov x3, x0             // x3 apunta al inicio de la cadena

compare_loop:
    cmp x3, x2             // Comparar el inicio con el final
    bge is_palindrome      // Si se cruzan, es un palíndromo

    ldrb w4, [x3]          // Leer carácter desde el inicio
    ldrb w5, [x2]          // Leer carácter desde el final
    cmp w4, w5             // Comparar caracteres
    bne not_palindrome     // Si no son iguales, no es palíndromo

    add x3, x3, #1         // Avanzar el inicio
    sub x2, x2, #1         // Retroceder el final

    b compare_loop         // Repetir la comparación

is_palindrome:
    mov w0, 1              // Retornar 1 si es palíndromo
    ret

not_palindrome:
    mov w0, 0              // Retornar 0 si no es palíndromo
    ret
```
## poli.cs
```
using System;
using System.Runtime.InteropServices;
using System.Text;

class Program
{
    // Importar la función de verificación de palíndromo desde la biblioteca compartida
    [DllImport("libcalculations.so")]
    public static extern int es_palindromo(StringBuilder str);

    static void Main()
    {
        // Pedir al usuario que ingrese una cadena
        Console.Write("Ingresa una cadena para verificar si es palíndromo: ");
        string input = Console.ReadLine();

        // Convertir la cadena a StringBuilder (mutable)
        StringBuilder cadena = new StringBuilder(input);

        // Llamar a la función para verificar si es palíndromo
        int resultado = es_palindromo(cadena);

        // Mostrar el resultado
        if (resultado == 1)
        {
            Console.WriteLine($"\"{input}\" es un palíndromo.");
        }
        else
        {
            Console.WriteLine($"\"{input}\" no es un palíndromo.");
        }
    }
}
```
### mono poli.exe
![image](https://gist.github.com/user-attachments/assets/e3b211ce-d473-49ab-880a-6625684727e4)

# 12.- Encontrar el máximo en un arreglo	
## nano arreglo.s
```
.section .data
.section .text
.global encontrar_maximo

// Función para encontrar el máximo en un arreglo
// Parámetros de entrada: x0 (puntero al arreglo), x1 (número de elementos)
// Retorno: x0 contiene el valor máximo

encontrar_maximo:
    cbz x1, fin             // Si el tamaño es 0, regresar de inmediato (sin elementos)

    ldr w2, [x0], #4        // Cargar el primer elemento del arreglo en w2 y avanzar el puntero
    sub x1, x1, #1          // Decrementar el contador de elementos

buscar_max:
    cbz x1, fin             // Si ya no hay más elementos, salir del bucle

    ldr w3, [x0], #4        // Cargar el siguiente elemento en w3 y avanzar el puntero
    cmp w3, w2              // Comparar el elemento actual con el máximo
    ble siguiente           // Si el actual es menor o igual, pasar al siguiente
    mov w2, w3              // Si el actual es mayor, actualizar el máximo

siguiente:
    sub x1, x1, #1          // Decrementar el contador de elementos
    b buscar_max            // Repetir el ciclo para el siguiente elemento

fin:
    mov w0, w2              // Colocar el máximo encontrado en w0 (resultado)
    ret                     // Retornar
```
## nano arreglo.cs
```
using System;
using System.Runtime.InteropServices;

class Program
{
    // Importar la función de encontrar el máximo desde la biblioteca compartida
    [DllImport("libcalculations.so")]
    public static extern int encontrar_maximo(int[] arr, int n);

    static void Main()
    {
        // Definir un arreglo de ejemplo
        Console.Write("Ingresa la cantidad de elementos en el arreglo: ");
        int n = int.Parse(Console.ReadLine());
        int[] arreglo = new int[n];

        // Rellenar el arreglo con valores del usuario
        for (int i = 0; i < n; i++)
        {
            Console.Write($"Elemento {i + 1}: ");
            arreglo[i] = int.Parse(Console.ReadLine());
        }

        // Llamar a la función para encontrar el máximo en el arreglo
        int maximo = encontrar_maximo(arreglo, arreglo.Length);

        // Mostrar el valor máximo
        Console.WriteLine($"El valor máximo en el arreglo es: {maximo}");
    }
}
```
### mono arreglo.exe
![image](https://gist.github.com/user-attachments/assets/3f63f7bf-0f9c-4e13-899a-9c72b5c4cc79)

# 13.- Encontrar el mínimo en un arreglo	
## nano min.s
```
.section .data
.section .text
.global encontrar_minimo

// Función para encontrar el mínimo en un arreglo
// Parámetros de entrada: x0 (puntero al arreglo), x1 (número de elementos)
// Retorno: x0 contiene el valor mínimo

encontrar_minimo:
    cbz x1, fin             // Si el tamaño es 0, regresar de inmediato (sin elementos)

    ldr w2, [x0], #4        // Cargar el primer elemento del arreglo en w2 y avanzar el puntero
    sub x1, x1, #1          // Decrementar el contador de elementos

buscar_min:
    cbz x1, fin             // Si ya no hay más elementos, salir del bucle

    ldr w3, [x0], #4        // Cargar el siguiente elemento en w3 y avanzar el puntero
    cmp w3, w2              // Comparar el elemento actual con el mínimo
    bge siguiente           // Si el actual es mayor o igual, pasar al siguiente
    mov w2, w3              // Si el actual es menor, actualizar el mínimo

siguiente:
    sub x1, x1, #1          // Decrementar el contador de elementos
    b buscar_min            // Repetir el ciclo para el siguiente elemento

fin:
    mov w0, w2              // Colocar el mínimo encontrado en w0 (resultado)
    ret                     // Retornar
```
## nano min.cs
```
using System;
using System.Runtime.InteropServices;

class Program
{
    // Importar la función de encontrar el mínimo desde la biblioteca compartida
    [DllImport("libcalculations.so")]
    public static extern int encontrar_minimo(int[] arr, int n);

    static void Main()
    {
        // Definir un arreglo de ejemplo
        Console.Write("Ingresa la cantidad de elementos en el arreglo: ");
        int n = int.Parse(Console.ReadLine());
        int[] arreglo = new int[n];

        // Rellenar el arreglo con valores del usuario
        for (int i = 0; i < n; i++)
        {
            Console.Write($"Elemento {i + 1}: ");
            arreglo[i] = int.Parse(Console.ReadLine());
        }

        // Llamar a la función para encontrar el mínimo en el arreglo
        int minimo = encontrar_minimo(arreglo, arreglo.Length);

        // Mostrar el valor mínimo
        Console.WriteLine($"El valor mínimo en el arreglo es: {minimo}");
    }
}
```
### mono min.exe
![image](https://gist.github.com/user-attachments/assets/bc2b78f1-3cf4-4a34-a57c-f544c4d7c0de)

# 14.- Búsqueda lineal	
## nano lineal.s
```
.section .data
.section .text
.global busqueda_lineal

// Función para realizar una búsqueda lineal en un arreglo
// Parámetros de entrada: x0 (puntero al arreglo), x1 (número de elementos), x2 (valor a buscar)
// Retorno: x0 contiene el índice del elemento si se encuentra, o -1 si no está presente

busqueda_lineal:
    mov w3, -1             // Configurar -1 como valor de retorno por defecto (no encontrado)
    cbz x1, fin            // Si el tamaño es 0, regresar de inmediato (arreglo vacío)

buscar:
    ldr w4, [x0], #4       // Cargar el siguiente elemento en w4 y avanzar el puntero
    cmp w4, w2             // Comparar el elemento actual con el valor buscado
    beq encontrado         // Si son iguales, ir a la etiqueta "encontrado"

    sub x1, x1, #1         // Decrementar el contador de elementos
    add w3, w3, #1         // Incrementar el índice
    cbnz x1, buscar        // Si hay más elementos, continuar la búsqueda

    mov w3, -1             // Si no se encontró, establecer el retorno en -1

fin:
    mov w0, w3             // Colocar el índice en w0
    ret                    // Retornar

encontrado:
    ret                    // Retornar con el índice actual en w3
```
## nano lineal.cs
```
using System;
using System.Runtime.InteropServices;

class Program
{
    // Importar la función de búsqueda lineal desde la biblioteca compartida
    [DllImport("libcalculations.so")]
    public static extern int busqueda_lineal(int[] arr, int n, int valor);

    static void Main()
    {
        // Definir un arreglo de ejemplo
        Console.Write("Ingresa la cantidad de elementos en el arreglo: ");
        int n = int.Parse(Console.ReadLine());
        int[] arreglo = new int[n];

        // Rellenar el arreglo con valores del usuario
        for (int i = 0; i < n; i++)
        {
            Console.Write($"Elemento {i + 1}: ");
            arreglo[i] = int.Parse(Console.ReadLine());
        }

        // Pedir el valor a buscar
        Console.Write("Ingresa el valor a buscar en el arreglo: ");
        int valor = int.Parse(Console.ReadLine());

        // Llamar a la función para realizar la búsqueda lineal
        int indice = busqueda_lineal(arreglo, arreglo.Length, valor);

        // Mostrar el resultado
        if (indice >= 0)
        {
            Console.WriteLine($"El valor {valor} se encuentra en el índice {indice}.");
        }
        else
        {
            Console.WriteLine($"El valor {valor} no se encuentra en el arreglo.");
        }
    }
}
```
### mono lineal.exe
![image](https://gist.github.com/user-attachments/assets/586a95d3-33fa-49f5-8cc8-8466040dc519)

# 15.- Búsqueda binaria	
## nano bin.s
```
.section .data
.section .text
.global busqueda_binaria

// Función para realizar una búsqueda binaria en un arreglo ordenado
// Parámetros de entrada: x0 (puntero al arreglo), x1 (número de elementos), x2 (valor a buscar)
// Retorno: x0 contiene el índice del elemento si se encuentra, o -1 si no está presente

busqueda_binaria:
    mov x3, 0               // Índice inicial (left)
    sub x4, x1, 1           // Índice final (right) = tamaño - 1

bucle:
    cmp x3, x4              // Si left > right, salir del bucle (elemento no encontrado)
    bgt no_encontrado

    add x5, x3, x4          // Calcular el índice medio
    lsr x5, x5, 1           // x5 = (left + right) / 2

    ldr w6, [x0, x5, lsl #2] // Cargar el valor en el índice medio
    cmp w6, w2              // Comparar el valor en el medio con el valor buscado

    beq encontrado          // Si es igual, se encontró el elemento
    blt mover_izquierda     // Si es menor, mover right a la izquierda del medio

    // Si el valor buscado es mayor, mover left a la derecha del medio
    add x3, x5, 1           
    b bucle

mover_izquierda:
    sub x4, x5, 1           // Mover right a la izquierda del medio
    b bucle

encontrado:
    mov x0, x5              // Colocar el índice encontrado en x0
    ret

no_encontrado:
    mov x0, -1              // Si no se encontró, retornar -1
    ret
```
## nano bin.cs
```
using System;
using System.Runtime.InteropServices;

class Program
{
    // Importar la función de búsqueda binaria desde la biblioteca compartida
    [DllImport("libcalculations.so")]
    public static extern int busqueda_binaria(int[] arr, int n, int valor);

    static void Main()
    {
        // Definir un arreglo de ejemplo
        Console.Write("Ingresa la cantidad de elementos en el arreglo (debe estar ordenado): ");
        int n = int.Parse(Console.ReadLine());
        int[] arreglo = new int[n];

        // Rellenar el arreglo con valores del usuario
        Console.WriteLine("Ingresa los elementos en orden ascendente:");
        for (int i = 0; i < n; i++)
        {
            Console.Write($"Elemento {i + 1}: ");
            arreglo[i] = int.Parse(Console.ReadLine());
        }

        // Pedir el valor a buscar
        Console.Write("Ingresa el valor a buscar en el arreglo: ");
        int valor = int.Parse(Console.ReadLine());

        // Llamar a la función para realizar la búsqueda binaria
        int indice = busqueda_binaria(arreglo, arreglo.Length, valor);

        // Mostrar el resultado
        if (indice >= 0)
        {
            Console.WriteLine($"El valor {valor} se encuentra en el índice {indice}.");
        }
        else
        {
            Console.WriteLine($"El valor {valor} no se encuentra en el arreglo.");
        }
    }
}
```
### mono bin.exe
![image](https://gist.github.com/user-attachments/assets/c4bf7d1e-f047-4bd9-bf0b-df21bcd74a96)


# 16.- Ordenamiento burbuja	
## nano bur.s
```
.section .data
.section .text
.global ordenamiento_burbuja

// Función de ordenamiento burbuja en ARM64 Assembly
// Parámetros de entrada: x0 (puntero al arreglo), x1 (número de elementos)
// Retorno: el arreglo ordenado en orden ascendente (se modifica en su lugar)

ordenamiento_burbuja:
    mov x2, x1              // Guardar el tamaño del arreglo en x2 para el bucle externo

bucle_externo:
    sub x2, x2, 1           // Disminuir el tamaño del bucle externo en cada iteración
    mov x3, 0               // Reiniciar índice para el bucle interno

bucle_interno:
    cmp x3, x2              // Comparar el índice con el límite
    bge fin_bucle_interno   // Si alcanzamos el límite, salir del bucle interno

    ldr w4, [x0, x3, lsl #2]       // Cargar el elemento actual en w4
    add x6, x3, 1                  // Calcular el índice del siguiente elemento
    ldr w5, [x0, x6, lsl #2]       // Cargar el siguiente elemento en w5
    cmp w4, w5                     // Comparar el elemento actual con el siguiente

    ble siguiente                  // Si el actual <= siguiente, pasar al siguiente par

    // Intercambiar elementos
    str w5, [x0, x3, lsl #2]       // Guardar el siguiente en la posición actual
    str w4, [x0, x6, lsl #2]       // Guardar el actual en la posición siguiente

siguiente:
    add x3, x3, 1                  // Incrementar el índice para el bucle interno
    b bucle_interno                // Volver al inicio del bucle interno

fin_bucle_interno:
    cmp x2, 1                      // Comprobar si el tamaño del bucle externo es 1
    bgt bucle_externo              // Si es mayor que 1, continuar con el bucle externo
    ret                            // Terminar la función
```
## nano bur.cs
```
using System;
using System.Runtime.InteropServices;

class Program
{
    // Importar la función de ordenamiento burbuja desde la biblioteca compartida
    [DllImport("libcalculations.so")]
    public static extern void ordenamiento_burbuja(int[] arr, int n);

    static void Main()
    {
        // Solicitar el tamaño del arreglo
        Console.Write("Ingresa la cantidad de elementos en el arreglo: ");
        int n = int.Parse(Console.ReadLine());
        int[] arreglo = new int[n];

        // Rellenar el arreglo con valores proporcionados por el usuario
        Console.WriteLine("Ingresa los elementos:");
        for (int i = 0; i < n; i++)
        {
            Console.Write($"Elemento {i + 1}: ");
            arreglo[i] = int.Parse(Console.ReadLine());
        }

        // Llamar a la función para ordenar el arreglo
        ordenamiento_burbuja(arreglo, arreglo.Length);

        // Mostrar el arreglo ordenado
        Console.WriteLine("Arreglo ordenado:");
        foreach (int num in arreglo)
        {
            Console.Write(num + " ");
        }
        Console.WriteLine();
    }
}
```
### mono bur.exe
![image](https://gist.github.com/user-attachments/assets/505c6386-f81d-4c56-8036-1fe1c12e5c01)

# 17.- Ordenamiento por selección	
## ord.s
```
.section .data
.section .text
.global ordenamiento_seleccion

ordenamiento_seleccion:
    mov x2, x1              // Guardar el tamaño del arreglo en x2 para el bucle externo

bucle_externo:
    cmp x2, 1               // Si hay 1 o menos elementos, ya está ordenado
    ble fin_bucle_externo   // Salir si el arreglo tiene 0 o 1 elementos

    mov x3, 0               // Reiniciar el índice del bucle externo
    mov x4, x3               // Suponer que el mínimo es el índice actual

bucle_interno:
    add x5, x3, 1            // x5 es el índice del siguiente elemento
    cmp x5, x2               // Comparar x5 con el tamaño del arreglo
    bge intercambio           // Si es mayor o igual, realizar el intercambio

    ldr w6, [x0, x5, lsl #2]  // Cargar el siguiente elemento
    ldr w7, [x0, x4, lsl #2]  // Cargar el elemento mínimo actual
    cmp w6, w7                // Comparar el siguiente elemento con el mínimo

    blt actualizar_minimo     // Si el siguiente elemento es menor, actualizar el mínimo
    b siguiente_elemento

actualizar_minimo:
    mov x4, x5                // Actualizar el índice mínimo

siguiente_elemento:
    add x3, x3, 1             // Incrementar el índice del bucle interno
    b bucle_interno           // Volver al inicio del bucle interno

intercambio:
    cmp x4, x3                // Comparar el índice mínimo con el índice actual
    beq siguiente_bucle       // Si son iguales, no hacer nada

    // Intercambiar elementos
    ldr w6, [x0, x3, lsl #2]  // Cargar el elemento en el índice actual
    ldr w7, [x0, x4, lsl #2]  // Cargar el elemento mínimo
    str w7, [x0, x3, lsl #2]  // Guardar el mínimo en la posición actual
    str w6, [x0, x4, lsl #2]  // Guardar el actual en la posición del mínimo

siguiente_bucle:
    sub x2, x2, 1             // Decrementar el tamaño del bucle externo
    b bucle_externo            // Volver al inicio del bucle externo

fin_bucle_externo:
    ret                        // Terminar la función
```
## ord.cs
```
using System;
using System.Runtime.InteropServices;

class Program
{
    [DllImport("libcalculations.so")]
    public static extern void ordenamiento_seleccion(int[] arr, int n);

    static void Main()
    {
        Console.Write("Ingresa la cantidad de elementos en el arreglo: ");
        int n = int.Parse(Console.ReadLine());
        int[] arreglo = new int[n];

        Console.WriteLine("Ingresa los elementos:");
        for (int i = 0; i < n; i++)
        {
            Console.Write($"Elemento {i + 1}: ");
            arreglo[i] = int.Parse(Console.ReadLine());
        }

        // Llamar a la función para ordenar el arreglo
        ordenamiento_seleccion(arreglo, n);

        Console.WriteLine("Arreglo ordenado:");
        foreach (int num in arreglo)
        {
            Console.Write(num + " ");
        }
        Console.WriteLine();
    }
}
```
### mono ord.exe
![image](https://gist.github.com/user-attachments/assets/883d757c-0ab1-4c20-98bc-b16766981879)

# 18.- Ordenamiento por mezcla (Merge Sort)	
## nano merge.s
```
.section .data
.section .text
.global merge_sort
.global merge

// merge_sort(int* arr, int n)
// x0: puntero al array
// x1: tamaño del array
merge_sort:
    stp x29, x30, [sp, #-16]!    // Guardar frame pointer y link register
    stp x19, x20, [sp, #-16]!    // Guardar registros que preservaremos
    stp x21, x22, [sp, #-16]!

    // Guardar parámetros
    mov x19, x0                   // Guardar puntero al array
    mov x20, x1                   // Guardar tamaño

    // Verificar caso base
    cmp x20, #2                   // Si tamaño < 2, ya está ordenado
    b.lt .Lend_merge_sort

    // Calcular punto medio
    lsr x21, x20, #1             // mid = size / 2

    // Primera llamada recursiva (primera mitad)
    mov x0, x19                   // array
    mov x1, x21                   // tamaño = mid
    bl merge_sort

    // Segunda llamada recursiva (segunda mitad)
    add x0, x19, x21, lsl #2     // array + mid
    sub x1, x20, x21             // tamaño = size - mid
    bl merge_sort

    // Merge
    mov x0, x19                   // array original
    mov x1, x21                   // mid
    mov x2, x20                   // size
    bl merge

.Lend_merge_sort:
    ldp x21, x22, [sp], #16      // Restaurar registros
    ldp x19, x20, [sp], #16
    ldp x29, x30, [sp], #16
    ret

// merge(int* arr, int mid, int size)
// x0: puntero al array
// x1: mid
// x2: size total
merge:
    // Primero guardar todos los registros que necesitamos
    stp x29, x30, [sp, #-16]!    // Guardar frame pointer y link register
    stp x19, x20, [sp, #-16]!    // Guardar registros que usaremos
    stp x21, x22, [sp, #-16]!
    stp x23, x24, [sp, #-16]!
    stp x25, x26, [sp, #-16]!
    
    // Establecer frame pointer
    mov x29, sp
    
    // Guardar parámetros en registros preservados
    mov x19, x0                   // array original
    mov x20, x1                   // mid
    mov x21, x2                   // size total
    
    // Calcular y reservar espacio para array temporal
    mov x3, x21                   // Copiar size
    lsl x3, x3, #2               // Multiplicar por 4 (tamaño de int)
    sub sp, sp, x3               // Reservar espacio en el stack
    mov x25, sp                  // Guardar puntero al array temporal

    // Inicializar índices
    mov x22, #0                   // i = 0 (índice para primera mitad)
    mov x23, x20                  // j = mid (índice para segunda mitad)
    mov x24, #0                   // k = 0 (índice para array temporal)

.Lmerge_loop:
    // Verificar si hemos terminado alguna mitad
    cmp x22, x20                 // i >= mid?
    b.ge .Lcopy_right_half
    cmp x23, x21                 // j >= size?
    b.ge .Lcopy_left_half

    // Cargar y comparar elementos
    ldr w3, [x19, x22, lsl #2]   // arr[i]
    ldr w4, [x19, x23, lsl #2]   // arr[j]
    cmp w3, w4
    b.gt .Lcopy_from_right

.Lcopy_from_left:
    str w3, [x25, x24, lsl #2]   // temp[k] = arr[i]
    add x22, x22, #1             // i++
    add x24, x24, #1             // k++
    b .Lmerge_loop

.Lcopy_from_right:
    str w4, [x25, x24, lsl #2]   // temp[k] = arr[j]
    add x23, x23, #1             // j++
    add x24, x24, #1             // k++
    b .Lmerge_loop

.Lcopy_left_half:
    cmp x22, x20                 // Quedan elementos en la izquierda?
    b.ge .Lcopy_back
    ldr w3, [x19, x22, lsl #2]   // arr[i]
    str w3, [x25, x24, lsl #2]   // temp[k] = arr[i]
    add x22, x22, #1             // i++
    add x24, x24, #1             // k++
    b .Lcopy_left_half

.Lcopy_right_half:
    cmp x23, x21                 // Quedan elementos en la derecha?
    b.ge .Lcopy_back
    ldr w4, [x19, x23, lsl #2]   // arr[j]
    str w4, [x25, x24, lsl #2]   // temp[k] = arr[j]
    add x23, x23, #1             // j++
    add x24, x24, #1             // k++
    b .Lcopy_right_half

.Lcopy_back:
    // Copiar desde temp_array al array original
    mov x22, #0                  // i = 0
.Lcopy_back_loop:
    cmp x22, x21                 // i >= size?
    b.ge .Lmerge_end
    ldr w3, [x25, x22, lsl #2]   // temp[i]
    str w3, [x19, x22, lsl #2]   // arr[i] = temp[i]
    add x22, x22, #1             // i++
    b .Lcopy_back_loop

.Lmerge_end:
    // Restaurar stack pointer y registros
    mov sp, x29                  // Restaurar stack pointer usando frame pointer
    ldp x25, x26, [sp], #16     // Restaurar registros en orden inverso
    ldp x23, x24, [sp], #16
    ldp x21, x22, [sp], #16
    ldp x19, x20, [sp], #16
    ldp x29, x30, [sp], #16
    ret
```
## nano merge.cs
```
using System;
using System.Runtime.InteropServices;

class Program
{
    // Importar la función de ordenamiento por mezcla desde la biblioteca compartida
    [DllImport("libcalculations.so")]
    public static extern void merge_sort(int[] arr, int n);

    static void Main()
    {
        // Solicitar el tamaño del arreglo
        Console.Write("Ingresa la cantidad de elementos en el arreglo: ");
        int n = int.Parse(Console.ReadLine());
        int[] arreglo = new int[n];

        // Rellenar el arreglo con valores proporcionados por el usuario
        Console.WriteLine("Ingresa los elementos:");
        for (int i = 0; i < n; i++)
        {
            Console.Write($"Elemento {i + 1}: ");
            arreglo[i] = int.Parse(Console.ReadLine());
        }

        // Llamar a la función para ordenar el arreglo
        merge_sort(arreglo, arreglo.Length);

        // Mostrar el arreglo ordenado
        Console.WriteLine("Arreglo ordenado:");
        foreach (int num in arreglo)
        {
            Console.Write(num + " ");
        }
        Console.WriteLine();
    }
}
```
### mono merge.exe
![image](https://gist.github.com/user-attachments/assets/518277f9-2834-4e3c-b21c-9d13fc9f1fac)

# 19.- Suma de matrices	 
## matriz.s
```
.section .text
.global suma_matrices

suma_matrices:
    // Se espera que A, B, C sean punteros a enteros y rows y cols sean los tamaños de la matriz
    // A: x0, B: x1, C: x2, rows: x3, cols: x4

    // Inicializar índices
    mov x5, #0         // i = 0
outer_loop:
    cmp x5, x3         // Comparar i con rows
    bge end_outer_loop // Si i >= rows, salir del bucle

    mov x6, #0         // j = 0
inner_loop:
    cmp x6, x4         // Comparar j con cols
    bge end_inner_loop // Si j >= cols, salir del bucle

    // Calcular el índice en la matriz
    mul x7, x5, x4     // x7 = i * cols
    add x7, x7, x6     // x7 = i * cols + j

    // C = A + B
    ldr w8, [x0, x7, lsl #2] // Cargar A[i][j]
    ldr w9, [x1, x7, lsl #2] // Cargar B[i][j]
    add w10, w8, w9    // w10 = A[i][j] + B[i][j]
    str w10, [x2, x7, lsl #2] // Guardar en C[i][j]

    add x6, x6, #1     // j++
    b inner_loop        // Repetir el bucle interno

end_inner_loop:
    add x5, x5, #1     // i++
    b outer_loop        // Repetir el bucle externo

end_outer_loop:
    ret
```
## matriz.cs
```
using System;
using System.Runtime.InteropServices;

class Matriz
{
    // Declaración de la función de suma de matrices
    [DllImport("libcalculations.so")]
    public static extern void suma_matrices(int[] A, int[] B, int[] C, long rows, long cols);

    static void Main(string[] args)
    {
        // Definir el número de filas y columnas
        long rows = 2; // Cambia esto al número de filas que necesites
        long cols = 3; // Cambia esto al número de columnas que necesites

        // Inicializar las matrices A y B
        int[] A = new int[rows * cols];
        int[] B = new int[rows * cols];
        int[] C = new int[rows * cols]; // Matriz para almacenar el resultado

        // Leer los elementos de la matriz A
         Console.WriteLine("Ingrese los elementos de la matriz A:");
        for (long i = 0; i < rows; i++)
        {
            for (long j = 0; j < cols; j++)
            {
                Console.Write($"Elemento A[{i},{j}]: ");
                A[i * cols + j] = int.Parse(Console.ReadLine());
            }
        }

        // Leer los elementos de la matriz B
        Console.WriteLine("Ingrese los elementos de la matriz B:");
        for (long i = 0; i < rows; i++)
        {
            for (long j = 0; j < cols; j++)
            {
                Console.Write($"Elemento B[{i},{j}]: ");
                B[i * cols + j] = int.Parse(Console.ReadLine());
            }
        }

        // Llamar a la función de suma de matrices
        suma_matrices(A, B, C, rows, cols);

        // Mostrar la matriz resultante C
        Console.WriteLine("La matriz resultante C (A + B) es:");
        for (long i = 0; i < rows; i++)
        {
            for (long j = 0; j < cols; j++)
            {
                Console.Write(C[i * cols + j] + "\t");
            }
            Console.WriteLine();
        }
    }
}
```
### mono matriz.exe
![image](https://gist.github.com/user-attachments/assets/e5944468-afbe-40f5-a381-be04eb69cb06)


# 20.- Multiplicación de matrices	 
## nano mat.s
```
.section .text
.global multiplicar_matrices

multiplicar_matrices:
    // Se espera que A, B, C sean punteros a enteros y rowsA, colsA, colsB sean los tamaños
    // A: x0, B: x1, C: x2, rowsA: x3, colsA: x4, colsB: x5

    // Inicializar índices
    mov x6, #0  // i = 0
outer_loop:
    cmp x6, x3  // Comparar i con rowsA
    bge end_outer_loop // Si i >= rowsA, salir del bucle

    mov x7, #0  // j = 0
    mov x8, #0  // k = 0
inner_loop:
    cmp x7, x5  // Comparar j con colsB
    bge end_inner_loop // Si j >= colsB, salir del bucle

    // Inicializar C[i][j] = 0
    mov w9, #0
    str w9, [x2, x6, lsl #2] // C[i][j] = 0

    // k-loop para la multiplicación
    mov x8, #0  // Reiniciar k
k_loop:
    cmp x8, x4  // Comparar k con colsA
    bge end_k_loop // Si k >= colsA, salir del bucle

    // C[i][j] += A[i][k] * B[k][j]
    // Calcular los índices
    mul x10, x6, x4 // x10 = i * colsA
    add x10, x10, x8 // x10 = i * colsA + k
    ldr w11, [x0, x10, lsl #2] // w11 = A[i][k]

    mul x12, x8, x5 // x12 = k * colsB
    add x12, x12, x7 // x12 = k * colsB + j
    ldr w13, [x1, x12, lsl #2] // w13 = B[k][j]

    mul w14, w11, w13 // w14 = A[i][k] * B[k][j]

    // Sumar el resultado a C[i][j]
    ldr w15, [x2, x6, lsl #2] // w15 = C[i][j]
    add w15, w15, w14 // w15 += A[i][k] * B[k][j]
    str w15, [x2, x6, lsl #2] // Guardar el resultado en C[i][j]

    add x8, x8, #1 // k++
    b k_loop // Repetir el bucle k

end_k_loop:
    add x7, x7, #1 // j++
    b inner_loop // Repetir el bucle interno

end_inner_loop:
    add x6, x6, #1 // i++
    b outer_loop // Repetir el bucle externo

end_outer_loop:
    ret
```
## nano mat.cs
```
using System;
using System.Runtime.InteropServices;

public class Mat
{
    [DllImport("libcalculations.so", CallingConvention = CallingConvention.Cdecl)]
    public static extern void multiplicar_matrices(int[] A, int[] B, int[] C, int rowsA, int colsA, int colsB);

    public static void Main()
    {
        int rowsA = 2, colsA = 3, colsB = 2;
        
        int[] A = new int[rowsA * colsA];
        int[] B = new int[colsA * colsB];
        int[] C = new int[rowsA * colsB];

        Console.WriteLine("Ingrese los elementos de la matriz A:");
        for (int i = 0; i < rowsA; i++)
        {
            for (int j = 0; j < colsA; j++)
            {
                Console.Write($"Elemento A[{i},{j}]: ");
                A[i * colsA + j] = int.Parse(Console.ReadLine());
            }
        }

        Console.WriteLine("Ingrese los elementos de la matriz B:");
        for (int i = 0; i < colsA; i++)
        {
            for (int j = 0; j < colsB; j++)
            {
                Console.Write($"Elemento B[{i},{j}]: ");
                B[i * colsB + j] = int.Parse(Console.ReadLine());
            }
        }

        // Llamar a la función de multiplicación de matrices
        multiplicar_matrices(A, B, C, rowsA, colsA, colsB);

        Console.WriteLine("Resultado de la multiplicación de matrices C:");
        for (int i = 0; i < rowsA; i++)
        {
            for (int j = 0; j < colsB; j++)
            {
                Console.Write(C[i * colsB + j] + " ");
            }
            Console.WriteLine();
        }
    }
}
```
### mono mat.exe
![image](https://gist.github.com/user-attachments/assets/40c57d8c-b00a-44ba-ad4f-172e2fe0f819)

# 21.- Transposición de una matriz	
## nano trans.s
```
// trans.s - Transposición de una matriz
// Entrada: Puntero a la matriz de entrada, puntero a la matriz de salida, filas y columnas de la matriz

.global transponer_matriz

transponer_matriz:
    // Registros de entrada:
    // x0 - puntero a la matriz de entrada
    // x1 - puntero a la matriz de salida
    // x2 - número de filas (m)
    // x3 - número de columnas (n)

    mov x4, #0          // Índice fila (i)
1:
    cmp x4, x2          // ¿i >= m?
    bge fin             // Si i >= m, fin del bucle

    mov x5, #0          // Índice columna (j)
2:
    cmp x5, x3          // ¿j >= n?
    bge siguiente_fila  // Si j >= n, pasar a la siguiente fila

    // Calcular el índice en la matriz original
    mul x6, x4, x3      // x6 = i * n
    add x6, x6, x5      // x6 = i * n + j
    ldr w7, [x0, x6, LSL #2] // Cargar elemento de entrada

    // Calcular el índice transpuesto
    mul x8, x5, x2      // x8 = j * m
    add x8, x8, x4      // x8 = j * m + i
    str w7, [x1, x8, LSL #2] // Guardar elemento en la matriz transpuesta

    add x5, x5, #1      // j++
    b 2b                // Repetir columna

siguiente_fila:
    add x4, x4, #1      // i++
    b 1b                // Repetir fila

fin:
    ret
```
## nano trans.cs
```
using System;
using System.Runtime.InteropServices;

class Transposicion
{
    // Importar la función de ensamblador
    [DllImport("libcalculations.so")]
    public static extern void transponer_matriz(int[] matrizEntrada, int[] matrizSalida, long filas, long columnas);

    static void Main()
    {
        Console.Write("Ingrese el número de filas: ");
        int filas = int.Parse(Console.ReadLine());
        Console.Write("Ingrese el número de columnas: ");
        int columnas = int.Parse(Console.ReadLine());

        int[] matrizEntrada = new int[filas * columnas];
        int[] matrizSalida = new int[columnas * filas];

        Console.WriteLine("Ingrese los elementos de la matriz:");
        for (int i = 0; i < filas; i++)
        {
            for (int j = 0; j < columnas; j++)
            {
                Console.Write($"Elemento [{i},{j}]: ");
                matrizEntrada[i * columnas + j] = int.Parse(Console.ReadLine());
            }
        }

        // Llamada a la función de ensamblador
        transponer_matriz(matrizEntrada, matrizSalida, filas, columnas);

        Console.WriteLine("Matriz transpuesta:");
        for (int i = 0; i < columnas; i++)
        {
            for (int j = 0; j < filas; j++)
            {
                Console.Write(matrizSalida[i * filas + j] + " ");
            }
            Console.WriteLine();
        }
    }
}
```
### mono trans.exe
![image](https://gist.github.com/user-attachments/assets/f0322a70-7632-4a7f-83eb-492e6bcdc65a)

# 22.- Conversión de ASCII a entero
## nano ascii.s
```
// ascii.s - Conversión de ASCII a entero
// Entrada: Puntero a la cadena de entrada (en x0)
// Salida: El entero convertido en w0

.global ascii_a_entero

ascii_a_entero:
    mov w1, #0           // Inicializar el resultado en 0
    mov x2, #0           // Índice de posición en la cadena (64 bits para el offset)

1:
    ldrb w3, [x0, x2]    // Leer el siguiente carácter de la cadena (con offset en x2)
    cmp w3, #0           // ¿Es el final de la cadena (valor nulo)?
    beq fin              // Si es el final de la cadena, salir del bucle

    sub w3, w3, #'0'     // Convertir ASCII a dígito (restar '0')
    
    // Multiplicar el resultado acumulado por 10
    mov w4, #10          // Usar un registro temporal para la constante 10
    mul w1, w1, w4       // Multiplicar w1 por 10 usando w4
    add w1, w1, w3       // Sumar el dígito al resultado acumulado

    add x2, x2, #1       // Avanzar al siguiente carácter
    b 1b                 // Repetir

fin:
    mov w0, w1           // Colocar el resultado en w0 para retornar
    ret
```
## nano ascii.cs
```
using System;
using System.Runtime.InteropServices;

class AsciiConversion
{
    // Importar la función de ensamblador
    [DllImport("libcalculations.so")]
    public static extern int ascii_a_entero(string cadena);

    static void Main()
    {
        Console.Write("Ingrese una cadena numérica: ");
        string cadena = Console.ReadLine();

        // Llamada a la función de ensamblador para la conversión
        int numero = ascii_a_entero(cadena);

        Console.WriteLine($"El número entero es: {numero}");
    }
}
```
### mono ascii.exe
![image](https://gist.github.com/user-attachments/assets/fa3aed8b-af29-4bbe-b5d0-c723715977be)

# 23.- 
## nano entero.s
```
.global entero_a_ascii
entero_a_ascii:
    mov x3, x0          // x3 = número a convertir
    mov x4, x2          // x4 = base
    mov x5, x1          // x5 = puntero al buffer
    mov x6, #0          // x6 = índice en el buffer

convertir_digito:
    // Divide x3 entre x4 y guarda el resultado en x7
    udiv x7, x3, x4
    // Calcula el residuo (x3 % x4)
    msub x8, x7, x4, x3 // x8 = x3 - (x7 * x4)

    // Convierte el residuo a ASCII
    cmp x8, #9
    ble convertir_numero // Si el residuo es <= 9

    // Para valores de 10 a 15, convertimos a 'A' (10) a 'F' (15)
    add x8, x8, #'A' - 10
    b guardar_caracter

convertir_numero:
    add x8, x8, #'0' // Convierte 0-9 a ASCII

guardar_caracter:
    // Guarda el carácter en el buffer
    strb w8, [x5, x6]
    add x6, x6, #1    // Incrementa el índice en el buffer

    // Actualiza x3 para la siguiente iteración
    mov x3, x7
    cbnz x3, convertir_digito // Si x3 no es cero, repite

    // Termina la cadena con un byte nulo
    mov w8, #0
    strb w8, [x5, x6]

    // Invertir el buffer (opcional)
    mov x9, x1          // x9 = inicio del buffer
    sub x10, x6, #1     // x10 = final del buffer (sin incluir el byte nulo)

invertir:
    cmp x9, x10
    b.ge fin            // Terminar si x9 >= x10

    ldrb w11, [x9]      // Cargar byte en x9
    ldrb w12, [x10]     // Cargar byte en x10
    strb w12, [x9]      // Intercambiar bytes
    strb w11, [x10]

    add x9, x9, #1
    sub x10, x10, #1
    b invertir

fin:
    ret
```
## nano entero.cs
```
using System;
using System.Runtime.InteropServices;

class Entero
{
    // Declaración de la función en la biblioteca compartida
    [DllImport("libcalculations.so")]
    public static extern void entero_a_ascii(long numero, byte[] buffer, int baseNum);

    static void Main()
    {
        Console.Write("Ingrese el número entero a convertir: ");
        long numero = Convert.ToInt64(Console.ReadLine());

        Console.Write("Ingrese la base (por ejemplo, 10 para decimal, 16 para hexadecimal): ");
        int baseNum = Convert.ToInt32(Console.ReadLine());

        // Crear un buffer suficientemente grande para almacenar el resultado ASCII
        byte[] buffer = new byte[20];

        // Llamar a la función ensambladora para convertir el número
        entero_a_ascii(numero, buffer, baseNum);

        // Buscar el índice del byte nulo (0) para evitar errores de conversión
        int nullIndex = Array.IndexOf(buffer, (byte)0);
        if (nullIndex == -1) nullIndex = buffer.Length;  // Si no hay byte nulo, usa toda la longitud

        // Convertir el buffer de bytes a una cadena en C#, solo hasta el byte nulo
        string resultado = System.Text.Encoding.ASCII.GetString(buffer, 0, nullIndex);
        
        Console.WriteLine($"El número {numero} en base {baseNum} es: {resultado}");
    }
}
```
### mono entero.exe
![image](https://gist.github.com/user-attachments/assets/e224d2d0-8a1a-4ca6-b29d-f55b0e1d7add)

# 24.- Calcular la longitud de una cadena	
## nano cad.s
```
.global longitud_cadena

.section .text
longitud_cadena:
    mov x1, 0                      // Inicializar contador a 0

.loop:
    ldrb w2, [x0, x1]             // Cargar el siguiente byte de la cadena
    cmp w2, #0                     // Comparar con 0 (fin de cadena)
    beq .done                      // Si es 0, saltar a la sección done
    add x1, x1, #1                 // Incrementar contador
    b .loop                        // Volver al inicio del bucle

.done:
    mov x0, x1                     // Retornar la longitud en x0
    ret
```
## nano cad.cs
```
using System;
using System.Runtime.InteropServices;

class Cad
{
    [DllImport("libcalculations.so", CallingConvention = CallingConvention.Cdecl)]
    public static extern long longitud_cadena(byte[] cadena);

    static void Main()
    {
        Console.WriteLine("Ingrese una cadena: ");
        string input = Console.ReadLine();
        byte[] cadena = System.Text.Encoding.ASCII.GetBytes(input + '\0'); // Agregar terminador nulo

        long longitud = longitud_cadena(cadena);
        Console.WriteLine($"La longitud de la cadena es: {longitud}");
    }
}
```
### mono cad.exe
![image](https://gist.github.com/user-attachments/assets/64108ab1-e088-4ec8-8144-09c50ad18fb7)

# 25.- Contar vocales y consonantes	 
## nano vocal.s
```
.global contar_vocales_consonantes

.section .text
contar_vocales_consonantes:
    // x0 = puntero a la cadena
    // x1 = puntero al contador de vocales
    // x2 = puntero al contador de consonantes
    
    // Guardar registros
    stp x29, x30, [sp, #-16]!
    stp x19, x20, [sp, #-16]!  // x19 = vocales, x20 = consonantes
    
    // Inicializar contadores
    mov x19, #0     // vocales = 0
    mov x20, #0     // consonantes = 0
    mov x4, #0      // índice = 0

loop:
    // Cargar carácter actual
    ldrb w3, [x0, x4]
    
    // Si es fin de cadena, terminar
    cbz w3, done
    
    // Convertir a minúscula si es mayúscula
    sub w5, w3, #'A'
    cmp w5, #25
    bhi not_upper
    add w3, w3, #32
    
not_upper:
    // Verificar si es letra minúscula
    sub w5, w3, #'a'
    cmp w5, #25
    bhi next_char
    
    // Comprobar si es vocal
    mov w6, #'a'
    cmp w3, w6
    beq is_vowel
    mov w6, #'e'
    cmp w3, w6
    beq is_vowel
    mov w6, #'i'
    cmp w3, w6
    beq is_vowel
    mov w6, #'o'
    cmp w3, w6
    beq is_vowel
    mov w6, #'u'
    cmp w3, w6
    beq is_vowel
    
    // Si no es vocal, es consonante
    add x20, x20, #1
    b next_char
    
is_vowel:
    add x19, x19, #1
    
next_char:
    add x4, x4, #1
    b loop
    
done:
    // Guardar resultados en las direcciones proporcionadas
    str x19, [x1]    // guardar vocales
    str x20, [x2]    // guardar consonantes
    
    // Restaurar registros
    ldp x19, x20, [sp], #16
    ldp x29, x30, [sp], #16
    ret
```
## nano vocal.cs
```
using System;
using System.Runtime.InteropServices;

class ConvertidorVocales
{
    // Declaración de la función en ensamblador
    [DllImport("libcalculations.so")]
    public static extern void contar_vocales_consonantes(byte[] cadena, out long vocales, out long consonantes);

    static void Main()
    {
        Console.WriteLine("Ingrese una cadena: ");
        string input = Console.ReadLine();

        // Convertir la cadena a un arreglo de bytes
        byte[] cadena = System.Text.Encoding.ASCII.GetBytes(input + '\0'); // Agregar terminador nulo

        long vocales, consonantes;
        contar_vocales_consonantes(cadena, out vocales, out consonantes);

        Console.WriteLine($"Vocales: {vocales}, Consonantes: {consonantes}");
    }
}
```
### mono vocal.exe
![image](https://gist.github.com/user-attachments/assets/d248e645-433b-4d65-b7d5-4a3d3fde1f2f)


# 26.- Operaciones AND, OR, XOR a nivel de bits
## nano datos.s
```
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
```
## nano datos.cs
```
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
```
### mono datos.exe
![image](https://gist.github.com/user-attachments/assets/92242423-8d80-4815-823b-7d7ff7c6b8dc)

# 27.- Desplazamientos a la izquierda y derecha	
## nano desp.s
```
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
```
## nano desp.cs
```
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
```
### mono desp.exe
```
Si ingresas 4 como número y 1 como desplazamiento:
Desplazar a la izquierda (4 << 1) resulta en 8 (binary 100 se convierte en 1000).
Desplazar a la derecha (4 >> 1) resulta en 2 (binary 100 se convierte en 10).
```
![image](https://gist.github.com/user-attachments/assets/c9941a07-a8dd-48ff-8564-bce361799e51)

# 28.- Establecer, borrar y alternar bits	 
## nano alter.s
```
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
```
## nano alter.cs
```
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
```
### mono alter.exe
![image](https://gist.github.com/user-attachments/assets/8fb0620d-fea3-4b30-8ed5-f07b79a007aa)

# 29.- Contar los bits activados en un número	
## nano bit.s
```
.section .text
.global contar_bits

contar_bits:
    mov x1, 0          // Contador de bits activados
    mov x2, x0         // Copia el número a x2

.loop:
    and x3, x2, #1     // Verifica el bit menos significativo
    add x1, x1, x3     // Incrementa el contador si el bit es 1
    lsr x2, x2, #1     // Desplaza a la derecha
    cbnz x2, .loop     // Si x2 no es cero, continúa

    mov x0, x1         // El resultado se almacena en x0
    ret
```
## nano bit.cs
```
using System;
using System.Runtime.InteropServices;

class BitCounter
{
    // Importar la función en ensamblador
    [DllImport("libcalculations.so", CallingConvention = CallingConvention.Cdecl)]
    public static extern long contar_bits(long number);

    static void Main()
    {
        Console.Write("Ingrese un número: ");
        long number = Convert.ToInt64(Console.ReadLine());

        long result = contar_bits(number);
        Console.WriteLine($"El número de bits activados en {number} es: {result}");
    }
}
```
### mono bit.exe
```
El programa debería devolver El número de bits activados en 5 es: 2, ya que 5 en binario es 101, que tiene dos bits activados.
```
![image](https://gist.github.com/user-attachments/assets/310787c7-39e3-4812-8ba4-368b9b43f702)

# 30.- Máximo Común Divisor (MCD)	
## nano mcd.s
```
.section .text
.global calcular_mcd

calcular_mcd:
    // Preservar registros
    stp x29, x30, [sp, #-16]!
    
    // x0: primer número
    // x1: segundo número
    
    // Verificar que x1 no sea 0
    cmp x1, #0
    beq .fin
    
.loop:
    // Algoritmo de Euclides
    udiv x2, x0, x1     // x2 = x0 / x1
    msub x2, x2, x1, x0 // x2 = x0 - (x2 * x1) [remainder]
    mov x0, x1          // x0 = x1
    mov x1, x2          // x1 = remainder
    
    cmp x1, #0          // Comparar si el remainder es 0
    bne .loop           // Si no es 0, continuar el loop
    
.fin:
    // Restaurar registros y retornar
    ldp x29, x30, [sp], #16
    ret
```
## nano mcd.cs
```
using System;
using System.Runtime.InteropServices;

class MCDCalculator
{
    // Importar la función en ensamblador
    [DllImport("libcalculations.so", CallingConvention = CallingConvention.Cdecl)]
    public static extern long calcular_mcd(long a, long b);

    static void Main()
    {
        Console.Write("Ingrese el primer número: ");
        long a = Convert.ToInt64(Console.ReadLine());

        Console.Write("Ingrese el segundo número: ");
        long b = Convert.ToInt64(Console.ReadLine());

        long result = calcular_mcd(a, b);
        Console.WriteLine($"El MCD de {a} y {b} es: {result}");
    }
}
```
### mono mcd.exe
![image](https://gist.github.com/user-attachments/assets/9493ebf5-f9c6-4491-b2b6-cf50980f0d1d)

# 31.- Mínimo Común Múltiplo (MCM)	 
## nano mcm.s
```
// mcm.s - Ensamblador ARM64 para calcular el MCM

.global mcm

// Calcula el MCM de dos números a y b
mcm:
    // Guardar registros
    stp x29, x30, [sp, -16]!
    mov x29, sp

    // Guardar valores iniciales en registros para el cálculo
    mov x2, x0          // x2 = a
    mov x3, x1          // x3 = b

    // Calcular el producto a * b y guardarlo en x4
    mul x4, x2, x3      // x4 = a * b

    // Llamar a la función mcd para obtener el MCD
    bl mcd              // Resultado del MCD está en x0 después de la llamada

    // Dividir el producto (a * b) entre el MCD para obtener el MCM
    udiv x0, x4, x0     // MCM almacenado en x0

    // Restaurar registros y retornar
    ldp x29, x30, [sp], 16
    ret

// Función para calcular el MCD usando el Algoritmo de Euclides
mcd:
    // x0 = a, x1 = b
    cmp x1, 0
    b.eq mcd_done
mcd_loop:
    mov x2, x1
    udiv x3, x0, x1     // x3 = x0 / x1
    msub x1, x3, x1, x0 // x1 = x0 - (x3 * x1)
    mov x0, x2
    cbnz x1, mcd_loop
mcd_done:
    ret
```
## nano mcm.cs
```
// mcm.cs - C# para invocar el ensamblador ARM64 y calcular el MCM
using System;
using System.Runtime.InteropServices;

class Program
{
    // Importar la función mcm desde el archivo ensamblador
    [DllImport("mcm.so", EntryPoint = "mcm")]
    private static extern long MCM(long a, long b);

    static void Main()
    {
        Console.WriteLine("Introduce dos números:");
        Console.Write("a: ");
        long a = Convert.ToInt64(Console.ReadLine());
        Console.Write("b: ");
        long b = Convert.ToInt64(Console.ReadLine());

        long result = MCM(a, b);
        Console.WriteLine($"El MCM de {a} y {b} es: {result}");
    }
}
```
### mono mcm.exe
![image](https://gist.github.com/user-attachments/assets/3a2109d9-c4b9-4214-98af-4f4427022999)

# 32.- Potencia (x^n)	 
## nano poten.s
```
// poten.s - Ensamblador ARM64 para calcular la potencia x^n

.global potencia

// Calcula la potencia x^n (x en x0, n en x1, resultado en x0)
potencia:
    // Guardar registros
    stp x29, x30, [sp, -16]!
    mov x29, sp

    // Verificar si el exponente (n) es 0
    cmp x1, 0
    b.eq potencia_base_cero // Si n es 0, devolver 1

    // Inicializar el resultado en x2 con x (base)
    mov x2, x0

potencia_loop:
    // Decrementar el exponente (n)
    sub x1, x1, 1
    cmp x1, 0
    b.eq potencia_done      // Si n llega a 0, salir del bucle

    // Multiplicar el resultado actual por x (base)
    mul x2, x2, x0
    b potencia_loop         // Repetir el bucle

potencia_base_cero:
    mov x2, 1               // Si n es 0, x^0 = 1

potencia_done:
    // Mover el resultado a x0
    mov x0, x2

    // Restaurar registros y retornar
    ldp x29, x30, [sp], 16
    ret
```
## nano poten.cs
```
// poten.cs - C# para invocar el ensamblador ARM64 y calcular la potencia x^n
using System;
using System.Runtime.InteropServices;

class Program
{
    // Importar la función potencia desde el archivo ensamblador
    [DllImport("poten.so", EntryPoint = "potencia")]
    private static extern long Potencia(long x, long n);

    static void Main()
    {
        Console.WriteLine("Introduce la base y el exponente:");
        Console.Write("Base (x): ");
        long x = Convert.ToInt64(Console.ReadLine());
        Console.Write("Exponente (n): ");
        long n = Convert.ToInt64(Console.ReadLine());

        long result = Potencia(x, n);
        Console.WriteLine($"{x}^{n} es: {result}");
    }
}
```
### mono poten.exe
![image](https://gist.github.com/user-attachments/assets/639437a0-edeb-4fcb-aa83-fc4533e236fd)

# 33.- Suma de elementos en un arreglo	 
## arreglo.s
```
// arreglo.s - Ensamblador ARM64 para sumar los elementos de un arreglo

.global suma_arreglo

// Función que calcula la suma de un arreglo
// Entrada: x0 = puntero al arreglo, x1 = tamaño del arreglo
// Salida: x0 = suma de los elementos
suma_arreglo:
    // Guardar registros
    stp x29, x30, [sp, -16]!
    mov x29, sp

    // Inicializar la suma en x2 a 0
    mov x2, 0

suma_loop:
    // Comprobar si el tamaño (x1) es 0
    cmp x1, 0
    beq suma_done

    // Cargar el valor actual del arreglo en x3
    ldr x3, [x0], 8      // Cargar valor de x0 y avanzar el puntero en 8 bytes (para enteros de 64 bits)
    add x2, x2, x3       // Sumar el valor en x2

    // Decrementar el tamaño del arreglo
    sub x1, x1, 1
    b suma_loop          // Repetir el bucle

suma_done:
    // Mover el resultado a x0
    mov x0, x2

    // Restaurar registros y retornar
    ldp x29, x30, [sp], 16
    ret
```
## arreglo.cs
```
// arreglo.cs - C# para invocar el ensamblador ARM64 y calcular la suma de un arreglo
using System;
using System.Runtime.InteropServices;

class Program
{
    // Importar la función suma_arreglo desde el archivo ensamblador
    [DllImport("arreglo.so", EntryPoint = "suma_arreglo")]
    private static extern long SumaArreglo(long[] arreglo, long tamaño);

    static void Main()
    {
        Console.WriteLine("Introduce el número de elementos en el arreglo:");
        int n = Convert.ToInt32(Console.ReadLine());
        long[] arreglo = new long[n];

        Console.WriteLine("Introduce los elementos del arreglo:");
        for (int i = 0; i < n; i++)
        {
            Console.Write($"Elemento {i + 1}: ");
            arreglo[i] = Convert.ToInt64(Console.ReadLine());
        }

        long suma = SumaArreglo(arreglo, n);
        Console.WriteLine($"La suma de los elementos del arreglo es: {suma}");
    }
}
```
### mono arreglo.exe
![image](https://gist.github.com/user-attachments/assets/e49d68f6-ab71-4bf8-a127-655cc1f55bb4)

# 34.- Invertir los elementos de un arreglo	
## invertir.s
```
// invertir.s - Ensamblador ARM64 para invertir los elementos de un arreglo

.global invertir_arreglo

// Función que invierte un arreglo
// Entrada: x0 = puntero al arreglo, x1 = tamaño del arreglo
invertir_arreglo:
    // Guardar registros
    stp x29, x30, [sp, -16]!
    mov x29, sp

    // Calcular los límites iniciales
    mov x2, x0           // x2 = puntero al inicio del arreglo
    add x3, x0, x1, lsl #3  // x3 = puntero al final del arreglo (x1 * 8 bytes para enteros de 64 bits)
    sub x3, x3, 8        // Ajustar x3 para que apunte al último elemento

invertir_loop:
    // Comparar los punteros para ver si se cruzaron
    cmp x2, x3
    b.ge invertir_done   // Si se cruzaron, terminar

    // Intercambiar los elementos apuntados por x2 y x3
    ldr x4, [x2]         // Cargar el valor en x2 en x4
    ldr x5, [x3]         // Cargar el valor en x3 en x5
    str x5, [x2]         // Almacenar x5 en la posición de x2
    str x4, [x3]         // Almacenar x4 en la posición de x3

    // Mover los punteros hacia el centro
    add x2, x2, 8        // Avanzar x2 al siguiente elemento
    sub x3, x3, 8        // Retroceder x3 al elemento anterior
    b invertir_loop      // Repetir el bucle

invertir_done:
    // Restaurar registros y retornar
    ldp x29, x30, [sp], 16
    ret
```
## invertir.cs
```
// invertir.cs - C# para invocar el ensamblador ARM64 y invertir los elementos de un arreglo
using System;
using System.Runtime.InteropServices;

class Program
{
    // Importar la función invertir_arreglo desde el archivo ensamblador
    [DllImport("invertir.so", EntryPoint = "invertir_arreglo")]
    private static extern void InvertirArreglo(long[] arreglo, long tamaño);

    static void Main()
    {
        Console.WriteLine("Introduce el número de elementos en el arreglo:");
        int n = Convert.ToInt32(Console.ReadLine());
        long[] arreglo = new long[n];

        Console.WriteLine("Introduce los elementos del arreglo:");
        for (int i = 0; i < n; i++)
        {
            Console.Write($"Elemento {i + 1}: ");
            arreglo[i] = Convert.ToInt64(Console.ReadLine());
        }

        // Llamar a la función de ensamblador para invertir el arreglo
        InvertirArreglo(arreglo, n);

        Console.WriteLine("Arreglo invertido:");
        foreach (long elemento in arreglo)
        {
            Console.Write(elemento + " ");
        }
        Console.WriteLine();
    }
}
```
### mono invertir.exe
![image](https://gist.github.com/user-attachments/assets/e9db95b1-9437-4bcc-b0a1-0ac6f3ee2b9f)


# 35.- Rotación de un arreglo (izquierda/derecha)	
## nano rotacion.s
```
// rotacion.s - Ensamblador ARM64 para rotar los elementos de un arreglo

.global rotar_arreglo

// Función que rota un arreglo a la izquierda o derecha
// Entrada: x0 = puntero al arreglo, x1 = tamaño del arreglo, x2 = número de posiciones, x3 = dirección (0 = izquierda, 1 = derecha)
rotar_arreglo:
    // Guardar registros
    stp x29, x30, [sp, -16]!
    mov x29, sp

    // Ajustar el número de posiciones para que esté dentro del tamaño del arreglo
    udiv x2, x2, x1      // x2 %= x1 (número de rotaciones efectivas)

    // Si el tamaño es 0 o la rotación es nula, regresar
    cbz x1, rotacion_done
    cbz x2, rotacion_done

    // Seleccionar dirección de rotación
    cmp x3, 0
    beq rotacion_izquierda
    b rotacion_derecha

rotacion_izquierda:
    // Guardar el primer elemento temporalmente y hacer un shift a la izquierda
    ldr x4, [x0]                 // Guardar el primer elemento en x4
    add x5, x0, 8                // Puntero al siguiente elemento

rotacion_izq_loop:
    // Desplazar elementos
    cmp x1, 1
    b.le rotacion_izq_store      // Si sólo queda un elemento, almacenar x4
    ldr x6, [x5]                 // Cargar el siguiente elemento
    str x6, [x0], 8              // Desplazar a la izquierda
    mov x5, x0                   // Mover puntero
    sub x1, x1, 1
    b rotacion_izq_loop

rotacion_izq_store:
    str x4, [x0]
    b rotacion_done

rotacion_derecha:
    // Guardar el último elemento temporalmente y hacer un shift a la derecha
    add x5, x0, x1, lsl #3       // Puntero al último elemento
    sub x5, x5, 8                // Ajustar para último índice
    ldr x4, [x5]                 // Guardar último elemento en x4

rotacion_der_loop:
    // Desplazar elementos
    cmp x1, 1
    b.le rotacion_der_store      // Si sólo queda un elemento, almacenar x4
    ldr x6, [x5, -8]             // Cargar el elemento anterior
    str x6, [x5]                 // Desplazar a la derecha
    mov x5, x5                   // Ajustar puntero
    sub x1, x1, 1
    b rotacion_der_loop

rotacion_der_store:
    str x4, [x5]
    b rotacion_done

rotacion_done:
    // Restaurar registros y retornar
    ldp x29, x30, [sp], 16
    ret
```
## nano rotacion.cs
```
// rotacion.cs - C# para invocar el ensamblador ARM64 y rotar los elementos de un arreglo
using System;
using System.Runtime.InteropServices;

class Program
{
    // Importar la función rotar_arreglo desde el archivo ensamblador
    [DllImport("rotacion.so", EntryPoint = "rotar_arreglo")]
    private static extern void RotarArreglo(long[] arreglo, long tamaño, long posiciones, long direccion);

    static void Main()
    {
        Console.WriteLine("Introduce el número de elementos en el arreglo:");
        int n = Convert.ToInt32(Console.ReadLine());
        long[] arreglo = new long[n];

        Console.WriteLine("Introduce los elementos del arreglo:");
        for (int i = 0; i < n; i++)
        {
            Console.Write($"Elemento {i + 1}: ");
            arreglo[i] = Convert.ToInt64(Console.ReadLine());
        }

        Console.Write("Introduce el número de posiciones para rotar: ");
        long posiciones = Convert.ToInt64(Console.ReadLine());

        Console.Write("Dirección de rotación (0 = izquierda, 1 = derecha): ");
        long direccion = Convert.ToInt64(Console.ReadLine());

        // Llamar a la función de ensamblador para rotar el arreglo
        RotarArreglo(arreglo, n, posiciones, direccion);

        Console.WriteLine("Arreglo después de la rotación:");
        foreach (long elemento in arreglo)
        {
            Console.Write(elemento + " ");
        }
        Console.WriteLine();
    }
}
```
### mono rotacion.exe
![image](https://gist.github.com/user-attachments/assets/b766efff-ba59-4818-b905-dad06290963d)

# 36.- Encontrar el segundo elemento más grande	
## nano grande.s
```
// grande.s - Ensamblador ARM64 para encontrar el segundo elemento más grande en un arreglo

.global segundo_mas_grande

// Función que encuentra el segundo elemento más grande
// Entrada: x0 = puntero al arreglo, x1 = tamaño del arreglo
segundo_mas_grande:
    stp x29, x30, [sp, -16]!   // Guardar registros
    mov x29, sp

    // Inicializar los dos máximos
    mov x2, -1                  // max1 = -1
    mov x3, -1                  // max2 = -1

    // Bucle para recorrer el arreglo
    mov x4, 0                   // índice i = 0

busqueda_loop:
    cmp x4, x1                  // Comparar i con tamaño del arreglo
    bge busqueda_done           // Si i >= tamaño, terminar

    ldr x5, [x0, x4, lsl #3]    // Cargar el elemento en x5 (8 bytes por entero)
    
    // Comparar con max1
    cmp x5, x2
    ble comprobar_max2          // Si x5 <= max1, comprobar max2

    // Actualizar max2 y max1
    mov x3, x2                  // max2 = max1
    mov x2, x5                  // max1 = x5

    b busqueda_continue

comprobar_max2:
    // Comparar con max2
    cmp x5, x3
    ble busqueda_continue        // Si x5 <= max2, continuar

    // Actualizar max2
    mov x3, x5                  // max2 = x5

busqueda_continue:
    add x4, x4, 1               // Incrementar índice
    b busqueda_loop             // Repetir bucle

busqueda_done:
    // Verificar si max2 se actualizó
    cmp x3, x2                  // Si max2 es igual a max1, no hay segundo mayor
    beq no_segundo_mayor
    mov x0, x3                  // Retornar max2
    b fin

no_segundo_mayor:
    mov x0, -1                  // Retornar -1 si no se encontró segundo mayor

fin:
    ldp x29, x30, [sp], 16
    ret
```
## nano grande.cs
```
// grande.cs - C# para invocar el ensamblador ARM64 y encontrar el segundo elemento más grande
using System;
using System.Runtime.InteropServices;

class Program
{
    // Importar la función segundo_mas_grande desde el archivo ensamblador
    [DllImport("grande.so", EntryPoint = "segundo_mas_grande")]
    private static extern long SegundoMasGrande(long[] arreglo, long tamaño);

    static void Main()
    {
        Console.WriteLine("Introduce el número de elementos en el arreglo:");
        int n = Convert.ToInt32(Console.ReadLine());
        long[] arreglo = new long[n];

        Console.WriteLine("Introduce los elementos del arreglo:");
        for (int i = 0; i < n; i++)
        {
            Console.Write($"Elemento {i + 1}: ");
            arreglo[i] = Convert.ToInt64(Console.ReadLine());
        }

        // Llamar a la función de ensamblador para encontrar el segundo elemento más grande
        long segundoMayor = SegundoMasGrande(arreglo, n);

        if (segundoMayor == -1)
        {
            Console.WriteLine("No se encontró un segundo elemento más grande.");
        }
        else
        {
            Console.WriteLine($"El segundo elemento más grande es: {segundoMayor}");
        }
    }
}
```
### mono grande.exe
![image](https://gist.github.com/user-attachments/assets/5789ed94-1060-4e90-b065-e2f31e1343f7)

# 37.- Implementar una pila usando un arreglo
## nano pila.s
```
.data
    // Estructura de datos para la pila
    .align 3                    // Alineamiento a 8 bytes
    stack_array: .skip 800      // Espacio para 100 elementos de 8 bytes
    stack_count: .word 0        // Contador de elementos
    .equ MAX_SIZE, 100         // Constante para tamaño máximo

.text
.align 2
.global init_pila
.global push
.global pop
.global is_empty

// Función para inicializar la pila
init_pila:
    stp     x29, x30, [sp, -16]!   // Guardar frame pointer y link register
    mov     x29, sp
    
    adrp    x0, stack_count        // Cargar dirección de stack_count
    add     x0, x0, :lo12:stack_count
    str     wzr, [x0]              // Inicializar contador a 0
    
    ldp     x29, x30, [sp], 16
    ret

// Función para apilar (push)
push:
    stp     x29, x30, [sp, -16]!
    mov     x29, sp
    
    // Verificar si hay espacio
    adrp    x1, stack_count
    add     x1, x1, :lo12:stack_count
    ldr     w2, [x1]               // Cargar contador actual
    cmp     w2, MAX_SIZE
    b.ge    push_overflow
    
    // Calcular dirección donde guardar
    adrp    x3, stack_array
    add     x3, x3, :lo12:stack_array
    lsl     x4, x2, #3             // Multiplicar índice por 8
    str     x0, [x3, x4]           // Guardar valor
    
    // Incrementar contador
    add     w2, w2, #1
    str     w2, [x1]
    
    mov     x0, #0                 // Retorno exitoso
    ldp     x29, x30, [sp], 16
    ret

push_overflow:
    mov     x0, #-1                // Código de error
    ldp     x29, x30, [sp], 16
    ret

// Función para desapilar (pop)
pop:
    stp     x29, x30, [sp, -16]!
    mov     x29, sp
    
    // Verificar si hay elementos
    adrp    x1, stack_count
    add     x1, x1, :lo12:stack_count
    ldr     w2, [x1]
    cbz     w2, pop_empty
    
    // Calcular dirección del elemento a extraer
    sub     w2, w2, #1             // Decrementar contador
    str     w2, [x1]               // Guardar nuevo contador
    
    adrp    x3, stack_array
    add     x3, x3, :lo12:stack_array
    lsl     x4, x2, #3             // Multiplicar índice por 8
    ldr     x0, [x3, x4]           // Cargar valor
    
    ldp     x29, x30, [sp], 16
    ret

pop_empty:
    mov     x0, #-1                // Código de error
    ldp     x29, x30, [sp], 16
    ret

// Función para verificar si está vacía
is_empty:
    adrp    x1, stack_count
    add     x1, x1, :lo12:stack_count
    ldr     w0, [x1]
    cmp     w0, #0
    cset    w0, eq                 // Establecer 1 si está vacía, 0 si no
    ret
```
## nano pila.cs
```
// pila.cs - C# para invocar el ensamblador ARM64 y manejar una pila
using System;
using System.Runtime.InteropServices;

class Program
{
    // Importar las funciones desde el ensamblador
    [DllImport("pila.so", EntryPoint = "init_pila")]
    private static extern void InitPila();

    [DllImport("pila.so", EntryPoint = "push")]
    private static extern long Push(long value);

    [DllImport("pila.so", EntryPoint = "pop")]
    private static extern long Pop();

    [DllImport("pila.so", EntryPoint = "is_empty")]
    private static extern int IsEmpty();

    static void Main()
    {
        InitPila();
        int option;

        do
        {
            Console.WriteLine("\nMenu:");
            Console.WriteLine("1. Apilar");
            Console.WriteLine("2. Desapilar");
            Console.WriteLine("3. Verificar si la pila está vacía");
            Console.WriteLine("0. Salir");
            Console.Write("Seleccione una opción: ");
            option = Convert.ToInt32(Console.ReadLine());

            switch (option)
            {
                case 1:
                    Console.Write("Ingrese un valor a apilar: ");
                    long value = Convert.ToInt64(Console.ReadLine());
                    long result = Push(value);
                    if (result == -1)
                    {
                        Console.WriteLine("Error: Desbordamiento de pila.");
                    }
                    else
                    {
                        Console.WriteLine($"{value} apilado.");
                    }
                    break;

                case 2:
                    long poppedValue = Pop();
                    if (poppedValue == -1)
                    {
                        Console.WriteLine("Error: Pila vacía.");
                    }
                    else
                    {
                        Console.WriteLine($"Desapilado: {poppedValue}");
                    }
                    break;

                case 3:
                    if (IsEmpty() == 1)
                    {
                        Console.WriteLine("La pila está vacía.");
                    }
                    else
                    {
                        Console.WriteLine("La pila no está vacía.");
                    }
                    break;

                case 0:
                    Console.WriteLine("Saliendo...");
                    break;

                default:
                    Console.WriteLine("Opción no válida.");
                    break;
            }
        } while (option != 0);
    }
}
```
### mono pila.exe
![image](https://gist.github.com/user-attachments/assets/d8ba5e19-26cd-4ed6-a661-d823b6b2f4ff)
![image](https://gist.github.com/user-attachments/assets/5f2198d4-45ea-4fff-835b-472716a1fee5)

# 38.- Implementar una cola usando un arreglo	 
## nano cola.s
```
.data
    .align 3                    // Alineamiento a 8 bytes
    queue_array: .skip 800      // Espacio para 100 elementos de 8 bytes
    front: .word 0             // Índice del frente de la cola
    rear: .word 0              // Índice del final de la cola
    count: .word 0             // Contador de elementos
    .equ MAX_SIZE, 100         // Tamaño máximo de la cola

.text
.align 2
.global init_cola
.global enqueue
.global dequeue
.global is_empty
.global is_full

// Inicializar cola
init_cola:
    stp     x29, x30, [sp, -16]!
    mov     x29, sp
    
    // Reiniciar todos los índices a 0
    adrp    x0, front
    add     x0, x0, :lo12:front
    str     wzr, [x0]
    
    adrp    x0, rear
    add     x0, x0, :lo12:rear
    str     wzr, [x0]
    
    adrp    x0, count
    add     x0, x0, :lo12:count
    str     wzr, [x0]
    
    ldp     x29, x30, [sp], 16
    ret

// Encolar (enqueue) - x0 contiene el valor a encolar
enqueue:
    stp     x29, x30, [sp, -16]!
    mov     x29, sp
    
    // Verificar si la cola está llena
    bl      is_full
    cbnz    w0, enqueue_full
    
    // Obtener índice rear actual
    adrp    x1, rear
    add     x1, x1, :lo12:rear
    ldr     w2, [x1]
    
    // Guardar valor en la cola
    adrp    x3, queue_array
    add     x3, x3, :lo12:queue_array
    lsl     x4, x2, #3             // Multiplicar índice por 8
    str     x0, [x3, x4]           // Guardar valor
    
    // Actualizar rear
    add     w2, w2, #1
    cmp     w2, MAX_SIZE
    csel    w2, wzr, w2, eq        // Si rear == MAX_SIZE, volver a 0
    str     w2, [x1]
    
    // Incrementar count
    adrp    x1, count
    add     x1, x1, :lo12:count
    ldr     w2, [x1]
    add     w2, w2, #1
    str     w2, [x1]
    
    mov     x0, #0                 // Éxito
    ldp     x29, x30, [sp], 16
    ret

enqueue_full:
    mov     x0, #-1                // Error: cola llena
    ldp     x29, x30, [sp], 16
    ret

// Desencolar (dequeue)
dequeue:
    stp     x29, x30, [sp, -16]!
    mov     x29, sp
    
    // Verificar si la cola está vacía
    bl      is_empty
    cbnz    w0, dequeue_empty
    
    // Obtener valor del frente
    adrp    x1, front
    add     x1, x1, :lo12:front
    ldr     w2, [x1]
    
    adrp    x3, queue_array
    add     x3, x3, :lo12:queue_array
    lsl     x4, x2, #3
    ldr     x0, [x3, x4]           // Cargar valor a retornar
    
    // Actualizar front
    add     w2, w2, #1
    cmp     w2, MAX_SIZE
    csel    w2, wzr, w2, eq        // Si front == MAX_SIZE, volver a 0
    str     w2, [x1]
    
    // Decrementar count
    adrp    x1, count
    add     x1, x1, :lo12:count
    ldr     w2, [x1]
    sub     w2, w2, #1
    str     w2, [x1]
    
    ldp     x29, x30, [sp], 16
    ret

dequeue_empty:
    mov     x0, #-1                // Error: cola vacía
    ldp     x29, x30, [sp], 16
    ret

// Verificar si está vacía
is_empty:
    adrp    x1, count
    add     x1, x1, :lo12:count
    ldr     w0, [x1]
    cmp     w0, #0
    cset    w0, eq                 // 1 si está vacía, 0 si no
    ret

// Verificar si está llena
is_full:
    adrp    x1, count
    add     x1, x1, :lo12:count
    ldr     w0, [x1]
    cmp     w0, MAX_SIZE
    cset    w0, eq                 // 1 si está llena, 0 si no
    ret
```
## nano cola.cs
```
using System;
using System.Runtime.InteropServices;

class Program
{
    // Importar funciones del ensamblador
    [DllImport("cola.so", EntryPoint = "init_cola")]
    private static extern void InitCola();

    [DllImport("cola.so", EntryPoint = "enqueue")]
    private static extern long Enqueue(long value);

    [DllImport("cola.so", EntryPoint = "dequeue")]
    private static extern long Dequeue();

    [DllImport("cola.so", EntryPoint = "is_empty")]
    private static extern int IsEmpty();

    [DllImport("cola.so", EntryPoint = "is_full")]
    private static extern int IsFull();

    static void Main()
    {
        InitCola();
        int opcion;

        do
        {
            Console.WriteLine("\nMenú Cola:");
            Console.WriteLine("1. Encolar (Enqueue)");
            Console.WriteLine("2. Desencolar (Dequeue)");
            Console.WriteLine("3. Verificar si está vacía");
            Console.WriteLine("4. Verificar si está llena");
            Console.WriteLine("0. Salir");
            Console.Write("Seleccione una opción: ");
            
            if (int.TryParse(Console.ReadLine(), out opcion))
            {
                switch (opcion)
                {
                    case 1:
                        Console.Write("Ingrese el valor a encolar: ");
                        if (long.TryParse(Console.ReadLine(), out long valor))
                        {
                            long resultado = Enqueue(valor);
                            if (resultado == -1)
                            {
                                Console.WriteLine("Error: La cola está llena.");
                            }
                            else
                            {
                                Console.WriteLine($"Valor {valor} encolado exitosamente.");
                            }
                        }
                        else
                        {
                            Console.WriteLine("Error: Ingrese un número válido.");
                        }
                        break;

                    case 2:
                        long valorDesencolado = Dequeue();
                        if (valorDesencolado == -1)
                        {
                            Console.WriteLine("Error: La cola está vacía.");
                        }
                        else
                        {
                            Console.WriteLine($"Valor desencolado: {valorDesencolado}");
                        }
                        break;

                    case 3:
                        if (IsEmpty() == 1)
                        {
                            Console.WriteLine("La cola está vacía.");
                        }
                        else
                        {
                            Console.WriteLine("La cola no está vacía.");
                        }
                        break;

                    case 4:
                        if (IsFull() == 1)
                        {
                            Console.WriteLine("La cola está llena.");
                        }
                        else
                        {
                            Console.WriteLine("La cola no está llena.");
                        }
                        break;

                    case 0:
                        Console.WriteLine("Saliendo del programa...");
                        break;

                    default:
                        Console.WriteLine("Opción no válida.");
                        break;
                }
            }
            else
            {
                Console.WriteLine("Error: Ingrese un número válido.");
                opcion = -1;
            }

        } while (opcion != 0);
    }
}
```
### mono cola.exe
![image](https://gist.github.com/user-attachments/assets/477be79f-d45b-43c2-ab7b-fa01ac099dfc)
![image](https://gist.github.com/user-attachments/assets/13c7a7e4-6bf0-44ec-b01b-0136cea67872)
![image](https://gist.github.com/user-attachments/assets/9d7fe4c3-27cf-4ad8-a17b-9a52da3b8ed6)

# 39.- Convertir decimal a binario	 
## nano convertir.s
```
.data
    .align 3
    binary_array: .skip 64      // Espacio para 64 bits (suficiente para un long)
    result_size: .word 0        // Cantidad de bits en el resultado

.text
.align 2
.global decimal_to_binary
.global get_bit
.global get_size

// Función para convertir decimal a binario
// Entrada: x0 = número decimal
decimal_to_binary:
    stp     x29, x30, [sp, -32]!
    mov     x29, sp
    str     x19, [sp, 16]      // Guardar x19 para usarlo
    
    mov     x19, x0            // Guardar número original en x19
    
    // Reiniciar contador de bits
    adrp    x0, result_size
    add     x0, x0, :lo12:result_size
    str     wzr, [x0]
    
    // Si el número es 0, manejar caso especial
    cbnz    x19, conversion_loop
    
    // Caso especial para 0
    adrp    x0, binary_array
    add     x0, x0, :lo12:binary_array
    strb    wzr, [x0]
    
    adrp    x0, result_size
    add     x0, x0, :lo12:result_size
    mov     w1, #1
    str     w1, [x0]
    b       end_conversion

conversion_loop:
    // Mientras el número no sea 0
    cbz     x19, end_conversion
    
    // Obtener el bit actual (número & 1)
    and     w1, w19, #1
    
    // Obtener índice actual
    adrp    x2, result_size
    add     x2, x2, :lo12:result_size
    ldr     w3, [x2]
    
    // Guardar el bit en el array
    adrp    x4, binary_array
    add     x4, x4, :lo12:binary_array
    strb    w1, [x4, x3]
    
    // Incrementar contador
    add     w3, w3, #1
    str     w3, [x2]
    
    // Dividir número entre 2 (shift right)
    lsr     x19, x19, #1
    
    b       conversion_loop

end_conversion:
    ldr     x19, [sp, 16]      // Restaurar x19
    ldp     x29, x30, [sp], 32
    ret

// Función para obtener un bit específico del resultado
// Entrada: x0 = índice del bit
// Salida: x0 = valor del bit (0 o 1)
get_bit:
    stp     x29, x30, [sp, -16]!
    mov     x29, sp
    
    // Verificar que el índice sea válido
    adrp    x1, result_size
    add     x1, x1, :lo12:result_size
    ldr     w1, [x1]
    cmp     w0, w1
    b.ge    invalid_index
    
    // Obtener el bit del array
    adrp    x1, binary_array
    add     x1, x1, :lo12:binary_array
    ldrb    w0, [x1, x0]
    
    ldp     x29, x30, [sp], 16
    ret

invalid_index:
    mov     x0, #-1            // Retornar -1 para índice inválido
    ldp     x29, x30, [sp], 16
    ret

// Función para obtener el tamaño del resultado binario
// Salida: x0 = cantidad de bits
get_size:
    adrp    x0, result_size
    add     x0, x0, :lo12:result_size
    ldr     w0, [x0]
    ret
```
## nano convertir.cs
```
using System;
using System.Runtime.InteropServices;
using System.Text;

class Program
{
    [DllImport("convertir.so", EntryPoint = "decimal_to_binary")]
    private static extern void DecimalToBinary(long number);

    [DllImport("convertir.so", EntryPoint = "get_bit")]
    private static extern long GetBit(int index);

    [DllImport("convertir.so", EntryPoint = "get_size")]
    private static extern int GetSize();

    static string GetBinaryString(long number)
    {
        DecimalToBinary(number);
        int size = GetSize();
        StringBuilder result = new StringBuilder();

        // Construir el string binario desde el último bit hasta el primero
        for (int i = size - 1; i >= 0; i--)
        {
            result.Append(GetBit(i));
        }

        return result.ToString();
    }

    static void Main()
    {
        while (true)
        {
            Console.WriteLine("\nConversor de Decimal a Binario");
            Console.WriteLine("1. Convertir número");
            Console.WriteLine("0. Salir");
            Console.Write("Seleccione una opción: ");

            if (int.TryParse(Console.ReadLine(), out int opcion))
            {
                switch (opcion)
                {
                    case 1:
                        Console.Write("\nIngrese un número decimal (0-9223372036854775807): ");
                        if (long.TryParse(Console.ReadLine(), out long numero))
                        {
                            if (numero < 0)
                            {
                                Console.WriteLine("Por favor, ingrese un número positivo.");
                                break;
                            }

                            string binario = GetBinaryString(numero);
                            Console.WriteLine($"\nNúmero decimal: {numero}");
                            Console.WriteLine($"Número binario: {binario}");
                            
                            // Mostrar información adicional
                            Console.WriteLine($"Cantidad de bits: {binario.Length}");
                            if (binario.Length > 0)
                            {
                                Console.WriteLine($"Bit más significativo: {binario[0]}");
                                Console.WriteLine($"Bit menos significativo: {binario[binario.Length - 1]}");
                            }
                        }
                        else
                        {
                            Console.WriteLine("Error: Ingrese un número válido.");
                        }
                        break;

                    case 0:
                        Console.WriteLine("Saliendo del programa...");
                        return;

                    default:
                        Console.WriteLine("Opción no válida.");
                        break;
                }
            }
            else
            {
                Console.WriteLine("Error: Ingrese un número válido.");
            }
        }
    }
}
```
### mono convertir.exe
![image](https://gist.github.com/user-attachments/assets/32872b7c-a169-4cd8-a089-db3c5739f96e)

# 40.- Convertir binario a decimal	
## nano binario.s
```
.data
    .align 3
    error_flag: .word 0        // Flag para indicar error en la entrada

.text
.align 2
.global binary_to_decimal
.global get_error
.global clear_error

// Función para convertir binario a decimal
// Entrada: x0 = dirección del string binario
// Salida: x0 = número decimal resultante
binary_to_decimal:
    stp     x29, x30, [sp, -48]!
    mov     x29, sp
    stp     x19, x20, [sp, 16]     // Guardar registros que usaremos
    stp     x21, x22, [sp, 32]

    // Inicializar registros
    mov     x19, x0                 // Guardar dirección del string
    mov     x20, #0                 // Resultado decimal
    mov     x21, #0                 // Índice actual
    mov     x22, #1                 // Valor de potencia de 2

    // Limpiar flag de error
    bl      clear_error

validate_loop:
    // Cargar carácter actual
    ldrb    w0, [x19, x21]
    
    // Si es null (fin del string), terminar validación
    cbz     w0, start_conversion
    
    // Verificar si es '0' o '1'
    cmp     w0, #'0'
    b.lt    invalid_input
    cmp     w0, #'1'
    b.gt    invalid_input
    
    // Siguiente carácter
    add     x21, x21, #1
    b       validate_loop

invalid_input:
    // Marcar error y retornar
    bl      set_error
    mov     x0, #-1
    b       end_conversion

start_conversion:
    // x21 ahora tiene la longitud del string
    mov     x22, #1                 // Reiniciar potencia de 2
    mov     x20, #0                 // Reiniciar resultado
    
convert_loop:
    // Si ya procesamos todos los dígitos, terminar
    cbz     x21, end_conversion
    
    // Decrementar índice para procesar desde el último dígito
    sub     x21, x21, #1
    
    // Cargar dígito actual
    ldrb    w0, [x19, x21]
    
    // Si es '1', sumar la potencia actual
    cmp     w0, #'1'
    b.ne    next_digit
    
    // Sumar potencia actual al resultado
    add     x20, x20, x22
    
next_digit:
    // Multiplicar potencia por 2
    lsl     x22, x22, #1
    b       convert_loop

end_conversion:
    mov     x0, x20                 // Mover resultado a x0
    
    // Restaurar registros
    ldp     x19, x20, [sp, 16]
    ldp     x21, x22, [sp, 32]
    ldp     x29, x30, [sp], 48
    ret

// Función para establecer error
set_error:
    adrp    x0, error_flag
    add     x0, x0, :lo12:error_flag
    mov     w1, #1
    str     w1, [x0]
    ret

// Función para limpiar error
clear_error:
    adrp    x0, error_flag
    add     x0, x0, :lo12:error_flag
    str     wzr, [x0]
    ret

// Función para obtener estado de error
get_error:
    adrp    x0, error_flag
    add     x0, x0, :lo12:error_flag
    ldr     w0, [x0]
    ret
```
## nano binario.cs
```
using System;
using System.Runtime.InteropServices;
using System.Text.RegularExpressions;

class Program
{
    [DllImport("binario.so", EntryPoint = "binary_to_decimal")]
    private static extern long BinaryToDecimal(string binary);

    [DllImport("binario.so", EntryPoint = "get_error")]
    private static extern int GetError();

    static void Main()
    {
        while (true)
        {
            Console.WriteLine("\nConversor de Binario a Decimal");
            Console.WriteLine("1. Convertir número binario");
            Console.WriteLine("0. Salir");
            Console.Write("Seleccione una opción: ");

            if (int.TryParse(Console.ReadLine(), out int opcion))
            {
                switch (opcion)
                {
                    case 1:
                        Console.Write("\nIngrese un número binario (solo 0s y 1s): ");
                        string entrada = Console.ReadLine()?.Trim();

                        if (string.IsNullOrEmpty(entrada))
                        {
                            Console.WriteLine("Error: Entrada vacía.");
                            break;
                        }

                        // Verificar longitud máxima (64 bits)
                        if (entrada.Length > 64)
                        {
                            Console.WriteLine("Error: El número binario no puede tener más de 64 dígitos.");
                            break;
                        }

                        // Verificar que solo contenga 0s y 1s
                        if (!Regex.IsMatch(entrada, "^[01]+$"))
                        {
                            Console.WriteLine("Error: El número debe contener solo 0s y 1s.");
                            break;
                        }

                        long resultado = BinaryToDecimal(entrada);
                        
                        if (GetError() != 0 || resultado == -1)
                        {
                            Console.WriteLine("Error al convertir el número.");
                            break;
                        }

                        Console.WriteLine($"\nNúmero binario: {entrada}");
                        Console.WriteLine($"Número decimal: {resultado}");
                        
                        // Mostrar información adicional
                        Console.WriteLine($"Cantidad de bits: {entrada.Length}");
                        Console.WriteLine($"Primer bit (MSB): {entrada[0]}");
                        Console.WriteLine($"Último bit (LSB): {entrada[entrada.Length - 1]}");
                        break;

                    case 0:
                        Console.WriteLine("Saliendo del programa...");
                        return;

                    default:
                        Console.WriteLine("Opción no válida.");
                        break;
                }
            }
            else
            {
                Console.WriteLine("Error: Ingrese un número válido.");
            }
        }
    }
}
```
### mono binario.exe
![image](https://gist.github.com/user-attachments/assets/8f957ec8-a9a6-48e5-947f-c2bff69ff6ad)
![image](https://gist.github.com/user-attachments/assets/71e3c394-cc45-4e0e-ab7d-b167e76c93a2)

# 41.- Conversión de decimal a hexadecimal
## nano deci.s
```
.data
    .align 3
    hex_array: .skip 32         // Buffer para almacenar resultado hexadecimal
    result_length: .word 0      // Longitud del resultado
    hex_chars: .ascii "0123456789ABCDEF"  // Caracteres hexadecimales

.text
.align 2
.global decimal_to_hex
.global get_hex_char
.global get_length

// Función para convertir decimal a hexadecimal
// Entrada: x0 = número decimal
decimal_to_hex:
    stp     x29, x30, [sp, -48]!
    mov     x29, sp
    stp     x19, x20, [sp, 16]
    stp     x21, x22, [sp, 32]

    mov     x19, x0            // Guardar número original
    
    // Reiniciar contador de longitud
    adrp    x0, result_length
    add     x0, x0, :lo12:result_length
    str     wzr, [x0]
    
    // Si el número es 0, manejar caso especial
    cbnz    x19, conversion_loop
    
    // Caso especial para 0
    adrp    x0, hex_array
    add     x0, x0, :lo12:hex_array
    mov     w1, '0'
    strb    w1, [x0]
    
    adrp    x0, result_length
    add     x0, x0, :lo12:result_length
    mov     w1, #1
    str     w1, [x0]
    b       end_conversion

conversion_loop:
    // Mientras el número no sea 0
    cbz     x19, reverse_result
    
    // Obtener residuo (número & 0xF)
    and     x20, x19, #0xF
    
    // Obtener carácter hexadecimal correspondiente
    adrp    x21, hex_chars
    add     x21, x21, :lo12:hex_chars
    ldrb    w20, [x21, x20]
    
    // Guardar carácter en el array
    adrp    x21, result_length
    add     x21, x21, :lo12:result_length
    ldr     w22, [x21]
    
    adrp    x0, hex_array
    add     x0, x0, :lo12:hex_array
    strb    w20, [x0, x22]
    
    // Incrementar longitud
    add     w22, w22, #1
    str     w22, [x21]
    
    // Dividir número entre 16
    lsr     x19, x19, #4
    
    b       conversion_loop

reverse_result:
    // Invertir el resultado ya que se generó al revés
    adrp    x0, hex_array
    add     x0, x0, :lo12:hex_array
    adrp    x1, result_length
    add     x1, x1, :lo12:result_length
    ldr     w1, [x1]           // w1 = longitud
    
    mov     x2, #0             // índice inicio
    sub     w3, w1, #1         // índice final
    
reverse_loop:
    cmp     w2, w3
    b.ge    end_conversion
    
    // Intercambiar caracteres
    ldrb    w4, [x0, x2]
    ldrb    w5, [x0, x3]
    strb    w5, [x0, x2]
    strb    w4, [x0, x3]
    
    add     w2, w2, #1
    sub     w3, w3, #1
    b       reverse_loop

end_conversion:
    ldp     x19, x20, [sp, 16]
    ldp     x21, x22, [sp, 32]
    ldp     x29, x30, [sp], 48
    ret

// Función para obtener un carácter del resultado
// Entrada: x0 = índice
// Salida: x0 = carácter en esa posición
get_hex_char:
    stp     x29, x30, [sp, -16]!
    mov     x29, sp
    
    adrp    x1, result_length
    add     x1, x1, :lo12:result_length
    ldr     w1, [x1]
    cmp     w0, w1
    b.ge    invalid_index
    
    adrp    x1, hex_array
    add     x1, x1, :lo12:hex_array
    ldrb    w0, [x1, x0]
    
    ldp     x29, x30, [sp], 16
    ret

invalid_index:
    mov     x0, #0
    ldp     x29, x30, [sp], 16
    ret

// Función para obtener la longitud del resultado
get_length:
    adrp    x0, result_length
    add     x0, x0, :lo12:result_length
    ldr     w0, [x0]
    ret
```
## nano deci.cs
```
using System;
using System.Runtime.InteropServices;
using System.Text;

class Program
{
    [DllImport("deci.so", EntryPoint = "decimal_to_hex")]
    private static extern void DecimalToHex(long number);

    [DllImport("deci.so", EntryPoint = "get_hex_char")]
    private static extern char GetHexChar(int index);

    [DllImport("deci.so", EntryPoint = "get_length")]
    private static extern int GetLength();

    static string GetHexString(long number)
    {
        DecimalToHex(number);
        int length = GetLength();
        StringBuilder result = new StringBuilder();

        for (int i = 0; i < length; i++)
        {
            result.Append(GetHexChar(i));
        }

        return result.ToString();
    }

    static void Main()
    {
        while (true)
        {
            Console.WriteLine("\nConversor de Decimal a Hexadecimal");
            Console.WriteLine("1. Convertir número");
            Console.WriteLine("2. Ver tabla de conversión (0-15)");
            Console.WriteLine("0. Salir");
            Console.Write("Seleccione una opción: ");

            if (int.TryParse(Console.ReadLine(), out int opcion))
            {
                switch (opcion)
                {
                    case 1:
                        Console.Write("\nIngrese un número decimal positivo: ");
                        if (long.TryParse(Console.ReadLine(), out long numero))
                        {
                            if (numero < 0)
                            {
                                Console.WriteLine("Por favor, ingrese un número positivo.");
                                break;
                            }

                            string hexadecimal = GetHexString(numero);
                            Console.WriteLine($"\nNúmero decimal: {numero}");
                            Console.WriteLine($"Número hexadecimal: 0x{hexadecimal}");
                            
                            // Información adicional
                            Console.WriteLine($"Longitud: {hexadecimal.Length} dígitos");
                            if (hexadecimal.Length > 0)
                            {
                                Console.WriteLine($"Dígito más significativo: {hexadecimal[0]}");
                                Console.WriteLine($"Dígito menos significativo: {hexadecimal[hexadecimal.Length - 1]}");
                            }
                        }
                        else
                        {
                            Console.WriteLine("Error: Ingrese un número válido.");
                        }
                        break;

                    case 2:
                        Console.WriteLine("\nTabla de conversión (0-15):");
                        Console.WriteLine("Decimal -> Hexadecimal");
                        Console.WriteLine("--------------------");
                        for (int i = 0; i <= 15; i++)
                        {
                            string hex = GetHexString(i);
                            Console.WriteLine($"{i,7} -> 0x{hex}");
                        }
                        break;

                    case 0:
                        Console.WriteLine("Saliendo del programa...");
                        return;

                    default:
                        Console.WriteLine("Opción no válida.");
                        break;
                }
            }
            else
            {
                Console.WriteLine("Error: Ingrese un número válido.");
            }
        }
    }
}
```
### mono deci.exe
![image](https://gist.github.com/user-attachments/assets/6a855c96-cabe-4272-87ff-8e3aa4b47f68)
![image](https://gist.github.com/user-attachments/assets/28df6ed4-fc1e-4bfa-8e9f-74e346e1f07b)

# 42.- Conversión de hexadecimal a decimal	 
## nano hexa.s
```
// hexa.s - Convierte un carácter hexadecimal en decimal (simplificado)

.global hex_char_to_dec

// Convierte un carácter hexadecimal a decimal
// Entrada: w0 (carácter hexadecimal, como 'A' o 'F')
// Salida: w0 (valor decimal)
hex_char_to_dec:
    cmp w0, '0'
    blt invalid_hex               // Si es menor que '0', no es hexadecimal
    cmp w0, '9'
    ble convert_digit             // Si está entre '0' y '9', es dígito decimal

    cmp w0, 'A'
    blt invalid_hex               // Si es menor que 'A', no es hexadecimal
    cmp w0, 'F'
    ble convert_upper_letter      // Si está entre 'A' y 'F', es letra mayúscula

    cmp w0, 'a'
    blt invalid_hex               // Si es menor que 'a', no es hexadecimal
    cmp w0, 'f'
    ble convert_lower_letter      // Si está entre 'a' y 'f', es letra minúscula

invalid_hex:
    mov w0, -1                    // Retornar -1 si no es válido
    ret

convert_digit:
    sub w0, w0, '0'               // Convertir '0'-'9' a 0-9
    ret

convert_upper_letter:
    sub w0, w0, 'A'               // Convertir 'A'-'F' a 10-15
    add w0, w0, 10
    ret

convert_lower_letter:
    sub w0, w0, 'a'               // Convertir 'a'-'f' a 10-15
    add w0, w0, 10
    ret
```
## nano hexa.cs
```
using System;
using System.Runtime.InteropServices;

class HexadecimalToDecimal
{
    // Importar la función de conversión en ensamblador si decides usarla
    [DllImport("hexa.so")]
    public static extern int HexToDec(string hex);

    static void Main()
    {
        Console.Write("Introduce un número hexadecimal: ");
        string hexNumber = Console.ReadLine(); // Leer el número hexadecimal
        
        // Convertir a decimal usando la función en C#
        int decimalNumber = Convert.ToInt32(hexNumber, 16);
        
        Console.WriteLine($"El número decimal es: {decimalNumber}");
    }
}
```
### mono hexa.exe
![image](https://gist.github.com/user-attachments/assets/8931632c-2ceb-4cdd-89f7-73c1c64e97de)

# 43.- Calculadora simple (Suma, Resta, Multiplicación, División)	
## nano simple.s
```
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
```
## nano simple.cs
```
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
```
### mono simple.exe
![image](https://gist.github.com/user-attachments/assets/55cf7c77-8988-410e-847a-caea9bdf3dc9)
![image](https://gist.github.com/user-attachments/assets/a87856a3-e205-4136-a0f2-2220393f6ad9)

# 44.- Generación de números aleatorios (con semilla)	
## nano semilla.s
```
.global GenerarAleatorio

GenerarAleatorio:
    // w0 contiene la semilla de entrada

    // Cargar el valor 1103515245 en w1 usando instrucciones separadas
    movz w1, 0x49E3        // Parte inferior del número (16 bits)
    movk w1, 0x4E35, lsl #16  // Parte superior del número (añadir a los bits altos)

    mov w2, 12345          // Incremento

    // Realizar el cálculo: semilla = (semilla * 1103515245 + 12345) & 0x7FFFFFFF
    mul w0, w0, w1         // Multiplica semilla por 1103515245
    add w0, w0, w2         // Suma 12345
    and w0, w0, 0x7FFFFFFF // Asegurarse de que esté en el rango de 0 a 2^31-1
    ret
```
## nano semilla.cs
```
using System;
using System.Runtime.InteropServices;

class RandomGenerator
{
    // Importar la función de ensamblador para generar un número pseudoaleatorio
    [DllImport("semilla.so")]
    public static extern int GenerarAleatorio(int semilla);

    static void Main()
    {
        Console.Write("Introduce una semilla: ");
        int semilla = int.Parse(Console.ReadLine());

        Console.Write("¿Cuántos números aleatorios deseas generar? ");
        int cantidad = int.Parse(Console.ReadLine());

        Console.WriteLine("Números aleatorios generados:");
        for (int i = 0; i < cantidad; i++)
        {
            semilla = GenerarAleatorio(semilla);  // Actualiza la semilla para el siguiente número
            Console.WriteLine(semilla);
        }
    }
}
```
### mono semilla.exe
![image](https://gist.github.com/user-attachments/assets/0483cee9-6d41-4eda-b321-225ab49fbfb1)

# 45.- Verificar si un número es Armstrong	
## nano veri.s
```
.global EsArmstrong
    
// x0: número de entrada
// x1: copia del número para trabajar
// x2: suma de potencias
// x3: contador de dígitos
// x4: dígito actual
// x5: base para potencia
// x6: resultado de potencia
// x7: contador para potencia

EsArmstrong:
    // Guardar registros
    stp x29, x30, [sp, #-16]!
    stp x19, x20, [sp, #-16]!
    
    mov x19, x0                  // Guardar número original
    mov x1, x0                   // Copiar número para contar dígitos
    mov x3, 0                    // Inicializar contador de dígitos

contar_digitos:
    cbz x1, preparar_calculo     // Si x1 es 0, terminar conteo
    udiv x1, x1, #10            // Dividir por 10
    add x3, x3, #1              // Incrementar contador
    b contar_digitos

preparar_calculo:
    mov x1, x19                 // Restaurar número original
    mov x2, #0                  // Inicializar suma de potencias

procesar_digitos:
    cbz x1, verificar           // Si no hay más dígitos, verificar resultado
    
    // Obtener último dígito
    mov x4, x1                  // Copiar número actual
    udiv x4, x4, #10           // Dividir por 10
    msub x4, x4, #10, x1       // x4 = x1 - (x4 * 10) -> último dígito
    udiv x1, x1, #10           // Actualizar número removiendo último dígito
    
    // Calcular potencia
    mov x5, x4                  // Base = dígito
    mov x6, #1                  // Resultado inicial = 1
    mov x7, x3                  // Contador = número de dígitos

calcular_potencia:
    cbz x7, sumar_potencia     // Si contador es 0, sumar resultado
    mul x6, x6, x5             // Multiplicar por base
    sub x7, x7, #1             // Decrementar contador
    b calcular_potencia

sumar_potencia:
    add x2, x2, x6             // Sumar potencia al total
    b procesar_digitos

verificar:
    cmp x2, x19                // Comparar suma con número original
    cset w0, eq                // Establecer resultado (1 si igual, 0 si no)
    
    // Restaurar registros
    ldp x19, x20, [sp], #16
    ldp x29, x30, [sp], #16
    ret
```
## nano veri.cs
```
using System;
using System.Runtime.InteropServices;

class Program 
{
    // Importar la función de ensamblador
    [DllImport("veri.so")]
    public static extern int EsArmstrong(int numero);

    static void Main()
    {
        try
        {
            Console.Write("Introduce un número: ");
            if (int.TryParse(Console.ReadLine(), out int numero))
            {
                int resultado = EsArmstrong(numero);
                if (resultado == 1)
                    Console.WriteLine($"{numero} es un número Armstrong.");
                else
                    Console.WriteLine($"{numero} no es un número Armstrong.");
            }
            else
            {
                Console.WriteLine("Por favor ingresa un número válido.");
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error: {ex.Message}");
        }
    }
}
```
### mono veri.exe
![image](https://gist.github.com/user-attachments/assets/6352bab9-f9f1-4075-8e4b-cccd9c9e5f80)

# 46.- Encontrar prefijo común más largo en cadenas
## nano cadena.s
```
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
```
## nano cadena.cs
```
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
```
### mono cadena.exe
![image](https://gist.github.com/user-attachments/assets/92c63a09-2ab8-43f1-a305-1038238a2620)

# 47.- Detección de desbordamiento en suma	
## nano detec.s
```
.global DetectOverflow

// Función para detectar desbordamiento en suma
DetectOverflow:
    // Guardar registros
    stp x29, x30, [sp, #-16]!
    
    // Guardar los números originales
    mov w2, w0  // Primer número en w2
    mov w3, w1  // Segundo número en w3
    
    // Realizar la suma con detección de desbordamiento
    adds w4, w2, w3
    
    // Verificar desbordamiento positivo
    // Si a > 0 y b > 0 pero suma < 0, hay desbordamiento
    cmp w2, #0
    b.le check_negative
    cmp w3, #0
    b.le no_overflow
    cmp w4, #0
    b.lt overflow
    b no_overflow

check_negative:
    // Verificar desbordamiento negativo
    // Si a < 0 y b < 0 pero suma >= 0, hay desbordamiento
    cmp w2, #0
    b.ge no_overflow
    cmp w3, #0
    b.ge no_overflow
    cmp w4, #0
    b.ge overflow
    b no_overflow

overflow:
    mov w0, #1      // Retornar 1 si hay desbordamiento
    b end

no_overflow:
    mov w0, #0      // Retornar 0 si no hay desbordamiento

end:
    // Restaurar registros y retornar
    ldp x29, x30, [sp], #16
    ret
```
## nano detec.cs
```
using System;
using System.Runtime.InteropServices;

class Program
{
    [DllImport("detec.so")]
    public static extern int DetectOverflow(int a, int b);

    static void Main()
    {
        try
        {
            Console.WriteLine("Introduce dos números para sumar:");
            
            Console.Write("Número 1: ");
            int num1 = int.Parse(Console.ReadLine());
            
            Console.Write("Número 2: ");
            int num2 = int.Parse(Console.ReadLine());

            int result = DetectOverflow(num1, num2);
            
            if (result == 1)
            {
                Console.WriteLine("¡Desbordamiento detectado en la suma!");
                Console.WriteLine($"La suma de {num1} + {num2} excede el rango de int32.");
            }
            else
            {
                Console.WriteLine($"No hay desbordamiento. La suma es: {num1 + num2}");
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error: {ex.Message}");
        }
    }
}
```
### mono detec.exe
![image](https://gist.github.com/user-attachments/assets/db960270-8046-4e1f-91ec-60c385f03a8e)

# 48.- Medir el tiempo de ejecución de una función	
## nano tiempo.s
```
.global FuncionDePrueba

// Función de prueba que realiza operaciones matemáticas en un bucle
// Parámetro x0: número de iteraciones
// Retorna: resultado de las operaciones
FuncionDePrueba:
    // Guardar registros
    stp x29, x30, [sp, #-16]!
    stp x19, x20, [sp, #-16]!
    
    // Guardar el número de iteraciones
    mov x19, x0
    
    // Inicializar acumulador y constantes
    mov x1, #1          // Acumulador
    mov x3, #7          // Constante para multiplicación
    mov x4, #3          // Constante para división
    
bucle:
    // Verificar si quedan iteraciones
    cbz x19, fin
    
    // Realizar algunas operaciones matemáticas
    add x1, x1, x1      // x1 = x1 + x1
    lsr x2, x1, #1      // x2 = x1 >> 1
    add x1, x1, x2      // x1 = x1 + x2
    mul x1, x1, x3      // x1 = x1 * 7
    udiv x1, x1, x4     // x1 = x1 / 3
    
    // Decrementar contador
    sub x19, x19, #1
    
    // Continuar bucle
    b bucle
    
fin:
    // Mover resultado a x0 para retorno
    mov x0, x1
    
    // Restaurar registros
    ldp x19, x20, [sp], #16
    ldp x29, x30, [sp], #16
    ret
```
## nano tiempo.cs
```
using System;
using System.Runtime.InteropServices;
using System.Diagnostics;

class Program
{
    [DllImport("tiempo.so")]
    public static extern ulong FuncionDePrueba(ulong iteraciones);

    static void Main()
    {
        try
        {
            Console.Write("Introduce el número de iteraciones: ");
            if (ulong.TryParse(Console.ReadLine(), out ulong iteraciones))
            {
                // Crear el cronómetro
                Stopwatch cronometro = new Stopwatch();

                // Calentar la CPU (opcional)
                FuncionDePrueba(1000);
                
                Console.WriteLine("\nIniciando medición de tiempo...");
                
                // Iniciar medición
                cronometro.Start();
                
                // Llamar a la función
                ulong resultado = FuncionDePrueba(iteraciones);
                
                // Detener medición
                cronometro.Stop();

                // Mostrar resultados
                Console.WriteLine($"\nResultados de la medición:");
                Console.WriteLine($"Tiempo transcurrido: {cronometro.ElapsedMilliseconds} ms");
                Console.WriteLine($"Tiempo por iteración: {(double)cronometro.ElapsedTicks / iteraciones:F6} ticks");
                Console.WriteLine($"Resultado del cálculo: {resultado}");
            }
            else
            {
                Console.WriteLine("Por favor, ingresa un número válido.");
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error: {ex.Message}");
        }
    }
}
```
### mono tiempo.exe
![image](https://gist.github.com/user-attachments/assets/1d8b829f-58bd-46e6-8aaf-3614ee25ebd4)

# 49.- Leer entrada desde el teclado	
## nano leer.s
```
.global LeerEntrada

LeerEntrada:
    // Reservar espacio en el stack
    sub sp, sp, #16
    
    // Leer entrada (syscall read)
    mov x0, #0          // stdin
    ldr x1, =buffer     // dirección del buffer
    mov x2, #16         // tamaño máximo a leer
    mov x8, #63         // syscall read
    svc #0
    
    // Convertir string a número
    ldr x1, =buffer     // dirección del buffer
    mov x2, #0          // inicializar resultado
    mov x3, #10         // base decimal

convert_loop:
    ldrb w4, [x1], #1   // cargar byte y avanzar puntero
    cmp w4, #10         // comparar con newline
    beq end_convert     // si es newline, terminar
    
    sub w4, w4, #'0'    // convertir ASCII a número
    mul x2, x2, x3      // resultado * 10
    sxtw x4, w4         // extender w4 a 64 bits
    add x2, x2, x4      // sumar dígito actual
    
    b convert_loop

end_convert:
    mov x0, x2          // mover resultado a x0
    add sp, sp, #16     // restaurar stack
    ret

.data
buffer: .space 16       // buffer para entrada
```
## nano leer.cs
```
using System;
using System.Runtime.InteropServices;

class Program
{
    // Declaración de la función externa
    [DllImport("leer.so", CallingConvention = CallingConvention.Cdecl)]
    public static extern long LeerEntrada();

    static void Main()
    {
        Console.WriteLine("Introduce un número:");
        long numero = LeerEntrada();
        Console.WriteLine($"Número leído: {numero}");
    }
}
```
### mono leer.exe
![image](https://gist.github.com/user-attachments/assets/d6b41efb-fb48-4809-8d6f-9aaee2a31df1)

# 50.- Escribir en un archivo	
## nano escribir.s
```
.global EscribirArchivo

EscribirArchivo:
    // Preservar registros
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    
    // Guardar argumentos
    str x0, [sp, #-16]!    // Guardar número a escribir
    
    // Abrir archivo (syscall open)
    adr x0, filename       // nombre del archivo
    mov x1, #0x441        // Flags: O_WRONLY|O_CREAT|O_TRUNC
    mov x2, #0666         // Permisos
    mov x8, #56          // syscall open
    svc #0
    
    // Guardar file descriptor
    mov x19, x0
    
    // Convertir número a string
    ldr x0, [sp]         // Recuperar número
    adr x1, buffer       // Buffer donde escribiremos
    mov x2, #0          // Contador de dígitos
    mov x3, #10         // Divisor (base 10)
    
convert_loop:
    udiv x4, x0, x3     // x4 = número / 10
    msub x5, x4, x3, x0 // x5 = número % 10
    add x5, x5, #'0'    // Convertir a ASCII
    strb w5, [x1, x2]   // Guardar dígito
    add x2, x2, #1      // Incrementar contador
    mov x0, x4          // Actualizar número
    cbnz x0, convert_loop // Si número != 0, continuar
    
    // Agregar newline
    mov w5, #10         // Carácter newline
    strb w5, [x1, x2]   // Guardar newline
    add x2, x2, #1      // Incrementar contador
    
    // Escribir al archivo (syscall write)
    mov x0, x19         // File descriptor
    adr x1, buffer      // Buffer con el string
    mov x8, #64         // syscall write
    svc #0
    
    // Cerrar archivo (syscall close)
    mov x0, x19         // File descriptor
    mov x8, #57         // syscall close
    svc #0
    
    // Restaurar stack y retornar
    add sp, sp, #16     // Liberar espacio del número
    ldp x29, x30, [sp], #16
    ret

.data
filename: .asciz "salida.txt"    // Nombre del archivo
buffer: .space 32                // Buffer para convertir número a string
```
## nano escribir.cs
```
using System;
using System.Runtime.InteropServices;

class Program
{
    [DllImport("escribir.so", CallingConvention = CallingConvention.Cdecl)]
    public static extern void EscribirArchivo(long numero);

    static void Main()
    {
        Console.WriteLine("Introduce un número para escribir en el archivo:");
        if (long.TryParse(Console.ReadLine(), out long numero))
        {
            EscribirArchivo(numero);
            Console.WriteLine($"El número {numero} ha sido escrito en salida.txt");
        }
        else
        {
            Console.WriteLine("Error: Entrada inválida");
        }
    }
}
```
### mono escribir.exe
![image](https://gist.github.com/user-attachments/assets/568bd2e7-4ce4-4acf-b31c-91ce4611a765)
