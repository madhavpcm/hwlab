section .data

section .bss
newline : resb 1
inp : resb 1
num : resd 1
section .text
global _start

_start:
    mov dword[num], 0
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
    push rbp
    mov rbp, rsp

    mov edx, 0
    mov ebx, 0
    mov bx, 10

print_int_loop:
    push rbp
    mov rbp, rsp
    sub rsp, 8
    mov qword [rsp - 8] ,0
    print_loop_begin:
    cmp dword[num] , 0
    jle print_int_exit
    mov edx, 0
    mov eax, dword[num]
    mov ebx,10
    div ebx
    
    mov dword[num],eax

    mov byte[inp], dl
    add byte[inp], 30h

    movsx rax,byte[inp]
    push rax
    inc qword[rsp - 8]

    jmp print_loop_begin 
    
print_int_exit:
    cmp dword[rsp - 8] , 0
    jle print_int_real_exit
    dec dword[rsp - 8]
    pop rax
    mov byte[inp], al

    mov eax, 4
    mov ebx, 1
    mov ecx, inp
    mov edx, 1
    int 80h

    jmp print_int_exit
print_int_real_exit:
    add rsp, 8
    pop rbp
    ret

