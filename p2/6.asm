section .data

section .bss

section .data
mssg : db "Enter a 2 digit number",10
lmssg : equ $-mssg

section .bss
x : resb 2
y : resb 2
section .text

global _start:
    _start:
;int hcf(int a, int b)
;{
    ;if (a == 0)
        ;return b;
    ;else if (b == 0)
        ;return a;
    ;while (a != b) {
        ;if (a > b)
            ;a = a - b;
        ;else
            ;b = b - a;
    ;}
    ;return a;
;}
    mov eax,4
    mov ebx,1
    mov ecx,mssg
    mov edx,lmssg
    int 80h
    
    mov eax,3
    mov ebx,0
    mov ecx,x
    mov edx,2
    int 80h

    mov eax,3
    mov ebx,0
    mov ecx,y
    mov edx,1
    int 80h
    
    mov eax,4
    mov ebx,1
    mov ecx,mssg
    mov edx,lmssg
    int 80h

    mov eax,3
    mov ebx,0
    mov ecx,y
    mov edx,2
    int 80h

    sub byte[x], 30h
    sub byte[x+1], 30h
    sub byte[y], 30h
    sub byte[y+1], 30h

    mov eax, 0
    mov al , byte[x]
    mov bl ,10
    mul bl
    add al, byte[x+1]
    mov byte[x],al

    mov eax, 0
    mov al , byte[y]
    mov bl ,10
    mul bl
    add al, byte[y+1]
    mov byte[y],al

    mov al, byte[x]
    mov bl, byte[y]
    
    call euclid
    mov byte[x] ,al

    mov bl, 10
    div bl

    mov byte[x] , al
    mov byte[x+1], ah

    add byte[x],30h
    add byte[x+1],30h

    mov eax,4
    mov ebx,1
    mov ecx,x
    mov edx,2
    int 80h

    jmp exit
euclid:
    cmp al, 0
    je _b
        cmp bl, 0
        je _a
        ;while
            while:
                cmp al,bl
                jne _loop
                ret
                _loop:
                    cmp al,bl
                    jle _if 
                    _else:
                        sub al,bl
                        jmp while 
                    _if:
                        sub bl,al
                        jmp while

                ret
            _b:
                mov al, bl
                ret
            _a:
                ret
exit:
    mov eax,1
    mov ebx,0
    int 80h