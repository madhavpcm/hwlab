.text
main:
    li $v0, 4
    la $a0, msg1 
    syscall

    li $v0, 5
    syscall
    
    move $t0,$v0
    li $t1, 0 #fa
    li $t2, 1 #fb
    li $t3, 0 #index

loop:
    beq $t0, $t3,exit
    addi $t3,$t3,1
    
    #print fb
    li $v0, 1
    move $a0, $t1
    syscall

    move $t4, $t2
    add $t2, $t2, $t1# fb= fb+fa
    move $t1, $t2 # fa = fb
    move $t1, $t4
    
    li $v0, 4
    la $a0, spc
    syscall
    j loop
exit:
    li $v0, 10
    syscall

.data
msg1: .asciiz "Enter n no:"
spc: .asciiz " "
