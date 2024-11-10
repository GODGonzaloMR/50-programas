// Este es el menu que organiza todos los codigos para poder correrlos

#include <stdio.h>

// Declaraciones de las funciones en ensamblador
extern void celsius_a_fahrenheit(long celsius);
extern void suma(long a, long b);
extern void resta(long a, long b);
extern void multiplicacion(long a, long b);
extern void division(long a, long b);
extern void suma_naturales(long n);
extern void factorial(long n);
extern void fibonacci(long n);
extern int primo(long n);
extern void invertir_cadena(char* cadena);
extern int es_palindromo(char* cadena);
extern int max_en_arreglo(int* arreglo, long n);
extern int min_en_arreglo(int* arreglo, long n);
extern int busqueda_lineal(int* arreglo, long n, int valor);
extern int busqueda_binaria(int* arreglo, long n, int valor);
extern void ordenamiento_burbuja(int* arreglo, long n);
extern void ordenamiento_seleccion(int* arreglo, long n);
extern void merge_sort(int* arreglo, long n);
extern void suma_matrices(int* A, int* B, int* C, long rows, long cols);
extern void multiplicacion_matrices(int* A, int* B, int* C, long rowsA, long colsA, long colsB);
extern void transponer_matriz(int* matrizEntrada, int* matrizSalida, long filas, long columnas);
extern int ascii_a_entero(char* cadena);
extern void entero_a_ascii(long numero, char* buffer, int baseNum);
extern long longitud_cadena(unsigned char* cadena);
extern void contar_vocales_consonantes(unsigned char* cadena, long* vocales, long* consonantes);
extern void operaciones_bits(long num1, long num2, long* resultAND, long* resultOR, long* resultXOR);
extern long desplazar_izquierda(long numero, long desplazamiento); // Agregar esta línea
extern long desplazar_derecha(long numero, long desplazamiento);  // Agregar esta línea
extern long establecer_bit(long valor, long n);
extern long borrar_bit(long valor, long n);
extern long alternar_bit(long valor, long n);
extern long contar_bits(long number); // Agregar esta línea
extern long calcular_mcd(long a, long b); // Agregar esta línea



int main() {
    int opcion;
    printf("\nSeleccione la operación:\n");
    printf("1. Multiplicación de matrices\n");
    printf("2. Contar vocales y consonantes\n");
    printf("3. Operaciones a nivel de bits\n");
    printf("4. Calcular MCD\n"); // Asegúrate de mostrar esta opción
    scanf("%d", &opcion);

    switch(opcion) {
        case 1: {
            long rowsA, colsA, colsB;

            printf("Ingrese el número de filas de la matriz A: ");
            scanf("%ld", &rowsA);
            printf("Ingrese el número de columnas de la matriz A (y filas de la matriz B): ");
            scanf("%ld", &colsA);
            printf("Ingrese el número de columnas de la matriz B: ");
            scanf("%ld", &colsB);

             int A[rowsA][colsA], B[colsA][colsB], C[rowsA][colsB];
            printf("Ingrese los elementos de la matriz A:\n");
            for (long i = 0; i < rowsA; i++) {
                for (long j = 0; j < colsA; j++) {
                    printf("Elemento A[%ld][%ld]: ", i, j);
                    scanf("%d", &A[i][j]);
                }
            }

            printf("Ingrese los elementos de la matriz B:\n");
            for (long i = 0; i < colsA; i++) {
                for (long j = 0; j < colsB; j++) {
                    printf("Elemento B[%ld][%ld]: ", i, j);
                    scanf("%d", &B[i][j]);
                }
            }

              multiplicacion_matrices((int*)A, (int*)B, (int*)C, rowsA, colsA, colsB);

            printf("Resultado de la multiplicación de matrices:\n");
            for (long i = 0; i < rowsA; i++) {
                for (long j = 0; j < colsB; j++) {
                    printf("%d ", C[i][j]);
                }
                printf("\n");
            }
            break;
        }
        case 2: {
            unsigned char cadena[1000];
            long vocales = 0, consonantes = 0;

            printf("Ingrese una cadena de texto: ");
            getchar(); // Limpiar el buffer
            fgets((char*)cadena, sizeof(cadena), stdin);

            // Eliminar el salto de línea si existe
            for(int i = 0; cadena[i] != '\0'; i++) {
                if(cadena[i] == '\n') {
                    cadena[i] = '\0';
                    break;
                }
            }

            contar_vocales_consonantes(cadena, &vocales, &consonantes);

            printf("Resultados:\n");
            printf("Vocales: %ld\n", vocales);
            printf("Consonantes: %ld\n", consonantes);
            break;
        }
        case 3: {
            long num1, num2;
            long resultAND, resultOR, resultXOR;

            printf("Ingrese el primer número: ");
            scanf("%ld", &num1);
            printf("Ingrese el segundo número: ");
            scanf("%ld", &num2);

            operaciones_bits(num1, num2, &resultAND, &resultOR, &resultXOR);

            printf("\nResultados:\n");
            printf("AND: %ld (Binario: ", resultAND);
            for(int i = 63; i >= 0; i--) {
                printf("%ld", (resultAND >> i) & 1L);
            }
            printf(")\n");

            printf("OR:  %ld (Binario: ", resultOR);
            for(int i = 63; i >= 0; i--) {
                printf("%ld", (resultOR >> i) & 1L);
            }
            printf(")\n");

            printf("XOR: %ld (Binario: ", resultXOR);
            for(int i = 63; i >= 0; i--) {
                printf("%ld", (resultXOR >> i) & 1L);
            }
            printf(")\n");

            break;
        }
        case 4: { // MCD
            long num1, num2;

            printf("Ingrese el primer numero: ");
            scanf("%ld", &num1);

            printf("Ingrese el segundo numero: ");
            scanf("%ld", &num2);

            long resultado = calcular_mcd(num1, num2);
            printf("El MCD es: %ld\n", resultado);
            break; // Asegúrate de que haya un break aquí
        }
            default:
            printf("Opción no válida\n");
            break;
    }

    return 0;
}
