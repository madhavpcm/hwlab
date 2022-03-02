section .data
newl : db 10
section .bss
newline : resb 1
inp : resb 1
num : resd 1
pcount : resw 1
section .text
global _start

_start:
    mov dword[num], 0
    mov word[pcount], 0
    call read_int
    call print_int
    call read_int
    call print_int
exit:
    mov eax, 1
    mov ebx, 0
    int 80h

read_int: 
    push rbp
    mov rbp, rsp

    mov eax, 3
    mov ebx, 0
    mov ecx, inp 
    mov edx, 1
    int 80h
read_int_loop:
    movzx eax, byte[inp]
    sub eax,48
    cmp eax,0
    jl read_int_exit

    sub byte[inp], 48
    mov ebx,10
    mov eax, dword[num] 
    mul ebx 
    movsx ecx, byte[inp]
    add eax, ecx 
    mov dword[num] , eax

    mov eax, 3
    mov ebx, 0
    mov ecx, inp 
    mov edx, 1
    int 80h

    jmp read_int_loop
read_int_exit:
    pop rbp
    ret


print_int:
    mov word[pcount], 0
    push rax 
    push rbx 
    push rcx 
    push rdx 
    push rdi
    push rsi
    push rbp
    mov rbp, rsp
    mov rdx,0
push_int_to_stack:
    cmp word[num], 0
    je print_num
    inc word[pcount]
    mov edx, 0 
    mov eax, dword[num]
    mov ebx, 10
    div ebx
    push rdx
    mov dword[num], eax
    jmp push_int_to_stack
    
print_num:
    cmp word[pcount], 0
    je print_int_end
    dec word[pcount] 
    pop rdx
    mov byte[inp], dl
    add byte[inp], 30h
    mov eax, 4
    mov ebx, 1
    mov ecx,inp
    mov edx, 1
    int 80h
    jmp print_num
print_int_end:
    mov eax,4
    mov ebx,1
    mov ecx,newl
    mov edx,1
    int 80h

    pop rbp
    pop rsi
    pop rdi
    pop rdx
    pop rcx
    pop rbx
    pop rax
    ret
