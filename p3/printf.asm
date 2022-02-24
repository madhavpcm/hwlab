section .data
str: db 'Example',10,0

section .text
global main
extern printf

main:
    push rbp  
    mov rbp, rsp
    push str 
    push qword 0
    call printf
    mov rsp,rbp
    pop rax
    pop rbp
    ret
