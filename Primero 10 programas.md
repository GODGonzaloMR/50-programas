# Gonzalo Cortez Huerta 22210761

### Programas del 1 al 10 
- https://asciinema.org/a/687451
  
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
