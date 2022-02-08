section .data
ent : db "Enter a 2 digit number :", 10
lenter : equ $-ent

section .bss

inp : resw 1
i : resb 1
sq : resw 1
ot : resb 4

section .text
global _start:
    _start:
    mov eax, 4
    mov ebx, 1
    mov ecx, ent
    mov edx, lenter
    int 80h
; digit 1
    mov eax, 3
    mov ebx, 0
    mov ecx, inp
    mov edx, 1
    int 80h
; digit 2
    mov eax, 3
    mov ebx, 0
    mov ecx, inp+1
    mov edx, 1
    int 80h
; ascii
    sub byte[inp], 30h
    sub byte[inp+1], 30h
; multiply number by itself
    mov ax,0
    mov al, byte[inp]
    mov cx, 10
    mul cx
    add al, byte[inp+1]
    mul al
; save
    mov [sq], ax
    mov edx, 0

    mov ebx, 1000
    div bx
    mov byte[ot], al 
    movzx eax, dx 

    mov ebx, 100
    div bl
    mov byte[ot+1], al
    movzx ax, ah 

    mov ebx, 10
    div bl
    mov byte[ot+2], al
    movzx ax, ah 

    mov byte[ot+3], al

    add byte[ot], 30h
    add byte[ot+1], 30h
    add byte[ot+2], 30h
    add byte[ot+3], 30h

    mov eax, 4
    mov ebx, 1
    mov ecx, ot
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, ot+1
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, ot+2
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, ot+3
    mov edx, 1
    int 80h

    mov eax, 1
    mov ebx, 0
    int 80h
    

