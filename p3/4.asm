section .data
arr : times 100 dd 0
msg : db "Enter number of elements to be entered: ",0
imsg : db "Enter array[%d]: ",0
msg1 : db "Enter the value to be searched: ",10,0
yes : db "Element found at index %d!",10,0
nno : db "Element Not found!",10,0
fin : db  "%d",0
fout : db "%d ",0
section .bss
i : resd 1
n : resd 1
x : resd 1
sum : resd 1
avg : resd 1
index : resd 1
flag : resb 1
section .text
global main
extern scanf
extern printf

main:
    push rbp
    
    mov rdi, msg
    call printf

    mov rdi, fin
    mov rsi, n
    call scanf

    mov dword[i], 0
    mov dword[index], 0
    mov dword[sum],0
    rloop_inv:
        movzx ebx, word[n]
        cmp dword[i] , ebx 
        jl rloop_body 
        jmp rloop_exit
    rloop_body:
        mov rdi, fin
        mov rsi, x
        call scanf
        mov eax, dword[x]
        mov ebx, dword[i]
        shl ebx, 2
        add ebx, arr
        mov dword[ebx],eax
        inc dword[i]
        jmp rloop_inv
    rloop_exit: 
    mov rdi, msg1
    call printf

    mov rdi, fin
    mov rsi, x
    call scanf
    mov ecx, dword[x]
    mov byte[flag], 0
    mov dword[i],0
    cloop_inv:
        movzx ebx, word[n]
        cmp dword[i], ebx
        jl cloop_body
        jmp cloop_exit
    cloop_body:
        mov ebx, dword[i]
        shl ebx, 2
        add ebx, arr

        cmp ecx, dword[ebx]
        jne no 
        mov byte[flag], 1
        mov rdi, yes 
        mov rsi, [i]
        call printf
        no:
        inc dword[i]
        jmp cloop_inv
    cloop_exit:

    cmp byte[flag] , 0
    jne exit

    mov rdi, nno
    call printf

exit:
    mov eax, 1
    mov ebx, 0
    int 80h

