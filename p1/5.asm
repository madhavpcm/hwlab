section .data
yes : db 'Greater',10
l_yes : equ $-yes
no : db 'Not greater',10
l_no : equ $-no

section .bss
x : resb 1
y : resb 1
nl : resb 1

section .text
global _start:
    _start:

    mov eax,3
    mov ebx,0
    mov ecx,x
    mov edx,1
    int 80h

    mov eax,3
    mov ebx,0
    mov ecx,y
    mov edx,1
    int 80h

    mov al,byte[x]

    cmp al,byte[y]
    jle _lessereq
;>
    mov eax,4
    mov ebx,1
    mov ecx,yes
    mov edx,l_yes
    int 80h

    jmp _exit
;<=
_lessereq:
    mov eax,4
    mov ebx,1
    mov ecx,no
    mov edx,l_no
    int 80h


_exit:
    mov eax,1
    mov ebx,0
    int 80h

