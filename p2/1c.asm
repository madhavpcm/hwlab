	.file	"1.c"
	.text
	.section	.rodata
.LC0:
	.string	"DISPLAY"
.LC1:
	.string	"on"
.LC2:
	.string	"off"
.LC3:
	.string	"Caps Lock is %s\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	leaq	.LC0(%rip), %rax
	movq	%rax, %rdi
	call	getenv@PLT
	movq	%rax, %rdi
	call	XOpenDisplay@PLT
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	jne	.L2
	movl	$1, %eax
	jmp	.L7
.L2:
	leaq	-20(%rbp), %rdx
	movq	-16(%rbp), %rax
	movl	$256, %esi
	movq	%rax, %rdi
	call	XkbGetIndicatorState@PLT
	testl	%eax, %eax
	je	.L4
	movl	$2, %eax
	jmp	.L7
.L4:
	movl	-20(%rbp), %eax
	andl	$1, %eax
	testl	%eax, %eax
	je	.L5
	leaq	.LC1(%rip), %rax
	jmp	.L6
.L5:
	leaq	.LC2(%rip), %rax
.L6:
	movq	%rax, %rsi
	leaq	.LC3(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, %eax
.L7:
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L8
	call	__stack_chk_fail@PLT
.L8:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	main, .-main
	.ident	"GCC: (GNU) 11.1.0"
	.section	.note.GNU-stack,"",@progbits
