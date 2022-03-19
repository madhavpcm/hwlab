section .data
prmpt : db "Enter a string : ", 0
lprmpt : equ $-prmpt
inp : times 100 db 0
section .bss
pcount : resw 1
ix : resb 1
x : resb 1
i : resb 1
newl : resb 1
j : resb 1
mn : resb 1
mx : resb 1
mni : resq 1
mxi : resq 1
num : resd 1
section .text
global _start
_start:
	mov byte[newl], 10
	mov byte[i], 0
	mov byte[j], 0
	mov byte[mn], 100
	mov byte[mx], 0
	mov rsi, inp
	call read_str	
	mov rsi, inp
	call mxmnloop
	movzx eax, byte[mx]
	mov dword[num], eax
	call print_int
	movzx eax, byte[mn]
	mov dword[num], eax
	call print_int
	mov rsi,qword[mxi]
	call print_str 
	mov rax ,4
	mov rbx, 1
	mov rcx, newl
	mov rdx, 1
	int 80h
	mov rsi,qword[mni] 
	call print_str 
	mov rax ,4
	mov rbx, 1
	mov rcx, newl
	mov rdx, 1
	int 80h
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
	mov al, 0
	movzx rbx, byte[i]
	add rbx, inp
	mov byte[rbx], al

	ret

mxmnloop:
	mov byte[j], 0
	mov byte[i], 0
	mov rax, rsi	
mxmnloopcontrol:
	cmp byte[rax], 32
	je reset
	cmp byte[rax], 0
	je mxmnexit
	inc byte[j]		
	inc rax
	jmp mxmnloopcontrol
	reset:
	mov cl, byte[mn]
	mov dl, byte[mx]
	cmp byte[j], cl
	jle minyes
	cmp byte[j], dl	
	jge maxyes
	
	minyes:
		mov cl, byte[j]
		mov byte[mn], cl
		movzx rcx, byte[j]
		mov rbx, rax
		sub rbx, rcx
		mov qword[mni], rbx
		
		mov dl, byte[mx]
		cmp byte[j], dl	
		jg maxyes
		inc rax
		mov byte[j], 0
		jmp mxmnloopcontrol


	maxyes:
		mov cl, byte[j]
		mov byte[mx], cl
		movzx rcx, byte[j]
		mov rbx, rax
		sub rbx, rcx
		mov qword[mxi], rbx
		inc rax
		mov byte[j], 0
		jmp mxmnloopcontrol
mxmnexit:
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
    mov byte[ix], dl
    add byte[ix], 30h
    mov eax, 4
    mov ebx, 1
    mov ecx, ix
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

print_str:
    mov rcx, 0
print_str_l:
    mov rax, rsi
    add rax, rcx 
    cmp byte[rax], 0
    je print_str_int
    cmp byte[rax], 32 
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
