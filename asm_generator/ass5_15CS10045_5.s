	.file	"test.mm"
	.section	.rodata
.LC0:
	.string	"matrix 1 \n"
.LC1:
	.string	"\t"
.LC2:
	.string	"\n"
.LC3:
	.string	"matrix 2 \n"
.LC4:
	.string	"\t"
.LC5:
	.string	"\n"
.LC6:
	.string	"matrix m_add = m1+m2 \n"
.LC7:
	.string	"\t"
.LC8:
	.string	"\n"
.LC9:
	.string	"matrix m_sub = m1-m2 \n"
.LC10:
	.string	"\t"
.LC11:
	.string	"\n"
.LC12:
	.string	"matrix m_trans = m1 .' \n"
.LC13:
	.string	"\t"
.LC14:
	.string	"\n"
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
.LCt010:
	.long	1717986918
	.long	1078273638
	.align 8
.LCt011:
	.long	3435973837
	.long	1077300428
	.align 8
.LCt012:
	.long	858993459
	.long	1075131187
	.align 8
.LCt013:
	.long	2576980378
	.long	1084316313
	.align 8
.LCt014:
	.long	858993459
	.long	1075131187
	.align 8
.LCt015:
	.long	858993459
	.long	1070805811
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
	subq	$1268, %rsp

	movl	$2, %eax
	movl	%eax, -84(%rbp)

	movl	$3, %eax
	movl	%eax, -88(%rbp)

	movq	.LCt002(%rip), %rax
	movq 	%rax, -92(%rbp)
	movq	.LCt003(%rip), %rax
	movq 	%rax, -100(%rbp)
	movq	.LCt004(%rip), %rax
	movq 	%rax, -108(%rbp)
	movq	.LCt005(%rip), %rax
	movq 	%rax, -116(%rbp)
	movq	.LCt006(%rip), %rax
	movq 	%rax, -124(%rbp)
	movq	.LCt007(%rip), %rax
	movq 	%rax, -132(%rbp)
	movq	-92(%rbp), %rdx
	movq	%rdx, -76(%rbp)

	movq	-100(%rbp), %rdx
	movq	%rdx, -68(%rbp)

	movq	-108(%rbp), %rdx
	movq	%rdx, -60(%rbp)

	movq	-116(%rbp), %rdx
	movq	%rdx, -52(%rbp)

	movq	-124(%rbp), %rdx
	movq	%rdx, -44(%rbp)

	movq	-132(%rbp), %rdx
	movq	%rdx, -36(%rbp)

	movl	$2, %eax
	movl	%eax, -196(%rbp)

	movl	$3, %eax
	movl	%eax, -200(%rbp)

	movq	.LCt010(%rip), %rax
	movq 	%rax, -204(%rbp)
	movq	.LCt011(%rip), %rax
	movq 	%rax, -212(%rbp)
	movq	.LCt012(%rip), %rax
	movq 	%rax, -220(%rbp)
	movq	.LCt013(%rip), %rax
	movq 	%rax, -228(%rbp)
	movq	.LCt014(%rip), %rax
	movq 	%rax, -236(%rbp)
	movq	.LCt015(%rip), %rax
	movq 	%rax, -244(%rbp)
	movq	-204(%rbp), %rdx
	movq	%rdx, -188(%rbp)

	movq	-212(%rbp), %rdx
	movq	%rdx, -180(%rbp)

	movq	-220(%rbp), %rdx
	movq	%rdx, -172(%rbp)

	movq	-228(%rbp), %rdx
	movq	%rdx, -164(%rbp)

	movq	-236(%rbp), %rdx
	movq	%rdx, -156(%rbp)

	movq	-244(%rbp), %rdx
	movq	%rdx, -148(%rbp)

	movl	$2, %eax
	movl	%eax, -308(%rbp)

	movl	$3, %eax
	movl	%eax, -312(%rbp)

	movl	$2, %eax
	movl	%eax, -372(%rbp)

	movl	$3, %eax
	movl	%eax, -376(%rbp)

	movl	$3, %eax
	movl	%eax, -436(%rbp)

	movl	$2, %eax
	movl	%eax, -440(%rbp)

	movq 	$.LC0, -456(%rbp)
	movl 	-456(%rbp), %eax
	movq 	-456(%rbp), %rdi
	call	printStr
	movl	%eax, -460(%rbp)
	movl	$0, %eax
	movl	%eax, -464(%rbp)

	movl	-464(%rbp), %eax
	movl	%eax, -444(%rbp)

.L2: 
	movl	$2, %eax
	movl	%eax, -468(%rbp)

	movl	-444(%rbp), %eax
	cmpl	-468(%rbp), %eax
	jl .L4
	jmp .L9
.L3: 
	movl	-444(%rbp), %eax
	movl	%eax, -472(%rbp)

		movl	-472(%rbp), %eax 
	addl 	$1, %eax
	movl	%eax, -444(%rbp)

	jmp .L2
.L4: 
	movl	$0, %eax
	movl	%eax, -476(%rbp)

	movl	-476(%rbp), %eax
	movl	%eax, -448(%rbp)

.L5: 
	movl	$3, %eax
	movl	%eax, -480(%rbp)

	movl	-448(%rbp), %eax
	cmpl	-480(%rbp), %eax
	jl .L7
	jmp .L8
.L6: 
	movl	-448(%rbp), %eax
	movl	%eax, -484(%rbp)

		movl	-484(%rbp), %eax 
	addl 	$1, %eax
	movl	%eax, -448(%rbp)

	jmp .L5
.L7: 
	movl 	-444(%rbp), %eax
	imull 	$24, %eax
	movl 	%eax, -496(%rbp)
		movl	-496(%rbp), %eax
	movl	%eax, -492(%rbp)

	movl 	-448(%rbp), %eax
	imull 	$8, %eax
	movl 	%eax, -504(%rbp)
	movl 	-492(%rbp), %eax
	movl 	-504(%rbp), %edx
	addl 	%edx, %eax
	movl 	%eax, -500(%rbp)
	leaq	-76(%rbp), %rdx
	movl	-500(%rbp), %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -508(%rbp)

	movl 	-508(%rbp), %eax
	movsd 	-508(%rbp), %xmm0
	cvtsd2ss	%xmm0, %xmm0
	call	printFlt
	movl	%eax, -512(%rbp)
	movq 	$.LC1, -516(%rbp)
	movl 	-516(%rbp), %eax
	movq 	-516(%rbp), %rdi
	call	printStr
	movl	%eax, -520(%rbp)
	jmp .L6
.L8: 
	movq 	$.LC2, -524(%rbp)
	movl 	-524(%rbp), %eax
	movq 	-524(%rbp), %rdi
	call	printStr
	movl	%eax, -528(%rbp)
	jmp .L3
.L9: 
	movq 	$.LC3, -532(%rbp)
	movl 	-532(%rbp), %eax
	movq 	-532(%rbp), %rdi
	call	printStr
	movl	%eax, -536(%rbp)
	movl	$0, %eax
	movl	%eax, -540(%rbp)

	movl	-540(%rbp), %eax
	movl	%eax, -444(%rbp)

.L10: 
	movl	$2, %eax
	movl	%eax, -544(%rbp)

	movl	-444(%rbp), %eax
	cmpl	-544(%rbp), %eax
	jl .L12
	jmp .L17
.L11: 
	movl	-444(%rbp), %eax
	movl	%eax, -548(%rbp)

		movl	-548(%rbp), %eax 
	addl 	$1, %eax
	movl	%eax, -444(%rbp)

	jmp .L10
.L12: 
	movl	$0, %eax
	movl	%eax, -552(%rbp)

	movl	-552(%rbp), %eax
	movl	%eax, -448(%rbp)

.L13: 
	movl	$3, %eax
	movl	%eax, -556(%rbp)

	movl	-448(%rbp), %eax
	cmpl	-556(%rbp), %eax
	jl .L15
	jmp .L16
.L14: 
	movl	-448(%rbp), %eax
	movl	%eax, -560(%rbp)

		movl	-560(%rbp), %eax 
	addl 	$1, %eax
	movl	%eax, -448(%rbp)

	jmp .L13
.L15: 
	movl 	-444(%rbp), %eax
	imull 	$24, %eax
	movl 	%eax, -568(%rbp)
		movl	-568(%rbp), %eax
	movl	%eax, -564(%rbp)

	movl 	-448(%rbp), %eax
	imull 	$8, %eax
	movl 	%eax, -576(%rbp)
	movl 	-564(%rbp), %eax
	movl 	-576(%rbp), %edx
	addl 	%edx, %eax
	movl 	%eax, -572(%rbp)
	leaq	-188(%rbp), %rdx
	movl	-572(%rbp), %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -580(%rbp)

	movl 	-580(%rbp), %eax
	movsd 	-580(%rbp), %xmm0
	cvtsd2ss	%xmm0, %xmm0
	call	printFlt
	movl	%eax, -584(%rbp)
	movq 	$.LC4, -588(%rbp)
	movl 	-588(%rbp), %eax
	movq 	-588(%rbp), %rdi
	call	printStr
	movl	%eax, -592(%rbp)
	jmp .L14
.L16: 
	movq 	$.LC5, -596(%rbp)
	movl 	-596(%rbp), %eax
	movq 	-596(%rbp), %rdi
	call	printStr
	movl	%eax, -600(%rbp)
	jmp .L11
.L17: 
		movq	-76(%rbp), %rax
	movq	%rax, -652(%rbp)
	movq	-68(%rbp), %rax
	movq	%rax, -644(%rbp)
	movq	-60(%rbp), %rax
	movq	%rax, -636(%rbp)
	movq	-52(%rbp), %rax
	movq	%rax, -628(%rbp)
	movq	-44(%rbp), %rax
	movq	%rax, -620(%rbp)
	movq	-36(%rbp), %rax
	movq	%rax, -612(%rbp)
	movq	-28(%rbp), %rax
	movq	%rax, -604(%rbp)

		movq	-188(%rbp), %rax
	movq	%rax, -708(%rbp)
	movq	-180(%rbp), %rax
	movq	%rax, -700(%rbp)
	movq	-172(%rbp), %rax
	movq	%rax, -692(%rbp)
	movq	-164(%rbp), %rax
	movq	%rax, -684(%rbp)
	movq	-156(%rbp), %rax
	movq	%rax, -676(%rbp)
	movq	-148(%rbp), %rax
	movq	%rax, -668(%rbp)
	movq	-140(%rbp), %rax
	movq	%rax, -660(%rbp)

	leaq	-652(%rbp), %rdx
	movl	$0, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -772(%rbp)

	leaq	-708(%rbp), %rdx
	movl	$0, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -780(%rbp)

		movsd	-772(%rbp), %xmm0
	movsd	-780(%rbp), %xmm1
	addsd	%xmm0, %xmm1
	movsd	%xmm1, -788(%rbp)

	movl	$0, %eax
	leaq	-764(%rbp), %rdx
	leaq	(%rdx,%rax), %rax
	movq	-788(%rbp), %rdx
	movq	%rdx, (%rax)

	leaq	-652(%rbp), %rdx
	movl	$8, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -772(%rbp)

	leaq	-708(%rbp), %rdx
	movl	$8, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -780(%rbp)

		movsd	-772(%rbp), %xmm0
	movsd	-780(%rbp), %xmm1
	addsd	%xmm0, %xmm1
	movsd	%xmm1, -788(%rbp)

	movl	$8, %eax
	leaq	-764(%rbp), %rdx
	leaq	(%rdx,%rax), %rax
	movq	-788(%rbp), %rdx
	movq	%rdx, (%rax)

	leaq	-652(%rbp), %rdx
	movl	$16, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -772(%rbp)

	leaq	-708(%rbp), %rdx
	movl	$16, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -780(%rbp)

		movsd	-772(%rbp), %xmm0
	movsd	-780(%rbp), %xmm1
	addsd	%xmm0, %xmm1
	movsd	%xmm1, -788(%rbp)

	movl	$16, %eax
	leaq	-764(%rbp), %rdx
	leaq	(%rdx,%rax), %rax
	movq	-788(%rbp), %rdx
	movq	%rdx, (%rax)

	leaq	-652(%rbp), %rdx
	movl	$24, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -772(%rbp)

	leaq	-708(%rbp), %rdx
	movl	$24, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -780(%rbp)

		movsd	-772(%rbp), %xmm0
	movsd	-780(%rbp), %xmm1
	addsd	%xmm0, %xmm1
	movsd	%xmm1, -788(%rbp)

	movl	$24, %eax
	leaq	-764(%rbp), %rdx
	leaq	(%rdx,%rax), %rax
	movq	-788(%rbp), %rdx
	movq	%rdx, (%rax)

	leaq	-652(%rbp), %rdx
	movl	$32, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -772(%rbp)

	leaq	-708(%rbp), %rdx
	movl	$32, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -780(%rbp)

		movsd	-772(%rbp), %xmm0
	movsd	-780(%rbp), %xmm1
	addsd	%xmm0, %xmm1
	movsd	%xmm1, -788(%rbp)

	movl	$32, %eax
	leaq	-764(%rbp), %rdx
	leaq	(%rdx,%rax), %rax
	movq	-788(%rbp), %rdx
	movq	%rdx, (%rax)

	leaq	-652(%rbp), %rdx
	movl	$40, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -772(%rbp)

	leaq	-708(%rbp), %rdx
	movl	$40, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -780(%rbp)

		movsd	-772(%rbp), %xmm0
	movsd	-780(%rbp), %xmm1
	addsd	%xmm0, %xmm1
	movsd	%xmm1, -788(%rbp)

	movl	$40, %eax
	leaq	-764(%rbp), %rdx
	leaq	(%rdx,%rax), %rax
	movq	-788(%rbp), %rdx
	movq	%rdx, (%rax)

	leaq	-652(%rbp), %rdx
	movl	$48, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -772(%rbp)

	leaq	-708(%rbp), %rdx
	movl	$48, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -780(%rbp)

		movsd	-772(%rbp), %xmm0
	movsd	-780(%rbp), %xmm1
	addsd	%xmm0, %xmm1
	movsd	%xmm1, -788(%rbp)

	movl	$48, %eax
	leaq	-764(%rbp), %rdx
	leaq	(%rdx,%rax), %rax
	movq	-788(%rbp), %rdx
	movq	%rdx, (%rax)

		movq	-764(%rbp), %rax
	movq	%rax, -300(%rbp)
	movq	-756(%rbp), %rax
	movq	%rax, -292(%rbp)
	movq	-748(%rbp), %rax
	movq	%rax, -284(%rbp)
	movq	-740(%rbp), %rax
	movq	%rax, -276(%rbp)
	movq	-732(%rbp), %rax
	movq	%rax, -268(%rbp)
	movq	-724(%rbp), %rax
	movq	%rax, -260(%rbp)
	movq	-716(%rbp), %rax
	movq	%rax, -252(%rbp)

	movq 	$.LC6, -796(%rbp)
	movl 	-796(%rbp), %eax
	movq 	-796(%rbp), %rdi
	call	printStr
	movl	%eax, -800(%rbp)
	movl	$0, %eax
	movl	%eax, -804(%rbp)

	movl	-804(%rbp), %eax
	movl	%eax, -444(%rbp)

.L18: 
	movl	$2, %eax
	movl	%eax, -808(%rbp)

	movl	-444(%rbp), %eax
	cmpl	-808(%rbp), %eax
	jl .L20
	jmp .L25
.L19: 
	movl	-444(%rbp), %eax
	movl	%eax, -812(%rbp)

		movl	-812(%rbp), %eax 
	addl 	$1, %eax
	movl	%eax, -444(%rbp)

	jmp .L18
.L20: 
	movl	$0, %eax
	movl	%eax, -816(%rbp)

	movl	-816(%rbp), %eax
	movl	%eax, -448(%rbp)

.L21: 
	movl	$3, %eax
	movl	%eax, -820(%rbp)

	movl	-448(%rbp), %eax
	cmpl	-820(%rbp), %eax
	jl .L23
	jmp .L24
.L22: 
	movl	-448(%rbp), %eax
	movl	%eax, -824(%rbp)

		movl	-824(%rbp), %eax 
	addl 	$1, %eax
	movl	%eax, -448(%rbp)

	jmp .L21
.L23: 
	movl 	-444(%rbp), %eax
	imull 	$24, %eax
	movl 	%eax, -832(%rbp)
		movl	-832(%rbp), %eax
	movl	%eax, -828(%rbp)

	movl 	-448(%rbp), %eax
	imull 	$8, %eax
	movl 	%eax, -840(%rbp)
	movl 	-828(%rbp), %eax
	movl 	-840(%rbp), %edx
	addl 	%edx, %eax
	movl 	%eax, -836(%rbp)
	leaq	-300(%rbp), %rdx
	movl	-836(%rbp), %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -844(%rbp)

	movl 	-844(%rbp), %eax
	movsd 	-844(%rbp), %xmm0
	cvtsd2ss	%xmm0, %xmm0
	call	printFlt
	movl	%eax, -848(%rbp)
	movq 	$.LC7, -852(%rbp)
	movl 	-852(%rbp), %eax
	movq 	-852(%rbp), %rdi
	call	printStr
	movl	%eax, -856(%rbp)
	jmp .L22
.L24: 
	movq 	$.LC8, -860(%rbp)
	movl 	-860(%rbp), %eax
	movq 	-860(%rbp), %rdi
	call	printStr
	movl	%eax, -864(%rbp)
	jmp .L19
.L25: 
		movq	-76(%rbp), %rax
	movq	%rax, -916(%rbp)
	movq	-68(%rbp), %rax
	movq	%rax, -908(%rbp)
	movq	-60(%rbp), %rax
	movq	%rax, -900(%rbp)
	movq	-52(%rbp), %rax
	movq	%rax, -892(%rbp)
	movq	-44(%rbp), %rax
	movq	%rax, -884(%rbp)
	movq	-36(%rbp), %rax
	movq	%rax, -876(%rbp)
	movq	-28(%rbp), %rax
	movq	%rax, -868(%rbp)

		movq	-188(%rbp), %rax
	movq	%rax, -972(%rbp)
	movq	-180(%rbp), %rax
	movq	%rax, -964(%rbp)
	movq	-172(%rbp), %rax
	movq	%rax, -956(%rbp)
	movq	-164(%rbp), %rax
	movq	%rax, -948(%rbp)
	movq	-156(%rbp), %rax
	movq	%rax, -940(%rbp)
	movq	-148(%rbp), %rax
	movq	%rax, -932(%rbp)
	movq	-140(%rbp), %rax
	movq	%rax, -924(%rbp)

	leaq	-916(%rbp), %rdx
	movl	$0, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -1036(%rbp)

	leaq	-972(%rbp), %rdx
	movl	$0, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -1044(%rbp)

		movsd	-1036(%rbp), %xmm1
	movsd	-1044(%rbp), %xmm0
	subsd	%xmm0, %xmm1
	movsd	%xmm1, -1052(%rbp)

	movl	$0, %eax
	leaq	-1028(%rbp), %rdx
	leaq	(%rdx,%rax), %rax
	movq	-1052(%rbp), %rdx
	movq	%rdx, (%rax)

	leaq	-916(%rbp), %rdx
	movl	$8, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -1036(%rbp)

	leaq	-972(%rbp), %rdx
	movl	$8, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -1044(%rbp)

		movsd	-1036(%rbp), %xmm1
	movsd	-1044(%rbp), %xmm0
	subsd	%xmm0, %xmm1
	movsd	%xmm1, -1052(%rbp)

	movl	$8, %eax
	leaq	-1028(%rbp), %rdx
	leaq	(%rdx,%rax), %rax
	movq	-1052(%rbp), %rdx
	movq	%rdx, (%rax)

	leaq	-916(%rbp), %rdx
	movl	$16, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -1036(%rbp)

	leaq	-972(%rbp), %rdx
	movl	$16, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -1044(%rbp)

		movsd	-1036(%rbp), %xmm1
	movsd	-1044(%rbp), %xmm0
	subsd	%xmm0, %xmm1
	movsd	%xmm1, -1052(%rbp)

	movl	$16, %eax
	leaq	-1028(%rbp), %rdx
	leaq	(%rdx,%rax), %rax
	movq	-1052(%rbp), %rdx
	movq	%rdx, (%rax)

	leaq	-916(%rbp), %rdx
	movl	$24, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -1036(%rbp)

	leaq	-972(%rbp), %rdx
	movl	$24, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -1044(%rbp)

		movsd	-1036(%rbp), %xmm1
	movsd	-1044(%rbp), %xmm0
	subsd	%xmm0, %xmm1
	movsd	%xmm1, -1052(%rbp)

	movl	$24, %eax
	leaq	-1028(%rbp), %rdx
	leaq	(%rdx,%rax), %rax
	movq	-1052(%rbp), %rdx
	movq	%rdx, (%rax)

	leaq	-916(%rbp), %rdx
	movl	$32, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -1036(%rbp)

	leaq	-972(%rbp), %rdx
	movl	$32, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -1044(%rbp)

		movsd	-1036(%rbp), %xmm1
	movsd	-1044(%rbp), %xmm0
	subsd	%xmm0, %xmm1
	movsd	%xmm1, -1052(%rbp)

	movl	$32, %eax
	leaq	-1028(%rbp), %rdx
	leaq	(%rdx,%rax), %rax
	movq	-1052(%rbp), %rdx
	movq	%rdx, (%rax)

	leaq	-916(%rbp), %rdx
	movl	$40, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -1036(%rbp)

	leaq	-972(%rbp), %rdx
	movl	$40, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -1044(%rbp)

		movsd	-1036(%rbp), %xmm1
	movsd	-1044(%rbp), %xmm0
	subsd	%xmm0, %xmm1
	movsd	%xmm1, -1052(%rbp)

	movl	$40, %eax
	leaq	-1028(%rbp), %rdx
	leaq	(%rdx,%rax), %rax
	movq	-1052(%rbp), %rdx
	movq	%rdx, (%rax)

	leaq	-916(%rbp), %rdx
	movl	$48, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -1036(%rbp)

	leaq	-972(%rbp), %rdx
	movl	$48, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -1044(%rbp)

		movsd	-1036(%rbp), %xmm1
	movsd	-1044(%rbp), %xmm0
	subsd	%xmm0, %xmm1
	movsd	%xmm1, -1052(%rbp)

	movl	$48, %eax
	leaq	-1028(%rbp), %rdx
	leaq	(%rdx,%rax), %rax
	movq	-1052(%rbp), %rdx
	movq	%rdx, (%rax)

		movq	-1028(%rbp), %rax
	movq	%rax, -364(%rbp)
	movq	-1020(%rbp), %rax
	movq	%rax, -356(%rbp)
	movq	-1012(%rbp), %rax
	movq	%rax, -348(%rbp)
	movq	-1004(%rbp), %rax
	movq	%rax, -340(%rbp)
	movq	-996(%rbp), %rax
	movq	%rax, -332(%rbp)
	movq	-988(%rbp), %rax
	movq	%rax, -324(%rbp)
	movq	-980(%rbp), %rax
	movq	%rax, -316(%rbp)

	movq 	$.LC9, -1060(%rbp)
	movl 	-1060(%rbp), %eax
	movq 	-1060(%rbp), %rdi
	call	printStr
	movl	%eax, -1064(%rbp)
	movl	$0, %eax
	movl	%eax, -1068(%rbp)

	movl	-1068(%rbp), %eax
	movl	%eax, -444(%rbp)

.L26: 
	movl	$2, %eax
	movl	%eax, -1072(%rbp)

	movl	-444(%rbp), %eax
	cmpl	-1072(%rbp), %eax
	jl .L28
	jmp .L33
.L27: 
	movl	-444(%rbp), %eax
	movl	%eax, -1076(%rbp)

		movl	-1076(%rbp), %eax 
	addl 	$1, %eax
	movl	%eax, -444(%rbp)

	jmp .L26
.L28: 
	movl	$0, %eax
	movl	%eax, -1080(%rbp)

	movl	-1080(%rbp), %eax
	movl	%eax, -448(%rbp)

.L29: 
	movl	$3, %eax
	movl	%eax, -1084(%rbp)

	movl	-448(%rbp), %eax
	cmpl	-1084(%rbp), %eax
	jl .L31
	jmp .L32
.L30: 
	movl	-448(%rbp), %eax
	movl	%eax, -1088(%rbp)

		movl	-1088(%rbp), %eax 
	addl 	$1, %eax
	movl	%eax, -448(%rbp)

	jmp .L29
.L31: 
	movl 	-444(%rbp), %eax
	imull 	$24, %eax
	movl 	%eax, -1096(%rbp)
		movl	-1096(%rbp), %eax
	movl	%eax, -1092(%rbp)

	movl 	-448(%rbp), %eax
	imull 	$8, %eax
	movl 	%eax, -1104(%rbp)
	movl 	-1092(%rbp), %eax
	movl 	-1104(%rbp), %edx
	addl 	%edx, %eax
	movl 	%eax, -1100(%rbp)
	leaq	-364(%rbp), %rdx
	movl	-1100(%rbp), %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -1108(%rbp)

	movl 	-1108(%rbp), %eax
	movsd 	-1108(%rbp), %xmm0
	cvtsd2ss	%xmm0, %xmm0
	call	printFlt
	movl	%eax, -1112(%rbp)
	movq 	$.LC10, -1116(%rbp)
	movl 	-1116(%rbp), %eax
	movq 	-1116(%rbp), %rdi
	call	printStr
	movl	%eax, -1120(%rbp)
	jmp .L30
.L32: 
	movq 	$.LC11, -1124(%rbp)
	movl 	-1124(%rbp), %eax
	movq 	-1124(%rbp), %rdi
	call	printStr
	movl	%eax, -1128(%rbp)
	jmp .L27
.L33: 
	leaq	-76(%rbp), %rdx
	movl	$0, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -1188(%rbp)

	movl	$0, %eax
	leaq	-1180(%rbp), %rdx
	leaq	(%rdx,%rax), %rax
	movq	-1188(%rbp), %rdx
	movq	%rdx, (%rax)

	leaq	-76(%rbp), %rdx
	movl	$8, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -1188(%rbp)

	movl	$16, %eax
	leaq	-1180(%rbp), %rdx
	leaq	(%rdx,%rax), %rax
	movq	-1188(%rbp), %rdx
	movq	%rdx, (%rax)

	leaq	-76(%rbp), %rdx
	movl	$16, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -1188(%rbp)

	movl	$32, %eax
	leaq	-1180(%rbp), %rdx
	leaq	(%rdx,%rax), %rax
	movq	-1188(%rbp), %rdx
	movq	%rdx, (%rax)

	leaq	-76(%rbp), %rdx
	movl	$24, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -1188(%rbp)

	movl	$8, %eax
	leaq	-1180(%rbp), %rdx
	leaq	(%rdx,%rax), %rax
	movq	-1188(%rbp), %rdx
	movq	%rdx, (%rax)

	leaq	-76(%rbp), %rdx
	movl	$32, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -1188(%rbp)

	movl	$24, %eax
	leaq	-1180(%rbp), %rdx
	leaq	(%rdx,%rax), %rax
	movq	-1188(%rbp), %rdx
	movq	%rdx, (%rax)

	leaq	-76(%rbp), %rdx
	movl	$40, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -1188(%rbp)

	movl	$40, %eax
	leaq	-1180(%rbp), %rdx
	leaq	(%rdx,%rax), %rax
	movq	-1188(%rbp), %rdx
	movq	%rdx, (%rax)

		movq	-1180(%rbp), %rax
	movq	%rax, -428(%rbp)
	movq	-1172(%rbp), %rax
	movq	%rax, -420(%rbp)
	movq	-1164(%rbp), %rax
	movq	%rax, -412(%rbp)
	movq	-1156(%rbp), %rax
	movq	%rax, -404(%rbp)
	movq	-1148(%rbp), %rax
	movq	%rax, -396(%rbp)
	movq	-1140(%rbp), %rax
	movq	%rax, -388(%rbp)
	movq	-1132(%rbp), %rax
	movq	%rax, -380(%rbp)

	movq 	$.LC12, -1196(%rbp)
	movl 	-1196(%rbp), %eax
	movq 	-1196(%rbp), %rdi
	call	printStr
	movl	%eax, -1200(%rbp)
	movl	$0, %eax
	movl	%eax, -1204(%rbp)

	movl	-1204(%rbp), %eax
	movl	%eax, -444(%rbp)

.L34: 
	movl	$3, %eax
	movl	%eax, -1208(%rbp)

	movl	-444(%rbp), %eax
	cmpl	-1208(%rbp), %eax
	jl .L36
	jmp .L41
.L35: 
	movl	-444(%rbp), %eax
	movl	%eax, -1212(%rbp)

		movl	-1212(%rbp), %eax 
	addl 	$1, %eax
	movl	%eax, -444(%rbp)

	jmp .L34
.L36: 
	movl	$0, %eax
	movl	%eax, -1216(%rbp)

	movl	-1216(%rbp), %eax
	movl	%eax, -448(%rbp)

.L37: 
	movl	$2, %eax
	movl	%eax, -1220(%rbp)

	movl	-448(%rbp), %eax
	cmpl	-1220(%rbp), %eax
	jl .L39
	jmp .L40
.L38: 
	movl	-448(%rbp), %eax
	movl	%eax, -1224(%rbp)

		movl	-1224(%rbp), %eax 
	addl 	$1, %eax
	movl	%eax, -448(%rbp)

	jmp .L37
.L39: 
	movl 	-444(%rbp), %eax
	imull 	$16, %eax
	movl 	%eax, -1232(%rbp)
		movl	-1232(%rbp), %eax
	movl	%eax, -1228(%rbp)

	movl 	-448(%rbp), %eax
	imull 	$8, %eax
	movl 	%eax, -1240(%rbp)
	movl 	-1228(%rbp), %eax
	movl 	-1240(%rbp), %edx
	addl 	%edx, %eax
	movl 	%eax, -1236(%rbp)
	leaq	-428(%rbp), %rdx
	movl	-1236(%rbp), %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -1244(%rbp)

	movl 	-1244(%rbp), %eax
	movsd 	-1244(%rbp), %xmm0
	cvtsd2ss	%xmm0, %xmm0
	call	printFlt
	movl	%eax, -1248(%rbp)
	movq 	$.LC13, -1252(%rbp)
	movl 	-1252(%rbp), %eax
	movq 	-1252(%rbp), %rdi
	call	printStr
	movl	%eax, -1256(%rbp)
	jmp .L38
.L40: 
	movq 	$.LC14, -1260(%rbp)
	movl 	-1260(%rbp), %eax
	movq 	-1260(%rbp), %rdi
	call	printStr
	movl	%eax, -1264(%rbp)
	jmp .L35
.L41: 
	movl	$0, %eax
	movl	%eax, -1268(%rbp)

	movl	-1268(%rbp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident		"Compiled by 15CS10045 - swastik"
	.section	.note.GNU-stack,"",@progbits
