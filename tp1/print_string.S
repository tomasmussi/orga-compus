##
## Codigo MIPS para la funcion print_string
##
##

## FRAME = 4 (SRA) + 0 (FPA) + 0 (LTA) + 4 (ABA)
## Memoria = 16 + 0 + 0 + 16 = 32 bytes

## SRA (Save Register Area):
## 1) ra (Return address)
## 2) fp (Frame Pointer)
## 3) gp (Global Pointer)
## Esto nos da un SRA de 4 * 4 bytes = 16 bytes (alineado a 8 bytes)
## 4 REGISTROS

## FPRA (Floating Point Register Area)
## No se utilizan registros de punto flotante
## 0 REGISTROS

## LTA (Local and Temporary Area)
## No se utilizan registros locales
## 0 REGISTROS

## ABA (Argument Building Area)
## Esta funcion invoca a write que toma tres argumentos de entrada
## a0: file descriptor a escribir
## a1: puntero a char donde comienza el string
## a2: cantidad de bytes a escribir desde el string apuntado por a1
## Esto nos da un ABA de 4 * 4 bytes = 16 bytes (alineado a 8 bytes)
## 4 REGISTROS

#include <mips/regdef.h>
#include <sys/syscall.h>

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

	.globl	print_string
	.ent	print_string

print_string:
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
	sw	a0, ARG0_POS($fp)	# Guardo en $fp + ARG0_POS a0, que es el file descriptor del stream
	sw	a1, ARG1_POS($fp)	# Guardo en $fp + ARG1_POS a1, que es el string a flushear

	###### Comienzo de la funcion

	###### Hago la llamada a strlen
	move a0, a1		# Paso el puntero al string al argumento 0 para invocar strlen
	la t9, strlen
	jal ra, t9		# strlen(str);

	## Aca ya tengo en v0 la cantidad de bytes a escribir con la system call
	move a2, v0		# copio len al argumento 3 de la funcion write
	lw a0, ARG0_POS($fp)	# Recupero el file descriptor de memoria y lo cargo para llamar a write
	lw a1, ARG1_POS($fp)	# Recupero el puntero a char de memoria y lo cargo para llamar a write
	li	v0, SYS_write		# Cargo en v0 el numero de system call que es write
	syscall					# write(fd, str, len);

	## Luego de haber llamado a la system call write, me devuelve en v0
	## la cantidad de bytes escritos en el stream, que tambien coincide con
	## el valor que tiene que retornar la funcion print_string
	## Asi que lo unico que queda hacer es destruir el stack frame y retornar

	## En v0 ya esta guardada la cantidad de bytes escritos

	lw	gp, GP_POS(sp)		# se restauran callee-saved regs
	lw	$fp, FP_POS(sp)
	lw	ra, RA_POS(sp)

	addu	sp, sp, FRAME_S		# se destruye el stack frame

	jr	ra			# se vuelve a la funcion llamante

	.end	print_string
	.size	print_string,.-print_string
