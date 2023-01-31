	.file	"main.c"
	.intel_syntax noprefix
 .section	.rodata.str1.1
.LC4:
	.string	"r"
.LC5:
	.string	"input.txt"
	.globl	main
	.type	main, @function
main:
	push	r14	#
	push	r13 # Выделяем пямять под переменные
	push	r12	#
  push	rbp	#
	sub	rsp, 24	
	cmp	edi, 1	# argc != 1
	je	.L42	# if (argc != 1)
	lea	rsi, .LC4[rip]	# "r"
	lea	rdi, .LC5[rip]	# "input.txt"
	mov	r14d, 1	# file = 1
	call	fopen@PLT	# fopen
	lea	rdx, 12[rsp]	# F in fscanf
	lea	rsi, .LC0[rip]	# "%d" in fscanf
	mov	rbp, rax	# F = fopen("input.txt", "r")
	mov	rdi, rax	# &n in fscanf
	xor	eax, eax	
	call	__isoc99_fscanf@PLT	   #
	movsx	rdi, DWORD PTR 12[rsp] #
	mov	r13, rdi	               # malloc(n * sizeof(int))
	sal	rdi, 2	                 #
	call	malloc@PLT	           #
	mov	rdx, rbp	#
	mov	esi, r13d	# for input
	mov	rdi, rax	#
	mov	r12, rax	# from = malloc(n * sizeof(int))
	call	input@PLT	# input(from, n, F)
	mov	rdi, rbp	    #
	call	fclose@PLT	# fclose(F)
.L43:
	movsx	rdi, DWORD PTR 12[rsp]	#
	mov	r13, rdi	                #
	sal	rdi, 2	                  # malloc(n * sizeof(int))
	call	malloc@PLT	            #
	mov	edx, r13d	#
	mov	rdi, r12	# for make
	mov	rsi, rax	#
	mov	rbp, rax	# int *to = malloc(n * sizeof(int))
	call	make@PLT	# make(from, to, n)
	mov	esi, DWORD PTR 12[rsp]	#
	mov	edx, r14d	              #
	mov	rdi, rbp	              # print(to, n, file)
	call	print@PLT	            #
	mov	rdi, r12	  # free(from)
	call	free@PLT	#
	mov	rdi, rbp	  # free(to)
	call	free@PLT	#
	add	rsp, 24	
	xor	eax, eax
	pop	rbp	#
	pop	r12	# высвобождаем память
	pop	r13	#
	pop	r14	#
	ret	
	.size	main, .-main
