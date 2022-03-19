section .data
s1 : times 100 db 0
s2 : times 100 db 0
s : times 200 db  0
syes : db "Yes. they match", 10,0
lsyes : equ $-syes
sno : db "No .they dont match", 10,0
lsno : equ $-sno
section .bss
x : resb 1
inp : resb 1
i : resb 1
n1 : resb 1
n2 : resb 1
section .text
global _start:

_start:
    mov byte[i], 0
    mov rsi, s1
    call read_str
    mov al, byte[i]
    mov byte[n1], al
    mov byte[i], 0

    mov rsi, s2
    call read_str
    mov al, byte[i]
    mov byte[n2], al
    mov byte[i], 0

    mov rsi, s1
    mov rdi, s2
    call str_cmp 
    
_exit:
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
    add rbx, rsi 
    mov byte[rbx], al
    inc byte[i]
    jmp read_str

read_str_return:
    movzx rbx, byte[i]
    add rbx, rsi
    mov byte[rbx],0
    inc byte[i] 
    ret

str_cmp:
    mov byte[i], 0
    mov cl, byte[n1]
    cmp cl, byte[n2]
    jne no
    loop_c:
    cmp cl, 0
    je yes
    movzx rax, byte[i]
    add rax, rsi

    movzx rbx, byte[i]
    add rbx, rdi
    
    mov cl, byte[rax]
    mov dl, byte[rbx]

    inc byte[i]
    cmp cl, dl
    jne no
    jmp loop_c

no:
    mov rax,4 
    mov rbx,1
    mov rcx,sno
    mov rdx,lsno
    int 80h
    ret
yes:
    mov rax,4 
    mov rbx,1
    mov rcx,syes
    mov rdx,lsyes
    int 80h
    ret
