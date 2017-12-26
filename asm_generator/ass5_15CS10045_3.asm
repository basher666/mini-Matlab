	.file	"test.mm"
	.section	.rodata
.LC0:
	.string	"Entered the fib function\n"
.LC1:
	.string	"\nThe fibonacci number is : "
.LC2:
	.string	"enter the i for finding its fibonacci number : "
.LC3:
	.string	"\nYou Entered : "
.LC4:
	.string	"\nNow, entering the function to calculate fibonacci numbers for i entered\n"
.LC5:
	.string	"\n\nReturned from the fib function\n\n"
.LC6:
	.string	"value returned is = "
	.text	
	.globl	fib
	.type	fib, @function
fib: 
.LFB0:
	.cfi_startproc
	pushq 	%rbp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movq 	%rsp, %rbp
	.cfi_def_cfa_register 5
	subq	$96, %rsp
	movq	%rdi, -20(%rbp)
	movq 	$.LC0, -32(%rbp)
	movl 	-32(%rbp), %eax
	movq 	-32(%rbp), %rdi
	call	printStr
	movl	%eax, -36(%rbp)
	movl	$1, %eax
	movl	%eax, -44(%rbp)

	movl	-44(%rbp), %eax
	movl	%eax, -40(%rbp)

	movl	$0, %eax
	movl	%eax, -52(%rbp)

	movl	-52(%rbp), %eax
	movl	%eax, -48(%rbp)

	movl	$1, %eax
	movl	%eax, -60(%rbp)

	movl	-60(%rbp), %eax
	movl	%eax, -56(%rbp)

.L2: 
	movl	-56(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jl .L3
	jmp .L4
.L3: 
	movl	-40(%rbp), %eax
	movl	%eax, -64(%rbp)

	movl 	-40(%rbp), %eax
	movl 	-48(%rbp), %edx
	addl 	%edx, %eax
	movl 	%eax, -68(%rbp)
	movl	-68(%rbp), %eax
	movl	%eax, -40(%rbp)

	movl	-64(%rbp), %eax
	movl	%eax, -48(%rbp)

	movl	$1, %eax
	movl	%eax, -72(%rbp)

	movl 	-56(%rbp), %eax
	movl 	-72(%rbp), %edx
	addl 	%edx, %eax
	movl 	%eax, -76(%rbp)
	movl	-76(%rbp), %eax
	movl	%eax, -56(%rbp)

	jmp .L2
.L4: 
	movq 	$.LC1, -80(%rbp)
	movl 	-80(%rbp), %eax
	movq 	-80(%rbp), %rdi
	call	printStr
	movl	%eax, -84(%rbp)
	movl 	-40(%rbp), %eax
	movq 	-40(%rbp), %rdi
	call	printInt
	movl	%eax, -92(%rbp)
	movl	-40(%rbp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	fib, .-fib
	.globl	main
	.type	main, @function
main: 
.LFB1:
	.cfi_startproc
	pushq 	%rbp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movq 	%rsp, %rbp
	.cfi_def_cfa_register 5
	subq	$112, %rsp

	movq 	$.LC2, -32(%rbp)
	movl 	-32(%rbp), %eax
	movq 	-32(%rbp), %rdi
	call	printStr
	movl	%eax, -36(%rbp)
	leaq	-40(%rbp), %rax
	movq 	%rax, -48(%rbp)
	movl 	-48(%rbp), %eax
	movq 	-48(%rbp), %rdi
	call	readInt
	movl	%eax, -52(%rbp)
	movq 	$.LC3, -56(%rbp)
	movl 	-56(%rbp), %eax
	movq 	-56(%rbp), %rdi
	call	printStr
	movl	%eax, -60(%rbp)
	movl 	-40(%rbp), %eax
	movq 	-40(%rbp), %rdi
	call	printInt
	movl	%eax, -68(%rbp)
	movq 	$.LC4, -72(%rbp)
	movl 	-72(%rbp), %eax
	movq 	-72(%rbp), %rdi
	call	printStr
	movl	%eax, -76(%rbp)
	movl 	-40(%rbp), %eax
	movq 	-40(%rbp), %rdi
	call	fib
	movl	%eax, -88(%rbp)
	movl	-88(%rbp), %eax
	movl	%eax, -80(%rbp)

	movq 	$.LC5, -92(%rbp)
	movl 	-92(%rbp), %eax
	movq 	-92(%rbp), %rdi
	call	printStr
	movl	%eax, -96(%rbp)
	movq 	$.LC6, -100(%rbp)
	movl 	-100(%rbp), %eax
	movq 	-100(%rbp), %rdi
	call	printStr
	movl	%eax, -104(%rbp)
	movl 	-80(%rbp), %eax
	movq 	-80(%rbp), %rdi
	call	printInt
	movl	%eax, -108(%rbp)
	movl	$1, %eax
	movl	%eax, -112(%rbp)

	movl	-112(%rbp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE1:
	.size	main, .-main
	.ident		"Compiled by 15CS10045 - swastik"
	.section	.note.GNU-stack,"",@progbits
