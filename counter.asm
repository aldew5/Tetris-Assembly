    .data
ADDR_DSPL:
    .word 0x10008000
    
RED:
    .word 0xff0000
    
# instruction memory
	.text
	.globl main
    
main:
    jal first_zero
    li $t5, 9
    beq $t5, 0, jal_zero
    beq $t5, 1, jal_one
    beq $t5, 2, jal_two
    beq $t5, 3, jal_three
    beq $t5, 4, jal_four
    beq $t5, 5, jal_five
    beq $t5, 6, jal_six
    beq $t5, 7, jal_seven
    beq $t5, 8, jal_eight
    beq $t5, 9, jal_nine
    
    j exit

jal_zero:
    jal zero
    jr $ra
    
jal_one:
    jal one
    jr $ra
    
jal_two:
    jal two
    jr $ra
    
jal_three:
    jal three
    jr $ra
    
jal_four:
    jal four
    jr $ra
    
jal_five:
    jal five
    jr $ra

jal_six:
    jal six
    jr $ra
    
jal_seven:
    jal seven
    jr $ra
    
jal_eight:
    jal eight
    jr $ra
    
jal_nine:
    jal nine
    jr $ra
    
zero:
    lw $t0, ADDR_DSPL
    lw $t2, RED
    sw $t2, 236($t0)
    sw $t2, 364($t0)
    sw $t2, 492($t0)
    sw $t2, 620($t0)
    sw $t2, 748($t0)
    sw $t2, 240($t0)
    sw $t2, 244($t0)
    sw $t2, 372($t0)
    sw $t2, 500($t0)
    sw $t2, 628($t0)
    sw $t2, 752($t0)
    sw $t2, 756($t0)
    jr $ra

one:
    lw $t0, ADDR_DSPL
    lw $t2, RED
    sw $t2, 244($t0)
    sw $t2, 372($t0)
    sw $t2, 500($t0)
    sw $t2, 628($t0)
    sw $t2, 756($t0)
    jr $ra
    
 two:
    lw $t0, ADDR_DSPL
    lw $t2, RED
    sw $t2, 240($t0)
    sw $t2, 244($t0)
    sw $t2, 372($t0)
    sw $t2, 500($t0)
    sw $t2, 496($t0)
    sw $t2, 624($t0)
    sw $t2, 752($t0)
    sw $t2, 756($t0)
    jr $ra
    
three:
    lw $t0, ADDR_DSPL
    lw $t2, RED
    sw $t2, 240($t0)
    sw $t2, 244($t0)
    sw $t2, 372($t0)
    sw $t2, 500($t0)
    sw $t2, 496($t0)
    sw $t2, 628($t0)
    sw $t2, 752($t0)
    sw $t2, 756($t0)
    jr $ra
    
four:
    lw $t0, ADDR_DSPL
    lw $t2, RED
    sw $t2, 236($t0)
    sw $t2, 364($t0)
    sw $t2, 492($t0)
    sw $t2, 244($t0)
    sw $t2, 372($t0)
    sw $t2, 500($t0)
    sw $t2, 496($t0)
    sw $t2, 628($t0)
    sw $t2, 756($t0)
    jr $ra
    
five:
    lw $t0, ADDR_DSPL
    lw $t2, RED
    sw $t2, 240($t0)
    sw $t2, 244($t0)
    sw $t2, 368($t0)
    sw $t2, 500($t0)
    sw $t2, 496($t0)
    sw $t2, 628($t0)
    sw $t2, 752($t0)
    sw $t2, 756($t0)
    jr $ra
    
six:
    lw $t0, ADDR_DSPL
    lw $t2, RED
    sw $t2, 236($t0)
    sw $t2, 364($t0)
    sw $t2, 492($t0)
    sw $t2, 620($t0)
    sw $t2, 748($t0)
    sw $t2, 240($t0)
    sw $t2, 244($t0)
    sw $t2, 500($t0)
    sw $t2, 496($t0)
    sw $t2, 628($t0)
    sw $t2, 752($t0)
    sw $t2, 756($t0)
    jr $ra
    
seven:
    lw $t0, ADDR_DSPL
    lw $t2, RED
    sw $t2, 236($t0)
    sw $t2, 240($t0)
    sw $t2, 244($t0)
    sw $t2, 372($t0)
    sw $t2, 500($t0)
    sw $t2, 628($t0)
    sw $t2, 756($t0)
    jr $ra
    
eight:
    lw $t0, ADDR_DSPL
    lw $t2, RED
    sw $t2, 236($t0)
    sw $t2, 364($t0)
    sw $t2, 492($t0)
    sw $t2, 620($t0)
    sw $t2, 748($t0)
    sw $t2, 240($t0)
    sw $t2, 244($t0)
    sw $t2, 372($t0)
    sw $t2, 500($t0)
    sw $t2, 496($t0)
    sw $t2, 628($t0)
    sw $t2, 752($t0)
    sw $t2, 756($t0)
    jr $ra
    
nine:
    lw $t0, ADDR_DSPL
    lw $t2, RED
    sw $t2, 236($t0)
    sw $t2, 364($t0)
    sw $t2, 492($t0)
    sw $t2, 748($t0)
    sw $t2, 240($t0)
    sw $t2, 244($t0)
    sw $t2, 372($t0)
    sw $t2, 500($t0)
    sw $t2, 496($t0)
    sw $t2, 628($t0)
    sw $t2, 752($t0)
    sw $t2, 756($t0)
    jr $ra
    
first_zero:
    lw $t0, ADDR_DSPL
    lw $t2, RED
    sw $t2, 220($t0)
    sw $t2, 348($t0)
    sw $t2, 476($t0)
    sw $t2, 604($t0)
    sw $t2, 732($t0)
    sw $t2, 224($t0)
    sw $t2, 228($t0)
    sw $t2, 356($t0)
    sw $t2, 484($t0)
    sw $t2, 612($t0)
    sw $t2, 736($t0)
    sw $t2, 740($t0)
    jr $ra
    
exit:
    li $v0, 10
    syscall
    

