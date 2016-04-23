#
# Codigo MIPS para la funcion matrix_multiply
#
# TODO: FRAME = x (SRA) + x (LTA) + 4 (ABA)
#
# m1: rows (0-4), cols (4-8), array[0] (8-12), array[1] (12-16), etc.
# rows y cols son size_t 	(4 bytes)
# a[i] son double* 		(4 bytes)
#
# t0: i
# t1: j
# t2: k
# t3: cantidadElementosNueva
# t4: resultado
#
# s0: m1->rows
# s1: m1->cols
# s2: m2->rows
# s3: m2->cols

#include <mips/regdef.h>

#define FRAME_S 40
#define GP_POS	24
#define FP_POS 	28
#define RA_POS 	32

#define ARG0_POS 40
#define ARG1_POS 44

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
	
	sw	a0, ARG0_POS($fp)	# se guardan los argumentos
	sw	a1, ARG1_POS($fp)

	######
					# se inicializan las variables
	li	t0, zero		# i
	li	t1, zero		# j
	li	t2, zero		# k
	li	t3, zero		# cantidadElementosNueva
	li	t4, zero		# resultado
					# se guardan valores de las matrices
	lw	a0, ARG0_POS($fp)	
	lw	s0, 0(a0)		# m1->rows
	lw	s1, 4(a0)		# m1->cols
	lw	a1, ARG1_POS($fp)
	lw	s2, 0(a1)		# m2->rows
	lw	s3, 4(a1)		# m2->cols

	# TODO: comprobar si argumentos son null, crear m3

for1:
	bge	t0, s0, exit_loop	# i >= m1->rows
	li	t1, zero		# j = 0
	
for2: 
	bge 	t1, s3, update1		# j >= m2->cols
	li	t2, zero		# k = 0
	li	t4, zero		# resultado = 0

for3:
	bge	t2, s2, update2		# k >= m2->rows
	
	# contenido loop

	mul	t5, t0, s1		# t5 = i * m1->cols
	add	t5, t5, t2		# t5 = t5 + k
	add	t6, a0, 8		# &m1->array[0]
	mul	t5, t5, 4		# t5 = t5 * 4
	add	t6, t6, t5		# &m1->array[t5]
	lw	t5, 0(t6)		# t5 = m1->array[t5]

	mul	t7, t2, s3		# t7 = k * m2->cols
	add 	t7, t7, t1		# t7 = t7 + j
	add	t8, a1, 8		# &m2->array[0]
	mul	t7, t7, 4		# t7 = t7 * 4
	add	t8, t8, t7		# &m2->array[t7]
	lw	t7, 0(t8)		# t7 = m2->array[t7]

	mul	t6, t5, t7		# t6 = t5 * t7
	
	add 	t4, t4, t6		# resultado += t6

	addi	t2, t2, 1		# k++
	j	for3

update2:
	mul	t5, t0, s3		# t5 = i * m2->cols
	add	t5, t5, t1		# t5 = t5 + j

	# TODO: falta guardar en m3

	addi	t3, t3, 1		# cantidadElementosNueva++

	addi	t1, t1, 1		# j++
	j	for2
	
update1:
	addi	t0, t0, 1		# i++
	j	for1

	######

exit_loop:

	# TODO: falta return m3

	lw	gp, GP_POS(sp)		# se restauran callee-saved regs
	lw	$fp, FP_POS(sp)
	lw	ra, RA_POS(sp)

	addu	sp, sp, FRAME_S		# se destruye el stack frame

	jr	ra			# se vuelve a la funcion llamante

	.end	matrix_multiply
	.size	matrix_multiply,.-matrix_multiply


