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
	.ascii	"%g\000"
	.align	2
$LC3:
	.ascii	" \000"
	.align	2
$LC4:
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
	la	$a1,$LC2
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
	la	$a1,$LC3
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
	la	$a1,$LC4
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
$LC5:
	.ascii	"Las matrices son invalidas; no se ha podido realizar la "
	.ascii	"multiplicacion \n\000"
	.align	2
$LC6:
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
	la	$a1,$LC5
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
	la	$a1,$LC6
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
	sw	$v0,24($fp)
	sw	$zero,28($fp)
	sw	$zero,32($fp)
$L39:
	lw	$v0,80($fp)
	lw	$v1,32($fp)
	lw	$v0,0($v0)
	sltu	$v0,$v1,$v0
	bne	$v0,$zero,$L42
	b	$L40
$L42:
	sw	$zero,36($fp)
$L43:
	lw	$v0,84($fp)
	lw	$v1,36($fp)
	lw	$v0,4($v0)
	sltu	$v0,$v1,$v0
	bne	$v0,$zero,$L46
	b	$L41
$L46:
	sw	$zero,48($fp)
	sw	$zero,52($fp)
	sw	$zero,40($fp)
$L47:
	lw	$v0,84($fp)
	lw	$v1,40($fp)
	lw	$v0,0($v0)
	sltu	$v0,$v1,$v0
	bne	$v0,$zero,$L50
	b	$L48
$L50:
	lw	$a0,80($fp)
	lw	$v0,80($fp)
	lw	$v1,32($fp)
	lw	$v0,4($v0)
	mult	$v1,$v0
	mflo	$v1
	lw	$v0,40($fp)
	addu	$v0,$v1,$v0
	sll	$v1,$v0,3
	lw	$v0,8($a0)
	addu	$a1,$v1,$v0
	lw	$a0,84($fp)
	lw	$v0,84($fp)
	lw	$v1,40($fp)
	lw	$v0,4($v0)
	mult	$v1,$v0
	mflo	$v1
	lw	$v0,36($fp)
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
	lw	$v0,40($fp)
	addu	$v0,$v0,1
	sw	$v0,40($fp)
	b	$L47
$L48:
	lw	$a0,24($fp)
	lw	$v0,84($fp)
	lw	$v1,32($fp)
	lw	$v0,4($v0)
	mult	$v1,$v0
	mflo	$v1
	lw	$v0,36($fp)
	addu	$v0,$v1,$v0
	sll	$v1,$v0,3
	lw	$v0,8($a0)
	addu	$v0,$v1,$v0
	l.d	$f0,48($fp)
	s.d	$f0,0($v0)
	lw	$v0,28($fp)
	addu	$v0,$v0,1
	sw	$v0,28($fp)
	lw	$v0,36($fp)
	addu	$v0,$v0,1
	sw	$v0,36($fp)
	b	$L43
$L41:
	lw	$v0,32($fp)
	addu	$v0,$v0,1
	sw	$v0,32($fp)
	b	$L39
$L40:
	lw	$v0,24($fp)
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
$LC7:
	.ascii	"-h\000"
	.align	2
$LC8:
	.ascii	"--help\000"
	.align	2
$LC9:
	.ascii	"Usage:\n"
	.ascii	"\ttpo -h\n"
	.ascii	"\ttp0 -V\n"
	.ascii	"\ttp0 < in_file > out_file 2> err_file\n\n\000"
	.align	2
$LC10:
	.ascii	"Options:\n"
	.ascii	"\t-V, --version\t\tPrint version and quit\n"
	.ascii	"\t-h --help\t\tPrint this information and quit\n\n\000"
	.align	2
$LC11:
	.ascii	"Examples:\n"
	.ascii	"\ttp0 < in.txt > out.txt\n"
	.ascii	"\tcat in.txt | tp0 > out.txt\n\n\000"
	.align	2
$LC12:
	.ascii	"-V\000"
	.align	2
$LC13:
	.ascii	"--version\000"
	.align	2
$LC14:
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
	la	$a1,$LC7
	la	$t9,strcmp
	jal	$ra,$t9
	beq	$v0,$zero,$L58
	lw	$a0,40($fp)
	la	$a1,$LC8
	la	$t9,strcmp
	jal	$ra,$t9
	bne	$v0,$zero,$L57
$L58:
	la	$a0,$LC9
	la	$t9,printf
	jal	$ra,$t9
	la	$a0,$LC10
	la	$t9,printf
	jal	$ra,$t9
	la	$a0,$LC11
	la	$t9,printf
	jal	$ra,$t9
	b	$L56
$L57:
	lw	$a0,40($fp)
	la	$a1,$LC12
	la	$t9,strcmp
	jal	$ra,$t9
	beq	$v0,$zero,$L61
	lw	$a0,40($fp)
	la	$a1,$LC13
	la	$t9,strcmp
	jal	$ra,$t9
	bne	$v0,$zero,$L56
$L61:
	la	$a0,$LC14
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
	.globl	lineaEsValida
	.ent	lineaEsValida
lineaEsValida:
	.frame	$fp,64,$ra		# vars= 24, regs= 4/0, args= 16, extra= 8
	.mask	0xd0010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,64
	.cprestore 16
	sw	$ra,60($sp)
	sw	$fp,56($sp)
	sw	$gp,52($sp)
	sw	$s0,48($sp)
	move	$fp,$sp
	sw	$a0,64($fp)
	sw	$a1,68($fp)
	sw	$sp,40($fp)
	lw	$v0,68($fp)
	addu	$v0,$v0,1
	addu	$v0,$v0,7
	srl	$v0,$v0,3
	sll	$v0,$v0,3
	subu	$sp,$sp,$v0
	addu	$s0,$sp,16
	lw	$v0,68($fp)
	addu	$v0,$v0,1
	move	$a0,$s0
	lw	$a1,64($fp)
	move	$a2,$v0
	la	$t9,strncpy
	jal	$ra,$t9
	sw	$zero,24($fp)
	sw	$zero,28($fp)
	move	$a0,$s0
	la	$a1,$LC3
	la	$t9,strtok
	jal	$ra,$t9
	sw	$v0,32($fp)
	lw	$a0,32($fp)
	la	$t9,atoi
	jal	$ra,$t9
	sw	$v0,28($fp)
$L63:
	lw	$v0,32($fp)
	bne	$v0,$zero,$L65
	b	$L64
$L65:
	lw	$v0,24($fp)
	addu	$v0,$v0,1
	sw	$v0,24($fp)
	move	$a0,$zero
	la	$a1,$LC3
	la	$t9,strtok
	jal	$ra,$t9
	sw	$v0,32($fp)
	b	$L63
$L64:
	lw	$v0,28($fp)
	bgtz	$v0,$L66
	lw	$sp,40($fp)
	sw	$zero,36($fp)
	b	$L62
$L66:
	lw	$v1,28($fp)
	lw	$v0,28($fp)
	mult	$v1,$v0
	mflo	$v0
	sll	$v1,$v0,1
	lw	$v0,24($fp)
	addu	$v0,$v0,-1
	beq	$v1,$v0,$L67
	lw	$sp,40($fp)
	sw	$zero,36($fp)
	b	$L62
$L67:
	lw	$sp,40($fp)
	li	$v0,1			# 0x1
	sw	$v0,36($fp)
$L62:
	lw	$v0,36($fp)
	move	$sp,$fp
	lw	$ra,60($sp)
	lw	$fp,56($sp)
	lw	$s0,48($sp)
	addu	$sp,$sp,64
	j	$ra
	.end	lineaEsValida
	.size	lineaEsValida, .-lineaEsValida
	.rdata
	.align	2
$LC15:
	.ascii	"La dimension no concuerda con la cantidad de elementos d"
	.ascii	"e la linea.\n\000"
	.text
	.align	2
	.globl	tokenizarLinea
	.ent	tokenizarLinea
tokenizarLinea:
	.frame	$fp,88,$ra		# vars= 48, regs= 4/0, args= 16, extra= 8
	.mask	0xd0010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,88
	.cprestore 16
	sw	$ra,84($sp)
	sw	$fp,80($sp)
	sw	$gp,76($sp)
	sw	$s0,72($sp)
	move	$fp,$sp
	sw	$a0,88($fp)
	sw	$a1,92($fp)
	sw	$sp,60($fp)
	lw	$a0,88($fp)
	lw	$a1,92($fp)
	la	$t9,lineaEsValida
	jal	$ra,$t9
	bne	$v0,$zero,$L69
	la	$a0,__sF+176
	la	$a1,$LC15
	la	$t9,fprintf
	jal	$ra,$t9
	b	$L68
$L69:
	sw	$zero,24($fp)
	sw	$zero,28($fp)
	lw	$a0,88($fp)
	la	$a1,$LC3
	la	$t9,strtok
	jal	$ra,$t9
	sw	$v0,32($fp)
	lw	$a0,32($fp)
	la	$t9,atoi
	jal	$ra,$t9
	sw	$v0,28($fp)
	lw	$v1,28($fp)
	lw	$v0,28($fp)
	mult	$v1,$v0
	mflo	$v0
	sw	$v0,36($fp)
	lw	$v0,36($fp)
	addu	$v0,$v0,-1
	sll	$v0,$v0,3
	addu	$v0,$v0,8
	subu	$sp,$sp,$v0
	addu	$v0,$sp,16
	sw	$v0,64($fp)
	lw	$v0,36($fp)
	addu	$v0,$v0,-1
	sll	$v0,$v0,3
	addu	$v0,$v0,8
	subu	$sp,$sp,$v0
	addu	$v1,$sp,16
	sw	$v1,68($fp)
	sw	$zero,40($fp)
	sw	$zero,44($fp)
$L70:
	lw	$v0,32($fp)
	bne	$v0,$zero,$L72
	b	$L71
$L72:
	lw	$v0,24($fp)
	addu	$v0,$v0,1
	sw	$v0,24($fp)
	lw	$v1,24($fp)
	li	$v0,1			# 0x1
	bne	$v1,$v0,$L73
	move	$a0,$zero
	la	$a1,$LC3
	la	$t9,strtok
	jal	$ra,$t9
	sw	$v0,32($fp)
	b	$L70
$L73:
	lw	$v0,24($fp)
	addu	$v1,$v0,-1
	lw	$v0,36($fp)
	slt	$v0,$v0,$v1
	bne	$v0,$zero,$L74
	lw	$v0,40($fp)
	sll	$v0,$v0,3
	lw	$v1,64($fp)
	addu	$s0,$v0,$v1
	lw	$a0,32($fp)
	la	$t9,atof
	jal	$ra,$t9
	s.d	$f0,0($s0)
	lw	$v0,40($fp)
	addu	$v0,$v0,1
	sw	$v0,40($fp)
	b	$L75
$L74:
	lw	$v0,44($fp)
	sll	$v0,$v0,3
	lw	$v1,68($fp)
	addu	$s0,$v0,$v1
	lw	$a0,32($fp)
	la	$t9,atof
	jal	$ra,$t9
	s.d	$f0,0($s0)
	lw	$v0,44($fp)
	addu	$v0,$v0,1
	sw	$v0,44($fp)
$L75:
	move	$a0,$zero
	la	$a1,$LC3
	la	$t9,strtok
	jal	$ra,$t9
	sw	$v0,32($fp)
	b	$L70
$L71:
	lw	$a0,28($fp)
	lw	$a1,28($fp)
	la	$t9,create_matrix
	jal	$ra,$t9
	sw	$v0,48($fp)
	lw	$a0,28($fp)
	lw	$a1,28($fp)
	la	$t9,create_matrix
	jal	$ra,$t9
	sw	$v0,52($fp)
	lw	$a0,48($fp)
	lw	$a1,64($fp)
	la	$t9,load_matrix
	jal	$ra,$t9
	lw	$a0,52($fp)
	lw	$a1,68($fp)
	la	$t9,load_matrix
	jal	$ra,$t9
	lw	$a0,48($fp)
	lw	$a1,52($fp)
	la	$t9,matrix_multiply
	jal	$ra,$t9
	sw	$v0,56($fp)
	la	$a0,__sF+88
	lw	$a1,56($fp)
	la	$t9,print_matrix
	jal	$ra,$t9
	lw	$a0,48($fp)
	la	$t9,destroy_matrix
	jal	$ra,$t9
	lw	$a0,52($fp)
	la	$t9,destroy_matrix
	jal	$ra,$t9
	lw	$a0,56($fp)
	la	$t9,destroy_matrix
	jal	$ra,$t9
	lw	$sp,60($fp)
$L68:
	move	$sp,$fp
	lw	$ra,84($sp)
	lw	$fp,80($sp)
	lw	$s0,72($sp)
	addu	$sp,$sp,88
	j	$ra
	.end	tokenizarLinea
	.size	tokenizarLinea, .-tokenizarLinea
	.rdata
	.align	2
$LC16:
	.ascii	"No se puede asignar memoria al bufferLinea \n\000"
	.align	2
$LC17:
	.ascii	"No se puede reasignar memoria al bufferLinea \n\000"
	.text
	.align	2
	.globl	leerLinea
	.ent	leerLinea
leerLinea:
	.frame	$fp,72,$ra		# vars= 32, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,72
	.cprestore 16
	sw	$ra,64($sp)
	sw	$fp,60($sp)
	sw	$gp,56($sp)
	move	$fp,$sp
	sw	$a0,72($fp)
	sw	$a1,76($fp)
	sw	$sp,48($fp)
	li	$v0,10			# 0xa
	sw	$v0,24($fp)
	lw	$a0,24($fp)
	la	$t9,malloc
	jal	$ra,$t9
	sw	$v0,28($fp)
	lw	$v0,28($fp)
	bne	$v0,$zero,$L77
	la	$a0,$LC16
	la	$t9,printf
	jal	$ra,$t9
	li	$a0,1			# 0x1
	la	$t9,exit
	jal	$ra,$t9
$L77:
	lw	$v1,72($fp)
	lw	$v0,72($fp)
	lw	$v0,4($v0)
	addu	$v0,$v0,-1
	sw	$v0,4($v1)
	bgez	$v0,$L78
	lw	$a0,72($fp)
	la	$t9,__srget
	jal	$ra,$t9
	sb	$v0,44($fp)
	b	$L79
$L78:
	lw	$v0,72($fp)
	lw	$v1,0($v0)
	move	$a0,$v1
	lbu	$a0,0($a0)
	sb	$a0,44($fp)
	addu	$v1,$v1,1
	sw	$v1,0($v0)
$L79:
	lbu	$v0,44($fp)
	sb	$v0,32($fp)
	sw	$zero,36($fp)
$L80:
	lb	$v1,32($fp)
	li	$v0,10			# 0xa
	beq	$v1,$v0,$L81
	lb	$v1,32($fp)
	li	$v0,-1			# 0xffffffffffffffff
	bne	$v1,$v0,$L82
	b	$L81
$L82:
	lw	$v0,36($fp)
	slt	$v0,$v0,10
	bne	$v0,$zero,$L84
	lw	$v0,24($fp)
	addu	$v0,$v0,10
	sw	$v0,24($fp)
	lw	$a0,28($fp)
	lw	$a1,24($fp)
	la	$t9,realloc
	jal	$ra,$t9
	sw	$v0,40($fp)
	lw	$v0,28($fp)
	bne	$v0,$zero,$L85
	lw	$a0,28($fp)
	la	$t9,free
	jal	$ra,$t9
	la	$a0,$LC17
	la	$t9,printf
	jal	$ra,$t9
	li	$a0,1			# 0x1
	la	$t9,exit
	jal	$ra,$t9
$L85:
	lw	$v0,40($fp)
	sw	$v0,28($fp)
$L84:
	lw	$v1,28($fp)
	lw	$v0,36($fp)
	addu	$v1,$v1,$v0
	lbu	$v0,32($fp)
	sb	$v0,0($v1)
	lw	$v0,36($fp)
	addu	$v0,$v0,1
	sw	$v0,36($fp)
	lw	$v1,72($fp)
	lw	$v0,72($fp)
	lw	$v0,4($v0)
	addu	$v0,$v0,-1
	sw	$v0,4($v1)
	bgez	$v0,$L86
	lw	$a0,72($fp)
	la	$t9,__srget
	jal	$ra,$t9
	sb	$v0,45($fp)
	b	$L87
$L86:
	lw	$v0,72($fp)
	lw	$v1,0($v0)
	move	$a0,$v1
	lbu	$a0,0($a0)
	sb	$a0,45($fp)
	addu	$v1,$v1,1
	sw	$v1,0($v0)
$L87:
	lbu	$v1,45($fp)
	sb	$v1,32($fp)
	b	$L80
$L81:
	lw	$v1,28($fp)
	lw	$v0,36($fp)
	addu	$v0,$v1,$v0
	sb	$zero,0($v0)
	lw	$v0,36($fp)
	addu	$v0,$v0,1
	addu	$v0,$v0,7
	srl	$v0,$v0,3
	sll	$v0,$v0,3
	subu	$sp,$sp,$v0
	addu	$v0,$sp,16
	sw	$v0,52($fp)
	lw	$v0,36($fp)
	addu	$v0,$v0,1
	lw	$a0,52($fp)
	lw	$a1,28($fp)
	move	$a2,$v0
	la	$t9,strncpy
	jal	$ra,$t9
	lw	$a0,28($fp)
	la	$t9,free
	jal	$ra,$t9
	lw	$v1,52($fp)
	lb	$v0,0($v1)
	beq	$v0,$zero,$L88
	lw	$v1,76($fp)
	lw	$v0,76($fp)
	lw	$v0,0($v0)
	addu	$v0,$v0,1
	sw	$v0,0($v1)
	lw	$v0,36($fp)
	addu	$v0,$v0,1
	lw	$a0,52($fp)
	move	$a1,$v0
	la	$t9,tokenizarLinea
	jal	$ra,$t9
$L88:
	lw	$sp,48($fp)
	move	$sp,$fp
	lw	$ra,64($sp)
	lw	$fp,60($sp)
	addu	$sp,$sp,72
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
	beq	$v1,$v0,$L90
	lw	$v0,52($fp)
	addu	$v0,$v0,4
	lw	$a0,0($v0)
	la	$t9,show_help
	jal	$ra,$t9
	sw	$zero,28($fp)
	b	$L89
$L90:
	sw	$zero,24($fp)
$L91:
	lhu	$v0,__sF+12
	srl	$v0,$v0,5
	andi	$v0,$v0,0x1
	beq	$v0,$zero,$L93
	b	$L92
$L93:
	la	$a0,__sF
	addu	$a1,$fp,24
	la	$t9,leerLinea
	jal	$ra,$t9
	b	$L91
$L92:
	sw	$zero,28($fp)
$L89:
	lw	$v0,28($fp)
	move	$sp,$fp
	lw	$ra,40($sp)
	lw	$fp,36($sp)
	addu	$sp,$sp,48
	j	$ra
	.end	main
	.size	main, .-main
	.ident	"GCC: (GNU) 3.3.3 (NetBSD nb3 20040520)"
