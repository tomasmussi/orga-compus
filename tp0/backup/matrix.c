#include "matrix.h"

#define DEBUG_MODE false

struct matrix {
	size_t rows;
	size_t cols;
	double* array;
};

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
	if (DEBUG_MODE)
		printf("Se ha creado la matriz\n");
	return matriz;
}

void destroy_matrix(matrix_t* m) {
    if (m != NULL) {
        free (m->array);
        free (m);
    }
}

int print_matrix(FILE* fp, matrix_t* m) {
	for (size_t fila = 0; fila < m->rows; fila++) {
		for (size_t col = 0; col < m->cols; col++) {
			fprintf(fp, "%.2f ", m->array[(fila * m->rows) + col]);
		}
	}
	fprintf(fp, "\n");
	return 0;
}

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

	for (int i = 0; i < m1->rows; i++) {
		for (int j = 0; j < m2->cols; j++) {
			double resultado = 0;

			for (int k = 0; k < m2->rows; k++) {
				resultado += m1->array[i * m1->cols + k] * m2->array[k * m2->cols + j];
			}

			m3->array[i * m2->cols + j] = resultado;
			cantidadElementosNueva++;
		}
	}

	if (DEBUG_MODE) {
		for (int indice = 0; indice < cantidadElementosNueva; indice++) {
			printf("%.1f ", m3->array[indice]);
		}
	}
	return m3;
}


void load_matrix(matrix_t* m, double* elements) {
	for (int i = 0; i < m->rows * m->cols; i++) {
		m->array[i] = elements[i];
	}
}
