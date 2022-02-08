section .data
mssg : db "Enter a key :"
lmssg : equ $-mssg

yes : db "Capslock is ON", 0
lyes : equ $-yes

no : db "Capslock is OFF", 0
lno : equ $-no

section .bss
var : resb 1

section .text
global _start:
    _start:
        mov eax, 4
        mov ebx, 1
        mov ecx, mssg
        mov edx, lmssg
        int 80h

        mov eax, 3
        mov ebx, 0
        mov ecx, var
        mov edx, 1
        int 80h

        mov eax, 3
        mov ebx, 0
        mov ecx, var
        mov edx, 1
        int 80h


        in al, 64h
        and al, 40h

        cmp al, 40h
        je _yes
        
        mov eax,4
        mov ebx,1
        mov ecx,no
        mov edx,lno
        int 80h

        call exit

    _yes: 
        mov eax,4
        mov ebx,1
        mov ecx,yes
        mov edx,lyes
        int 80h

        call exit


    exit:

        mov eax,1
        mov ebx,0
        int 80h
