	.file	"test.mm"
	.section	.rodata
	.align 8
.LCt010:
	.long	0
	.long	1078263808
	.align 8
.LCt017:
	.long	858993459
	.long	1074213683
	.text	
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
	subq	$300, %rsp

	movl	$3, %eax
	movl	%eax, -180(%rbp)

	movl	$6, %eax
	movl	%eax, -184(%rbp)

	movl	$1, %eax
	movl	%eax, -192(%rbp)

	movl	-192(%rbp), %eax
	movl	%eax, -188(%rbp)

	movl	$9, %eax
	movl	%eax, -196(%rbp)

	movl	-188(%rbp), %eax
	cmpl	-196(%rbp), %eax
	jl .L2
	jmp .L3
.L2: 
	movl	$0, %eax
	movl	%eax, -200(%rbp)

	movl 	-200(%rbp), %eax
	imull 	$48, %eax
	movl 	%eax, -208(%rbp)
		movl	-208(%rbp), %eax
	movl	%eax, -204(%rbp)

	movl	$3, %eax
	movl	%eax, -212(%rbp)

	movl 	-212(%rbp), %eax
	imull 	$8, %eax
	movl 	%eax, -220(%rbp)
	movl 	-204(%rbp), %eax
	movl 	-220(%rbp), %edx
	addl 	%edx, %eax
	movl 	%eax, -216(%rbp)
	movq	.LCt010(%rip), %rax
	movq 	%rax, -224(%rbp)
	movl	-216(%rbp), %eax
	leaq	-172(%rbp), %rdx
	leaq	(%rdx,%rax), %rax
	movq	-224(%rbp), %rdx
	movq	%rdx, (%rax)

	jmp .L4
.L3: 
	movl	$0, %eax
	movl	%eax, -232(%rbp)

	movl 	-232(%rbp), %eax
	imull 	$48, %eax
	movl 	%eax, -240(%rbp)
		movl	-240(%rbp), %eax
	movl	%eax, -236(%rbp)

	movl	$5, %eax
	movl	%eax, -244(%rbp)

	movl 	-244(%rbp), %eax
	imull 	$8, %eax
	movl 	%eax, -252(%rbp)
	movl 	-236(%rbp), %eax
	movl 	-252(%rbp), %edx
	addl 	%edx, %eax
	movl 	%eax, -248(%rbp)
	movq	.LCt017(%rip), %rax
	movq 	%rax, -256(%rbp)
	movl	-248(%rbp), %eax
	leaq	-172(%rbp), %rdx
	leaq	(%rdx,%rax), %rax
	movq	-256(%rbp), %rdx
	movq	%rdx, (%rax)

.L4: 
	movl	$0, %eax
	movl	%eax, -268(%rbp)

	movl 	-268(%rbp), %eax
	imull 	$48, %eax
	movl 	%eax, -276(%rbp)
		movl	-276(%rbp), %eax
	movl	%eax, -272(%rbp)

	movl	$3, %eax
	movl	%eax, -280(%rbp)

	movl 	-280(%rbp), %eax
	imull 	$8, %eax
	movl 	%eax, -288(%rbp)
	movl 	-272(%rbp), %eax
	movl 	-288(%rbp), %edx
	addl 	%edx, %eax
	movl 	%eax, -284(%rbp)
	leaq	-172(%rbp), %rdx
	movl	-284(%rbp), %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -292(%rbp)

	movl 	-292(%rbp), %eax
	movsd 	-292(%rbp), %xmm0
	cvtsd2ss	%xmm0, %xmm0
	call	printFlt
	movl	%eax, -296(%rbp)
	movl	$0, %eax
	movl	%eax, -300(%rbp)

	movl	-300(%rbp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident		"Compiled by 15CS10045 - swastik"
	.section	.note.GNU-stack,"",@progbits
