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
    
BLUE:
    .word 0x0000FF
    
LIGHT_GRAY:
    .word 0x1C1C1C
    
BLACK:
    .word 0x000000

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
    lw $s0, ADDR_KBRD       # $s0 = keyboard location in memory
    li $s1, 4               # $s1 = offset to block location
    li $s2, 0
    li $s3, 0
    li $s4, 0               # USED IN ROTATIONS FIX
    li $s7, 0               # $s7 = rotation counter
    lw $t0, ADDR_DSPL       # $t0 = base address for display
    li $t1, 1024            # $t1 = address of final pixel in bottom row
    lw $t2, LIGHT_GRAY      # $t2 = current color
    li $t3, 0               # $t3 = counter for end of board
    lw $t5, ADDR_DSPL
    addi $t5, $t5, 3968     # t5 = current index on bottom row
    li $t7, 0               # $t7 = counter for index on current row
    li $t8, 32              # $t8 = address of final pixel in row
    

grid_init:
    lw $t0, ADDR_DSPL       # $t0 = base address for display
    li $t1, 1024            # $t1 = address of final pixel in bottom row
    lw $t2, LIGHT_GRAY      # $t2 = current color
    li $t3, 0               # $t3 = counter for end of board
    lw $t6, BLACK
    li $t7, 0               # $t7 = counter for index on current row
    li $t8, 32              # $t8 = address of final pixel in row
    
grid1:
    beq $t3, $t1, rows_init     # break if grid complete
    beq $t7, $t8, offset1       # break if row complete move to next row
    sw $t2, 0($t0)              # write a light gray cell
    addi $t0, $t0, 4            # move to next pixel
    sw $t6, 0($t0)              # draw black
    addi $t0, $t0, 4            # next pixel
    addi $t3, $t3, 2            # increment both counters by 2
    addi $t7, $t7, 2
    j grid1                     # loop until row complete
    
grid2:
    beq $t3, $t1, rows_init     # same logic as above grid1 and grid2 handle alternate rows
    beq $t7, $t8, offset2
    sw $t2, 0($t0)              # write a light gray cell
    addi $t0, $t0, 4            # move to next pixel
    sw $t6, 0($t0)              # draw black
    addi $t0, $t0, 4 
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
    lw $t5, ADDR_DSPL       
    addi $t5, $t5, 3968     # t5 = current index on bottom row
    
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
    beq $t3, $t4, draw_rect      # break if counter is 32
    sw $t2, 0($t1)          # write on right
    sw $t2, 0($t0)          # write on left
    addi $t0, $t0, 128       # increment pixel pos
    addi $t1, $t1, 128
    addi $t3, $t3, 1        # increment counter
    j columns_loop

# for now draws at ADDR_DISPLAY
# note could be done with a loop but probably fine to do it this way
# assumes that $s1 contains the value we start writing to
draw_rect:
    lw $t2, RED             # $t2 = color of block
    lw $t0, ADDR_DSPL
    add $t0, $t0, $s1
    sw $t2, 0($t0)
    add $t0, $t0, $s4       # register for rotation
    addi $t0, $t0, 128      # draw the pixel, go to next row and do same
    sw $t2, 0($t0)
    add $t0, $t0, $s3       # register for rotation
    addi $t0, $t0, 128
    sw $t2, 0($t0)
    add $t0, $t0, $s2       # register for rotation
    addi $t0, $t0, 128
    sw $t2, 0($t0)
    j game_loop
# Checks for keyboard input
keyboard_address:
    lw $t0, 0($s0)              # contents are 1 iff some key has been pressed
    beq $t0, 1, keyboard_input  # if something has been pressed, handle it 
    j game_loop                 # else, go back to game loop
    
#Checks for keyboard input
keyboard_input:                     	# A key is pressed
    lw $t0, 4($s0)                  	# Load second word from keyboard (which contains code)
    li $ra, 0                           # this will be used to check where to jump back
    beq $t0 0x64, move_right	        # moves cube right 1 pixel
    beq $t0, 0x61, move_left            # move left 1 pixel
    beq $t0, 0x73, move_down
    beq $t0, 0x77, rotate
    beq $t0, 0x71, exit
    
    j game_loop

# moves block left
move_right:
    li $t1, 4                  # $t1 = offset
    li $t6, -1                  # indicates type of movement
    jal check_collision_init
    addi $s1, $s1, 4                    # set the value of $s1 where the block will now be drawn
    lw $t0, ADDR_DSPL                   # $t0 = top left pixel so grid drawing works
    
    j grid_init                         # redraw everything but now the block is moved left
    
# same idea as moving right except subtract 4
move_left:
    li $t1, -4                  # $t1 = offset
    li $t6, -1                  # indicates type of movement
    jal check_collision_init
    subi $s1, $s1, 4
    lw $t0, ADDR_DSPL
    j grid_init

move_down:
    addi $s1, $s1, 128
    lw $t0, ADDR_DSPL
    j grid_init

# check that we're not hitting left wall
# ASSUME $t1 CONTAINS OFFSET (hypothetical moving of block)
# ASSUME $t6 = -1 if not rotation and the rotation number otherwise
check_collision_init:
    lw $t0, ADDR_DSPL                   # $t0 = left wall position
    lw $t5, ADDR_DSPL
    add $t1, $t1, $t5
    addi $t5, $t5, 124       # $t5 = first pixel in right column
    li $t2, 0                   # $t2 = rows counter
    li $t3, 32                  # $t3 = number of rows
    li $t4, 1                   # $t4 used for orientation check    
    
    sw $ra, 0($sp)              # save return address on stack
    add $t1, $t1, $s1           # add curr pos to offset
    jal check_collision_loop    # check first block
    
    lw $t0, ADDR_DSPL                              # reset everything
    li $t2, 0                  
    lw $t5, ADDR_DSPL
    addi $t5, $t5, 124       
    add $t1, $t1, $s4                   
    addi $t1, $t1, 128
    jal check_collision_loop   # then second
    
    lw $t0, ADDR_DSPL                 
    li $t2, 0  
    lw $t5, ADDR_DSPL
    addi $t5, $t5, 124      
    add $t1, $t1, $s3           # for rotations                 
    addi $t1, $t1, 128
    jal check_collision_loop
    
    lw $t0, ADDR_DSPL            
    li $t2, 0 
    lw $t5, ADDR_DSPL
    addi $t5, $t5, 124 
    add $t1, $t1, $s2                  
    addi $t1, $t1, 128
    jal check_collision_loop
    lw $ra, 0($sp)
    
    jr $ra
    
check_collision_loop:
    beq $t0, $t1, handle_collision                     # curr wall (t0) = block pos (t1) so we hit a wall
    beq $t5, $t1, handle_collision             # check right wall
    
    addi $t0, $t0, 128                          # increment $t0 to next left wall
    addi $t5, $t5, 128
    addi $t2, $t2, 1                            # next row
    bne $t2, $t3, check_collision_loop                     # have NOT checked every row
    
    jr $ra                                      # else, we've looked at every wall and didn't hit any. Jump back to main function


handle_collision:
    beq $t6, -1, game_loop
    beq $t6, 0, undo_rotate1
    beq $t6, 1, undo_rotate2
    beq $t6, 2, undo_rotate3
    beq $t6, 3, undo_rotate4


# Function to decide which rotation position the block is at
rotate: 
    beq $s7, 0, rotate1
    beq $s7, 1, rotate2
    beq $s7, 2, rotate3
    beq $s7, 3, rotate4
    

rotate1:                            # Rotate horizontally about third block first position
    addi $s1, $s1, 8
    addi $s1, $s1, 256
    addi $s4, $s4, -4
    addi $s4, $s4, -128
    addi $s3, $s3, -4
    addi $s3, $s3, -128
    addi $s2, $s2, -4
    addi $s2, $s2, -128
    
    li $t1, 0               # zero offset
    li $t6, 0
    jal check_collision_init
    
    lw $t0, ADDR_DSPL
    li $s7, 1
    
    j grid_init
    
    
undo_rotate1:
    subi $s1, $s1, 264
    subi $s4, $s4, -132
    subi $s3, $s3, -132
    subi $s2, $s2, -132
    j game_loop
    
rotate2:                            # Rotate vertically about third block second position
    addi $s1, $s1, -8
    addi $s1, $s1, 256
    addi $s4, $s4, 4
    addi $s4, $s4, -128
    addi $s3, $s3, 4
    addi $s3, $s3, -128
    addi $s2, $s2, 4
    addi $s2, $s2, -128
    
    li $t1, 0                   # zero offset
    li $t6, 1
    jal check_collision_init
    
    lw $t0, ADDR_DSPL
    li $s7, 2
    
    j grid_init

undo_rotate2:
    subi $s1, $s1, 248
    subi $s4, $s4, -124
    subi $s3, $s3, -124
    subi $s2, $s2, -124
    j game_loop
    
rotate3:                            # Rotate horizontally about third block third position
    addi $s1, $s1, -8
    addi $s1, $s1, -256
    addi $s4, $s4, 4
    addi $s4, $s4, 128
    addi $s3, $s3, 4
    addi $s3, $s3, 128
    addi $s2, $s2, 4
    addi $s2, $s2, 128
    
    li $t1, 0                   # zero offset
    li $t6, 2
    jal check_collision_init
    
    lw $t0, ADDR_DSPL
    li $s7, 3
    
    j grid_init
    
undo_rotate3:
    subi $s1, $s1, -264
    subi $s4, $s4, 132
    subi $s3, $s3, 132
    subi $s2, $s2, 132
    j game_loop
    
rotate4:                           # Rotate vertically about third block fourth position
    addi $s1, $s1, 8
    addi $s1, $s1, -256
    addi $s4, $s4, -4
    addi $s4, $s4, 128
    addi $s3, $s3, -4
    addi $s3, $s3, 128
    addi $s2, $s2, -4
    addi $s2, $s2, 128 
    
    li $t1, 0
    li $t6, 3
    jal check_collision_init
    
    lw $t0, ADDR_DSPL
    li $s7, 0
    
    j grid_init  
    
undo_rotate4:
    subi $s1, $s1, -248
    subi $s4, $s4, 124
    subi $s3, $s3, 124
    subi $s2, $s2, 124
    j game_loop
    
game_loop:
	# 1a. Check if key has been pressed
	j keyboard_address
    # 1b. Check which key has been pressed
    # 2a. Check for collisions
	# 2b. Update locations
	# 3. Draw the screen
	# 4. Sleep

    #5. Go back to 1
    b game_loop
    

exit:
    li $v0, 10              # terminate the program gracefully
    syscall
