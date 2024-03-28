.text
.globl main

# Main program entry point
music:
    jal E
    jal delay
    jal delay
    jal B
    jal delay
    jal C
    jal delay
    jal D
    jal delay
    jal delay
    
    jal C
    jal delay
    jal B
    jal delay
    jal A
    jal delay
    jal delay
    jal A
    jal delay
    jal C
    jal delay
    jal E
    jal delay
    jal delay
    
    jal D
    jal delay
    jal C
    jal delay
    jal B
    jal delay
    jal delay
    jal B
    jal delay
    jal C
    jal delay
    jal D
    jal delay
    jal delay
    
    jal E
    jal delay
    jal delay
    jal C
    jal delay
    jal delay
    jal A
    jal delay
    jal delay
    jal A
    jal delay
    jal delay
    jal delay
    
    jal D
    jal delay
    jal delay
    jal delay
    jal F
    jal delay
    jal A4
    jal delay
    jal delay
    jal G
    jal delay
    jal F
    jal delay
    jal E
    jal delay
    jal delay
    
    jal C
    jal delay
    jal delay
    jal E
    jal delay
    jal delay
    jal D
    jal delay
    jal C
    jal delay
    jal B
    jal delay
    jal delay
    
    jal B
    jal delay
    jal C
    jal delay
    jal D
    jal delay
    jal delay
    jal E
    jal delay
    jal delay
    jal C
    jal delay
    jal delay
    jal A
    jal delay
    jal delay
    jal A
    jal delay
    jal delay
    jal delay

    j music

A:
    li $v0, 31
    li $a0, 57  # Pitch for A3
    li $a1, 100 # Duration
    li $a2, 0   # Instrument
    li $a3, 100 # Volume
    syscall
    jr $ra      

B:
    li $v0, 31
    li $a0, 59  # Pitch for B3
    li $a1, 100 
    li $a2, 0   
    li $a3, 100 
    syscall
    jr $ra      
C:
    li $v0, 31
    li $a0, 60  # Pitch for C4
    li $a1, 100 
    li $a2, 0 
    li $a3, 100 
    syscall
    jr $ra      

D:
    li $v0, 31
    li $a0, 62  # Pitch for D4
    li $a1, 100
    li $a2, 0
    li $a3, 100
    syscall
    jr $ra

E:
    li $v0, 31
    li $a0, 64  # Pitch for E4
    li $a1, 100
    li $a2, 0
    li $a3, 100
    syscall
    jr $ra

F:
    li $v0, 31
    li $a0, 65  # Pitch for F4
    li $a1, 100
    li $a2, 0
    li $a3, 100
    syscall
    jr $ra

G:
    li $v0, 31
    li $a0, 67  # Pitch for G4
    li $a1, 100
    li $a2, 0
    li $a3, 100
    syscall
    jr $ra
    
A4:
    li $v0, 31
    li $a0, 69  # Pitch for A4
    li $a1, 100
    li $a2, 0
    li $a3, 100
    syscall
    jr $ra

delay:
    li $a0, 200    
    li $v0, 32     
    syscall        
    jr $ra         
    
