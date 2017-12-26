	.file	"test.mm"
	.comm	a,4,4
	.globl	b
	.data
	.align 4
	.type	b, @object
	.size	b, 4
b:
	.long	1
	.globl	t000
	.data
	.align 4
	.type	t000, @object
	.size	t000, 4
t000:
	.long	1
	.comm	c,1,1
	.globl	d
	.type	d, @object
	.size	d, 1
d:
	.byte	0
	.globl	t001
	.type	t001, @object
	.size	t001, 1
t001:
	.byte	0
	.section	.rodata
.LC0:
	.string	"enter the 2*2 matrix elements \n"
.LC1:
	.string	"\n printing the entered matrix \n"
.LC2:
	.string	"\t"
.LC3:
	.string	"\n"
	.text	
	movl	$1, %eax
	movl	%eax, 0(%rbp)
	movq	%rax, t000(%rip)
	movl	0(%rbp), %eax
	movl	%eax, 0(%rbp)
	movq	%rax, b(%rip)
	movb	$0, 0(%rbp)
	movl	0(%rbp), %eax
	movl	%eax, 0(%rbp)
	movq	%rax, d(%rip)
	.globl	main
	.type	main, @function
main: 
.LFB0:
	.cfi_startproc
	pushq 	%rbp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movq 	%rsp, %rbp
	.cfi_def_cfa_register 5
	subq	$232, %rsp

	movl	$2, %eax
	movl	%eax, -68(%rbp)
	movq	%rax, t000(%rip)
	movl	$2, %eax
	movl	%eax, -72(%rbp)
	movq	%rax, t001(%rip)
	movq 	$.LC0, -88(%rbp)
	movl 	-88(%rbp), %eax
	movq 	-88(%rbp), %rdi
	call	printStr
	movl	%eax, -92(%rbp)
	movl	$0, %eax
	movl	%eax, -104(%rbp)

	movl	-104(%rbp), %eax
	movl	%eax, -76(%rbp)

.L2: 
	movl	$2, %eax
	movl	%eax, -108(%rbp)

	movl	-76(%rbp), %eax
	cmpl	-108(%rbp), %eax
	jl .L4
	jmp .L8
.L3: 
	movl	-76(%rbp), %eax
	movl	%eax, -112(%rbp)

		movl	-112(%rbp), %eax 
	addl 	$1, %eax
	movl	%eax, -76(%rbp)

	jmp .L2
.L4: 
	movl	$0, %eax
	movl	%eax, -116(%rbp)

	movl	-116(%rbp), %eax
	movl	%eax, -80(%rbp)

.L5: 
	movl	$2, %eax
	movl	%eax, -120(%rbp)

	movl	-80(%rbp), %eax
	cmpl	-120(%rbp), %eax
	jl .L7
	jmp .L3
.L6: 
	movl	-80(%rbp), %eax
	movl	%eax, -124(%rbp)

		movl	-124(%rbp), %eax 
	addl 	$1, %eax
	movl	%eax, -80(%rbp)

	jmp .L5
.L7: 
	leaq	-96(%rbp), %rax
	movq 	%rax, -132(%rbp)
	movl 	-132(%rbp), %eax
	movq 	-132(%rbp), %rdi
	call	readFlt
	movl	%eax, -136(%rbp)
	movl 	-76(%rbp), %eax
	imull 	$16, %eax
	movl 	%eax, -144(%rbp)
		movl	-144(%rbp), %eax
	movl	%eax, -140(%rbp)

	movl 	-80(%rbp), %eax
	imull 	$8, %eax
	movl 	%eax, -152(%rbp)
	movl 	-140(%rbp), %eax
	movl 	-152(%rbp), %edx
	addl 	%edx, %eax
	movl 	%eax, -148(%rbp)
	movl	-148(%rbp), %eax
	leaq	-60(%rbp), %rdx
	leaq	(%rdx,%rax), %rax
	movq	-96(%rbp), %rdx
	movq	%rdx, (%rax)

	jmp .L6
	jmp .L3
.L8: 
	movq 	$.LC1, -156(%rbp)
	movl 	-156(%rbp), %eax
	movq 	-156(%rbp), %rdi
	call	printStr
	movl	%eax, -160(%rbp)
	movl	$0, %eax
	movl	%eax, -164(%rbp)

	movl	-164(%rbp), %eax
	movl	%eax, -76(%rbp)

.L9: 
	movl	$2, %eax
	movl	%eax, -168(%rbp)

	movl	-76(%rbp), %eax
	cmpl	-168(%rbp), %eax
	jl .L11
	jmp .L16
.L10: 
	movl	-76(%rbp), %eax
	movl	%eax, -172(%rbp)

		movl	-172(%rbp), %eax 
	addl 	$1, %eax
	movl	%eax, -76(%rbp)

	jmp .L9
.L11: 
	movl	$0, %eax
	movl	%eax, -176(%rbp)

	movl	-176(%rbp), %eax
	movl	%eax, -80(%rbp)

.L12: 
	movl	$2, %eax
	movl	%eax, -180(%rbp)

	movl	-80(%rbp), %eax
	cmpl	-180(%rbp), %eax
	jl .L14
	jmp .L15
.L13: 
	movl	-80(%rbp), %eax
	movl	%eax, -184(%rbp)

		movl	-184(%rbp), %eax 
	addl 	$1, %eax
	movl	%eax, -80(%rbp)

	jmp .L12
.L14: 
	movl 	-76(%rbp), %eax
	imull 	$16, %eax
	movl 	%eax, -196(%rbp)
		movl	-196(%rbp), %eax
	movl	%eax, -192(%rbp)

	movl 	-80(%rbp), %eax
	imull 	$8, %eax
	movl 	%eax, -204(%rbp)
	movl 	-192(%rbp), %eax
	movl 	-204(%rbp), %edx
	addl 	%edx, %eax
	movl 	%eax, -200(%rbp)
	leaq	-60(%rbp), %rdx
	movl	-200(%rbp), %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -208(%rbp)

	movl 	-208(%rbp), %eax
	movsd 	-208(%rbp), %xmm0
	cvtsd2ss	%xmm0, %xmm0
	call	printFlt
	movl	%eax, -212(%rbp)
	movq 	$.LC2, -216(%rbp)
	movl 	-216(%rbp), %eax
	movq 	-216(%rbp), %rdi
	call	printStr
	movl	%eax, -220(%rbp)
	jmp .L13
.L15: 
	movq 	$.LC3, -224(%rbp)
	movl 	-224(%rbp), %eax
	movq 	-224(%rbp), %rdi
	call	printStr
	movl	%eax, -228(%rbp)
	jmp .L10
.L16: 
	movl	$0, %eax
	movl	%eax, -232(%rbp)

	movl	-232(%rbp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident		"Compiled by 15CS10045 - swastik"
	.section	.note.GNU-stack,"",@progbits
