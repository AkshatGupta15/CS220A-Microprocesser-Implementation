.data

array: .word 5, 4, 3, 2, 1, 0                                   # input array
size:  .word 6                                                  # size of array

.text
main:
    la $s0, array                                               # load address of array into $s0
    lw $s1, size                                                # load size of array into $s1
    addi $s2, $s1, -1                                           # $s2 stores "size - 1" (length of loop)
    li $t0, 0                                                   # loop 1 counter initialization
    li $t1, 0                                                   # loop 2 counter initialization
    li $t6, 0                                                   # printing counter

    Loop:

        sll $t2, $t1, 2                                         # $t2 = 4*i
        add $t2, $s0, $t2                                       # $t2 stores the address of array + 4i
        lw $t3, 0($t2)                                          # $t3 stores arr[i]
        lw $t4, 4($t2)                                          # $t4 stores arr[i+1]
        slt $t5, $t3, $t4                                       # $t5 = 1 if arr[i] < arr[i+1]
        bne $t5, $zero, Increase                                # If $t5 = 1, go to Increase
        sw $t4, 0($t2)                                          # swap operation
        sw $t3, 4($t2)                                          # swap operation

    Increase:

        addi $t1, $t1, 1                                        # increment i
        sub $s3, $s2, $t0                                       # $s3 = n - 1 - j
        bne $t1, $s3, Loop                                      # if i != n-1, go to Loop
        addi $t0, $t0, 1                                        # otherwise increment j
        li $t1, 0                                               # i = 0
        bne $t0, $s2, Loop

    Print:

        beq $t6, $s1, Exit                                      # if counter != size
        lw $t7, 0($s0)                                          # load from array  
        li $v0, 1                                               # system call to print integer
        move $a0, $t7
        syscall
        li $a0, 32					                            # system call to print empty space
	    li $v0, 11
	    syscall
        addi $s0, $s0, 4                                        # incrementing array
        addi $t6, $t6, 1                                        # incrementing loop counter
        j Print

    Exit:

        li $v0, 10                                              # exit the program
        syscall   