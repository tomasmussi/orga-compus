#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

#include "matrix.h"

#define MAX_SIZE 10

#define DEBUG_MODE true

void show_help(const char *arg) {
	if ((strcmp(arg, "-h") == 0) || (strcmp(arg, "--help") == 0)) {
		printf("Usage:\n\ttpo -h\n\ttp0 -V\n\ttp0 < in_file > out_file 2> err_file\n\n");
		printf("Options:\n\t-V, --version\t\tPrint version and quit\n\t-h --help\t\tPrint this information and quit\n\n");
		printf("Examples:\n\ttp0 < in.txt > out.txt\n\tcat in.txt | tp0 > out.txt\n\n");
	} else if ((strcmp(arg, "-V") == 0) || (strcmp(arg, "--version") == 0)) {
		printf("TP 0. Version 1.0\n");
	}
}

bool lineaEsValida(char* linea, int indice) {

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
		if (DEBUG_MODE) {
			//printf("%s\n", token);
		}
		cantidadElementos++;
		token = strtok(NULL, " ");
	}

	if (DEBUG_MODE) {
		printf("Cantidad Elementos en Linea: %d\n", cantidadElementos);
		printf("Dimension: %d\n", dimension);
		printf("Linea original: %s\n", linea);
		printf("Copia Linea: %s\n", copiaLinea);
		printf("---\n");
	}

	if (dimension <= 0) 
		return false;

	if ( (dimension * dimension * 2) != cantidadElementos - 1 ) {
		return false;
	}

	return true;

}

void tokenizarLinea(char* linea, int indice) {

	if (!lineaEsValida(linea, indice)) {
		printf("\tLa dimension no concuerda con la cantidad de elementos de la linea.\n");
		return;
	} 

	int cantidadElementos = 0;
	int dimension = 0;

	char* token = strtok(linea, " ");
	dimension = atoi(token);

	int cantidadElementosM1 = dimension * dimension;

	double elementosM1[cantidadElementosM1];
	double elementosM2[cantidadElementosM1];

	int indice1 = 0;
	int indice2 = 0;

	while (token != NULL) {

		cantidadElementos++;

		if (cantidadElementos == 1) {
			// Es la dimension
			token = strtok(NULL, " ");
			continue;
		}

		if (cantidadElementos - 1 <= cantidadElementosM1) {
			elementosM1[indice1] = atof(token);
			indice1++;
		} else {
			elementosM2[indice2] = atof(token);
			indice2++;
		}

		token = strtok(NULL, " ");
		
	}

	if (DEBUG_MODE) {
		printf("Dimension: %d\n", dimension);

		printf("Elementos M1: ");
		for (int i = 0; i < cantidadElementosM1; i++) {
			printf("%.1f ", elementosM1[i]);
		}

		printf("\nElementos M2: ");
		for (int j = 0; j < cantidadElementosM1; j++) {
			printf("%.1f ", elementosM2[j]);
		}

		printf("\n\n\n");
	}
	

	/* Se deberian cargar las matrices */

	matrix_t* matrizA = create_matrix(dimension, dimension);
	matrix_t* matrizB = create_matrix(dimension, dimension);

	load_matrix(matrizA, elementosM1);
	load_matrix(matrizB, elementosM2);

	matrix_multiply(matrizA, matrizB);

	destroy_matrix(matrizA);

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

	printf("\nSe abre archivo de texto ");
    
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

	printf("\nCantidad de Lineas en el archivo: %d\n", cantidadLineas);

	fclose(archivo);

	printf("Termina el programa \n");


	return 0;
}




