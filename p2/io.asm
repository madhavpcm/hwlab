	.file	"io.c"
	.text
	.section	.rodata
.LC0:
	.string	"ioperm"
	.text
	.globl	main
	.type	main, @function
main:
.LFB18:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	%edi, -20(%rbp)
	movq	%rsi, -32(%rbp)
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	subq	$192, %rax
	movl	%eax, %edx
	movl	$1, %esi
	movl	$96, %edi
	call	ioperm@PLT
	movl	%eax, -4(%rbp)
	cmpl	$0, -4(%rbp)
	jns	.L2
	leaq	.LC0(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
	movl	$1, %eax
	jmp	.L3
.L2:
	movl	-4(%rbp), %eax
	andl	$4, %eax
	testl	%eax, %eax
	je	.L4
	movl	$0, %edx
	movl	$1, %esi
	movl	$96, %edi
	call	ioperm@PLT
	movl	$1, %eax
	jmp	.L3
.L4:
	movl	$0, %edx
	movl	$1, %esi
	movl	$96, %edi
	call	ioperm@PLT
	movl	$2, %eax
.L3:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE18:
	.size	main, .-main
	.ident	"GCC: (GNU) 11.1.0"
	.section	.note.GNU-stack,"",@progbits
