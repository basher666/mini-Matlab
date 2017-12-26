	.file	"test.mm"
	.globl	aa
	.data
	.align 8
	.type	aa, @object
	.size	aa, 8
aa:
	.long	343597384
	.long	1073956782
	.globl	t000
	.data
	.align 8
	.type	t000, @object
	.size	t000, 8
t000:
	.long	343597384
	.long	1073956782
	.globl	g_i
	.data
	.align 4
	.type	g_i, @object
	.size	g_i, 4
g_i:
	.long	5202
	.globl	t001
	.data
	.align 4
	.type	t001, @object
	.size	t001, 4
t001:
	.long	5202
	.section	.rodata
.LC0:
	.string	"\n an indirect string printing example \n"
.LC1:
	.string	"\n printing local double d = "
.LC2:
	.string	"\n printing global double aa = "
.LC3:
	.string	"\n"
.LC4:
	.string	"\n printing global int g_i = "
.LC5:
	.string	"\n printing local int ->"
.LC6:
	.string	"\n"
.LC7:
	.string	"\t"
.LC8:
	.string	"\n"
.LC9:
	.string	"i="
.LC10:
	.string	"j="
	.align 8
.LCt002:
	.long	3435973837
	.long	1073007820
	.align 8
.LCt003:
	.long	1717986918
	.long	1073899110
	.align 8
.LCt004:
	.long	1717986918
	.long	1074423398
	.align 8
.LCt005:
	.long	858993459
	.long	1074869043
	.align 8
.LCt006:
	.long	858993459
	.long	1075131187
	.align 8
.LCt007:
	.long	858993459
	.long	1075393331
	.align 8
.LCt008:
	.long	3951369912
	.long	1077295185
	.text	
	movq	t000(%rip), %rax
	movq 	%rax, 0(%rbp)
	movq	0(%rbp), %rax
	movq	%rax, 0(%rbp)
	movq	%rax, aa(%rip)
	movl	$5202, %eax
	movl	%eax, 0(%rbp)
	movq	%rax, t001(%rip)
	movl	0(%rbp), %eax
	movl	%eax, 0(%rbp)
	movq	%rax, g_i(%rip)
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
	subq	$352, %rsp

	movl	$2, %eax
	movl	%eax, -80(%rbp)
	movq	%rax, t000(%rip)
	movl	$3, %eax
	movl	%eax, -84(%rbp)
	movq	%rax, t001(%rip)
	movq	.LCt002(%rip), %rax
	movq 	%rax, -88(%rbp)
	movq	.LCt003(%rip), %rax
	movq 	%rax, -96(%rbp)
	movq	.LCt004(%rip), %rax
	movq 	%rax, -104(%rbp)
	movq	.LCt005(%rip), %rax
	movq 	%rax, -112(%rbp)
	movq	.LCt006(%rip), %rax
	movq 	%rax, -120(%rbp)
	movq	.LCt007(%rip), %rax
	movq 	%rax, -128(%rbp)
	movq	-88(%rbp), %rdx
	movq	%rdx, -72(%rbp)

	movq	-96(%rbp), %rdx
	movq	%rdx, -64(%rbp)

	movq	-104(%rbp), %rdx
	movq	%rdx, -56(%rbp)

	movq	-112(%rbp), %rdx
	movq	%rdx, -48(%rbp)

	movq	-120(%rbp), %rdx
	movq	%rdx, -40(%rbp)

	movq	-128(%rbp), %rdx
	movq	%rdx, -32(%rbp)

	movq	.LCt008(%rip), %rax
	movq 	%rax, -144(%rbp)
	movq	-144(%rbp), %rax
	movq	%rax, -136(%rbp)

	movq 	$.LC0, -156(%rbp)
	movq	-156(%rbp), %rax
	movq	%rax, -152(%rbp)
movl	-156(%rbp), %eax
	movl	%eax, -152(%rbp)

	movl 	-152(%rbp), %eax
	movq 	-152(%rbp), %rdi
	call	printStr
	movl	%eax, -164(%rbp)
	movq 	$.LC1, -168(%rbp)
	movl 	-168(%rbp), %eax
	movq 	-168(%rbp), %rdi
	call	printStr
	movl	%eax, -172(%rbp)
	movl 	-136(%rbp), %eax
	movsd 	-136(%rbp), %xmm0
	cvtsd2ss	%xmm0, %xmm0
	call	printFlt
	movl	%eax, -180(%rbp)
	movq 	$.LC2, -184(%rbp)
	movl 	-184(%rbp), %eax
	movq 	-184(%rbp), %rdi
	call	printStr
	movl	%eax, -188(%rbp)
	movl 	-192(%rbp), %eax
	movsd 	aa(%rip), %xmm0
	cvtsd2ss	%xmm0, %xmm0
	call	printFlt
	movl	%eax, -196(%rbp)
	movq 	$.LC3, -200(%rbp)
	movl 	-200(%rbp), %eax
	movq 	-200(%rbp), %rdi
	call	printStr
	movl	%eax, -204(%rbp)
	movq 	$.LC4, -208(%rbp)
	movl 	-208(%rbp), %eax
	movq 	-208(%rbp), %rdi
	call	printStr
	movl	%eax, -212(%rbp)
	movl 	-220(%rbp), %eax
	movl 	g_i(%rip), %edi
	call	printInt
	movl	%eax, -224(%rbp)
	movq 	$.LC5, -228(%rbp)
	movl 	-228(%rbp), %eax
	movq 	-228(%rbp), %rdi
	call	printStr
	movl	%eax, -232(%rbp)
	movl	$23, %eax
	movl	%eax, -236(%rbp)

	movl 	-236(%rbp), %eax
	movq 	-236(%rbp), %rdi
	call	printInt
	movl	%eax, -240(%rbp)
	movq 	$.LC6, -244(%rbp)
	movl 	-244(%rbp), %eax
	movq 	-244(%rbp), %rdi
	call	printStr
	movl	%eax, -248(%rbp)
	movl	$0, %eax
	movl	%eax, -256(%rbp)

	movl	-256(%rbp), %eax
	movl	%eax, -252(%rbp)

	movl	$0, %eax
	movl	%eax, -264(%rbp)

	movl	-264(%rbp), %eax
	movl	%eax, -260(%rbp)

	movl	$0, %eax
	movl	%eax, -268(%rbp)

	movl	-268(%rbp), %eax
	movl	%eax, -252(%rbp)

.L2: 
	movl	$2, %eax
	movl	%eax, -272(%rbp)

	movl	-252(%rbp), %eax
	cmpl	-272(%rbp), %eax
	jl .L4
	jmp .L9
.L3: 
	movl	-252(%rbp), %eax
	movl	%eax, -276(%rbp)

		movl	-276(%rbp), %eax 
	addl 	$1, %eax
	movl	%eax, -252(%rbp)

	jmp .L2
.L4: 
	movl	$0, %eax
	movl	%eax, -280(%rbp)

	movl	-280(%rbp), %eax
	movl	%eax, -260(%rbp)

.L5: 
	movl	$3, %eax
	movl	%eax, -284(%rbp)

	movl	-260(%rbp), %eax
	cmpl	-284(%rbp), %eax
	jl .L7
	jmp .L8
.L6: 
	movl	-260(%rbp), %eax
	movl	%eax, -288(%rbp)

		movl	-288(%rbp), %eax 
	addl 	$1, %eax
	movl	%eax, -260(%rbp)

	jmp .L5
.L7: 
	movl 	-252(%rbp), %eax
	imull 	$24, %eax
	movl 	%eax, -296(%rbp)
		movl	-296(%rbp), %eax
	movl	%eax, -292(%rbp)

	movl 	-260(%rbp), %eax
	imull 	$8, %eax
	movl 	%eax, -304(%rbp)
	movl 	-292(%rbp), %eax
	movl 	-304(%rbp), %edx
	addl 	%edx, %eax
	movl 	%eax, -300(%rbp)
	leaq	-72(%rbp), %rdx
	movl	-300(%rbp), %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -308(%rbp)

	movl 	-308(%rbp), %eax
	movsd 	-308(%rbp), %xmm0
	cvtsd2ss	%xmm0, %xmm0
	call	printFlt
	movl	%eax, -312(%rbp)
	movq 	$.LC7, -316(%rbp)
	movl 	-316(%rbp), %eax
	movq 	-316(%rbp), %rdi
	call	printStr
	movl	%eax, -320(%rbp)
	jmp .L6
.L8: 
	movq 	$.LC8, -324(%rbp)
	movl 	-324(%rbp), %eax
	movq 	-324(%rbp), %rdi
	call	printStr
	movl	%eax, -328(%rbp)
	jmp .L3
.L9: 
	movq 	$.LC9, -332(%rbp)
	movl 	-332(%rbp), %eax
	movq 	-332(%rbp), %rdi
	call	printStr
	movl	%eax, -336(%rbp)
	movl 	-252(%rbp), %eax
	movq 	-252(%rbp), %rdi
	call	printInt
	movl	%eax, -340(%rbp)
	movq 	$.LC10, -344(%rbp)
	movl 	-344(%rbp), %eax
	movq 	-344(%rbp), %rdi
	call	printStr
	movl	%eax, -348(%rbp)
	movl 	-260(%rbp), %eax
	movq 	-260(%rbp), %rdi
	call	printInt
	movl	%eax, -352(%rbp)
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident		"Compiled by 15CS10045 - swastik"
	.section	.note.GNU-stack,"",@progbits
