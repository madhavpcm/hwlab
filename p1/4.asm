section .bss
A : resb 1
B : resb 1
C : resb 1
section .text
global _start:
    _start:
    mov eax,3
    mov ebx,0
    mov ecx,A
    mov edx,1
    int 80h

    mov eax,3
    mov ebx,0
    mov ecx,B
    mov edx,1
    int 80h
    mov eax, 0
    mov ebx, 0
    mov al, [A]    
    sub al, 30h

    mov bl, [B]
    sub bl, 30h
     
    add al,bl
    mov [C],al

    cmp al,10
;greater>=10
    jge _greaterequal
;less
    mov [A],al
    add byte[A],30h
    mov byte[B],30h
    jmp _after
    _greaterequal:
        sub byte[C],10
        mov ecx,[C]
        mov [A],ecx
        
        add byte[A],30h
        mov byte[B],31h
    _after:
    
    mov eax,4
    mov ebx,1
    mov ecx,B
    mov edx,1
    int 80h

    mov eax,4
    mov ebx,1
    mov ecx,A
    mov edx,1
    int 80h


    mov eax,1
    mov ebx,0
    int 80h

