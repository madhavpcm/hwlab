section .data
upper : db "Upper Case",10
l_upper : equ $-upper

lower : db "Lower Case",10
l_lower : equ $-lower

nnot : db "Not a valid alphabet",10
l_not : equ $-nnot

section .bss
c : resb 1

section .text
global _start:
    _start:

    mov eax,3
    mov ebx,0
    mov ecx,c
    mov edx,1
    int 80h

    mov eax, 0
    mov al, byte[c]
    
    cmp al, 65
    jge upper1

        jmp _not

    upper1:
        
        cmp al, 90
        jle upper2
            
            cmp al,97
            jl _not

                cmp al,122
                jg _not

                    mov eax,4
                    mov ebx,1
                    mov ecx,lower
                    mov edx,l_lower
                    int 80h

                    jmp exit 


        upper2:
            
            mov eax,4
            mov ebx,1
            mov ecx,upper
            mov edx,l_upper
            int 80h

            jmp exit 

    _not:

        mov eax,4    
        mov ebx,1
        mov ecx,nnot
        mov edx,l_not
        int 80h

        jmp exit

    exit:

        mov eax,1
        mov ebx,0
        int 80h
