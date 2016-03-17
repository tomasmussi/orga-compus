#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

#include "matrix.h"

#define MAX_SIZE 10

void show_help(const char *arg) {
	if ((strcmp(arg, "-h") == 0) || (strcmp(arg, "--help") == 0)) {
		printf("Usage:\n\ttpo -h\n\ttp0 -V\n\ttp0 < in_file > out_file 2> err_file\n\n");
		printf("Options:\n\t-V, --version\t\tPrint version and quit\n\t-h --help\t\tPrint this information and quit\n\n");
		printf("Examples:\n\ttp0 < in.txt > out.txt\n\tcat in.txt | tp0 > out.txt\n\n");
	} else if ((strcmp(arg, "-V") == 0) || (strcmp(arg, "--version") == 0)) {
		printf("TP 0. Version 1.0\n");
	}
}

void tokenizarLinea(char* linea, int indice) {

	bool DEBUG_MODE = true;

	// Copia de la linea original para contar elementos
	char copiaLinea[indice + 1];
	strncpy(copiaLinea, linea, (indice + 1));

	if (DEBUG_MODE) {
		int original = strlen(linea);
		int copia = strlen(copiaLinea);
		printf("Length original %d\n", original);
		printf("Length copia %d\n", copia);
	}

	int cantidadElementos = 0;
	int dimension = 0;

	char* token = strtok(copiaLinea, " ");
	dimension = atoi(token);

	while (token != NULL) {
		if (DEBUG_MODE)
			printf("%s\n", token);
		cantidadElementos++;
		token = strtok(NULL, " ");
	}

	if (DEBUG_MODE) {
		printf("Cantidad Elementos en Linea: %d\n", cantidadElementos);
		printf("Dimension: %d\n", dimension);
		printf("Linea original: %s\n", linea);
		printf("Copia Linea: %s\n", copiaLinea);
	}

	if ( (dimension * dimension) != ( (cantidadElementos - 1) / 2 ) ) {
		printf("La dimension no concuerda con la cantidad de elementos de la linea.\n");
		return;
	}

	printf("\n\n");

}

void leerLinea(FILE* archivo, int* cantidadLineas) {

	int tamanioLinea = MAX_SIZE;
	char* bufferLinea = (char*)malloc(sizeof(char) * tamanioLinea);

	if (bufferLinea == NULL) {
		printf("No se puede asignar memoria al bufferLinea \n");
		exit(1);
	}

	char caracter = getc(archivo);
	int indice = 0;

	while ((caracter != '\n') && (caracter != EOF)) {
   
		if (indice >= MAX_SIZE) {
       
			tamanioLinea += MAX_SIZE;
			bufferLinea = realloc(bufferLinea, tamanioLinea);
            
			if (bufferLinea == NULL) {
				printf("No se puede reasignar memoria al bufferLinea \n");
				exit(1);
			}
		}
        
		bufferLinea[indice] = caracter;
		indice++;

		caracter = getc(archivo);
	}

	// Termina el bufferLinea
	bufferLinea[indice] = '\0';
    
	char resultado[indice + 1];
	strncpy(resultado, bufferLinea, (indice + 1));
	free(bufferLinea);

	// Si la linea no esta vacia
	if (strlen(resultado) > 0) {
		*cantidadLineas += 1;
		printf("%s\n", resultado);
		tokenizarLinea(resultado, indice + 1);
	}
}

int main(int argc, char *argv[]) {
	// if (argc != 1) {
	// 	show_help(argv[1]);
	// 	return 0;
	// }

	/* Habria que chequear que si se corre sin parámetros, viene de stdin */

	/* ./tp0 prueba.txt */
	printf("\n\nSe abre archivo de texto ");
    
	printf("%s \n\n", argv[1]);
	FILE* archivo = fopen(argv[1], "r");

	if (archivo == NULL) {
		printf("Error al abrir el archivo \n");
		return -1;
	} else {
		printf("El archivo se cargó correctamente \n");
	}
	
	// Para verificar lineas no vacias
	int cantidadLineas = 0;

	while (!feof(archivo)) {
		leerLinea(archivo, &cantidadLineas);
	}

	printf("\nCantidad de Lineas: %d\n", cantidadLineas);

	fclose(archivo);

	printf("Termina el programa \n");
	return 0;
}




