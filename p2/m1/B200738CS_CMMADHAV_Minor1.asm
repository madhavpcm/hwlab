section .data
sm : db "Sum = ",0
lsm : equ $-sm
res : db "Result = ",0
lres : equ $-res

section .bss
newline : resb 1
x : resb 1
y : resb 1
nl : resb 1
i : resb 1
sum : resb 1
ssum : resb 1
o1 : resb 1
o2 : resb 1

section .text
global _start:
    _start:
        mov byte[newline], 10; set newline
        ; stdin x and y
        mov eax,3
        mov ebx,1
        mov ecx,x
        mov edx,1
        int 80h
        ; remove space
        mov eax,3
        mov ebx,1
        mov ecx,nl
        mov edx,1
        int 80h
    
        mov eax,3
        mov ebx,1
        mov ecx,y
        mov edx,1
        int 80h

        sub byte[x],30h
        sub byte[y],30h
        
        mov al, byte[x]
        mov byte[i], al
        inc byte[i]
        mov byte[sum],0
        mov eax,0
        mov bl, byte[y]
        cmp byte[i],bl 
        jge noloop 
        loop: ; sum to count from x+1 to y-1
            mov eax,0
            mov al, byte[sum]
            add al, byte[i]
            mov byte[sum],al
            inc byte[i]
            mov bl, byte[y] 
            cmp byte[i],bl 
            jl loop
        noloop:
        ;output variables 
        mov byte[o1],0
        mov byte[o2],0
        
        mov ax,0
        mov dx,0
        mov bl , byte[sum]
        mov byte[ssum],bl
        movzx ax, byte[sum]
        mov bl, 10
        div bl

        ;get 10ths and 1ths place by dividing with 10
        mov byte[o1], al; quotient in o1
        mov byte[o2], ah;reminder in o2

        add byte[o1], 30h; ascii
        add byte[o2], 30h
        ;output mssg
        mov eax,4 
        mov ebx,0
        mov ecx,sm
        mov edx,lsm
        int 80h

        ;check if o1 is 0, if so dont print it
        cmp byte[o1], 30h
        je single
        ;both if first is not 0
        mov eax,4
        mov ebx,0
        mov ecx,o1
        mov edx,1
        int 80h
        mov eax,4
        mov ebx,0
        mov ecx,o2
        mov edx,1
        int 80h
    
        jmp nxt
        single:
        ;only 2nd character if first is 0
        mov eax,4
        mov ebx,0
        mov ecx,o2
        mov edx,1
        int 80h
        
        nxt:
        ;print newline
        mov eax,4
        mov ebx,0
        mov ecx,newline
        mov edx,1
        int 80h
        ;roll number division
        movzx ax, byte[ssum]
        mov bl, 8
        div bl

        mov byte[ssum], al

        mov byte[o1],0
        mov byte[o2],0
        
        mov ax,0
        mov dx,0
                    
        movzx ax, byte[ssum]
        mov bl, 10
        div bl

        mov byte[o1], al
        mov byte[o2], ah

        add byte[o1], 30h
        add byte[o2], 30h

        mov eax,4 
        mov ebx,0
        mov ecx,res
        mov edx,lres
        int 80h

        cmp byte[o1], 30h
        je sngl 
        mov eax,4
        mov ebx,0
        mov ecx,o1
        mov edx,1
        int 80h

        mov eax,4
        mov ebx,0
        mov ecx,o2
        mov edx,1
        int 80h

        jmp exit 
        sngl:

        mov eax,4
        mov ebx,0
        mov ecx,o2
        mov edx,1
        int 80h

        exit:
        mov eax,1
        mov ebx,0
        int 80h
