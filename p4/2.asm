
section .data
prmpt : db "Enter a string : ", 0
lprmpt : equ $-prmpt
syes : db "String is a palindrome", 0
lsyes : equ $-syes
sno : db "String is not a palindrome", 0
lsno : equ $-sno
inp : times 100 db 0
rev : times 100 db 0
section .bss
i : resb 1
x : resb 1
n : resb 1
n_ : resb 1
section .text

global _start:

_start:
    push rbp
    mov rbp, rsp
    mov byte[i] ,0
    mov byte[n], 0

    mov rax, 4
    mov rbx, 1
    mov rcx, prmpt
    mov rdx, lprmpt
    int 80h 
    
    call read_str

    mov al, byte[i]
    sub al, 1
    mov byte[n_], al
    

    call str_rev 
exit:
    pop rbp
    mov rax, 1
    mov rbx, 0
    int 80h
read_str:
    mov rax, 3
    mov rbx, 0
    mov rcx, x 
    mov rdx, 1
    int 80h 

    cmp byte[x] , 10
    je read_str_return 

    mov al, byte[x]
    movzx rbx, byte[i] 
    add rbx, inp 
    mov byte[rbx], al
    inc byte[i]
    jmp read_str

read_str_return:
    ret

str_rev:
    mov cl, byte[n_]
    cmp byte[n], cl
    jge str_rev_end 

    movzx rax, byte[n] 
    add rax, inp 
    mov cl, byte[rax]
    movzx rbx, byte[n_]
    add rbx, inp 
    mov dl, byte[rbx]
    sub rax, inp 
    add rax, rev
    sub rbx, inp
    add rbx, rev
    mov byte[rax], dl
    mov byte[rbx], cl
    inc byte[n] 
    dec byte[n_]
    
    jmp str_rev
str_rev_end:
    mov rax, 4
    mov rbx, 1
    mov rcx, rev
    movzx rdx, byte[n]
    movzx rsi, byte[n_]
    add rdx, rsi 
    add rdx, 1
    int 80h
    ret
