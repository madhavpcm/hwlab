SECTION .data

SECTION .bss
name : resb 1
l_name : resb 1 
SECTION .text

global _start:
_start:
    mov eax,3
    mov ebx,0
    mov ecx, name
    mov edx, l_name
    int 80h

    mov eax,4
    mov ebx,1
    mov ecx, name 
    mov edx, l_name
    int 80h

    mov eax,1
    mov ebx,0
    int 80h



