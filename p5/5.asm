section .data
prmpt1 : db "Enter input string : ", 0
lprmpt1 : equ $-prmpt1
prmpt2 : db "Enter word to find and replace: ", 0
lprmpt2 : equ $-prmpt2
prmpt3 : db "Enter word to replace with: " , 0
lprmpt3 : equ $-prmpt3
invalid : db "Word was not found",0
linvalid : equ $-invalid
s : times 100 db 0
f : times 20 db 0
r : times 20 db 0
left : times 100 db 0
right : times 100 db 0
section .bss
x : resb 1
fn : resb 1
sn : resb 1
rn : resb 1
i : resb 1
flag : resb 1
n1 : resb 1
n2 : resb 1

; while(f[j] == r[j] )
    ;if(fj == ' ')
        ;break
    ;
section .text
global _start
_start:
    push rbp
    mov rbp, rsp
    
    mov rax, 4
    mov rbx, 1
    mov rcx, prmpt1
    mov rdx, lprmpt1
    int 80h

    mov rsi, s 
    mov rdi, 0
    call read_str
    mov rax, rdi
    mov byte[sn]  ,al 
    mov byte[i], 0

    mov rax, 4
    mov rbx, 1
    mov rcx, prmpt2
    mov rdx, lprmpt2
    int 80h

    mov rsi, f
    mov rdi, 0
    call read_str
    mov rax, rdi
    mov byte[fn], al
    mov byte[i], 0
    
    mov rsi, s
    mov rdi, f
    call find_word 
    cmp rax, 0
    je _invalid 
    push rsi
    push rsi
    push rax

    mov rax, 4
    mov rbx, 1
    mov rcx, prmpt3
    mov rdx, lprmpt3
    int 80h

    pop rax
    
    mov byte[i], 0
    mov rsi, r
    mov rdi, 0
    call read_str
    mov rax, rdi
    mov byte[rn],al 

    pop rdi
    movzx rax, byte[fn]
    inc rax
    add rdi, rax 
    mov rsi, rdi
    call str_len
    mov byte[n2], cl
    mov rsi, r
    call str_len
    mov byte[n1], cl
    mov r8, right
    call concatenate

    pop rsi
    mov byte[rsi], 0
    mov rsi, s
    call str_len
    mov byte[n1], cl
    mov rdi, right
    mov rsi, right
    call str_len
    mov byte[n2], cl
    mov rsi, s
    mov r8, left
    call concatenate
    
    mov rsi, left
    call print_str
    jmp _exit

_invalid:
    mov rax, 4
    mov rbx, 1
    mov rcx, invalid
    mov rdx, linvalid
    int 80h
    
_exit:
    pop rbp
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
    inc rdi
    jmp read_str

read_str_return:
    movzx rbx, byte[i]
    add rbx, rsi
    mov byte[rbx],0
    inc byte[i] 
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
    mov rcx, rsi 
    int 80h

    ret
find_word:
    mov byte[i] , 0
find_word_c:
    mov bl, byte[i]
    cmp bl, byte[sn]
    jg find_word_exit
find_word_loop:
    mov byte[flag], 1
    movzx rcx, byte[fn]
    cld
    push rsi
    push rdi
    REP CMPSB 
    jne nomatch
    match:
    pop rdi
    pop rsi
    mov rax, rsi;
    movzx rbx, byte[fn]
    sub rax, rbx 
    ret
    jmp find_word_c

    nomatch:
    pop rdi
    pop rsi
    mov byte[flag] ,0
    inc rsi
    inc byte[i]
    jmp find_word_c
find_word_exit: 
    mov rax, 0
    ret

concatenate:
str1:
    mov byte[i], 0
    mov cl, byte[n1]
str1l:
    cmp byte[i] , cl 
    jge str2
    movzx rax, byte[i]
    add rax, rsi
    mov dl, byte[rax]
    movzx rbx, byte[i]
    add rbx, r8 
    inc byte[i]
    mov byte[rbx], dl
    jmp str1l
str2:
    movzx rbx, byte[i]
    add rbx, r8
    mov byte[rbx], 32
    inc cl
    inc byte[i]

    mov dl, byte[n2]
    add cl, dl

str2l:
    cmp byte[i], cl
    jge concat_end

    mov rdx, 0
    movzx rax,byte[i]
    mov dl, byte[n1]
    sub rax, rdx 
    dec rax
    add rax, rdi ; rax = b+i, 

    mov dl, byte[rax] ;dl = *(b+i)

    movzx rbx, byte[i]; rbx = s +i
    add rbx, r8
    mov byte[rbx], dl ; *(s+i) = dl
    inc byte[i]
    jmp str2l
concat_end:
    ret 

str_len:
    mov rcx, 0
str_len_loop:
    cmp byte[rsi+rcx], 0
    je str_len_ret
    inc rcx
    jmp str_len_loop
str_len_ret:
    ret
