section .data
mssg : db "Enter a number: "
l_mssg : equ $-mssg

e: db "Number is Even",10
l_even : equ $-e

o: db "Number is Odd",10
l_odd : equ $-o

section .bss
c : resb 1
prev : resb 1

section .text
global _start:
    _start: 
        call read
        
        mov al,byte[prev] 
        mov bl,2
        div bl

        cmp ah, 0
        je even
        jmp odd 

    read:
        mov eax,[c]
        mov [prev],eax

        mov eax,3
        mov ebx,0
        mov ecx,c
        mov edx,1
        int 80h

        cmp byte[c],10
        jne read
        ret

    even:
        mov eax,4 
        mov ebx,1
        mov ecx,e
        mov edx,l_even
        int 80h
        
        jmp exit

    odd:
        mov eax,4
        mov ebx,1
        mov ecx,o
        mov edx,l_odd
        int 80h

        jmp exit

    exit:
        mov eax,1
        mov ebx,0
        int 80h

