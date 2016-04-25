#
# Codigo MIPS para la funcion matrix_multiply
#
# TODO: FRAME = x (SRA) + x (LTA) + 4 (ABA)
#
# m1: rows (0-3), cols (4-7), double* (8-11).
# rows y cols son size_t 	(4 bytes)
# array es PUNTERO a double	(4 bytes)
# array[i] es double 		(8 bytes)
#
# Enteros
	# t0: i
	# t1: j
	# t2: k
	# t3: m1rows
	# t4: m1cols
	# t5: m2rows
	# t6: m2cols
	# t7: offset
# Floating Point
	# f0: resultado
	# f1: intermedio
	# f2: intermedio2
# Punteros
	# v0: m3

#include <mips/regdef.h>

# TODO: Revisar direcciones de memoria---------

#define FRAME_S 40
#define GP_POS	24
#define FP_POS 	28
#define RA_POS 	32

#define ARG0_POS 40
#define ARG1_POS 44
#define i_POS 52
#define OFFSET_POS 48

	.text				# segmento de texto del programa

	.abicalls
	.align 2			# alineacion 2^2

	.globl	matrix_multiply
	.ent	matrix_multiply

matrix_multiply:
	.frame	$fp, FRAME_S, ra	# informacion de debugging

	.set	noreorder		# bloque para codigo PIC
	.cpload t9
	.set	reorder

	subu	sp, sp, FRAME_S		# se crea el stack frame

	.cprestore GP_POS		# sw gp, GP_POS(sp)
	
	sw	$fp, FP_POS(sp)		# se guardan los callee-saved regs en SRA
	sw	ra, RA_POS(sp)
	move	$fp, sp

	###### Guardo los argumentos
	sw	a0, ARG0_POS($fp)	# Guardo en $fp + ARG0_POS a0, que es el puntero a m1
	sw	a1, ARG1_POS($fp)	# Guardo en $fp + ARG1_POS a1, que es el puntero a m2

	###### Comienzo de la funcion

	# TODO: comprobar si argumentos son null -----------

	# se inicializan las variables
	lw	t3, 0(a0)		# m1rows = m1->rows;
	lw	t4, 4(a1)		# m2cols = m2->cols;
	
	###### Hago la llamada a create matrix
	move a0, t3
	move a1, t6
	la 	t9, create_matrix	# m3 = create_matrix(m1rows, m2cols);
	jal ra, t9
	# Aca ya tengo en v0 la direccion de memoria de m3, la matriz resultado,
	# porque create_matrix me devuelve el puntero m3 en v0.
	#
	# Recordar que al llamar a la funcion, perdimos los valores de los temporales
	# por lo que debemos cargar de nuevo a t3 y t6
	
	###### Recupero los argumentos, luego de llamar a la funcion create matrix
	lw	a0, ARG0_POS($fp)	# Recupero el valor de a0 que guarde antes en $fp + ARG0_POS
	lw	a1, ARG1_POS($fp)	# Recupero el valor de a1 que guarde antes en $fp + ARG1_POS
	lw	t3, 0(a0)		# m1rows = m1->rows;
	lw	t6, 4(a1)		# m2cols = m2->cols;

	lw	t4, 4(a0)		# m1cols = m1->cols;
	lw	t5, 0(a1)		# m2rows = m2->rows;
	li	t0, zero		# i = 0;

for1:
	bge	t0, t3, exit_for1	# si i >= m1->rows, termino for1
	li	t1, zero			# j = 0
	
for2: 
	bge t1, t6, exit_for2	# si j >= m2->cols, termino for2
	li	t2, zero			# k = 0
	ld	f0, zero			# resultado = 0

for3:
	bge	t2, t5, exit_for3		# k >= m2->rows

	mul	t7, t0, t4		# (i * m1->cols)
	addu t7, t7, t2		# offset = (i * m1->cols) + k

	sw t0, i_POS($fp)	# Guardo el valor de i actual en memoria

	lw t0, 8(a0)		# Guardo en t0 la direccion de memoria del array de m1
	mul t7, t7, 8		# Me desplazo "offset" posiciones * 8 bytes por posicion (multiplico por 8 bytes ser double)
	addu t0, t0, t7		# Sumo "offset" posiciones a la direccion de memoria del array de m1
	ld f1, 0(t0)		# intermedio = m1->array[offset];

	mul	t7, t2, t6		# (k * m2cols)
	addu t7, t7, t1		# offset = (k * m2cols) + j

	lw t0, 8(a1)		# Guardo en t0 la direccion de memoria del array de m2
	mul t7, t7, 8		# Me desplazo "offset" posiciones * 8 bytes por posicion (multiplico por 8 bytes ser double)
	addu t0, t0, t7		# Sumo "offset" posiciones a la direccion de memoria del array de m2
	ld f2, 0(t0)		# intermedio2 = m2->array[offset];


	mul f1, f1, f2		# intermedio = intermedio * intermedio2;
	addu f0, f0, f1		# resultado += intermedio;

	lw t0, i_POS($fp)	# Recupero el valor actual de i
	addu t2, t2, 1 		# k++;

	j	for3			# Vuelvo a ejecutar for 3

exit_for3:
	mul	t5, t0, s3		# t5 = i * m2->cols
	add	t5, t5, t1		# t5 = t5 + j

	# TODO: falta guardar: m3->array[i * m2cols + j] = resultado;

	addi	t1, t1, 1		# j++
	j	for2
	
exit_for2:
	addi	t0, t0, 1		# i++
	j	for1

	######

exit_for1:

	# TODO: falta return m3

	lw	gp, GP_POS(sp)		# se restauran callee-saved regs
	lw	$fp, FP_POS(sp)
	lw	ra, RA_POS(sp)

	addu	sp, sp, FRAME_S		# se destruye el stack frame

	jr	ra			# se vuelve a la funcion llamante

	.end	matrix_multiply
	.size	matrix_multiply,.-matrix_multiply


