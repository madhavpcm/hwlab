.text
main:
    li $v0, 4
    la $a0, msg1 
    syscall

    li $v0, 5
    syscall
    
    move $s0,$v0 #A

    li $v0, 4
    la $a0, msg2
    syscall

    li $v0, 5
    syscall

    move $s1, $v0 #B

    move $a0, $s0
    jal isPrime

    move $a0, $s1
    jal isPrime

    move $a0, $s0
    sub $a0, $s0, $s1

    li $t1, 2
    li $t2, -2
    beq $a0, $t1, Yes 
    beq $a0, $t2, Yes
    
    j No

exit:
    li $v0, 10
    syscall

isPrime:
    li $t1, 2 
    beq $a0, 1, No 
    beq $a0, 0, No 
    isPrimeLoop:
    beq $t1, $a0,isPrimeEnd  

    div $a0, $t1
    mfhi $a1 #remainder
    mflo $a2 #quotient

    beq $a1, 0, No 
    add $t1, $t1, 1
    j isPrimeLoop
    isPrimeEnd:
    jr $ra
    
No:
  li $v0, 4
  la $a0, msgn
  syscall

  li $v0, 10
  syscall

Yes:
  li $v0, 4
  la $a0, msgy
  syscall 

  li $v0, 10
  syscall

.data
msg1: .asciiz "Enter 1st no:"
msg2: .asciiz "Enter 2nd no:"
msgn: .asciiz "No they are not twin primes"
msgy: .asciiz "Yes they are twin primes"
spc: .asciiz " "
