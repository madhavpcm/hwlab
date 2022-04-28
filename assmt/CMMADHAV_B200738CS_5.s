#This is C code compiled using mips-gcc extension, it doenst work And I just put this here for reference.
.data
LC0:

        .asciiz  "%s"
        .text
main:
        addiu   $sp,$sp,-280
        sw      $31,276($sp)
        sw      $fp,272($sp)
        sw      $16,268($sp)
        move    $fp,$sp
        addiu   $2,$fp,36
        move    $5,$2
        lb     $2,16($LC0)
        addiu   $4,$2,($LC0)
        jal     __isoc99_scanf
        nop

        addiu   $2,$fp,136
        move    $5,$2
        lui     $2,($LC0)
        addiu   $4,$2,($LC0)
        jal     __isoc99_scanf
        nop

        addiu   $2,$fp,148
        move    $5,$2
        lui     $2,($LC0)
        addiu   $4,$2,($LC0)
        jal     __isoc99_scanf
        nop

        addiu   $3,$fp,136
        addiu   $2,$fp,36
        move    $5,$3
        move    $4,$2
        jal     strstr
        nop

        sw      $2,28($fp)
        lw      $2,28($fp)
        nop
        sw      $2,24($fp)
        b       $L2
        nop

$L4:
        lw      $2,24($fp)
        nop
        addiu   $2,$2,1
        sw      $2,24($fp)
$L2:
        lw      $2,24($fp)
        nop
        beq     $2,$0,$L3
        nop

        lw      $2,24($fp)
        nop
        lb      $3,0($2)
        li      $2,32                 # 0x20
        bne     $3,$2,$L4
        nop

$L3:
        lw      $3,28($fp)
        addiu   $2,$fp,36
        subu    $2,$3,$2
        sw      $2,32($fp)
        lw      $4,32($fp)
        addiu   $3,$fp,36
        addiu   $2,$fp,160
        move    $6,$4
        move    $5,$3
        move    $4,$2
        jal     memcpy
        nop

        lw      $2,32($fp)
        addiu   $3,$fp,160
        addu    $16,$3,$2
        addiu   $2,$fp,148
        move    $4,$2
        jal     strlen
        nop

        move    $3,$2
        addiu   $2,$fp,148
        move    $6,$3
        move    $5,$2
        move    $4,$16
        jal     memcpy
        nop

        addiu   $2,$fp,148
        move    $4,$2
        jal     strlen
        nop

        move    $3,$2
        lw      $2,32($fp)
        nop
        addu    $2,$3,$2
        addiu   $3,$fp,160
        addu    $16,$3,$2
        lw      $4,24($fp)
        jal     strlen
        nop

        move    $6,$2
        lw      $5,24($fp)
        move    $4,$16
        jal     memcpy
        nop

        move    $2,$0
        move    $sp,$fp
        lw      $31,276($sp)
        lw      $fp,272($sp)
        lw      $16,268($sp)
        addiu   $sp,$sp,280
        j       $31
        nop
