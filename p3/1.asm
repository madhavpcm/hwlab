section .data
msgo : db "Odd number count : %d",10,0
msge : db "Even number count : %d",10,0
msg : db "Enter the number of elements to store:",10,0
lmsg : equ $-msg
fin : db "%d",0
lfin : equ $-fin
fout db "%d ",0
lfout : equ $-fout

section .bss
n : resb 4
i : resb 1
x : resb 4
odd : resb 1
even : resb 1

section .text
global main
extern scanf
extern printf

main:
    push rbp
    mov rax, 0
    mov rdi, msg
    call printf

    mov rax, 0
    mov rdi, fin
    mov rsi, n 
    call scanf

    mov byte[i] , 0
    mov byte[odd], 0
    mov byte[even], 0
    loop:
        mov rax, 0
        mov rdi, fin
        mov rsi, x 
        call scanf

        mov rax, 1
        and al, byte[x]
        cmp al, 1
        je _odd
        _even:
            inc byte[even] 
            jmp loop_cmp
        _odd:
            inc byte[odd]
        
        loop_cmp:
            inc byte[i]
            movzx rbx, byte[n]
            movzx rcx, byte[i]
            cmp rcx, rbx 
            jl loop

    mov rdi , msgo
    movzx rsi , byte[odd]
    call printf 

    mov rdi , msge
    movzx rsi , byte[even]
    call printf 
    pop rbp
    ret