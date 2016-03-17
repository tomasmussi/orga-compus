#ifndef _MATRIX_H_

#define _MATRIX_H_

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

typedef struct matrix matrix_t;

/* Constructor de matriz.
 * PRE: rows y cols son mayores a 0
 * POST: devuelve una matriz vacia
 * */
matrix_t* create_matrix(size_t rows, size_t cols);

/* Destructor de matriz.
 * PRE: la matriz fue creada.
 * POST: matriz destruida y recursos liberados.
 * */
void destroy_matrix(matrix_t* m);

/* Imprime la matriz sobre el file pointer fp
 * PRE: la matriz fue creada y el file pointer es valido.
 * POST: la matriz se serealizo en el file pointer.
 * */
int print_matrix(FILE* fp, matrix_t* m);

/* Multiplica las matrices en m1 y m2
 * PRE: las matrices fueron creadas
 * POST: retorna una nueva matriz resultado del producto.
 * */
matrix_t* matrix_multiply(matrix_t* m1, matrix_t* m2);

/* Carga la matriz con los elementos pasados por parametro
 * PRE: la matriz fue creada
 * POST: 
 * */
void load_matrix(matrix_t* m, double* elements);

#endif // _MATRIX_H_
