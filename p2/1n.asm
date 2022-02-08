section .data
mssg : db "Enter any key",10
lmssg : equ $-mssg

yes : db "Capslock is ON", 10
lyes : equ $-yes

no : db "Capslock is OFF", 10
lno : equ $-no

section .bss
var : resb 1
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
    mov ecx,var
    mov edx,1
    int 80h
     
    cmp byte[var], 65
    jge ys
    jmp nno
    ys:
        cmp byte[var],90
        jle yss
        jmp nno

    yss:
        mov eax,4
        mov ebx,1
        mov ecx,yes
        mov edx,lyes
        int 80h

        jmp exit
    
    nno:
        mov eax,4 
        mov ebx,1
        mov ecx,no
        mov edx,lno
        int 80h

        jmp exit

    exit:  
        mov eax,1
        mov ebx,0
        int 80h