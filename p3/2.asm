section .data
arr : times 100 dd 0
msg : db "Enter number of elements to be entered: ",0
imsg : db "Enter array[%d]: ",0
fin : db  "%d",0
fout : db "%d ",0
savg : db "Average: %d",10,0
ssum : db "Sum: %d",10,0
section .bss
i : resd 1
n : resw 1
x : resd 1
sum : resd 1
avg : resd 1
index : resd 1
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
    loop_condition:
        movzx ebx, word[n]
        cmp dword[i] , ebx 
        jl loop_body
    loop_body:
        mov rdi, fin
        mov rsi, x
        call scanf

        mov eax, dword[x]
        add dword[sum],eax 
        mov ebx, dword[i]
        shl ebx, 2
        add ebx, arr
        mov dword[ebx],eax
        inc dword[i]
        jmp loop_condition
    
    mov eax, dword[sum]
    mov ebx,0
    mov bx, word[n]
    mov edx,0
    div bx

    mov dword[avg],0
    mov [avg], ax

    mov rdi, ssum
    mov rsi, [sum]
    call printf

    mov rdi, savg
    mov rsi, [avg]
    call printf

    mov rax, 1
    mov rbx, 0
    int 80h

    
