section .data
mssg1 : db 'Enter First No:',10
l_mssg1 : db $-mssg1

mssg2 : db 'Enter Second No:',10
l_mssg2 : db $-mssg2

section .bss
x : resb 2
y : resb 2
z : resb 1
n : resb 1

section .text
global _start:
    _start:
    ;read x
    mov eax,3
    mov ebx,0
    mov ecx,x
    mov edx,2
    int 80h

    ;read \n 
    call _readN
    ;read y
    mov eax,3
    mov ebx,0
    mov ecx,y
    mov edx,2
    int 80h
    ;printx
    call _readN

    sub byte[x],30h
    sub byte[x+1],30h
    sub byte[y],30h
    sub byte[y+1],30h

    ;x1+y1 / 10    
    mov al, byte[x+1]
    add al, byte[y+1]
    mov bl,10
    div bl
    mov byte[z+2],ah;z2 = ( x1+y1 )%10


    movzx ax,al;carry saved to eax
    add al, byte[x]; carry + x0 + y0
    add al, byte[y]
    mov bl,10
    div bl

    mov byte[z+1],ah ; z1 = (carry + x0 + y0) % 10
    mov byte[z], al  ; z0 = carry / 10

    add byte[z],30h
    add byte[z+1],30h
    add byte[z+2],30h

    mov eax,4
    mov ebx,1
    mov ecx,z
    mov edx,3
    int 80h

    mov eax,1 
    mov ebx,0
    int 80h

    _printN:
    mov eax,4
    mov ebx,1
    mov ecx,10
    mov edx,1
    int 80h
    ret

    _readN:
    mov eax,3
    mov ebx,0
    mov ecx,n
    mov edx,1
    int 80h
    ret
