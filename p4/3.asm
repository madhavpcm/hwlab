section .data
s1 : times 100 db 0
s2 : times 100 db 0
s : times 200 db  0
section .bss
x : resb 1
inp : resb 1
i : resb 1
n1 : resb 1
n2 : resb 1
section .text
global _start:

_start:
    mov byte[i], 0
    mov rsi, s1
    call read_str
    mov al, byte[i]
    mov byte[n1], al
    mov byte[i], 0

    mov rsi, s2
    call read_str
    mov al, byte[i]
    mov byte[n2], al
    mov byte[i], 0

    mov rsi, s1
    mov rdi, s2
    call concatenate
    
    mov rsi, s
    call print_str
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

concatenate:
str1:
    mov cl, byte[n1]
    dec cl
str1l:
    cmp byte[i] , cl 
    jge str2
    movzx rax, byte[i]
    add rax, rsi
    mov dl, byte[rax]
    movzx rbx, byte[i]
    add rbx, s 
    inc byte[i]
    mov byte[rbx], dl
    jmp str1l
str2:
    mov dl, byte[n2]
    add cl, dl
    dec cl

str2l:
    cmp byte[i], cl
    jge concat_end

    mov rdx, 0
    movzx rax,byte[i]
    mov dl, byte[n1]
    sub rax, rdx 
    inc rax
    add rax, rdi ; rax = b+i, 

    mov dl, byte[rax] ;dl = *(b+i)

    movzx rbx, byte[i]; rbx = s +i
    add rbx, s
    mov byte[rbx], dl ; *(s+i) = dl
    inc byte[i]
    jmp str2l
concat_end:
    ret 

print_str:
    mov rcx, 0
print_str_l:
    mov rax, rsi
    add rax, rcx 
    cmp byte[rax], 0
    je print_str_int
    inc rcx 
    jmp print_str_l
print_str_int:
    mov rax, 4
    mov rbx, 1
    mov rdx, rcx
    mov rcx, s
    int 80h

    ret
