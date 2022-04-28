section .data
    msg1: db 'Enter a string'
    size1: equ $-msg1
    
    nl: db 10
    size: equ $-nl
    

section .bss
    string0:    resb 50
    pointer:    resd 50
    str_len:    resd 1
    count:      resd 1
    temp:       resd 1

section .txt
global _start
    _start:
        mov eax, 4
        mov ebx, 1
        mov ecx, msg1
        mov edx, size1
        int 80h
        
        mov ecx, string0
    
        call read_string
    
        mov ecx, [temp]
        mov [str_len], ecx
        
        mov ecx, string0
        mov dword[pointer], ecx
        add dword[pointer], 4
        inc ecx
        
        call read_words
        
        mov ecx, [temp]
        mov [count], ecx
        
        mov ecx, pointer
        
        call print_words
    
        mov ebx, 0
        mov eax, 1
        int 80h
        
read_string:
    pusha
    
    mov edi, 0 ; count = 0
    mov edx, 1
    mov ebx, 0
    
    read_string_loop:
        mov eax, 3
        int 80h
        
        cmp byte[ecx], 10
            je end_reading_string_loop
        
        inc edi ; count++
        inc ecx
    jmp read_string_loop
    
    end_reading_string_loop:
        mov byte[ecx], 0
        mov [temp], edi
    popa
    ret

print_string:
    pusha
    
    mov edx, 1
    mov ebx, 1
    
    print_string_loop:
        cmp byte[ecx], 0
            je end_printing_string_loop
        
        mov eax, 4
        int 80h
        
        inc ecx
    jmp print_string_loop
    
    end_printing_string_loop:
    popa
    ret
    
read_words:
    pusha
    mov edi, 0 ;count of words
    read_words_loop:
        cmp byte[ecx], 10
            je end_read_words
        
        
        cmp byte[ecx], ' '
            je new_word
            
        inc ecx
        jmp read_words_loop
        
    new_word:
        inc ecx ; to get to the next letter after ' '
        mov dword[pointer], ecx
        add dword[pointer], 4
        inc ecx
        inc edi ;count++
        jmp read_words_loop
        
    end_read_words:
    mov [temp], edi ;copy size to edi
    mov dword[pointer], 0
    
    popa
    ret
    
    
    
print_words:
    pusha
    
    mov eax, 4
    mov ebx, 1
    print_words_loop:
        cmp byte[ecx], 0
            je end_print_words_loop
        
        mov edi, 4
        int 80h
        
        inc ecx
    end_print_words_loop:
    popa 
    ret
