section .data
mssg : db "Enter a 32-bit input",10
lmssg : equ $-mssg
s_in : db "%d",0
s_out : db "%d",10,0

section .text
extern scanf
extern printf 

global main:
    main:
    mov eax,4
    mov ebx,1
    mov ecx,mssg
    mov edx,lmssg
    int 80h


