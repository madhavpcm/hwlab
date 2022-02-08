section .data
mssg : db "Enter a 2 digit number",10
lmssg : equ $-mssg

section .bss
x : resb 2
i : resb 1
backup : resb 1
section .text
global _start:
    _start:
    
    mov eax,4
    mov ebx,1
    mov ecx,mssg
    mov edx, lmssg
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, x
    mov edx, 2
    int 80h

    sub byte[x], 30h
    sub byte[x+1], 30h

    mov al, byte[x]
    mov bl,10
    mul bl

    add al, byte[x+1]
    mov byte[backup] ,al
    mov byte[i], 0

    mov ebx,0
    inc ebx
    loop:
        mov al , byte[backup]
        inc byte[i]
        and al,bl
        shl bl, 1
        cmp al, 0
        je loop

    dec byte[i]
    add byte[i], 30h

    mov eax,4
    mov ebx,1
    mov ecx,i
    mov edx,1
    int 80h

    mov eax,1
    mov ebx,0
    int 80h
    

