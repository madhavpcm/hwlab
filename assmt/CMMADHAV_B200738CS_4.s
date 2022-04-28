.text
main:
  li $v0, 4
  la $a0, msg1
  syscall
  
  li $v0, 8
  la $a0, str1 
  li $a1, 200
  syscall
  
  li $s0, 200 #MIN
  li $s1, 0 #MAX
  li $t0, 0 #s2 = Min string addr
            #s3 = Max string addr

  la $a0, str1
  jal word_loop_enter

  move $t1, $s2
  addu $t1, $t1, $s0
  sb $zero, ($t1)

  move $t1, $s3
  addu $t1, $t1, $s1
  sb $zero, ($t1)

  li $v0, 4
  la $a0, msg3
  syscall

  li $v0, 4
  move $a0,$s2 
  syscall

  li $v0, 4
  la $a0, msg4
  syscall 

  li $v0, 4
  la $a0, msg2
  syscall

  li $v0, 4
  move $a0,$s3 
  syscall

  li $v0, 10
  syscall
  
word_loop_enter:
  move $t3, $ra
word_loop:
  jal word_len 
  lb $t2, ($a0)
  beq $t2, 0, word_loop_ret
  beq $t2, 10, reset 
  beq $t2, 32, reset 
  reset:
  blt $t1,$s0, mnyes 
  bgt $t1,$s1, mxyes
  addiu $a0,$a0, 1
  j word_loop

  mnyes:
    move $s2, $a0
    sub $s2, $s2, $t1
    move $s0, $t1
    bgt $t1,$s1, mxyes
    addiu $a0,$a0, 1
    j word_loop

  mxyes:
    move $s3, $a0
    sub $s3, $s3, $t1
    move $s1, $t1
    addiu $a0,$a0, 1
    j word_loop

  word_loop_ret:
  move  $ra,$t3
  jr $ra

word_len: 
  li $t1, 0
  word_len_body:
    lb $t2,0($a0)
    beq $t2, 0, word_len_ret
    beq $t2, 10, word_len_ret
    beq $t2, 32, word_len_ret
    addiu $t1, 1
    addiu $a0, 1
    j word_len_body
  word_len_ret:
  move $a1, $t1
  jr $ra

.data
msg1: .asciiz "Enter a String: "
msg2: .asciiz "The largest word is : "
msg3: .asciiz "The smallest word is : "
msg4: .asciiz "\n"
str1: .space 200
