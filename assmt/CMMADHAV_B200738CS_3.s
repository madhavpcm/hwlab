.text
main:
    li $v0, 4
    la $a0, msg1 
    syscall

    li $v0, 8
    la $a0, str1
    li $a1, 100
    syscall
    
    li $v0, 4
    la $a0, msg2
    syscall

    li $v0, 8
    la $a0, str2
    li $a1, 100
    syscall
    
    la $a0, str1
    jal str_len
    move $s0, $a0

    la $a0, str2
    jal str_len

    move $s1, $a0

    la  $a0, str3
    la  $a1, str1
    move $a2, $s0
    jal str_cpy

    la $a0, str3
    addu $a0, $a0, $s0
    la $a1, str2
    move $a2, $s1
    jal str_cpy
    
    li $v0, 4
    la $a0, str3
    syscall

    li $v0, 10
    syscall
    
  str_len: 
    li $t1, 0
    str_len_body:
      lb $t2,0($a0)
      beq $t2, 10, str_len_ret
      addiu $t1, 1
      addiu $a0, 1
      j str_len_body
    str_len_ret:
    move $a0, $t1
    jr $ra

  str_cpy:
      #// a0: new str
      #// a1: source str
      #// a2: number of chars to copy

    li $t0, 0                
    li $t1, 0                
    li $t2, 0                
    li $t3, 0                

    for:
        addu $t1, $a1, $t3     
        lb $t2, 0($t1)         

        addu $t0, $a0, $t3     
        sb $t2, 0($t0)         

        addi $t3, $t3, 1       
        bne $a2, $t3, for      

    jr $ra                      

.data
msg1: .asciiz "Enter Str1 : "
msg2: .asciiz "Enter Str2 : "
str1: .space 100
str2: .space 100
str3: .space 200
