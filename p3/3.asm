section .data
arr : times 100 dd 0
fin : db "%d",0
shigh : db "Highest Occurence number: %d %d times",10,0
slow : db "Lowest Occurence number: %d %d times", 10,0
msg : db "Enter number of elements to process: ",0
section .bss
i : resd 1
n : resd 1
x : resd 1
mx : resd 1
mn : resd 1
mxi : resd 1
mni : resd 1
section .text
global main
extern scanf 
extern printf

main:
    push rbp

    mov dword[i],0
    mov rdi,msg 
    call printf

    mov rdi,fin
    mov rsi, n
    call scanf 
     
    loop_condition:
        mov ebx, dword[n]
        cmp dword[i] , ebx 
        jl loop_body
        jmp loop_exit
    loop_body:
        mov rdi, fin
        mov rsi, x
        call scanf

        mov ebx, dword[x]
        shl ebx, 2
        add ebx, arr
        inc dword[ebx]

        inc dword[i]
        jmp loop_condition
    loop_exit: 

    mov dword[mx], 1
    mov dword[mn], 99

    mov ecx, mx
    mov edx, mn
    cloop_condition:
        mov ebx, dword[n]
        cmp dword[i], 100 
        jl cloop_body
        jmp cloop_exit
    cloop_body:
        mov ebx, dword[i]
        shl ebx, 2
        add ebx, arr ; ebx = arr+i

        mov eax, dword[mn]; eax = mn
        cmp dword[ebx], eax  ; arr[i] < mn ?
        jge c1 

        cmp dword[ebx], 0; arr[i] != 0
        je c1
        mov eax, dword[ebx]
        mov dword[mn], eax ;  mn = arr[i]
        mov eax, dword[i]
        mov dword[mni] , eax  ; mxi = i

        c1:

        mov eax,dword[mx]
        cmp dword[ebx], eax ; arr[i] > mx ?
        jle c2
        mov eax,dword[ebx]
        mov dword[mx], eax; mx = arr[i]
        mov eax, dword[i]
        mov dword[mxi], eax
        c2:


        inc dword[i]
        jmp cloop_condition
    cloop_exit:

    mov rax, 0
    mov ebx, dword[mxi]
    shl ebx, 2
    add ebx, arr
    mov rcx, [ebx] 

    mov rdi, shigh
    mov rdx, rcx
    mov rsi, [mxi]
    call printf

    mov rax, 0
    mov ebx, dword[mni]
    shl ebx, 2
    add ebx, arr
    mov rcx, [ebx]

    mov rdi, slow
    mov rdx, rcx
    mov rsi, [mni]
    call printf

    mov eax, 1
    mov ebx, 0
    int 80h
    pop rbp