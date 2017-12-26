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
	.string	" matrix m3 after multiplying m3= m1*m2 \n"
.LC7:
	.string	"\t"
.LC8:
	.string	"\n"
	.align 8
.LCt000:
	.long	1202590843
	.long	1078696673
	.align 8
.LCt003:
	.long	3435973837
	.long	1073007820
	.align 8
.LCt004:
	.long	1717986918
	.long	1073899110
	.align 8
.LCt005:
	.long	1717986918
	.long	1074423398
	.align 8
.LCt006:
	.long	858993459
	.long	1074869043
	.align 8
.LCt007:
	.long	858993459
	.long	1075131187
	.align 8
.LCt008:
	.long	858993459
	.long	1075393331
	.align 8
.LCt011:
	.long	1717986918
	.long	1073112678
	.align 8
.LCt012:
	.long	2576980378
	.long	1078598041
	.align 8
.LCt013:
	.long	0
	.long	1077493760
	.align 8
.LCt014:
	.long	3985729651
	.long	1080911740
	.align 8
.LCt015:
	.long	1717986918
	.long	1073112678
	.align 8
.LCt016:
	.long	2576980378
	.long	1078598041
	.align 8
.LCt017:
	.long	0
	.long	1077493760
	.align 8
.LCt018:
	.long	3985729651
	.long	1080911740
	.align 8
.LCt019:
	.long	1717986918
	.long	1073112678
	.align 8
.LCt020:
	.long	2576980378
	.long	1078598041
	.align 8
.LCt021:
	.long	0
	.long	1077493760
	.align 8
.LCt022:
	.long	3985729651
	.long	1080911740
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
	subq	$832, %rsp

	movq	.LCt000(%rip), %rax
	movq 	%rax, -36(%rbp)
	movq	-36(%rbp), %rax
	movq	%rax, -28(%rbp)

	movl	$2, %eax
	movl	%eax, -100(%rbp)

	movl	$3, %eax
	movl	%eax, -104(%rbp)

	movq	.LCt003(%rip), %rax
	movq 	%rax, -108(%rbp)
	movq	.LCt004(%rip), %rax
	movq 	%rax, -116(%rbp)
	movq	.LCt005(%rip), %rax
	movq 	%rax, -124(%rbp)
	movq	.LCt006(%rip), %rax
	movq 	%rax, -132(%rbp)
	movq	.LCt007(%rip), %rax
	movq 	%rax, -140(%rbp)
	movq	.LCt008(%rip), %rax
	movq 	%rax, -148(%rbp)
	movq	-108(%rbp), %rdx
	movq	%rdx, -92(%rbp)

	movq	-116(%rbp), %rdx
	movq	%rdx, -84(%rbp)

	movq	-124(%rbp), %rdx
	movq	%rdx, -76(%rbp)

	movq	-132(%rbp), %rdx
	movq	%rdx, -68(%rbp)

	movq	-140(%rbp), %rdx
	movq	%rdx, -60(%rbp)

	movq	-148(%rbp), %rdx
	movq	%rdx, -52(%rbp)

	movl	$3, %eax
	movl	%eax, -260(%rbp)

	movl	$4, %eax
	movl	%eax, -264(%rbp)

	movq	.LCt011(%rip), %rax
	movq 	%rax, -268(%rbp)
	movq	.LCt012(%rip), %rax
	movq 	%rax, -276(%rbp)
	movq	.LCt013(%rip), %rax
	movq 	%rax, -284(%rbp)
	movq	.LCt014(%rip), %rax
	movq 	%rax, -292(%rbp)
	movq	.LCt015(%rip), %rax
	movq 	%rax, -300(%rbp)
	movq	.LCt016(%rip), %rax
	movq 	%rax, -308(%rbp)
	movq	.LCt017(%rip), %rax
	movq 	%rax, -316(%rbp)
	movq	.LCt018(%rip), %rax
	movq 	%rax, -324(%rbp)
	movq	.LCt019(%rip), %rax
	movq 	%rax, -332(%rbp)
	movq	.LCt020(%rip), %rax
	movq 	%rax, -340(%rbp)
	movq	.LCt021(%rip), %rax
	movq 	%rax, -348(%rbp)
	movq	.LCt022(%rip), %rax
	movq 	%rax, -356(%rbp)
	movq	-268(%rbp), %rdx
	movq	%rdx, -252(%rbp)

	movq	-276(%rbp), %rdx
	movq	%rdx, -244(%rbp)

	movq	-284(%rbp), %rdx
	movq	%rdx, -236(%rbp)

	movq	-292(%rbp), %rdx
	movq	%rdx, -228(%rbp)

	movq	-300(%rbp), %rdx
	movq	%rdx, -220(%rbp)

	movq	-308(%rbp), %rdx
	movq	%rdx, -212(%rbp)

	movq	-316(%rbp), %rdx
	movq	%rdx, -204(%rbp)

	movq	-324(%rbp), %rdx
	movq	%rdx, -196(%rbp)

	movq	-332(%rbp), %rdx
	movq	%rdx, -188(%rbp)

	movq	-340(%rbp), %rdx
	movq	%rdx, -180(%rbp)

	movq	-348(%rbp), %rdx
	movq	%rdx, -172(%rbp)

	movq	-356(%rbp), %rdx
	movq	%rdx, -164(%rbp)

	movl	$2, %eax
	movl	%eax, -436(%rbp)

	movl	$4, %eax
	movl	%eax, -440(%rbp)

		movq	-92(%rbp), %rax
	movq	%rax, -492(%rbp)
	movq	-84(%rbp), %rax
	movq	%rax, -484(%rbp)
	movq	-76(%rbp), %rax
	movq	%rax, -476(%rbp)
	movq	-68(%rbp), %rax
	movq	%rax, -468(%rbp)
	movq	-60(%rbp), %rax
	movq	%rax, -460(%rbp)
	movq	-52(%rbp), %rax
	movq	%rax, -452(%rbp)
	movq	-44(%rbp), %rax
	movq	%rax, -444(%rbp)

	movq	$0, -596(%rbp)

	leaq	-492(%rbp), %rdx
	movl	$0, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -572(%rbp)

	leaq	-252(%rbp), %rdx
	movl	$0, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -580(%rbp)

		movsd	-572(%rbp), %xmm0
	movsd	-580(%rbp), %xmm1
	mulsd	%xmm0, %xmm1
	movsd	%xmm1, -588(%rbp)

		movsd	-596(%rbp), %xmm0
	movsd	-588(%rbp), %xmm1
	addsd	%xmm0, %xmm1
	movsd	%xmm1, -596(%rbp)

	leaq	-492(%rbp), %rdx
	movl	$8, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -572(%rbp)

	leaq	-252(%rbp), %rdx
	movl	$32, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -580(%rbp)

		movsd	-572(%rbp), %xmm0
	movsd	-580(%rbp), %xmm1
	mulsd	%xmm0, %xmm1
	movsd	%xmm1, -588(%rbp)

		movsd	-596(%rbp), %xmm0
	movsd	-588(%rbp), %xmm1
	addsd	%xmm0, %xmm1
	movsd	%xmm1, -596(%rbp)

	leaq	-492(%rbp), %rdx
	movl	$16, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -572(%rbp)

	leaq	-252(%rbp), %rdx
	movl	$64, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -580(%rbp)

		movsd	-572(%rbp), %xmm0
	movsd	-580(%rbp), %xmm1
	mulsd	%xmm0, %xmm1
	movsd	%xmm1, -588(%rbp)

		movsd	-596(%rbp), %xmm0
	movsd	-588(%rbp), %xmm1
	addsd	%xmm0, %xmm1
	movsd	%xmm1, -596(%rbp)

	movl	$0, %eax
	leaq	-564(%rbp), %rdx
	leaq	(%rdx,%rax), %rax
	movq	-596(%rbp), %rdx
	movq	%rdx, (%rax)

	movq	$0, -596(%rbp)

	leaq	-492(%rbp), %rdx
	movl	$0, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -572(%rbp)

	leaq	-252(%rbp), %rdx
	movl	$8, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -580(%rbp)

		movsd	-572(%rbp), %xmm0
	movsd	-580(%rbp), %xmm1
	mulsd	%xmm0, %xmm1
	movsd	%xmm1, -588(%rbp)

		movsd	-596(%rbp), %xmm0
	movsd	-588(%rbp), %xmm1
	addsd	%xmm0, %xmm1
	movsd	%xmm1, -596(%rbp)

	leaq	-492(%rbp), %rdx
	movl	$8, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -572(%rbp)

	leaq	-252(%rbp), %rdx
	movl	$40, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -580(%rbp)

		movsd	-572(%rbp), %xmm0
	movsd	-580(%rbp), %xmm1
	mulsd	%xmm0, %xmm1
	movsd	%xmm1, -588(%rbp)

		movsd	-596(%rbp), %xmm0
	movsd	-588(%rbp), %xmm1
	addsd	%xmm0, %xmm1
	movsd	%xmm1, -596(%rbp)

	leaq	-492(%rbp), %rdx
	movl	$16, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -572(%rbp)

	leaq	-252(%rbp), %rdx
	movl	$72, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -580(%rbp)

		movsd	-572(%rbp), %xmm0
	movsd	-580(%rbp), %xmm1
	mulsd	%xmm0, %xmm1
	movsd	%xmm1, -588(%rbp)

		movsd	-596(%rbp), %xmm0
	movsd	-588(%rbp), %xmm1
	addsd	%xmm0, %xmm1
	movsd	%xmm1, -596(%rbp)

	movl	$8, %eax
	leaq	-564(%rbp), %rdx
	leaq	(%rdx,%rax), %rax
	movq	-596(%rbp), %rdx
	movq	%rdx, (%rax)

	movq	$0, -596(%rbp)

	leaq	-492(%rbp), %rdx
	movl	$0, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -572(%rbp)

	leaq	-252(%rbp), %rdx
	movl	$16, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -580(%rbp)

		movsd	-572(%rbp), %xmm0
	movsd	-580(%rbp), %xmm1
	mulsd	%xmm0, %xmm1
	movsd	%xmm1, -588(%rbp)

		movsd	-596(%rbp), %xmm0
	movsd	-588(%rbp), %xmm1
	addsd	%xmm0, %xmm1
	movsd	%xmm1, -596(%rbp)

	leaq	-492(%rbp), %rdx
	movl	$8, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -572(%rbp)

	leaq	-252(%rbp), %rdx
	movl	$48, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -580(%rbp)

		movsd	-572(%rbp), %xmm0
	movsd	-580(%rbp), %xmm1
	mulsd	%xmm0, %xmm1
	movsd	%xmm1, -588(%rbp)

		movsd	-596(%rbp), %xmm0
	movsd	-588(%rbp), %xmm1
	addsd	%xmm0, %xmm1
	movsd	%xmm1, -596(%rbp)

	leaq	-492(%rbp), %rdx
	movl	$16, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -572(%rbp)

	leaq	-252(%rbp), %rdx
	movl	$80, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -580(%rbp)

		movsd	-572(%rbp), %xmm0
	movsd	-580(%rbp), %xmm1
	mulsd	%xmm0, %xmm1
	movsd	%xmm1, -588(%rbp)

		movsd	-596(%rbp), %xmm0
	movsd	-588(%rbp), %xmm1
	addsd	%xmm0, %xmm1
	movsd	%xmm1, -596(%rbp)

	movl	$16, %eax
	leaq	-564(%rbp), %rdx
	leaq	(%rdx,%rax), %rax
	movq	-596(%rbp), %rdx
	movq	%rdx, (%rax)

	movq	$0, -596(%rbp)

	leaq	-492(%rbp), %rdx
	movl	$0, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -572(%rbp)

	leaq	-252(%rbp), %rdx
	movl	$24, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -580(%rbp)

		movsd	-572(%rbp), %xmm0
	movsd	-580(%rbp), %xmm1
	mulsd	%xmm0, %xmm1
	movsd	%xmm1, -588(%rbp)

		movsd	-596(%rbp), %xmm0
	movsd	-588(%rbp), %xmm1
	addsd	%xmm0, %xmm1
	movsd	%xmm1, -596(%rbp)

	leaq	-492(%rbp), %rdx
	movl	$8, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -572(%rbp)

	leaq	-252(%rbp), %rdx
	movl	$56, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -580(%rbp)

		movsd	-572(%rbp), %xmm0
	movsd	-580(%rbp), %xmm1
	mulsd	%xmm0, %xmm1
	movsd	%xmm1, -588(%rbp)

		movsd	-596(%rbp), %xmm0
	movsd	-588(%rbp), %xmm1
	addsd	%xmm0, %xmm1
	movsd	%xmm1, -596(%rbp)

	leaq	-492(%rbp), %rdx
	movl	$16, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -572(%rbp)

	leaq	-252(%rbp), %rdx
	movl	$88, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -580(%rbp)

		movsd	-572(%rbp), %xmm0
	movsd	-580(%rbp), %xmm1
	mulsd	%xmm0, %xmm1
	movsd	%xmm1, -588(%rbp)

		movsd	-596(%rbp), %xmm0
	movsd	-588(%rbp), %xmm1
	addsd	%xmm0, %xmm1
	movsd	%xmm1, -596(%rbp)

	movl	$24, %eax
	leaq	-564(%rbp), %rdx
	leaq	(%rdx,%rax), %rax
	movq	-596(%rbp), %rdx
	movq	%rdx, (%rax)

	movq	$0, -596(%rbp)

	leaq	-492(%rbp), %rdx
	movl	$24, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -572(%rbp)

	leaq	-252(%rbp), %rdx
	movl	$0, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -580(%rbp)

		movsd	-572(%rbp), %xmm0
	movsd	-580(%rbp), %xmm1
	mulsd	%xmm0, %xmm1
	movsd	%xmm1, -588(%rbp)

		movsd	-596(%rbp), %xmm0
	movsd	-588(%rbp), %xmm1
	addsd	%xmm0, %xmm1
	movsd	%xmm1, -596(%rbp)

	leaq	-492(%rbp), %rdx
	movl	$32, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -572(%rbp)

	leaq	-252(%rbp), %rdx
	movl	$32, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -580(%rbp)

		movsd	-572(%rbp), %xmm0
	movsd	-580(%rbp), %xmm1
	mulsd	%xmm0, %xmm1
	movsd	%xmm1, -588(%rbp)

		movsd	-596(%rbp), %xmm0
	movsd	-588(%rbp), %xmm1
	addsd	%xmm0, %xmm1
	movsd	%xmm1, -596(%rbp)

	leaq	-492(%rbp), %rdx
	movl	$40, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -572(%rbp)

	leaq	-252(%rbp), %rdx
	movl	$64, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -580(%rbp)

		movsd	-572(%rbp), %xmm0
	movsd	-580(%rbp), %xmm1
	mulsd	%xmm0, %xmm1
	movsd	%xmm1, -588(%rbp)

		movsd	-596(%rbp), %xmm0
	movsd	-588(%rbp), %xmm1
	addsd	%xmm0, %xmm1
	movsd	%xmm1, -596(%rbp)

	movl	$32, %eax
	leaq	-564(%rbp), %rdx
	leaq	(%rdx,%rax), %rax
	movq	-596(%rbp), %rdx
	movq	%rdx, (%rax)

	movq	$0, -596(%rbp)

	leaq	-492(%rbp), %rdx
	movl	$24, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -572(%rbp)

	leaq	-252(%rbp), %rdx
	movl	$8, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -580(%rbp)

		movsd	-572(%rbp), %xmm0
	movsd	-580(%rbp), %xmm1
	mulsd	%xmm0, %xmm1
	movsd	%xmm1, -588(%rbp)

		movsd	-596(%rbp), %xmm0
	movsd	-588(%rbp), %xmm1
	addsd	%xmm0, %xmm1
	movsd	%xmm1, -596(%rbp)

	leaq	-492(%rbp), %rdx
	movl	$32, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -572(%rbp)

	leaq	-252(%rbp), %rdx
	movl	$40, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -580(%rbp)

		movsd	-572(%rbp), %xmm0
	movsd	-580(%rbp), %xmm1
	mulsd	%xmm0, %xmm1
	movsd	%xmm1, -588(%rbp)

		movsd	-596(%rbp), %xmm0
	movsd	-588(%rbp), %xmm1
	addsd	%xmm0, %xmm1
	movsd	%xmm1, -596(%rbp)

	leaq	-492(%rbp), %rdx
	movl	$40, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -572(%rbp)

	leaq	-252(%rbp), %rdx
	movl	$72, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -580(%rbp)

		movsd	-572(%rbp), %xmm0
	movsd	-580(%rbp), %xmm1
	mulsd	%xmm0, %xmm1
	movsd	%xmm1, -588(%rbp)

		movsd	-596(%rbp), %xmm0
	movsd	-588(%rbp), %xmm1
	addsd	%xmm0, %xmm1
	movsd	%xmm1, -596(%rbp)

	movl	$40, %eax
	leaq	-564(%rbp), %rdx
	leaq	(%rdx,%rax), %rax
	movq	-596(%rbp), %rdx
	movq	%rdx, (%rax)

	movq	$0, -596(%rbp)

	leaq	-492(%rbp), %rdx
	movl	$24, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -572(%rbp)

	leaq	-252(%rbp), %rdx
	movl	$16, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -580(%rbp)

		movsd	-572(%rbp), %xmm0
	movsd	-580(%rbp), %xmm1
	mulsd	%xmm0, %xmm1
	movsd	%xmm1, -588(%rbp)

		movsd	-596(%rbp), %xmm0
	movsd	-588(%rbp), %xmm1
	addsd	%xmm0, %xmm1
	movsd	%xmm1, -596(%rbp)

	leaq	-492(%rbp), %rdx
	movl	$32, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -572(%rbp)

	leaq	-252(%rbp), %rdx
	movl	$48, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -580(%rbp)

		movsd	-572(%rbp), %xmm0
	movsd	-580(%rbp), %xmm1
	mulsd	%xmm0, %xmm1
	movsd	%xmm1, -588(%rbp)

		movsd	-596(%rbp), %xmm0
	movsd	-588(%rbp), %xmm1
	addsd	%xmm0, %xmm1
	movsd	%xmm1, -596(%rbp)

	leaq	-492(%rbp), %rdx
	movl	$40, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -572(%rbp)

	leaq	-252(%rbp), %rdx
	movl	$80, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -580(%rbp)

		movsd	-572(%rbp), %xmm0
	movsd	-580(%rbp), %xmm1
	mulsd	%xmm0, %xmm1
	movsd	%xmm1, -588(%rbp)

		movsd	-596(%rbp), %xmm0
	movsd	-588(%rbp), %xmm1
	addsd	%xmm0, %xmm1
	movsd	%xmm1, -596(%rbp)

	movl	$48, %eax
	leaq	-564(%rbp), %rdx
	leaq	(%rdx,%rax), %rax
	movq	-596(%rbp), %rdx
	movq	%rdx, (%rax)

	movq	$0, -596(%rbp)

	leaq	-492(%rbp), %rdx
	movl	$24, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -572(%rbp)

	leaq	-252(%rbp), %rdx
	movl	$24, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -580(%rbp)

		movsd	-572(%rbp), %xmm0
	movsd	-580(%rbp), %xmm1
	mulsd	%xmm0, %xmm1
	movsd	%xmm1, -588(%rbp)

		movsd	-596(%rbp), %xmm0
	movsd	-588(%rbp), %xmm1
	addsd	%xmm0, %xmm1
	movsd	%xmm1, -596(%rbp)

	leaq	-492(%rbp), %rdx
	movl	$32, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -572(%rbp)

	leaq	-252(%rbp), %rdx
	movl	$56, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -580(%rbp)

		movsd	-572(%rbp), %xmm0
	movsd	-580(%rbp), %xmm1
	mulsd	%xmm0, %xmm1
	movsd	%xmm1, -588(%rbp)

		movsd	-596(%rbp), %xmm0
	movsd	-588(%rbp), %xmm1
	addsd	%xmm0, %xmm1
	movsd	%xmm1, -596(%rbp)

	leaq	-492(%rbp), %rdx
	movl	$40, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -572(%rbp)

	leaq	-252(%rbp), %rdx
	movl	$88, %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -580(%rbp)

		movsd	-572(%rbp), %xmm0
	movsd	-580(%rbp), %xmm1
	mulsd	%xmm0, %xmm1
	movsd	%xmm1, -588(%rbp)

		movsd	-596(%rbp), %xmm0
	movsd	-588(%rbp), %xmm1
	addsd	%xmm0, %xmm1
	movsd	%xmm1, -596(%rbp)

	movl	$56, %eax
	leaq	-564(%rbp), %rdx
	leaq	(%rdx,%rax), %rax
	movq	-596(%rbp), %rdx
	movq	%rdx, (%rax)

		movq	-564(%rbp), %rax
	movq	%rax, -428(%rbp)
	movq	-556(%rbp), %rax
	movq	%rax, -420(%rbp)
	movq	-548(%rbp), %rax
	movq	%rax, -412(%rbp)
	movq	-540(%rbp), %rax
	movq	%rax, -404(%rbp)
	movq	-532(%rbp), %rax
	movq	%rax, -396(%rbp)
	movq	-524(%rbp), %rax
	movq	%rax, -388(%rbp)
	movq	-516(%rbp), %rax
	movq	%rax, -380(%rbp)
	movq	-508(%rbp), %rax
	movq	%rax, -372(%rbp)
	movq	-500(%rbp), %rax
	movq	%rax, -364(%rbp)

	movq 	$.LC0, -616(%rbp)
	movl 	-616(%rbp), %eax
	movq 	-616(%rbp), %rdi
	call	printStr
	movl	%eax, -620(%rbp)
	movl	$0, %eax
	movl	%eax, -624(%rbp)

	movl	-624(%rbp), %eax
	movl	%eax, -604(%rbp)

.L2: 
	movl	$2, %eax
	movl	%eax, -628(%rbp)

	movl	-604(%rbp), %eax
	cmpl	-628(%rbp), %eax
	jl .L4
	jmp .L9
.L3: 
	movl	-604(%rbp), %eax
	movl	%eax, -632(%rbp)

		movl	-632(%rbp), %eax 
	addl 	$1, %eax
	movl	%eax, -604(%rbp)

	jmp .L2
.L4: 
	movl	$0, %eax
	movl	%eax, -636(%rbp)

	movl	-636(%rbp), %eax
	movl	%eax, -608(%rbp)

.L5: 
	movl	$3, %eax
	movl	%eax, -640(%rbp)

	movl	-608(%rbp), %eax
	cmpl	-640(%rbp), %eax
	jl .L7
	jmp .L8
.L6: 
	movl	-608(%rbp), %eax
	movl	%eax, -644(%rbp)

		movl	-644(%rbp), %eax 
	addl 	$1, %eax
	movl	%eax, -608(%rbp)

	jmp .L5
.L7: 
	movl 	-604(%rbp), %eax
	imull 	$24, %eax
	movl 	%eax, -656(%rbp)
		movl	-656(%rbp), %eax
	movl	%eax, -652(%rbp)

	movl 	-608(%rbp), %eax
	imull 	$8, %eax
	movl 	%eax, -664(%rbp)
	movl 	-652(%rbp), %eax
	movl 	-664(%rbp), %edx
	addl 	%edx, %eax
	movl 	%eax, -660(%rbp)
	leaq	-92(%rbp), %rdx
	movl	-660(%rbp), %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -668(%rbp)

	movl 	-668(%rbp), %eax
	movsd 	-668(%rbp), %xmm0
	cvtsd2ss	%xmm0, %xmm0
	call	printFlt
	movl	%eax, -672(%rbp)
	movq 	$.LC1, -676(%rbp)
	movl 	-676(%rbp), %eax
	movq 	-676(%rbp), %rdi
	call	printStr
	movl	%eax, -680(%rbp)
	jmp .L6
.L8: 
	movq 	$.LC2, -684(%rbp)
	movl 	-684(%rbp), %eax
	movq 	-684(%rbp), %rdi
	call	printStr
	movl	%eax, -688(%rbp)
	jmp .L3
.L9: 
	movq 	$.LC3, -692(%rbp)
	movl 	-692(%rbp), %eax
	movq 	-692(%rbp), %rdi
	call	printStr
	movl	%eax, -696(%rbp)
	movl	$0, %eax
	movl	%eax, -700(%rbp)

	movl	-700(%rbp), %eax
	movl	%eax, -604(%rbp)

.L10: 
	movl	$3, %eax
	movl	%eax, -704(%rbp)

	movl	-604(%rbp), %eax
	cmpl	-704(%rbp), %eax
	jl .L12
	jmp .L17
.L11: 
	movl	-604(%rbp), %eax
	movl	%eax, -708(%rbp)

		movl	-708(%rbp), %eax 
	addl 	$1, %eax
	movl	%eax, -604(%rbp)

	jmp .L10
.L12: 
	movl	$0, %eax
	movl	%eax, -712(%rbp)

	movl	-712(%rbp), %eax
	movl	%eax, -608(%rbp)

.L13: 
	movl	$4, %eax
	movl	%eax, -716(%rbp)

	movl	-608(%rbp), %eax
	cmpl	-716(%rbp), %eax
	jl .L15
	jmp .L16
.L14: 
	movl	-608(%rbp), %eax
	movl	%eax, -720(%rbp)

		movl	-720(%rbp), %eax 
	addl 	$1, %eax
	movl	%eax, -608(%rbp)

	jmp .L13
.L15: 
	movl 	-604(%rbp), %eax
	imull 	$32, %eax
	movl 	%eax, -728(%rbp)
		movl	-728(%rbp), %eax
	movl	%eax, -724(%rbp)

	movl 	-608(%rbp), %eax
	imull 	$8, %eax
	movl 	%eax, -736(%rbp)
	movl 	-724(%rbp), %eax
	movl 	-736(%rbp), %edx
	addl 	%edx, %eax
	movl 	%eax, -732(%rbp)
	leaq	-252(%rbp), %rdx
	movl	-732(%rbp), %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -740(%rbp)

	movl 	-740(%rbp), %eax
	movsd 	-740(%rbp), %xmm0
	cvtsd2ss	%xmm0, %xmm0
	call	printFlt
	movl	%eax, -744(%rbp)
	movq 	$.LC4, -748(%rbp)
	movl 	-748(%rbp), %eax
	movq 	-748(%rbp), %rdi
	call	printStr
	movl	%eax, -752(%rbp)
	jmp .L14
.L16: 
	movq 	$.LC5, -756(%rbp)
	movl 	-756(%rbp), %eax
	movq 	-756(%rbp), %rdi
	call	printStr
	movl	%eax, -760(%rbp)
	jmp .L11
.L17: 
	movq 	$.LC6, -764(%rbp)
	movl 	-764(%rbp), %eax
	movq 	-764(%rbp), %rdi
	call	printStr
	movl	%eax, -768(%rbp)
	movl	$0, %eax
	movl	%eax, -772(%rbp)

	movl	-772(%rbp), %eax
	movl	%eax, -604(%rbp)

.L18: 
	movl	$2, %eax
	movl	%eax, -776(%rbp)

	movl	-604(%rbp), %eax
	cmpl	-776(%rbp), %eax
	jl .L20
	jmp .L25
.L19: 
	movl	-604(%rbp), %eax
	movl	%eax, -780(%rbp)

		movl	-780(%rbp), %eax 
	addl 	$1, %eax
	movl	%eax, -604(%rbp)

	jmp .L18
.L20: 
	movl	$0, %eax
	movl	%eax, -784(%rbp)

	movl	-784(%rbp), %eax
	movl	%eax, -608(%rbp)

.L21: 
	movl	$4, %eax
	movl	%eax, -788(%rbp)

	movl	-608(%rbp), %eax
	cmpl	-788(%rbp), %eax
	jl .L23
	jmp .L24
.L22: 
	movl	-608(%rbp), %eax
	movl	%eax, -792(%rbp)

		movl	-792(%rbp), %eax 
	addl 	$1, %eax
	movl	%eax, -608(%rbp)

	jmp .L21
.L23: 
	movl 	-604(%rbp), %eax
	imull 	$32, %eax
	movl 	%eax, -800(%rbp)
		movl	-800(%rbp), %eax
	movl	%eax, -796(%rbp)

	movl 	-608(%rbp), %eax
	imull 	$8, %eax
	movl 	%eax, -808(%rbp)
	movl 	-796(%rbp), %eax
	movl 	-808(%rbp), %edx
	addl 	%edx, %eax
	movl 	%eax, -804(%rbp)
	leaq	-428(%rbp), %rdx
	movl	-804(%rbp), %eax
	movq	(%rdx,%rax), %rax
	movq	%rax, -812(%rbp)

	movl 	-812(%rbp), %eax
	movsd 	-812(%rbp), %xmm0
	cvtsd2ss	%xmm0, %xmm0
	call	printFlt
	movl	%eax, -816(%rbp)
	movq 	$.LC7, -820(%rbp)
	movl 	-820(%rbp), %eax
	movq 	-820(%rbp), %rdi
	call	printStr
	movl	%eax, -824(%rbp)
	jmp .L22
.L24: 
	movq 	$.LC8, -828(%rbp)
	movl 	-828(%rbp), %eax
	movq 	-828(%rbp), %rdi
	call	printStr
	movl	%eax, -832(%rbp)
	jmp .L19
.L25: 
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident		"Compiled by 15CS10045 - swastik"
	.section	.note.GNU-stack,"",@progbits
