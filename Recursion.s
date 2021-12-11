                .data   
msg1:           .asciiz "Enter an integer:\n"
msg2:           .asciiz "\nThe solution is: "
number:         .word 0
answer:         .word 0
                .text 
.globl  main    
main:
    # promt user
    la          $a0, msg1
    li          $v0, 4
    syscall

    # gather input and save to 'number'
    li          $v0, 5                  
    syscall
    sw          $v0, number
    la          $a0, msg2
    li          $v0, 4
    syscall
    lw          $a0, number
    jal         function1
    sw          $v0, answer
    li          $v0, 1
    lw          $a0, answer
    syscall
    li          $v0, 10
    syscall

############################################################################ 
# Procedure/Function function1 
# Description: (recursive)if n <= 3, function1(n) = (n / 4) + 17, otherwise= (function1(n-2) / 2 ) + function1(n-5)*n - n*n
# parameters: $a0 = n value 
# return value: $v0 = computed value 
# registers to be used: $s0 will be used. 
############################################################################
.globl function1
function1:
    # store in stack ra,a0,s0
    addi        $sp, $sp, -12
    sw          $ra, 8($sp)
    sw          $a0, 4($sp)
    sw          $s0, 0($sp)
    
    # base case:
    slti        $t0, $a0, 4
    beqz        $t0,greaterThan3
    addi        $t0, $zero, 4
    div         $a0, $t0
    mflo        $t0
    addi        $v0, $t0, 17
    j           done

    greaterThan3:

    # function1(n-2)
    addi        $t0, $zero, 2
    sub         $a0, $a0, $t0
    jal         function1

    # function1(n-2)/2
    addi        $t0, $zero, 2
    div         $v0, $t0
    mflo        $s0

    # function1(n-5)
    addi        $t0, $zero, 3
    sub         $a0, $a0, $t0
    jal         function1

    # function1(n-5)*n
    lw          $a0, 4($sp)
    mult        $v0, $a0 
    mflo        $t4

    # - n*n
    add         $t5, $s0, $t4
    lw          $a0, 4($sp)
    mult        $a0, $a0
    mflo        $t6
    sub         $v0, $t5, $t6

    done:
    lw          $ra, 8($sp)
    lw          $a0, 4($sp)
    lw          $s0, 0($sp)
    addi        $sp, $sp, 12
    jr          $ra