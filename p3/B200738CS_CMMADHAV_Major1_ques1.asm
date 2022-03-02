section .data
arr : times 1000 db 0
section .bss
newline : resb 1
inp : resb 1
num : resd 1
i : resw 1
n : resw 1
p : resd 1
pi : resd 1
pn : resd 1
sum : resd 1
section .text
global _start

_start:
    push rbp
    mov rbp,rsp
    ;init
    mov dword[num], 0
    mov word[i] ,0
    mov dword[sum], 0
    ;read init till eof or endline
    call read_int
    mov ax, word[i]
    mov word[n], ax
    mov word[i], 0
    call traverse_arr
    mov eax, dword[sum]
    mov dword[num] ,eax
    call print_int
exit:
    mov eax, 1
    mov ebx, 0
    int 80h
    pop rbp

read_int: 
    push rbp
    mov rbp, rsp
read_int_start:
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
    add eax, 48
    cmp eax, 10
    je read_int_real_exit
    
    movsx eax, word[i]
    shl eax, 2
    add eax, arr

    mov ebx, dword[num]
    mov dword[eax], ebx
    mov dword[num], 0

    inc word[i]
    jmp read_int_start 
read_int_real_exit:
    movsx eax, word[i]
    shl eax, 2
    add eax, arr

    mov ebx, dword[num]
    mov dword[eax], ebx
    mov dword[num], 0

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
    cmp dword[rsp - 8] , 1
    jle print_int_real_exit
    dec dword[rsp - 8]
    pop rax
    mov byte[inp], al

    mov rax, 4
    mov rbx, 1
    mov rcx, inp
    mov rdx, 1
    int 80h

    jmp print_int_exit
print_int_real_exit:
    add rsp, 8
    pop rbp
    ret

traverse_arr:
    push rbp
    mov rbp,rsp
    tloop_c:
        mov ax, word[i] 
        cmp ax, word[n]
        jle tloop_b
        jmp tloop_e
    tloop_b:
        movsx ebx, word[i]
        shl ebx, 2
        add ebx, arr
        
        mov eax, dword[ebx]
        mov dword[p], eax

        call isprime

        cmp eax, 0
        je no
        yes:
        mov eax, dword[p]
        add dword[sum], eax
        no:
        inc word[i]
        jmp tloop_c
    tloop_e:
    pop rbp
    ret
    
isprime:
    ;eax  = p
    push rbp
    mov rbp, rsp
    push rbx
    push rcx
    push rdx
    mov edx, 0
    mov dword[pi] , 2
    mov dword[pn] , eax
    shr dword[pn] , 1
    mov ecx , dword[pn]
    cmp dword[p],2
    jle nno 

    ploop_c:
        cmp dword[pi], ecx
        jle ploop_b
        jmp ploop_e
    ploop_b:
        mov eax, dword[p] 
        mov edx, 0
        mov ebx, dword[pi]
        div ebx
        inc dword[pi]

        cmp edx, 0
        jne ploop_c  
        nno:
        mov eax, 0 
        jmp isprimeexit
    ploop_e:
    
    mov eax, 1
    isprimeexit:
    pop rdx
    pop rcx
    pop rbx
    pop rbp
    ret
