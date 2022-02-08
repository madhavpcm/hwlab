SECTION .data
name : db 'Madhav',0ah
l_name : equ $-name
addr : db 'Kochi Kerala',0ah
l_addr : equ $-addr

SECTION .text

global _start:
_start:
    mov eax,4
    mov ebx,1
    mov ecx, name
    mov edx, l_name
    int 80h

    mov eax,4
    mov ebx,1
    mov ecx, addr 
    mov edx, l_addr
    int 80h

    mov eax,1
    mov ebx,0
    int 80h
