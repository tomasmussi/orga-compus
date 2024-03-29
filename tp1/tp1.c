#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

#include <sys/types.h>
#include <unistd.h>

#ifndef _POSIX_C_SOURCE
#define _POSIX_C_SOURCE 1
#endif

#define MAX_DIGITOS 1000

/* ------ Implementacion de funciones de matrices ------- */

typedef struct matrix {
	size_t rows;
	size_t cols;
	double* array;
} matrix_t;


bool invalido(matrix_t* m1, matrix_t* m2) {
	if (m1 == NULL || m2 == NULL) {
		fprintf(stderr, "Las matrices son invalidas; no se ha podido realizar la multiplicacion \n");
		return true;
	}
	if (m1->cols != m2->rows) {
		fprintf(stderr, "Error en las dimensiones; no se ha podido realizar la multiplicacion \n");
		return true;
	}
	return false;
}

/**
 * Primitiva implementada en Assembly
 * */
matrix_t* matrix_multiply(matrix_t* m1, matrix_t* m2);

/**
 * Imprime en el archivo indicado por el file descriptor fd, el string C
 * apuntado por str, sin incluir su byte nulo de finalizacion.
 **/
ssize_t print_string(int fd, char* str);

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

/*
ssize_t print_string(int fd, char* str) {
	size_t len = strlen(str);
	return write(fd, str, len);
}
*/

/* Imprime la matriz sobre el file pointer fp
 * PRE: la matriz fue creada y el file pointer es valido.
 * POST: la matriz se serealizo en el file pointer
 **/
int print_matrix(FILE* fp, matrix_t* m) {
	int fd;
	char buffer[20];
 	size_t fila, col;
 	fd = fileno(fp);
 	sprintf(buffer, "%u ", m->rows);
 	print_string(fd, buffer);
	for (fila=0; fila < m->rows; fila++) {
		for (col=0; col < m->cols; col++) {
			sprintf(buffer, "%g", m->array[(fila * m->rows) + col]);
 			print_string(fd, buffer);
			if (((fila + 1) != m->rows) || ((col + 1) != m->cols)) {
				print_string(fd, " ");
			}
		}
	}
	print_string(fd, "\n");
	return 0;
}


/* Multiplica las matrices en m1 y m2
 * PRE: las matrices fueron creadas
 * POST: retorna una nueva matriz resultado del producto
 **/
/*
matrix_t* matrix_multiply(matrix_t* m1, matrix_t* m2) {
*/
	/*
	if (m1 == NULL || m2 == NULL) {
		fprintf(stderr, "Las matrices son invalidas; no se ha podido realizar la multiplicacion \n");
		return NULL;
	}
	if (m1cols != m2rows) {
		fprintf(stderr, "Error en las dimensiones; no se ha podido realizar la multiplicacion \n");
		return NULL;
	}
	*/
	/*
	Tenemos 12 variables locales, una de ellas es el retorno,
	9 ints => 9 * 4 bytes
	1 puntero => 1 * 4 bytes
	2 double => 2 * 8 bytes
	1 Llamada a funcion

	*/
/*
	int i, j, k, m1rows, m1cols, m2rows, m2cols, offset;
	double resultado, intermedio, intermedio2;
	matrix_t* m3;

	m1rows = m1->rows;
	m2cols = m2->cols;

	m3 = create_matrix(m1rows, m2cols);

	m1cols = m1->cols;
	m2rows = m2->rows;

	i = 0;
	while (i < m1rows) {
		j = 0;
		while (j < m2cols) {
			k = 0;
			resultado = 0;
			while (k < m2rows) {
				offset = (i * m1cols) + k;
				intermedio = m1->array[offset];
				offset = (k * m2cols) + j;
				intermedio2 = m2->array[offset];
				intermedio = intermedio * intermedio2;
				resultado += intermedio;
				k++;
			}
			offset = (i * m2cols) + j;
			m3->array[offset] = resultado;
			j++;
		}
		i++;
	}
	return m3;
}*/

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
	destroy_matrix(matrizA);
	destroy_matrix(matrizB);
	if (producto != NULL) {
		print_matrix(stdout, producto);
		destroy_matrix(producto);
	}
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




