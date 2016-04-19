	.file	1 "tp0.c"
	.section .mdebug.abi32
	.previous
	.abicalls
	.rdata
	.align	2
$LC0:
	.ascii	"No se ha podido crear la matriz\n\000"
	.align	2
$LC1:
	.ascii	"Dimensiones invalidas, no se ha podido crear la matriz\n"
	.ascii	"\000"
	.text
	.align	2
	.globl	create_matrix
	.ent	create_matrix
create_matrix:
	.frame	$fp,48,$ra		# vars= 8, regs= 4/0, args= 16, extra= 8
	.mask	0xd0010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,48
	.cprestore 16
	sw	$ra,44($sp)
	sw	$fp,40($sp)
	sw	$gp,36($sp)
	sw	$s0,32($sp)
	move	$fp,$sp
	sw	$a0,48($fp)
	sw	$a1,52($fp)
	li	$a0,12			# 0xc
	la	$t9,malloc
	jal	$ra,$t9
	sw	$v0,24($fp)
	lw	$v0,24($fp)
	bne	$v0,$zero,$L18
	la	$a0,__sF+176
	la	$a1,$LC0
	la	$t9,fprintf
	jal	$ra,$t9
	sw	$zero,28($fp)
	b	$L17
$L18:
	lw	$v0,48($fp)
	beq	$v0,$zero,$L20
	lw	$v0,52($fp)
	bne	$v0,$zero,$L19
$L20:
	la	$a0,__sF+176
	la	$a1,$LC1
	la	$t9,fprintf
	jal	$ra,$t9
	sw	$zero,28($fp)
	b	$L17
$L19:
	lw	$v1,24($fp)
	lw	$v0,48($fp)
	sw	$v0,0($v1)
	lw	$v1,24($fp)
	lw	$v0,52($fp)
	sw	$v0,4($v1)
	lw	$v0,24($fp)
	sw	$zero,8($v0)
	lw	$s0,24($fp)
	lw	$v1,48($fp)
	lw	$v0,52($fp)
	mult	$v1,$v0
	mflo	$v0
	sll	$v0,$v0,3
	move	$a0,$v0
	la	$t9,malloc
	jal	$ra,$t9
	sw	$v0,8($s0)
	lw	$v0,24($fp)
	lw	$v0,8($v0)
	bne	$v0,$zero,$L21
	la	$a0,__sF+176
	la	$a1,$LC0
	la	$t9,fprintf
	jal	$ra,$t9
	lw	$a0,24($fp)
	la	$t9,free
	jal	$ra,$t9
	sw	$zero,28($fp)
	b	$L17
$L21:
	lw	$v0,24($fp)
	sw	$v0,28($fp)
$L17:
	lw	$v0,28($fp)
	move	$sp,$fp
	lw	$ra,44($sp)
	lw	$fp,40($sp)
	lw	$s0,32($sp)
	addu	$sp,$sp,48
	j	$ra
	.end	create_matrix
	.size	create_matrix, .-create_matrix
	.align	2
	.globl	destroy_matrix
	.ent	destroy_matrix
destroy_matrix:
	.frame	$fp,40,$ra		# vars= 0, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,40
	.cprestore 16
	sw	$ra,32($sp)
	sw	$fp,28($sp)
	sw	$gp,24($sp)
	move	$fp,$sp
	sw	$a0,40($fp)
	lw	$v0,40($fp)
	beq	$v0,$zero,$L22
	lw	$v0,40($fp)
	lw	$a0,8($v0)
	la	$t9,free
	jal	$ra,$t9
	lw	$a0,40($fp)
	la	$t9,free
	jal	$ra,$t9
$L22:
	move	$sp,$fp
	lw	$ra,32($sp)
	lw	$fp,28($sp)
	addu	$sp,$sp,40
	j	$ra
	.end	destroy_matrix
	.size	destroy_matrix, .-destroy_matrix
	.rdata
	.align	2
$LC2:
	.ascii	"%d \000"
	.align	2
$LC3:
	.ascii	"%g\000"
	.align	2
$LC4:
	.ascii	" \000"
	.align	2
$LC5:
	.ascii	"\n\000"
	.text
	.align	2
	.globl	print_matrix
	.ent	print_matrix
print_matrix:
	.frame	$fp,48,$ra		# vars= 8, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,48
	.cprestore 16
	sw	$ra,40($sp)
	sw	$fp,36($sp)
	sw	$gp,32($sp)
	move	$fp,$sp
	sw	$a0,48($fp)
	sw	$a1,52($fp)
	lw	$v0,52($fp)
	lw	$a0,48($fp)
	la	$a1,$LC2
	lw	$a2,0($v0)
	la	$t9,fprintf
	jal	$ra,$t9
	sw	$zero,24($fp)
$L25:
	lw	$v0,52($fp)
	lw	$v1,24($fp)
	lw	$v0,0($v0)
	sltu	$v0,$v1,$v0
	bne	$v0,$zero,$L28
	b	$L26
$L28:
	sw	$zero,28($fp)
$L29:
	lw	$v0,52($fp)
	lw	$v1,28($fp)
	lw	$v0,4($v0)
	sltu	$v0,$v1,$v0
	bne	$v0,$zero,$L32
	b	$L27
$L32:
	lw	$a0,52($fp)
	lw	$v0,52($fp)
	lw	$v1,24($fp)
	lw	$v0,0($v0)
	mult	$v1,$v0
	mflo	$v1
	lw	$v0,28($fp)
	addu	$v0,$v1,$v0
	sll	$v1,$v0,3
	lw	$v0,8($a0)
	addu	$v0,$v1,$v0
	lw	$a0,48($fp)
	la	$a1,$LC3
	lw	$a2,0($v0)
	lw	$a3,4($v0)
	la	$t9,fprintf
	jal	$ra,$t9
	lw	$v0,24($fp)
	addu	$v1,$v0,1
	lw	$v0,52($fp)
	lw	$v0,0($v0)
	bne	$v1,$v0,$L34
	lw	$v0,28($fp)
	addu	$v1,$v0,1
	lw	$v0,52($fp)
	lw	$v0,4($v0)
	bne	$v1,$v0,$L34
	b	$L31
$L34:
	lw	$a0,48($fp)
	la	$a1,$LC4
	la	$t9,fprintf
	jal	$ra,$t9
$L31:
	lw	$v0,28($fp)
	addu	$v0,$v0,1
	sw	$v0,28($fp)
	b	$L29
$L27:
	lw	$v0,24($fp)
	addu	$v0,$v0,1
	sw	$v0,24($fp)
	b	$L25
$L26:
	lw	$a0,48($fp)
	la	$a1,$LC5
	la	$t9,fprintf
	jal	$ra,$t9
	move	$v0,$zero
	move	$sp,$fp
	lw	$ra,40($sp)
	lw	$fp,36($sp)
	addu	$sp,$sp,48
	j	$ra
	.end	print_matrix
	.size	print_matrix, .-print_matrix
	.rdata
	.align	2
$LC6:
	.ascii	"Las matrices son invalidas; no se ha podido realizar la "
	.ascii	"multiplicacion \n\000"
	.align	2
$LC7:
	.ascii	"Error en las dimensiones; no se ha podido realizar la mu"
	.ascii	"ltiplicacion \n\000"
	.text
	.align	2
	.globl	matrix_multiply
	.ent	matrix_multiply
matrix_multiply:
	.frame	$fp,80,$ra		# vars= 40, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,80
	.cprestore 16
	sw	$ra,72($sp)
	sw	$fp,68($sp)
	sw	$gp,64($sp)
	move	$fp,$sp
	sw	$a0,80($fp)
	sw	$a1,84($fp)
	lw	$v0,80($fp)
	beq	$v0,$zero,$L37
	lw	$v0,84($fp)
	bne	$v0,$zero,$L36
$L37:
	la	$a0,__sF+176
	la	$a1,$LC6
	la	$t9,fprintf
	jal	$ra,$t9
	sw	$zero,56($fp)
	b	$L35
$L36:
	lw	$v0,80($fp)
	lw	$v1,84($fp)
	lw	$a0,4($v0)
	lw	$v0,0($v1)
	beq	$a0,$v0,$L38
	la	$a0,__sF+176
	la	$a1,$LC7
	la	$t9,fprintf
	jal	$ra,$t9
	sw	$zero,56($fp)
	b	$L35
$L38:
	lw	$v0,80($fp)
	lw	$v1,84($fp)
	lw	$a0,0($v0)
	lw	$a1,4($v1)
	la	$t9,create_matrix
	jal	$ra,$t9
	sw	$v0,40($fp)
	sw	$zero,36($fp)
	sw	$zero,24($fp)
$L39:
	lw	$v0,80($fp)
	lw	$v1,24($fp)
	lw	$v0,0($v0)
	sltu	$v0,$v1,$v0
	bne	$v0,$zero,$L42
	b	$L40
$L42:
	sw	$zero,28($fp)
$L43:
	lw	$v0,84($fp)
	lw	$v1,28($fp)
	lw	$v0,4($v0)
	sltu	$v0,$v1,$v0
	bne	$v0,$zero,$L46
	b	$L41
$L46:
	sw	$zero,48($fp)
	sw	$zero,52($fp)
	sw	$zero,32($fp)
$L47:
	lw	$v0,84($fp)
	lw	$v1,32($fp)
	lw	$v0,0($v0)
	sltu	$v0,$v1,$v0
	bne	$v0,$zero,$L50
	b	$L48
$L50:
	lw	$a0,80($fp)
	lw	$v0,80($fp)
	lw	$v1,24($fp)
	lw	$v0,4($v0)
	mult	$v1,$v0
	mflo	$v1
	lw	$v0,32($fp)
	addu	$v0,$v1,$v0
	sll	$v1,$v0,3
	lw	$v0,8($a0)
	addu	$a1,$v1,$v0
	lw	$a0,84($fp)
	lw	$v0,84($fp)
	lw	$v1,32($fp)
	lw	$v0,4($v0)
	mult	$v1,$v0
	mflo	$v1
	lw	$v0,28($fp)
	addu	$v0,$v1,$v0
	sll	$v1,$v0,3
	lw	$v0,8($a0)
	addu	$v0,$v1,$v0
	l.d	$f2,0($a1)
	l.d	$f0,0($v0)
	mul.d	$f2,$f2,$f0
	l.d	$f0,48($fp)
	add.d	$f0,$f0,$f2
	s.d	$f0,48($fp)
	lw	$v0,32($fp)
	addu	$v0,$v0,1
	sw	$v0,32($fp)
	b	$L47
$L48:
	lw	$a0,40($fp)
	lw	$v0,84($fp)
	lw	$v1,24($fp)
	lw	$v0,4($v0)
	mult	$v1,$v0
	mflo	$v1
	lw	$v0,28($fp)
	addu	$v0,$v1,$v0
	sll	$v1,$v0,3
	lw	$v0,8($a0)
	addu	$v0,$v1,$v0
	l.d	$f0,48($fp)
	s.d	$f0,0($v0)
	lw	$v0,36($fp)
	addu	$v0,$v0,1
	sw	$v0,36($fp)
	lw	$v0,28($fp)
	addu	$v0,$v0,1
	sw	$v0,28($fp)
	b	$L43
$L41:
	lw	$v0,24($fp)
	addu	$v0,$v0,1
	sw	$v0,24($fp)
	b	$L39
$L40:
	lw	$v0,40($fp)
	sw	$v0,56($fp)
$L35:
	lw	$v0,56($fp)
	move	$sp,$fp
	lw	$ra,72($sp)
	lw	$fp,68($sp)
	addu	$sp,$sp,80
	j	$ra
	.end	matrix_multiply
	.size	matrix_multiply, .-matrix_multiply
	.align	2
	.globl	load_matrix
	.ent	load_matrix
load_matrix:
	.frame	$fp,24,$ra		# vars= 8, regs= 2/0, args= 0, extra= 8
	.mask	0x50000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,24
	.cprestore 0
	sw	$fp,20($sp)
	sw	$gp,16($sp)
	move	$fp,$sp
	sw	$a0,24($fp)
	sw	$a1,28($fp)
	sw	$zero,8($fp)
$L52:
	lw	$v0,24($fp)
	lw	$v1,24($fp)
	lw	$a0,0($v0)
	lw	$v0,4($v1)
	mult	$a0,$v0
	mflo	$v1
	lw	$v0,8($fp)
	sltu	$v0,$v0,$v1
	bne	$v0,$zero,$L55
	b	$L51
$L55:
	lw	$a0,24($fp)
	lw	$v0,8($fp)
	sll	$v1,$v0,3
	lw	$v0,8($a0)
	addu	$a0,$v1,$v0
	lw	$v0,8($fp)
	sll	$v1,$v0,3
	lw	$v0,28($fp)
	addu	$v0,$v1,$v0
	l.d	$f0,0($v0)
	s.d	$f0,0($a0)
	lw	$v0,8($fp)
	addu	$v0,$v0,1
	sw	$v0,8($fp)
	b	$L52
$L51:
	move	$sp,$fp
	lw	$fp,20($sp)
	addu	$sp,$sp,24
	j	$ra
	.end	load_matrix
	.size	load_matrix, .-load_matrix
	.rdata
	.align	2
$LC8:
	.ascii	"-h\000"
	.align	2
$LC9:
	.ascii	"--help\000"
	.align	2
$LC10:
	.ascii	"Usage:\n"
	.ascii	"\ttpo -h\n"
	.ascii	"\ttp0 -V\n"
	.ascii	"\ttp0 < in_file > out_file 2> err_file\n\n\000"
	.align	2
$LC11:
	.ascii	"Options:\n"
	.ascii	"\t-V, --version\t\tPrint version and quit\n"
	.ascii	"\t-h --help\t\tPrint this information and quit\n\n\000"
	.align	2
$LC12:
	.ascii	"Examples:\n"
	.ascii	"\ttp0 < in.txt > out.txt\n"
	.ascii	"\tcat in.txt | tp0 > out.txt\n\n\000"
	.align	2
$LC13:
	.ascii	"-V\000"
	.align	2
$LC14:
	.ascii	"--version\000"
	.align	2
$LC15:
	.ascii	"TP 0. Version 1.0\n\000"
	.text
	.align	2
	.globl	show_help
	.ent	show_help
show_help:
	.frame	$fp,40,$ra		# vars= 0, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,40
	.cprestore 16
	sw	$ra,32($sp)
	sw	$fp,28($sp)
	sw	$gp,24($sp)
	move	$fp,$sp
	sw	$a0,40($fp)
	lw	$a0,40($fp)
	la	$a1,$LC8
	la	$t9,strcmp
	jal	$ra,$t9
	beq	$v0,$zero,$L58
	lw	$a0,40($fp)
	la	$a1,$LC9
	la	$t9,strcmp
	jal	$ra,$t9
	bne	$v0,$zero,$L57
$L58:
	la	$a0,$LC10
	la	$t9,printf
	jal	$ra,$t9
	la	$a0,$LC11
	la	$t9,printf
	jal	$ra,$t9
	la	$a0,$LC12
	la	$t9,printf
	jal	$ra,$t9
	b	$L56
$L57:
	lw	$a0,40($fp)
	la	$a1,$LC13
	la	$t9,strcmp
	jal	$ra,$t9
	beq	$v0,$zero,$L61
	lw	$a0,40($fp)
	la	$a1,$LC14
	la	$t9,strcmp
	jal	$ra,$t9
	bne	$v0,$zero,$L56
$L61:
	la	$a0,$LC15
	la	$t9,printf
	jal	$ra,$t9
$L56:
	move	$sp,$fp
	lw	$ra,32($sp)
	lw	$fp,28($sp)
	addu	$sp,$sp,40
	j	$ra
	.end	show_help
	.size	show_help, .-show_help
	.align	2
	.globl	multiplicar
	.ent	multiplicar
multiplicar:
	.frame	$fp,56,$ra		# vars= 16, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,56
	.cprestore 16
	sw	$ra,48($sp)
	sw	$fp,44($sp)
	sw	$gp,40($sp)
	move	$fp,$sp
	sw	$a0,56($fp)
	sw	$a1,60($fp)
	sw	$a2,64($fp)
	lw	$a0,56($fp)
	lw	$a1,56($fp)
	la	$t9,create_matrix
	jal	$ra,$t9
	sw	$v0,24($fp)
	lw	$a0,56($fp)
	lw	$a1,56($fp)
	la	$t9,create_matrix
	jal	$ra,$t9
	sw	$v0,28($fp)
	lw	$a0,24($fp)
	lw	$a1,60($fp)
	la	$t9,load_matrix
	jal	$ra,$t9
	lw	$a0,28($fp)
	lw	$a1,64($fp)
	la	$t9,load_matrix
	jal	$ra,$t9
	lw	$a0,24($fp)
	lw	$a1,28($fp)
	la	$t9,matrix_multiply
	jal	$ra,$t9
	sw	$v0,32($fp)
	la	$a0,__sF+88
	lw	$a1,32($fp)
	la	$t9,print_matrix
	jal	$ra,$t9
	lw	$a0,24($fp)
	la	$t9,destroy_matrix
	jal	$ra,$t9
	lw	$a0,28($fp)
	la	$t9,destroy_matrix
	jal	$ra,$t9
	lw	$a0,32($fp)
	la	$t9,destroy_matrix
	jal	$ra,$t9
	move	$sp,$fp
	lw	$ra,48($sp)
	lw	$fp,44($sp)
	addu	$sp,$sp,56
	j	$ra
	.end	multiplicar
	.size	multiplicar, .-multiplicar
	.rdata
	.align	2
$LC16:
	.ascii	"No hay suficiente memoria para la matriz 1\n\000"
	.align	2
$LC17:
	.ascii	"No hay suficiente memoria para la matriz 2\n\000"
	.align	2
$LC18:
	.ascii	"La dimension no concuerda con la cantidad de elementos d"
	.ascii	"e la linea.\n\000"
	.text
	.align	2
	.globl	leerLinea
	.ent	leerLinea
leerLinea:
	.frame	$fp,1080,$ra		# vars= 1040, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,1080
	.cprestore 16
	sw	$ra,1072($sp)
	sw	$fp,1068($sp)
	sw	$gp,1064($sp)
	move	$fp,$sp
	sw	$a0,1080($fp)
	sw	$a1,1084($fp)
	li	$v0,-1			# 0xffffffffffffffff
	sw	$v0,24($fp)
	sw	$zero,28($fp)
	sw	$zero,32($fp)
	sw	$zero,36($fp)
	sw	$zero,40($fp)
	sw	$zero,44($fp)
	sw	$zero,1048($fp)
	li	$v0,65			# 0x41
	sb	$v0,1052($fp)
	sb	$zero,1053($fp)
$L64:
	lb	$v1,1052($fp)
	li	$v0,10			# 0xa
	beq	$v1,$v0,$L65
	lb	$v1,1052($fp)
	li	$v0,-1			# 0xffffffffffffffff
	beq	$v1,$v0,$L65
	lbu	$v0,1053($fp)
	bne	$v0,$zero,$L65
	lw	$v1,1080($fp)
	lw	$v0,1080($fp)
	lw	$v0,4($v0)
	addu	$v0,$v0,-1
	sw	$v0,4($v1)
	bgez	$v0,$L68
	lw	$a0,1080($fp)
	la	$t9,__srget
	jal	$ra,$t9
	sb	$v0,1054($fp)
	b	$L69
$L68:
	lw	$v0,1080($fp)
	lw	$v1,0($v0)
	move	$a0,$v1
	lbu	$a0,0($a0)
	sb	$a0,1054($fp)
	addu	$v1,$v1,1
	sw	$v1,0($v0)
$L69:
	lbu	$v0,1054($fp)
	sb	$v0,1052($fp)
$L70:
	lb	$v1,1052($fp)
	li	$v0,10			# 0xa
	beq	$v1,$v0,$L71
	lb	$v1,1052($fp)
	li	$v0,-1			# 0xffffffffffffffff
	beq	$v1,$v0,$L71
	lb	$v1,1052($fp)
	li	$v0,32			# 0x20
	bne	$v1,$v0,$L72
	b	$L71
$L72:
	addu	$a1,$fp,1048
	lw	$v1,0($a1)
	move	$a0,$v1
	addu	$v0,$fp,24
	addu	$v0,$a0,$v0
	addu	$a0,$v0,24
	lbu	$v0,1052($fp)
	sb	$v0,0($a0)
	addu	$v1,$v1,1
	sw	$v1,0($a1)
	lw	$v1,1080($fp)
	lw	$v0,1080($fp)
	lw	$v0,4($v0)
	addu	$v0,$v0,-1
	sw	$v0,4($v1)
	bgez	$v0,$L74
	lw	$a0,1080($fp)
	la	$t9,__srget
	jal	$ra,$t9
	sb	$v0,1055($fp)
	b	$L75
$L74:
	lw	$v0,1080($fp)
	lw	$v1,0($v0)
	move	$a0,$v1
	lbu	$a0,0($a0)
	sb	$a0,1055($fp)
	addu	$v1,$v1,1
	sw	$v1,0($v0)
$L75:
	lbu	$v0,1055($fp)
	sb	$v0,1052($fp)
	b	$L70
$L71:
	addu	$v1,$fp,48
	lw	$v0,1048($fp)
	addu	$v0,$v1,$v0
	sb	$zero,0($v0)
	lw	$v0,1048($fp)
	blez	$v0,$L76
	lw	$v1,24($fp)
	li	$v0,-1			# 0xffffffffffffffff
	bne	$v1,$v0,$L77
	addu	$v0,$fp,48
	move	$a0,$v0
	la	$t9,atoi
	jal	$ra,$t9
	sw	$v0,24($fp)
	lw	$v1,24($fp)
	lw	$v0,24($fp)
	mult	$v1,$v0
	mflo	$v0
	sll	$v0,$v0,3
	move	$a0,$v0
	la	$t9,malloc
	jal	$ra,$t9
	sw	$v0,32($fp)
	lw	$v0,32($fp)
	bne	$v0,$zero,$L78
	la	$a0,__sF+176
	la	$a1,$LC16
	la	$t9,fprintf
	jal	$ra,$t9
	b	$L63
$L78:
	lw	$v1,24($fp)
	lw	$v0,24($fp)
	mult	$v1,$v0
	mflo	$v0
	sll	$v0,$v0,3
	move	$a0,$v0
	la	$t9,malloc
	jal	$ra,$t9
	sw	$v0,36($fp)
	lw	$v0,36($fp)
	bne	$v0,$zero,$L76
	lw	$a0,32($fp)
	la	$t9,free
	jal	$ra,$t9
	la	$a0,__sF+176
	la	$a1,$LC17
	la	$t9,fprintf
	jal	$ra,$t9
	b	$L63
$L77:
	lw	$v1,24($fp)
	lw	$v0,24($fp)
	mult	$v1,$v0
	mflo	$v0
	sll	$v1,$v0,1
	lw	$v0,28($fp)
	slt	$v0,$v0,$v1
	bne	$v0,$zero,$L81
	li	$v0,1			# 0x1
	sb	$v0,1053($fp)
	b	$L76
$L81:
	lw	$v0,24($fp)
	blez	$v0,$L83
	lw	$v1,24($fp)
	lw	$v0,24($fp)
	mult	$v1,$v0
	mflo	$v1
	lw	$v0,28($fp)
	div	$0,$v0,$v1
	mflo	$v0
	.set	noreorder
	bne	$v1,$0,1f
	nop
	break	7
1:
	.set	reorder
	bne	$v0,$zero,$L84
	addu	$v0,$fp,48
	move	$a0,$v0
	la	$t9,atof
	jal	$ra,$t9
	addu	$a1,$fp,40
	lw	$v1,0($a1)
	move	$v0,$v1
	sll	$a0,$v0,3
	lw	$v0,32($fp)
	addu	$v0,$a0,$v0
	s.d	$f0,0($v0)
	addu	$v1,$v1,1
	sw	$v1,0($a1)
	b	$L85
$L84:
	lw	$v1,24($fp)
	lw	$v0,24($fp)
	mult	$v1,$v0
	mflo	$v0
	sll	$v1,$v0,1
	lw	$v0,28($fp)
	bne	$v0,$v1,$L86
	li	$v0,1			# 0x1
	sb	$v0,1053($fp)
	b	$L85
$L86:
	addu	$v0,$fp,48
	move	$a0,$v0
	la	$t9,atof
	jal	$ra,$t9
	addu	$a1,$fp,44
	lw	$v1,0($a1)
	move	$v0,$v1
	sll	$a0,$v0,3
	lw	$v0,36($fp)
	addu	$v0,$a0,$v0
	s.d	$f0,0($v0)
	addu	$v1,$v1,1
	sw	$v1,0($a1)
$L85:
	lw	$v0,28($fp)
	addu	$v0,$v0,1
	sw	$v0,28($fp)
	b	$L76
$L83:
	li	$v0,1			# 0x1
	sb	$v0,1053($fp)
$L76:
	.set	noreorder
	nop
	.set	reorder
$L89:
	lb	$v1,1052($fp)
	li	$v0,32			# 0x20
	beq	$v1,$v0,$L91
	b	$L90
$L91:
	lw	$v1,1080($fp)
	lw	$v0,1080($fp)
	lw	$v0,4($v0)
	addu	$v0,$v0,-1
	sw	$v0,4($v1)
	bgez	$v0,$L92
	lw	$a0,1080($fp)
	la	$t9,__srget
	jal	$ra,$t9
	sb	$v0,1056($fp)
	b	$L93
$L92:
	lw	$v0,1080($fp)
	lw	$v1,0($v0)
	move	$a0,$v1
	lbu	$a0,0($a0)
	sb	$a0,1056($fp)
	addu	$v1,$v1,1
	sw	$v1,0($v0)
$L93:
	lbu	$v0,1056($fp)
	sb	$v0,1052($fp)
	b	$L89
$L90:
	lb	$v1,1052($fp)
	li	$v0,10			# 0xa
	beq	$v1,$v0,$L64
	lb	$v1,1052($fp)
	li	$v0,-1			# 0xffffffffffffffff
	beq	$v1,$v0,$L64
	sw	$zero,1048($fp)
	addu	$a1,$fp,1048
	lw	$v1,0($a1)
	move	$a0,$v1
	addu	$v0,$fp,24
	addu	$v0,$a0,$v0
	addu	$a0,$v0,24
	lbu	$v0,1052($fp)
	sb	$v0,0($a0)
	addu	$v1,$v1,1
	sw	$v1,0($a1)
	b	$L64
$L65:
	lw	$v0,28($fp)
	blez	$v0,$L95
	lbu	$v0,1053($fp)
	bne	$v0,$zero,$L97
	lw	$v1,24($fp)
	lw	$v0,24($fp)
	mult	$v1,$v0
	mflo	$v0
	sll	$v1,$v0,1
	lw	$v0,28($fp)
	bne	$v1,$v0,$L97
	b	$L96
$L97:
	la	$a0,__sF+176
	la	$a1,$LC18
	la	$t9,fprintf
	jal	$ra,$t9
$L98:
	lb	$v1,1052($fp)
	li	$v0,10			# 0xa
	beq	$v1,$v0,$L105
	lb	$v1,1052($fp)
	li	$v0,-1			# 0xffffffffffffffff
	bne	$v1,$v0,$L100
	b	$L105
$L100:
	lw	$v1,1080($fp)
	lw	$v0,1080($fp)
	lw	$v0,4($v0)
	addu	$v0,$v0,-1
	sw	$v0,4($v1)
	bgez	$v0,$L102
	lw	$a0,1080($fp)
	la	$t9,__srget
	jal	$ra,$t9
	sb	$v0,1057($fp)
	b	$L103
$L102:
	lw	$v0,1080($fp)
	lw	$v1,0($v0)
	move	$a0,$v1
	lbu	$a0,0($a0)
	sb	$a0,1057($fp)
	addu	$v1,$v1,1
	sw	$v1,0($v0)
$L103:
	lbu	$v0,1057($fp)
	sb	$v0,1052($fp)
	b	$L98
$L96:
	lw	$a0,24($fp)
	lw	$a1,32($fp)
	lw	$a2,36($fp)
	la	$t9,multiplicar
	jal	$ra,$t9
	b	$L105
$L95:
	lw	$v0,24($fp)
	bne	$v0,$zero,$L105
	la	$a0,__sF+176
	la	$a1,$LC18
	la	$t9,fprintf
	jal	$ra,$t9
$L105:
	lw	$a0,32($fp)
	la	$t9,free
	jal	$ra,$t9
	lw	$a0,36($fp)
	la	$t9,free
	jal	$ra,$t9
$L63:
	move	$sp,$fp
	lw	$ra,1072($sp)
	lw	$fp,1068($sp)
	addu	$sp,$sp,1080
	j	$ra
	.end	leerLinea
	.size	leerLinea, .-leerLinea
	.align	2
	.globl	main
	.ent	main
main:
	.frame	$fp,48,$ra		# vars= 8, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,48
	.cprestore 16
	sw	$ra,40($sp)
	sw	$fp,36($sp)
	sw	$gp,32($sp)
	move	$fp,$sp
	sw	$a0,48($fp)
	sw	$a1,52($fp)
	lw	$v1,48($fp)
	li	$v0,1			# 0x1
	beq	$v1,$v0,$L108
	lw	$v0,52($fp)
	addu	$v0,$v0,4
	lw	$a0,0($v0)
	la	$t9,show_help
	jal	$ra,$t9
	sw	$zero,28($fp)
	b	$L107
$L108:
	sw	$zero,24($fp)
$L109:
	lhu	$v0,__sF+12
	srl	$v0,$v0,5
	andi	$v0,$v0,0x1
	beq	$v0,$zero,$L111
	b	$L110
$L111:
	la	$a0,__sF
	addu	$a1,$fp,24
	la	$t9,leerLinea
	jal	$ra,$t9
	b	$L109
$L110:
	sw	$zero,28($fp)
$L107:
	lw	$v0,28($fp)
	move	$sp,$fp
	lw	$ra,40($sp)
	lw	$fp,36($sp)
	addu	$sp,$sp,48
	j	$ra
	.end	main
	.size	main, .-main
	.ident	"GCC: (GNU) 3.3.3 (NetBSD nb3 20040520)"
