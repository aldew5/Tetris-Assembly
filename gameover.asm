    .data
ADDR_DSPL: .word 0x10008000  
BLUE:       .word 0x000000ff  

    .text
    lw $t0, ADDR_DSPL
    addi $t0, $t0, 12
    addi $t0, $t0, 1024
    lw $t2, BLUE 

    #G
    sw $t2, 0($t0)
    sw $t2, 4($t0)
    sw $t2, 8($t0)

    sw $t2, 128($t0)
    sw $t2, 256($t0)
    
    sw $t2, 384($t0)
    sw $t2, 388($t0)
    sw $t2, 392($t0)
    sw $t2, 264($t0)

    addi $t0, $t0, 16
    
    #A
    sw $t2, 0($t0)
    sw $t2, 4($t0)
    sw $t2, 8($t0)
    
    sw $t2, 128($t0)
    sw $t2, 256($t0)
    sw $t2, 384($t0)
    
    sw $t2, 136($t0)
    sw $t2, 264($t0)
    sw $t2, 392($t0)
    
    sw $t2, 260($t0)
    
    addi $t0, $t0, 16
    
    #M
    sw $t2, 0($t0)
    sw $t2, 132($t0)
    sw $t2, 8($t0)
    
    sw $t2, 128($t0)
    sw $t2, 256($t0)
    sw $t2, 384($t0)
    
    sw $t2, 136($t0)
    sw $t2, 264($t0)
    sw $t2, 392($t0)
    
    addi $t0, $t0, 16
    
    #E
    sw $t2, 0($t0)
    sw $t2, 4($t0)
    sw $t2, 8($t0)
    
    sw $t2, 128($t0)
    sw $t2, 256($t0)
    sw $t2, 260($t0)
    sw $t2, 384($t0)
    sw $t2, 512($t0)
    sw $t2, 516($t0)
    sw $t2, 520($t0)
    
    addi $t0, $t0, 888
    
    #O
    sw $t2, 0($t0)
    sw $t2, 4($t0)
    sw $t2, 8($t0)
    
    sw $t2, 128($t0)
    sw $t2, 256($t0)
    sw $t2, 384($t0)
    sw $t2, 388($t0)
    
    sw $t2, 136($t0)
    sw $t2, 264($t0)
    sw $t2, 392($t0)
    
    addi $t0, $t0, 16
    
    #V
    sw $t2, 0($t0)
    # sw $t2, 4($t0)
    sw $t2, 8($t0)
    
    sw $t2, 128($t0)
    sw $t2, 256($t0)
    # sw $t2, 384($t0)
    sw $t2, 388($t0)
    
    sw $t2, 136($t0)
    sw $t2, 264($t0)
    # sw $t2, 392($t0)
    
    addi $t0, $t0, 16
    
    #E
    sw $t2, 0($t0)
    sw $t2, 4($t0)
    sw $t2, 8($t0)
    
    sw $t2, 128($t0)
    sw $t2, 256($t0)
    sw $t2, 260($t0)
    sw $t2, 384($t0)
    sw $t2, 512($t0)
    sw $t2, 516($t0)
    sw $t2, 520($t0)
    
    addi $t0, $t0, 16
    
    #R
    sw $t2, 0($t0)
    sw $t2, 4($t0)
    sw $t2, 8($t0)
    
    sw $t2, 128($t0)
    sw $t2, 256($t0)
    sw $t2, 384($t0)
    sw $t2, 512($t0)
    sw $t2, 524($t0)
    
    sw $t2, 136($t0)
    sw $t2, 264($t0)
    sw $t2, 392($t0)
    
    sw $t2, 260($t0)

    
    
    
    
