section .data
s1 : times 100 db 0
s2 : times 100 db 0
s : times 200 db  0
msg : db "Number of vowels occured is :"
lmsg : equ $-msg
newl : db 10
section .bss
x : resb 1
inp : resb 1
i : resb 1
n1 : resb 1
n2 : resb 1
num : resd 1
pcount : resw 1
count : resw 1
section .text
global _start:

_start:
    mov byte[i], 0
    mov word[count], 0
    mov word[pcount], 0
    mov rsi, s1
    call read_str
    mov al, byte[i]
    mov byte[n1], al
    mov byte[i], 0

    mov rsi, s1
    call count_space 
    
_exit:
    mov rax, 1
    mov rbx, 0
    int 80h

read_str:
    mov rax, 3
    mov rbx, 0
    mov rcx, x 
    mov rdx, 1
    int 80h 

    cmp byte[x] , 10
    je read_str_return 

    mov al, byte[x]
    movzx rbx, byte[i] 
    add rbx, rsi 
    mov byte[rbx], al
    inc byte[i]
    jmp read_str

read_str_return:
    movzx rbx, byte[i]
    add rbx, rsi
    mov byte[rbx],0
    inc byte[i] 
    ret

count_space:
    mov byte[i], 0
    mov cl , byte[n1]
count_cmp:
    cmp byte[i], cl
    jge end_count_space
    movzx rax, byte[i]
    add rax, rsi
    cmp byte[rax], 65 
    je yes
    cmp byte[rax], 69
    je yes
    cmp byte[rax], 73
    je yes
    cmp byte[rax], 79
    je yes
    cmp byte[rax], 85
    je yes
    cmp byte[rax], 97
    je yes
    cmp byte[rax], 101 
    je yes
    cmp byte[rax], 105 
    je yes
    cmp byte[rax], 111 
    je yes
    cmp byte[rax], 117 
    je yes
    no:
        inc byte[i]
        jmp count_cmp
    yes:
        inc byte[i] 
        inc word[num]
        jmp count_cmp
end_count_space:
    mov rax,4
    mov rbx,1
    mov rcx,msg
    mov rdx,lmsg
    int 80h
    
    call print_int
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
