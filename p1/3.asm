section .bss
n : resb 1
i : resb 1

section .text

global _start:
_start:
    mov eax,3
    mov ebx,0
    mov ecx,n
    mov edx,1
    int 80h

    sub byte[n],30h
    mov byte[i],0

    call _loop 

    mov eax, 1
    mov ebx, 0
    int 80h

_loop:
    add byte[i],30h

    mov eax, 4
    mov ebx, 1
    mov ecx, i 
    mov edx, 1
    int 80h

    sub byte[i],30h

    add byte[i],1
    mov al, byte[i]
    cmp al, byte[n]
    jna _loop  
    ret

printi:


