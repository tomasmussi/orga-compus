#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

#define MAX_DIGITOS 1000

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
	matriz->array = NULL;
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
 	fprintf(fp, "%d ", m->rows);
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
	int i, j, k, cantidadElementosNueva;
	matrix_t* m3;	
	if (m1 == NULL || m2 == NULL) {
		fprintf(stderr, "Las matrices son invalidas; no se ha podido realizar la multiplicacion \n");
		return NULL;
	}
	if (m1->cols != m2->rows) {
		fprintf(stderr, "Error en las dimensiones; no se ha podido realizar la multiplicacion \n");
		return NULL;
	}
	/* Se genera una nueva matriz m3 */
	m3 = create_matrix(m1->rows, m2->cols);	
	cantidadElementosNueva = 0;

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

void multiplicar(int dimension, double *matriz1, double *matriz2) {
	matrix_t* matrizA;
	matrix_t* matrizB;
	matrix_t* producto;
	matrizA = (matrix_t*) create_matrix(dimension, dimension);
	matrizB = (matrix_t*) create_matrix(dimension, dimension);
	load_matrix(matrizA, matriz1);
	load_matrix(matrizB, matriz2);
	producto = (matrix_t*) matrix_multiply(matrizA, matrizB);
	print_matrix(stdout, producto);
	destroy_matrix(matrizA);
	destroy_matrix(matrizB);
	destroy_matrix(producto);
}

void leerLinea(FILE* archivo, int* cantidadLineas) {
	int dimension = -1;
	int elementos = 0;
	double *matriz1 = NULL;
	double *matriz2 = NULL;
	int index1 = 0;
	int index2 = 0;
	
	char elemento[MAX_DIGITOS];
	int subindice = 0;
	char caracter = 'A';
	bool invalido = false;
	while (caracter != '\n' && caracter != EOF && !invalido) {
		caracter = getc(archivo);
		while (caracter != '\n' && caracter != EOF && caracter != ' ') {
			elemento[subindice++] = caracter;
			caracter = getc(archivo);			
		}
		elemento[subindice] = '\0';
		if (subindice > 0) {
			if (dimension == -1) {
				dimension = atoi(elemento);
				matriz1 = malloc(sizeof(double) * dimension * dimension);
				if (matriz1 == NULL) {
					fprintf(stderr, "No hay suficiente memoria para la matriz 1\n");
					return;
				}
				matriz2 = malloc(sizeof(double) * dimension * dimension);
				if (matriz2 == NULL) {
					free(matriz1);
					fprintf(stderr, "No hay suficiente memoria para la matriz 2\n");
					return;
				}
			} else if (elementos >= ((dimension * dimension * 2))) {
				/* Cantidad invalida */
				invalido = true;
			} else {
				if (dimension > 0) {
					if ((elementos / (dimension * dimension)) == 0) {
						matriz1[index1++] = atof(elemento);
					} else {
						if (elementos == ((dimension * dimension * 2))) {
							invalido = true;
						} else {
							matriz2[index2++] = atof(elemento);
						}
					}
					elementos++;
				} else {
					invalido = true;
				}
			}			
		}
		while (caracter == ' ') {
			caracter = getc(archivo);
		}
		if (caracter != '\n' && caracter != EOF) {
			subindice = 0;
			elemento[subindice++] = caracter;
		}
	}
	if ( elementos > 0) {
		if (invalido || (dimension * dimension * 2 != elementos)) {
			fprintf(stderr, "La dimension no concuerda con la cantidad de elementos de la linea.\n");
			while (caracter != '\n' && caracter != EOF) {
				caracter = getc(archivo);
			}
		} else {
			multiplicar(dimension, matriz1, matriz2);
		}
	} else if (dimension == 0) {
		fprintf(stderr, "La dimension no concuerda con la cantidad de elementos de la linea.\n");
	}
	free(matriz1);
	free(matriz2);
}

int main(int argc, char *argv[]) {
	int cantidadLineas;
	if (argc != 1) {
		show_help(argv[1]);
		return 0;
	}
	cantidadLineas = 0;
	while (!feof(stdin)) {
		leerLinea(stdin, &cantidadLineas);
	}
	return 0;
}




