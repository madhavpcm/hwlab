section .data
mssg: db "Enter a number ( 3 digits ):",10
lmssg: equ $-mssg

ys: db "Yes this number is prime",10
lys: equ $-ys
no: db "No this number is not prime",10
lno: equ $-no
section .bss
x : resb 3
i : resb 1
y : resw 1
section .text
global _start:
    _start:
    mov eax, 4
    mov ebx, 1
    mov ecx, mssg
    mov edx, lmssg
    int 80h

    mov eax,3
    mov ebx,0
    mov ecx,x
    mov edx,3
    int 80h

    mov eax,3
    mov ebx,0
    mov ecx,i
    mov edx,1
    int 80h

    mov byte[i],1
    mov word[y],0

    sub byte[x], 30h
    sub byte[x+1], 30h
    sub byte[x+2], 30h

    movzx eax, byte[x]
    mov ebx, 100
    mul ebx
    mov word[y],ax

    movzx eax,byte[x+1]
    mov ebx,10
    mul ebx
    add word[y],ax
    mov eax, 0
    mov al, byte[x+2]
    add word[y],ax
    mov cx, word[y] 
    call isPrime 

    cmp eax, 1
    je yz

    mov eax,4
    mov ebx,1
    mov ecx,no
    mov edx,lno
    int 80h

    jmp exit

    yz:
        mov eax,4
        mov ebx,1
        mov ecx,ys
        mov edx,lys
        int 80h
    
    exit:
        mov eax,1
        mov ebx,0
        int 80h

isPrime:
    inc byte[i]
    mov al, byte[i]
    mul al

    cmp ax , cx
    jle _yes
    _no:
        mov eax,1
        ret
    _yes:
        mov ax, word[y]
        mov dx, 0
        mov bl, byte[i]
        div bl

        cmp ah, 0
        jne isPrime

        mov eax, 0
        ret
