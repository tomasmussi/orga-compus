#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "matrix.h"

#define MAX_SIZE 15

void show_help(const char *arg) {
	if ((strcmp(arg, "-h") == 0) || (strcmp(arg, "--help") == 0)) {
		printf("Usage:\n\ttpo -h\n\ttp0 -V\n\ttp0 < in_file > out_file 2> err_file\n\n");
		printf("Options:\n\t-V, --version\t\tPrint version and quit\n\t-h --help\t\tPrint this information and quit\n\n");
		printf("Examples:\n\ttp0 < in.txt > out.txt\n\tcat in.txt | tp0 > out.txt\n\n");
	} else if ((strcmp(arg, "-V") == 0) || (strcmp(arg, "--version") == 0)) {
		printf("TP 0. Version 1.0\n");
	}
}

void leerLinea(FILE* archivo) {

	int tamanioLinea = MAX_SIZE;
    char* bufferLinea = (char*)malloc(sizeof(char) * tamanioLinea);

    if (bufferLinea == NULL) {
        printf("No se puede asignar memoria al bufferLinea \n");
        exit(1);
    }

    char caracter = getc(archivo);
    int indice = 0;

    while ((caracter != '\n') && (caracter != EOF)) {
   
        if (indice == MAX_SIZE) {
       
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
    printf("%s\n", resultado);
    //return resultado;
}

void crearMatriz(char* linea) {

	char* token = strtok(linea, " ");
	while( token != NULL ) {
		printf( " %s\n", token );
	    token = strtok(NULL, " ");
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
	 
	while (!feof(archivo)) {
	    //char* linea = leerLinea(archivo);
	    leerLinea(archivo);
	}

	fclose(archivo);
	printf("Termina el programa \n");
    return 0;
}




