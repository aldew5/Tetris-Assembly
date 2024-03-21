################ CSC258H1F Winter 2024 Assembly Final Project ##################
# This file contains our implementation of Tetris.
#
# Student 1: Alec Dewulf, Student Number
# Student 2: Faraaz Ahmed, 1008752985
######################## Bitmap Display Configuration ########################
# - Unit width in pixels: 8
# - Unit height in pixels: 8
# - Display width in pixels: 256
# - Display height in pixels: 256
# - Base Address for Display: 0x10008000 ($gp)
##############################################################################

# data memory
    .data
##############################################################################
# Immutable Data
##############################################################################
# The address of the bitmap display. Don't forget to connect it!
ADDR_DSPL:
    .word 0x10008000
# The address of the keyboard. Don't forget to connect it!
ADDR_KBRD:
    .word 0xffff0000

# colors
GRAY:
    .word 0x444444
    
RED:
    .word 0xff0000
    
LIGHT_GRAY:
    .word 0x1C1C1C

##############################################################################
# Mutable Data
##############################################################################

##############################################################################
# Code
##############################################################################

# instruction memory
	.text
	.globl main

	# Run the Tetris game.
main:
    lw $t0, ADDR_DSPL       # $t0 = base address for display
    li $t1, 1024            # $t1 = address of final pixel in bottom row
    lw $t2, LIGHT_GRAY      # $t2 = current color
    li $t3, 0               # $t3 = counter for end of board
    lw $t5, ADDR_DSPL
    addi $t5, $t5, 3968     # t5 = current index on bottom row
    li $t7, 0               # $t7 = counter for index on current row
    li $t8, 32              # $t8 = address of final pixel in row

grid1:
    beq $t3, $t1, rows_init     # break if grid complete
    beq $t7, $t8, offset1       # break if row complete move to next row
    sw $t2, 0($t0)              # write a light gray cell
    addi $t0, $t0, 8            # increment 8 to skip one pixel and draw in the next spot
    addi $t3, $t3, 2            # increment both counters by 2
    addi $t7, $t7, 2
    j grid1                     # loop until row complete
    
grid2:
    beq $t3, $t1, rows_init     # same logic as above grid1 and grid2 handle alternate rows
    beq $t7, $t8, offset2
    sw $t2, 0($t0)
    addi $t0, $t0, 8
    addi $t3, $t3, 2
    addi $t7, $t7, 2
    j grid2
    
offset1:                        # offset by +4 in alternate rows and reset counter
    addi $t0, $t0, 4
    li $t7, 0
    j grid2
    
offset2:                        # offset by -4 in alternate rows and reset counter
    addi $t0, $t0, -4
    li $t7, 0
    j grid1
    
rows_init:
    lw $t0, ADDR_DSPL       # $t0 = base address for display
    li $t1, 32              # $t1 = address of final pixel in row
    lw $t2, GRAY            # $t2 = current color
    li $t3, 0               # $t3 = counter

# draws the top and bottom rows in the border
rows:
    beq $t3, $t1, columns_init      # break if we have colored first row
    sw $t2, 0($t0)          # write a grey cell
    sw $t2 0($t5)
    # addi $t0, $t0, 4        # increment pixel positions
    addi $t5, $t5, 4
    addi $t3, $t3, 1        # increment counter
    j rows                  # jump back to start of loop

columns_init:
    lw $t0, ADDR_DSPL       # $t0 = first pixels in left column
    lw $t1, ADDR_DSPL
    addi $t1, $t1, 124       # $t1 = first pixel in right column
    li $t3, 0               # $t3 = counter
    li $t4, 32             # $t4 = number of rows

columns_loop:
    beq $t3, $t4, exit      # break if counter is 256
    sw $t2, 0($t1)          # write on right
    sw $t2, 0($t0)          # write on left
    addi $t0, $t0, 128       # increment pixel pos
    addi $t1, $t1, 128
    addi $t3, $t3, 1        # increment counter
    j columns_loop



exit:
    li $v0, 10              # terminate the program gracefully
    syscall


game_loop:
	# 1a. Check if key has been pressed
    # 1b. Check which key has been pressed
    # 2a. Check for collisions
	# 2b. Update locations (paddle, ball)
	# 3. Draw the screen
	# 4. Sleep

    #5. Go back to 1
    b game_loop
    

