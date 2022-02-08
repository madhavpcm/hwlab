section .data
mssg : db "Enter a 32-bit input",10
lmssg : equ $-mssg
section .bss
x : resb 11
y : resb 11
inp : resb 1
i : resb 1
section .text

global _start:
    _start:
    mov eax,4
    mov ebx,1
    mov ecx,mssg
    mov edx,lmssg
    int 80h
    mov byte[i], 0
    read:
        mov eax,3
        mov ebx,0
        mov ecx,x
        add ecx,byte[i]
        mov edx,1
        int 80h
        inc byte[i]
        mov ebx, x
        add ebx, byte[i] 
        sub ebx, 30h
        mov eax, %ebx
        cmp eax, 10
        jne read 
    
    ;newline
    mov eax,3
    mov ebx,0
    mov ecx,i
    mov edx,1
    int 80h
    ;mssg
    mov eax,4
    mov ebx,1
    mov ecx,mssg
    mov edx,lmssg
    int 80h

    mov byte[i],0
    read:
        mov eax,3
        mov ebx,0
        mov ecx,y
        add ecx,byte[i]
        mov edx,1
        int 80h
        inc byte[i]
        mov ebx, y
        add ebx, byte[i] 
        sub %ebx, 30h
        mov eax, %ebx
        cmp eax, 10
        jne read 



