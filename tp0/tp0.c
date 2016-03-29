#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

#define MAX_SIZE 10

#define DEBUG_MODE false


/* ------ Implementacion de funciones de matrices ------- */

typedef struct matrix {
	size_t rows;
	size_t cols;
	double* array;
} matrix_t;

/* Constructor de matriz.
 * PRE: rows y cols son mayores a 0
 * POST: devuelve una matriz vacia 
 **/
matrix_t* create_matrix(size_t rows, size_t cols) {
	matrix_t* matriz = (matrix_t*) malloc( sizeof(matrix_t) );
	if (matriz == NULL) {
		fprintf(stderr, "No se ha podido crear la matriz\n");
		return NULL;
	}
	if (rows == 0 || cols == 0) {
		fprintf(stderr, "Dimensiones invalidas, no se ha podido crear la matriz\n");
		return NULL;
	}
	matriz->rows = rows;
	matriz->cols = cols;
	matriz->array = (double*) malloc( rows * cols * sizeof(double) );
	if (matriz->array == NULL) {
		fprintf(stderr, "No se ha podido crear la matriz\n");
		free(matriz);
		return NULL;
	}
	return matriz;
}

/* Destructor de matriz.
 * PRE: la matriz fue creada.
 * POST: matriz destruida y recursos liberados 
 **/
void destroy_matrix(matrix_t* m) {
    if (m != NULL) {
        free (m->array);
        free (m);
    }
}

/* Imprime la matriz sobre el file pointer fp
 * PRE: la matriz fue creada y el file pointer es valido.
 * POST: la matriz se serealizo en el file pointer 
 **/
int print_matrix(FILE* fp, matrix_t* m) {
 	size_t fila, col;
	for (fila=0; fila < m->rows; fila++) {
		for (col=0; col < m->cols; col++) {
			fprintf(fp, "%g", m->array[(fila * m->rows) + col]);
			if (((fila + 1) != m->rows) || ((col + 1) != m->cols)) {
				fprintf(fp, " ");
			}
		}
	}
	fprintf(fp, "\n");
	return 0;
}

/* Multiplica las matrices en m1 y m2
 * PRE: las matrices fueron creadas
 * POST: retorna una nueva matriz resultado del producto 
 **/
matrix_t* matrix_multiply(matrix_t* m1, matrix_t* m2) {
	if (m1 == NULL || m2 == NULL) {
		fprintf(stderr, "Las matrices son invalidas; no se ha podido realizar la multiplicacion \n");
		return NULL;
	}
	if (m1->cols != m2->rows) {
		fprintf(stderr, "Error en las dimensiones; no se ha podido realizar la multiplicacion \n");
		return NULL;
	}
	// Se genera una nueva matriz m3
	matrix_t* m3 = create_matrix(m1->rows, m2->cols);
	int cantidadElementosNueva = 0;
	int i,j,k;

	for (i=0; i < m1->rows; i++) {
		for (j=0; j < m2->cols; j++) {
			double resultado = 0;
			for (k=0; k < m2->rows; k++) {
				resultado += m1->array[i * m1->cols + k] * m2->array[k * m2->cols + j];
			}
			m3->array[i * m2->cols + j] = resultado;
			cantidadElementosNueva++;
		}
	}
	return m3;
}

/* Carga la matriz con los elementos pasados por parametro
 * PRE: la matriz fue creada
 * POST: retorna la matriz con los datos cargados  
 **/
void load_matrix(matrix_t* m, double* elements) {
 	int i;
	for (i=0; i < m->rows * m->cols; i++) {
		m->array[i] = elements[i];
	}
}

/* --------------- */


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
		cantidadElementos++;
		token = strtok(NULL, " ");
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
		fprintf(stderr, "La dimension no concuerda con la cantidad de elementos de la linea.\n");
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

	/* Se deberian cargar las matrices */
	matrix_t* matrizA = create_matrix(dimension, dimension);
	matrix_t* matrizB = create_matrix(dimension, dimension);
	load_matrix(matrizA, elementosM1);
	load_matrix(matrizB, elementosM2);
	matrix_t *producto = matrix_multiply(matrizA, matrizB);
	print_matrix(stdout, producto);
	destroy_matrix(matrizA);
	destroy_matrix(matrizB);
	destroy_matrix(producto);
}

void leerLinea(FILE* archivo, int* cantidadLineas) {
	int tamanioLinea = MAX_SIZE;
	char* bufferLinea = (char*) malloc(sizeof(char) * tamanioLinea);
	if (bufferLinea == NULL) {
		printf("No se puede asignar memoria al bufferLinea \n");
		exit(1);
	}
	char caracter = getc(archivo);
	int indice = 0;
	while ((caracter != '\n') && (caracter != EOF)) {
		if (indice >= MAX_SIZE) {
			tamanioLinea += MAX_SIZE;
			char *nuevoBufferLinea = realloc(bufferLinea, tamanioLinea);
			if (bufferLinea == NULL) {
				free(bufferLinea);
				printf("No se puede reasignar memoria al bufferLinea \n");
				exit(1);
			}
			bufferLinea = nuevoBufferLinea;
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
		tokenizarLinea(resultado, indice + 1);
	}
}

int main(int argc, char *argv[]) {
	if (argc != 1) {
		show_help(argv[1]);
		return 0;
	}
	int cantidadLineas = 0;
	while (!feof(stdin)) {
		leerLinea(stdin, &cantidadLineas);
	}
	return 0;
}




