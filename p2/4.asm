section .data
mssg : db "enter a 2 digit number :",10
lmssg : equ $-mssg

section .bss
x : resb 2
i : resb 1
ot : resb 4
section .text

global _start:
    _start:
    mov eax,4 
    mov ebx,1
    mov ecx,mssg
    mov edx,lmssg
    int 80h

    mov eax,3
    mov ebx,0
    mov ecx,x
    mov edx,1
    int 80h

    mov eax,3
    mov ebx,0
    mov ecx,x+1
    mov edx,1
    int 80h

    sub byte[x],30h
    sub byte[x+1],30h

    movzx eax, byte[x]
    mov ebx,10
    mul ebx

    add eax, [x+1]
    mov ebx, eax
    mov eax, 0
    mov word[i], 0

    loop:
        add eax, [i]
        inc byte[i]
        inc byte[i]
        cmp byte[i], bl
        jle loop

    
    mov dx, 0
    mov bx, 1000 
    div bx

    mov byte[ot] ,al

    mov ax, dx
    mov bl, 100
    div bl

    mov byte[ot+1],al
    
    movzx ax, ah
    mov bl, 10
    div bl

    mov byte[ot+2],al
    mov byte[ot+3],ah

    add byte[ot], 30h
    add byte[ot+1], 30h
    add byte[ot+2], 30h
    add byte[ot+3], 30h

    mov eax,4
    mov ebx,1
    mov ecx,ot
    mov edx,4
    int 80h

    mov eax,1
    mov ebx,0
    int 80h
    

    



    


