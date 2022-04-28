section .data
format1 : db "%lf", 0
format2 : db "%d", 0

prmpt: db "Enter x : ",0
lprmpt : equ $-prmpt
prmpt1: db "Enter a : ",0
prmpt2: db "Enter b : ",0
prmpt3: db "Enter c : ",0
out1: db "x1 : ",0
out2: db "x2 : ",0
lout : equ $-out2
newl : db 10,0
lnewl: equ $-newl

section .bss
temp : resq 1
a : resq 1
b : resq 1
c : resq 1
x1 : resq 1
x2 : resq 1
d : resq 1
temp4 : resd 1
temp2 : resd 1
section .text
global main
extern scanf
extern printf

main:
    push rbp
    mov rbp,rsp

    mov rax, 4
    mov rbx, 1
    mov rcx, prmpt1
    mov rdx, lprmpt
    int 80h
    
    mov rax, 0
    mov rsi, a 
    mov rdi, format1
    call scanf

    mov rax, 4
    mov rbx, 1
    mov rcx, prmpt2
    mov rdx, lprmpt
    int 80h

    mov rax, 0
    mov rsi, b 
    mov rdi, format1
    call scanf

    mov rax, 4
    mov rbx, 1
    mov rcx, prmpt3
    mov rdx, lprmpt
    int 80h

    mov rax, 0
    mov rsi, c 
    mov rdi, format1
    call scanf
    
    call calc_roots

    mov rax, 4
    mov rbx, 1
    mov rcx, out1
    mov rdx, lout 
    int 80h

    mov rax, 1
    movsd xmm0,qword[x1]
    mov rdi, format1
    call printf

    mov rax, 4
    mov rbx, 1
    mov rcx, out2
    mov rdx, lout 
    int 80h

    mov rax, 1
    movsd xmm0,qword[x2]
    mov rdi, format1
    call printf

    mov rax, 1
    pop rbp
    ret

calc_roots:
    ; [-b + sqrt(b*b - 4*a*c) ]/2a
    mov dword[temp4] ,4
    mov dword[temp2] ,2

    fld qword[b]
    fmul qword[b];b*b
    fld qword[a]
    fmul qword[c]
    fimul dword[temp4];4ac
    
    fst qword[temp];
    fxch st1
    fsub qword[temp]
    fsqrt

    fst qword[d]

    fld qword[b]
    fchs

    fadd qword[d]
    fdiv qword[a]
    fidiv dword[temp2]
    
    fst qword[x1]

    fld qword[b]
    fchs

    fsub qword[d]
    fdiv qword[a]
    fidiv dword[temp2] 
    
    fst qword[x2]

    ret
