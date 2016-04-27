##
## Codigo MIPS para la funcion matrix_multiply
##
##
## m1: rows (0-3), cols (4-7), double* (8-11).
## rows y cols son size_t 	(4 bytes)
## array es PUNTERO a double	(4 bytes)
## array[i] es double 		(8 bytes)
##
## Enteros
	## t0: i => Se guarda en memoria
	## t1: j
	## t2: k
	## t3: m1rows
	## t4: m1cols
	## t5: m2rows
	## t6: m2cols
	## t7: offset
## Floating Point
	## f0: resultado
	## f2: intermedio
	## f4: intermedio2
## Punteros
	## v0: m3

#include <mips/regdef.h>

## FRAME = 4 (SRA) + 0 (FPA) + 2 (LTA) + 2 (ABA)
## Memoria = 16 + 0 + 8 + 8 = 32 bytes

## SRA (Save Register Area):
## 1) ra (Return address)
## 2) fp (Frame Pointer)
## 3) gp (Global Pointer)
## Esto nos da un SRA de 4 * 4 bytes = 16 bytes (alineado a 8 bytes)
## 4 REGISTROS

## FPRA (Floating Point Register Area)
## Se utilizan 3 registros de punto flotante pero ninguno se almacena en memoria
## 0 REGISTROS

## LTA (Local and Temporary Area)
## Se utilizan los 8 registros, de los cuales se guardan en memoria:
## 1) i que se utiliza con el registro t0
## Esto nos da un LTA de 2 * 4 bytes = 8 bytes (alineado a 8 bytes)
## 2 REGISTROS

## ABA (Argument Building Area)
## Esta funcion invoca a create matrix que toma dos argumentos de entrada
## a0: cantidad de filas de la matriz
## a1: cantidad de columnas de la matriz
## Esto nos da un ABA de 2 * 4 bytes = 8 bytes (alineado a 8 bytes)
## 2 REGISTROS


#define FRAME_S 32
#define GP_POS	16
#define FP_POS 	20
#define RA_POS 	24

#define ARG0_POS 32
#define ARG1_POS 36
#define i_POS 8

	.text				## segmento de texto del programa

	.abicalls
	.align 2			## alineacion 2^2

	.globl	matrix_multiply
	.ent	matrix_multiply

matrix_multiply:
	.frame	$fp, FRAME_S, ra	## informacion de debugging

	.set	noreorder		## bloque para codigo PIC
	.cpload t9
	.set	reorder

	subu	sp, sp, FRAME_S		## se crea el stack frame

	.cprestore GP_POS		## sw gp, GP_POS(sp)

	sw	$fp, FP_POS(sp)		## se guardan los callee-saved regs en SRA
	sw	ra, RA_POS(sp)
	move	$fp, sp

	###### Guardo los argumentos
	sw	a0, ARG0_POS($fp)	# Guardo en $fp + ARG0_POS a0, que es el puntero a m1
	sw	a1, ARG1_POS($fp)	# Guardo en $fp + ARG1_POS a1, que es el puntero a m2

	###### Comienzo de la funcion

	la t9, invalido		# Verifico si se puede hacer la multiplicacion
	jal ra, t9
	move t0, v0			# Copio a t0 el resultado
	li v0, 0			# m3 = NULL;
	bnez t0, exit_for1	# if (invalido(m1, m2)) return NULL;

	lw a0, ARG0_POS($fp)
	lw a1, ARG1_POS($fp)

	## se inicializan las variables
	lw	t3, 0(a0)		# m1rows = m1->rows;
	lw	t6, 4(a1)		# m2cols = m2->cols;

	###### Hago la llamada a create matrix
	move a0, t3
	move a1, t6
	la 	t9, create_matrix	# m3 = create_matrix(m1rows, m2cols);
	jal ra, t9
	## Aca ya tengo en v0 la direccion de memoria de m3, la matriz resultado,
	## porque create_matrix me devuelve el puntero m3 en v0.

	## Recordar que al llamar a la funcion, perdimos los valores de los temporales
	## por lo que debemos cargar de nuevo a t3 y t6

	###### Recupero los argumentos, luego de llamar a la funcion create matrix
	lw	a0, ARG0_POS($fp)	# Recupero el valor de a0 que guarde antes en $fp + ARG0_POS
	lw	a1, ARG1_POS($fp)	# Recupero el valor de a1 que guarde antes en $fp + ARG1_POS
	lw	t3, 0(a0)		# m1rows = m1->rows;
	lw	t6, 4(a1)		# m2cols = m2->cols;

	lw	t4, 4(a0)		# m1cols = m1->cols;
	lw	t5, 0(a1)		# m2rows = m2->rows;
	li	t0, 0		# i = 0;

for1:
	bge	t0, t3, exit_for1	# si i >= m1->rows, termino for1
	li	t1, 0			# j = 0

for2:
	bge t1, t6, exit_for2	# si j >= m2->cols, termino for2
	li	t2, 0			# k = 0
	li.d	$f0, 0			# resultado = 0

for3:
	bge	t2, t5, exit_for3		# k >= m2->rows

	mul	t7, t0, t4		# (i * m1->cols)
	addu t7, t7, t2		# offset = (i * m1->cols) + k

	sw t0, i_POS($fp)	# Guardo el valor de i actual en memoria

	lw t0, 8(a0)		# Guardo en t0 la direccion de memoria del array de m1
	mul t7, t7, 8		# Me desplazo "offset" posiciones * 8 bytes por posicion (multiplico por 8 bytes ser double)
	addu t0, t0, t7		# Sumo "offset" posiciones a la direccion de memoria del array de m1
	l.d $f2, 0(t0)		# intermedio = m1->array[offset];

	mul	t7, t2, t6		# (k * m2cols)
	addu t7, t7, t1		# offset = (k * m2cols) + j

	lw t0, 8(a1)		# Guardo en t0 la direccion de memoria del array de m2
	mul t7, t7, 8		# Me desplazo "offset" posiciones * 8 bytes por posicion (multiplico por 8 bytes ser double)
	addu t0, t0, t7		# Sumo "offset" posiciones a la direccion de memoria del array de m2
	l.d $f4, 0(t0)		# intermedio2 = m2->array[offset];


	mul.d $f2, $f2, $f4		# intermedio = intermedio * intermedio2;
	add.d $f0, $f0, $f2		# resultado += intermedio;

	lw t0, i_POS($fp)	# Recupero el valor actual de i
	addu t2, t2, 1 		# k++;

	j	for3			# Vuelvo a ejecutar for 3

exit_for3:

	mul t7, t0, t6		# offset = (i * m2cols)
	addu t7, t7, t1		# offset = (i * m2cols) + j;
	mul t7, t7, 8		# Me desplazo "offset" posiciones * 8 bytes por posicion (multiplico por 8 bytes ser double)

	## Como en esta parte k ya no la utilizo y al llamar a for2 se vuelve a poner en 0, la puedo usar para
	## cargar la direccion de memoria que necesito y hacer el store
	lw t2, 8(v0)		# double *puntero = m3->array;
	addu t2, t2, t7		# m3->array[offset];
	s.d $f0, 0(t2)		# m3->array[offset] = resultado;

	addi	t1, t1, 1	# j++;
	j	for2

exit_for2:
	addi	t0, t0, 1	# i++;
	j for1


exit_for1:

	## En v0 ya esta guardada la direccion de memoria de la nueva matriz.

	lw	gp, GP_POS(sp)		# se restauran callee-saved regs
	lw	$fp, FP_POS(sp)
	lw	ra, RA_POS(sp)

	addu	sp, sp, FRAME_S		# se destruye el stack frame

	jr	ra			# se vuelve a la funcion llamante

	.end	matrix_multiply
	.size	matrix_multiply,.-matrix_multiply
