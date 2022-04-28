section .data
prmpt : db "Enter string : ", 0
lprmpt : equ $-prmpt
list : times 200 db 0
string : times 200 db 0
newstring : times 200 db 0
newl : db 10, 0
buffer : times 20 db 0
empty : times 20 db 0
section .bss
x : resb 1
i : resb 1
n : resb 1
j : resb 1
section .text

global _start:
_start:
	push rbp
	mov rbp, rsp
    ;
	mov rax, 4
	mov rbx, 1
	mov rcx, prmpt
	mov rdx, lprmpt
	int 0x80

    mov rsi, string	
    call read_str

    mov rsi, string
    mov rdi, list
    call str_to_list
    mov al, byte[i]
    mov byte[n],al
    ;
	mov rsi, list
	call bubble_sort 

	mov rsi, list
	call print_str_in_list
	pop rbp
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
    mov byte[rbx],32
    inc byte[i] 
    ret

str_cpy_hard:
    ; dest <-- src
    ; rdi = destination
    ; rsi = source
    mov rcx, 20
    rep movsb
    ret

word_cpy:
    ; dest <-- src
    ; rdi = destination
    ; rsi = source
    call word_len 
    push rcx
    rep movsb
    pop rcx
    ret
str_len:
    mov rcx, 0
    push rsi    
str_len_body:
    cmp byte[rsi], 0
    je str_len_ret
    inc rcx
    inc rsi
    jmp str_len_body
str_len_ret:
    pop rsi
    ret

word_len:
    mov rcx, 0
    push rsi
word_len_body:
    cmp byte[rsi], 0
    je word_len_ret
    cmp byte[rsi], 32
    je word_len_ret
    inc rcx
    inc rsi
    jmp word_len_body
word_len_ret:
    cmp byte[rsi],32
    je word_len_ret2
    pop rsi
    ret 
word_len_ret2:
    inc rcx
    pop rsi
    ret

str_to_list:
    ;rdi : list input
    ;rsi : string
    mov byte[i], 0
str_to_list_body:
    cmp byte[rsi] , 0
    je str_to_list_end
    push rdi
    call word_cpy 
    pop rdi
    add rdi, 20 ; default word size
    inc byte[i]
    jmp str_to_list_body
str_to_list_end:
    ret

print_str_in_list:
    ;rsi : source
    mov rax, 0
    mov cl, 0
print_srt_in_list_body:
    cmp cl, byte[n] 
    jge print_str_in_list_ret 

    push rcx
    call print_str 
    ;mov rax, 4
    ;mov rbx, 1
    ;mov rcx, newl 
    ;mov rdx, 1 
    ;int 80h
    pop rcx

    add rsi, 20
    inc cl
    jmp print_srt_in_list_body
print_str_in_list_ret:
    ret

print_str:
    call str_len
    mov rax, 4
    mov rbx, 1
    mov rdx, rcx
    mov rcx, rsi
    int 80h
    ret

clear_buffer:
    ;rsi empty string
    ;rdi string to be cleard
    push rsi
    push rdi
    mov rcx, 20
    rep movsb 
    pop rsi
    pop rdi
    ret

str_swap:
    ;rsi string a    
    ;rdi string b
    push rdi; push b 
    push rsi; push a
    mov rdi, buffer; rsi = a, rdi = buffer
    call str_cpy_hard ; #### buffer = a
    
    pop rdi; pop a to rsi
    pop rsi; pop b to rdi
    push rsi; b
    push rdi; a

    call str_cpy_hard; ##### a = b
    
    pop rsi ; a
    pop rdi ; b
    push rsi
    push rdi
    mov rsi, buffer
    call str_cpy_hard ; ##### b= buffer 

    mov rsi, empty 
    mov rdi, buffer 
    call clear_buffer
    pop rdi
    pop rsi
    ret
str_cmp:
    push rbp
    mov rbp, rsp
    ;rsi a
    ;rdi b
    ; ret value in rdx
    push rsi
    push rdi
    call str_len
    rep cmpsb
    jne str_cmp_notequal
    mov rax, 0
    pop rdi
    pop rsi
    pop rbp
    ret
str_cmp_notequal:
    dec rsi
    dec rdi
    movzx rax, byte[rsi]
    mov bl, byte[rdi]
    sub al, bl
    pop rdi
    pop rsi
    pop rbp
    ret
bubble_sort:
    push rbp
    mov rbp,rsp
    ;rsi source 
    push rsi
    mov byte[i], 0
    mov byte[j], 0
for1:
    mov dl, byte[n]
    dec dl
    cmp byte[i],dl
    jge for1_exit 
for2:
    mov dl, byte[n]
    sub dl, byte[i]
    dec dl
    cmp byte[j],dl
    jge for2_exit
for2_body:
    ; a[j] index 
    
    push rdx
    mov rax, 0
    mov bl, byte[j] 
    mov al, 20
    mul bl
     
    mov rsi, qword[rsp+8] 
    add rsi, rax
    
    mov rdi, qword[rsp+8]
    add rdi, rax
    
    add rdi, 20

    push rax
    push rbx
    call str_cmp
    cmp al, 0 
    jle no_swap 
    call str_swap 
    no_swap:
    pop rbx
    pop rax
    pop rdx 
    inc byte[j]
    jmp for2   

for2_exit:
    inc byte[i]
    mov byte[j], 0
    jmp for1

for1_exit:
    pop rsi
    pop rbp
    ret
