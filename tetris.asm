################ CSC258H1F Winter 2024 Assembly Final Project ##################
# This file contains our implementation of Tetris.
#
# Student 1: Alec Dewulf, Student Number
# Student 2: Name, Student Number (if applicable)
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
    .word 0x808080 

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
    li $t1, 32              # $t1 = address of final pixel in row
    lw $t2, GRAY            # $t2 = current color
    li $t3, 0               # $t3 = counter
    lw $t5, ADDR_DSPL       
    addi $t5, $t5, 3968     #t5 = current index on bottom row    


# draws the top and bottom rows in the border
rows:
    beq $t3, $t1, columns_init      # break if we have colored first row
    sw $t2, 0($t0)          # write a grey cell
    sw $t2 0($t5)
    addi $t0, $t0, 4        # increment pixel positions
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
    

