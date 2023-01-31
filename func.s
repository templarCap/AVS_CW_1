	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%d"
	.text
	.globl	input
	.type	input, @function
input:
	push	r13	            #
	lea	eax, -1[rsi]	    # 
	push	r12	            #
	lea	r13, 4[rdi+rax*4]	# 
	lea	r12, .LC0[rip]	  # 
	push	rbp	            # void input(int *data, int n, FILE* file)
	mov	rbp, rdx	        # file, tmp102
	push	rbx	            #
	mov	rbx, rdi	        # 
	sub	rsp, 8	          #
	jmp	.L5	              #
.L3:
	mov	rdx, rbx	#
	mov	rsi, r12	# fscanf(file, "%d", &data[i])
	mov	rdi, rbp	#
	xor	eax, eax	#
	call	__isoc99_fscanf@PLT	
	add	rbx, 4	  # ++i
	cmp	rbx, r13	# i < n
	je	.L13	# for (int i = 0; i < n; ++i)
.L5:
	test	rbp, rbp	# file
	jne	.L3	# if (!file)
# ./main.c:7:             scanf("%d", &data[i]);
	mov	rsi, rbx	# scanf("%d", &data[i])
	mov	rdi, r12	#
	xor	eax, eax	#
	add	rbx, 4	#++i
	call	__isoc99_scanf@PLT	
	cmp	rbx, r13	# i < n
	jne	.L5	# for (int i = 0; i < n; ++i)
.L13:
	add	rsp, 8	
	pop	rbx	#
	pop	rbp	#
	pop	r12	# высвобождаем память
	pop	r13	#
	ret	
.L9:
	ret	
	.size	input, .-input
	.globl	make
	.type	make, @function

make:
# ./main.c:16:     for (int i = 0; i < n; ++i, ++j) {
	test	edx, edx	# n
	jle	.L14	#,
	movsx	r8, edx	# _26, n
	xor	ecx, ecx	# ivtmp.26
	jmp	.L20	#
.L29:
	movsx	rdx, eax
	mov	r9d, eax	
	imul	rdx, rdx, 1717986919	# (to[j] > 0 && to[j] % 10 == 4)
	sar	r9d, 31	                # 
	sar	rdx, 34	                # 
	sub	edx, r9d	              # 
	mov	r9d, eax	              # 
	lea	edx, [rdx+rdx*4]	      # 
	add	edx, edx	              #
	sub	r9d, edx	              # 
	cmp	r9d, 4	# if ((to[j] > 0 && to[j] % 10 == 4)) 
	je	.L17	  #
.L28:
	mov	DWORD PTR [rsi+rcx*4], eax	# to[j] /= 2
	add	rcx, 1	#
	cmp	rcx, r8	# for (int i = 0; i < n; ++i, ++j)
	je	.L14	#
.L20:
	mov	eax, DWORD PTR [rdi+rcx*4]	# _to[j] = from[i];
	test	eax, eax	
	jg	.L29	
	je	.L28	
	mov	r9d, eax
	neg	r9d	
	movsx	rdx, r9d	            
	mov	r10d, r9d	              # 
	imul	rdx, rdx, 1717986919	# (to[j] < 0 && (-1 * to[j]) % 10 == 4)
	sar	r10d, 31	              #
	sar	rdx, 34	                # 
	sub	edx, r10d	              #
	lea	edx, [rdx+rdx*4]	      #
	add	edx, edx	              #
	sub	r9d, edx	              #
# ./main.c:18:         if ((to[j] > 0 && to[j] % 10 == 4) || (to[j] < 0 && (-1 * to[j]) % 10 == 4)) {
	cmp	r9d, 4	# if ((to[j] > 0 && to[j] % 10 == 4) || (to[j] < 0 && (-1 * to[j]) % 10 == 4))
	jne	.L28	  #
.L17:
	mov	edx, eax	                  # 
	shr	edx, 31	                    # 
	add	eax, edx	                  # to[j] /= 2
	sar	eax	                        # 
	mov	DWORD PTR [rsi+rcx*4], eax	# 
	add	rcx, 1	# 
	cmp	rcx, r8	# for (int i = 0; i < n; ++i, ++j)
	jne	.L20	  #
.L14:
	ret	
	.size	make, .-make
	.section	.rodata.str1.1
.LC1:
	.string	"%d "
.LC2:
	.string	"w"
.LC3:
	.string	"output.txt"
	.text
	.globl	print
	.type	print, @function
print:
	push	r13	#
	push	r12	# выделяем память
	push	rbp	#
	mov	ebp, esi	# n
	push	rbx	#
	mov	rbx, rdi	# data
	sub	rsp, 8	#,
	test	edx, edx	# if (!file)
	jne	.L31	      #
	jle	.L30	            #
	lea	eax, -1[rsi]	    # for (int i = 0; i < n; ++i)
	lea	rbp, .LC1[rip]	  #
	lea	r12, 4[rdi+rax*4]	#
.L34:
	mov	edx, DWORD PTR [rbx] #
	mov	rsi, rbp	           # printf("%d ", data[i]);
	mov	edi, 1	             #
	xor	eax, eax	           #
	add	rbx, 4	            
	call	__printf_chk@PLT	#
	cmp	rbx, r12	# for (int i = 0; i < n; ++i)
	jne	.L34	    #
.L30:
	add	rsp, 8
	pop	rbx	#
	pop	rbp	# высвобождение памяти
	pop	r12	#
	pop	r13	#
	ret	
.L31:
	lea	rsi, .LC2[rip]	# fopen("output.txt", "w")
	lea	rdi, .LC3[rip]	#
	call	fopen@PLT	#
	mov	r12, rax	# fout = fopen("output.txt", "w")
	test	ebp, ebp	
	jle	.L36	
	lea	eax, -1[rbp]	
	lea	rbp, .LC1[rip]	
	lea	r13, 4[rbx+rax*4]	
.L37:
	mov	ecx, DWORD PTR [rbx]	
	mov	rdx, rbp	#
	mov	esi, 1	  # fprintf(fout, "%d ", data[i])
	mov	rdi, r12	#
	xor	eax, eax	#
	add	rbx, 4	# ++i
	call	__fprintf_chk@PLT	
	cmp	rbx, r13	# i < n
	jne	.L37	
.L36:
	add	rsp, 8	
	mov	rdi, r12
	pop	rbx	#
	pop	rbp	# высвобождение памяти
	pop	r12	#
	pop	r13	#
	jmp	fclose@PLT	# fclose(fout)
	.size	print, .-print
