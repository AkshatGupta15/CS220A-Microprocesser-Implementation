lw $4, 0($29)            ; 183: lw $a0 0($sp) # argc 
addiu $5, $29, 4         ; 184: addiu $a1 $sp 4 # argv 
addiu $6, $5, 4          ; 185: addiu $a2 $a1 4 # envp 
sll $2, $4, 2            ; 186: sll $v0 $a0 2 
addu $6, $6, $2          ; 187: addu $a2 $a2 $v0 
jal 0x00400024 [main]    ; 188: jal main 
nop                      ; 189: nop 
ori $2, $0, 10           ; 191: li $v0 10 
syscall                  ; 192: syscall # syscall 10 (exit) 
lui $16, 4097 [array]    ; 8: la $s0, array # load address of array into $s0 
lui $1, 4097             ; 9: lw $s1, size # load size of array into $s1 
lw $17, 24($1)           
addi $18, $17, -1        ; 10: addi $s2, $s1, -1 # $s2 stores "size - 1" (length of loop) 
ori $8, $0, 0            ; 11: li $t0, 0 # loop 1 counter initialization 
ori $9, $0, 0            ; 12: li $t1, 0 # loop 2 counter initialization 
ori $14, $0, 0           ; 13: li $t6, 0 # printing counter 
sll $10, $9, 2           ; 17: sll $t2, $t1, 2 # $t2 = 4*i 
add $10, $16, $10        ; 18: add $t2, $s0, $t2 # $t2 stores the address of array + 4i 
lw $11, 0($10)           ; 19: lw $t3, 0($t2) # $t3 stores arr[i] 
lw $12, 4($10)           ; 20: lw $t4, 4($t2) # $t4 stores arr[i+1] 
slt $13, $11, $12        ; 21: slt $t5, $t3, $t4 # $t5 = 1 if arr[i] 
bne $13, $0, 12 [Increase-0x00400054]
sw $12, 0($10)           ; 23: sw $t4, 0($t2) # swap operation 
sw $11, 4($10)           ; 24: sw $t3, 4($t2) # swap operation 
addi $9, $9, 1           ; 28: addi $t1, $t1, 1 # increment i 
sub $19, $18, $8         ; 29: sub $s3, $s2, $t0 # $s3 = n - 1 - j 
bne $9, $19, -40 [Loop-0x00400068]
addi $8, $8, 1           ; 31: addi $t0, $t0, 1 # otherwise increment j 
ori $9, $0, 0            ; 32: li $t1, 0 # i = 0 
bne $8, $18, -52 [Loop-0x00400074]
beq $14, $17, 44 [Exit-0x00400078]
lw $15, 0($16)           ; 38: lw $t7, 0($s0) # load from array 
ori $2, $0, 1            ; 39: li $v0, 1 # system call to print integer 
addu $4, $0, $15         ; 40: move $a0, $t7 
syscall                  ; 41: syscall 
ori $4, $0, 32           ; 42: li $a0, 32 # system call to print empty space 
ori $2, $0, 11           ; 43: li $v0, 11 
syscall                  ; 44: syscall 
addi $16, $16, 4         ; 45: addi $s0, $s0, 4 # incrementing array 
addi $14, $14, 1         ; 46: addi $t6, $t6, 1 # incrementing loop counter 
j 0x00400078 [Print]     ; 47: j Print 
ori $2, $0, 10           ; 51: li $v0, 10 # exit the program 
syscall                  ; 52: syscall 