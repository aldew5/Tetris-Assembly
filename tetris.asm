################ CSC258H1F Winter 2024 Assembly Final Project ##################
# This file contains our implementation of Tetris.
#
# Student 1: Alec Dewulf, 1009418701
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
    
ARRAY:
    .word 0:4096

##############################################################################
# Mutable Data
##############################################################################

##############################################################################
# Code
##############################################################################


# COLORS FOR ARRAY:
# GREY: 1
# GREY & FLOOR: 3
# LIGHT GREY: -2
# BLACK: -3
# RED: 2

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
    la $t0, ARRAY       # $t0 = base address for display
    li $t1, 1024            # $t1 = address of final pixel in bottom row
    li $t2, -2              # LIGHT GREY
    li $t3, 0               # $t3 = counter for end of board
    li $t6, -3              # BLACK
    li $t7, 0               # $t7 = counter for index on current row
    li $t8, 32              # $t8 = address of final pixel in row
    
grid1:
    beq $t3, $t1, draw_game_init     # break if grid complete
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
    li $t1, 32              # $t1 = address of final pixel in row
    li $t3, 0               # $t3 = counter
    li $t6, 992 
    la $t7, ARRAY
    addi $t7, $t7, 3968
    li $t8, 3
    
# draws the top and bottom rows in the border
rows:
    beq $t3, $t1, columns_init      # break if we have colored first row
    sw $t8, 0($t7)          # update array

    addi $t7, $t7, 4
    addi $t3, $t3, 1        # increment counter
    
    j rows                  # jump back to start of loop

columns_init:
    la $t7, ARRAY             # left col
    la $t8, ARRAY           # right col
    addi $t1, $t1, 124       # $t1 = first pixel in right column
    addi $t8, $t8, 124
    
    li $t3, 0               # $t3 = counter
    li $t4, 32             # $t4 = number of rows
    li $t5, 1

columns_loop:
    beq $t3, $t4, draw_game_init      # break if counter is 32

    sw $t5, 0($t7)          # for array
    sw $t5, 0($t8)

    addi $t7, $t7, 128
    addi $t8, $t8, 128
    
    addi $t3, $t3, 1        # increment counter
    j columns_loop
    
draw_game_init:
    li $t0, 0               # counter
    la $t2, ARRAY
    lw $t3, ADDR_DSPL
    
    
    
draw_game_loop:
    beq $t0, 4096, draw_tetro        # looked at all the blocks
    
    lw $t1, 0($t2)                  # load array value at t2
    lw $t5, RED
    beq $t1, 2, draw_block      # draw red if there's a 2
    lw $t5, GRAY
    beq $t1, 1, draw_block
    beq $t1, 3, draw_block      # grey floor
    lw $t5, LIGHT_GRAY
    beq $t1, -2, draw_block
    lw $t5, BLACK
    beq $t1, -3, draw_block
    
    addi $t3, $t3, 4                
    addi $t2, $t2, 4
    addi $t0, $t0, 1
    
    j draw_game_loop

draw_block:
    sw $t5, 0($t3)

    addi $t3, $t3, 4                
    addi $t2, $t2, 4
    addi $t0, $t0, 1
    
    j draw_game_loop

    


# for now draws at ADDR_DISPLAY
# note could be done with a loop but probably fine to do it this way
# assumes that $s1 contains the value we start writing to
# assume $t5 contains the tetro we want to draw
draw_tetro:
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
    
    j draw_game_init                       # redraw everything but now the block is moved left
    
# same idea as moving right except subtract 4
move_left:
    li $t1, -4                  # $t1 = offset
    li $t6, -1                  # indicates type of movement
    jal check_collision_init
    subi $s1, $s1, 4
    lw $t0, ADDR_DSPL
    j draw_game_init 

move_down:
    li $t1, 128                  # $t1 = offset
    li $t6, -2 

    jal check_collision_init
    addi $s1, $s1, 128

    lw $t0, ADDR_DSPL
    j draw_game_init

# check that we're not hitting left wall
# ASSUME $t1 CONTAINS OFFSET (hypothetical moving of block)
# ASSUME $t6 = -1 if not rotation and the rotation number otherwise
check_collision_init:
    la $t7, ARRAY
    add $t7, $t7, $t1
    add $t7, $t7, $s1
    
    # check each pixel separately
    lw $t9, 0($t7)
    li $t2, 0
    bge $t9, $t2, handle_collision  # something other than zero in that position => COLLISION
    
    # second pixel
    add $t7, $t7, $s4
    addi $t7, $t7, 128
    lw $t9, 0($t7)
    
    li $t2, 0
    bge $t9, $t2, handle_collision
    
    # third
    add $t7, $t7, $s3
    addi $t7, $t7, 128
    lw $t9, 0($t7)
    
    li $t2, 0
    bge $t9, $t2, handle_collision
    
    # last
    add $t7, $t7, $s2
    addi $t7, $t7, 128
    lw $t9, 0($t7)
    
    li $t2, 0
    bge $t9, $t2, handle_collision
    
    jr $ra
    
handle_collision:
    beq $t6, -1 game_loop 
    bge $t9, 2, handle_floor_collision #greater than 2 AND downwards movement
    
    beq $t6, 0, undo_rotate1
    beq $t6, 1, undo_rotate2
    beq $t6, 2, undo_rotate3
    beq $t6, 3, undo_rotate4


handle_floor_collision:
    # update array 
    la $t7, ARRAY
    li $t2, 2
    add $t7, $t7, $s1
    sw $t2, 0($t7)              # draw first pixel
    
    add $t7, $t7, $s4
    addi $t7, $t7, 128
    sw $t2, 0($t7)              # and second pixel...
    
    add $t7, $t7, $s3
    addi $t7, $t7, 128
    sw $t2, 0($t7)
    
    add $t7, $t7, $s2
    addi $t7, $t7, 128
    sw $t2, 0($t7)
    
    li $s1, 4               # create new block
    li $s2, 0
    li $s3, 0 
    li $s4, 0
    li $s7, 0
    
    jal check_line_init
    j draw_game_init

check_line_init:
    li $t0, 0           # row count
    li $t1, 0           # STORES THE NUMBER OF TIMES WE HAVE TO SHIFT DOWN AFTER
    la $t5, ARRAY
    addi $t5, $t5, 4         # skip column
    li $t3, 0           # first index of curr line
    li $t7, 0
    li $t8, 0           # how many hits in a particular row

check_line_loop:
    lw $t9, 0($t5)
    bne $t9, 2, next_line     #hit a non-red block so no line

    addi $t5, $t5, 4        # position
    addi $t8, $t8, 1        # hit another red
    addi $t7, $t7, 4        # global counter

    beq $t8, 30, found_line_init     # 30 red in a row (excluding the cols)
    bne $t7, 4096, check_line_loop  # we haven't looked at every pixel so return to loop
    
    jr $ra
    
next_line:
    addi $t3, $t3, 128      # start at next line
    la $t5, ARRAY
    
    add $t5, $t5, $t3       # update curr pos
    addi $t5, $t5, 4        # skip col
    
    li $t7, 0
    addi $t7, $t7, 1        # update global counter
    addi $t7, $t7, 4
    
    addi $t0, $t0, 1        # looked at a row so update row count
    li $t8, 0               # reset red block count
    
    ble $t0, 30, check_line_loop    
    j shift_down_init
    
found_line_init:
    li $t6, -3              # black color
    li $t8, 0               # reset red count

    subi $t5, $t5, 120      # go back to start of line CHANGE PARAM
    li $t4, 0
    add $t4, $t4, $t5
    addi $t4, $t4, 124
    addi $t1, $t1, 1
     

found_line_loop:
    beq $t5, $t4, write_grey        # write grey at the end
    
    # rebuild grid
    sw $t6, 0($t5)
    addi $t5, $t5, 4
    j found_line_loop

write_grey:
    li $t6, 1
    subi $t5, $t5, 4
    sw $t6, 0($t5)
    j check_line_loop

# ASSUMES $t1 stores number of shifts down
shift_down_init:
    li $t2, 4096       # counter
    li $t0, 0       # curr position
    la $t4, ARRAY
    addi $t4, $t4, 4096  # count down
    
    addi $sp, $sp, -4   # put return address on stack
    sw $ra, 0($sp)

shift_down_loop:
    beq $t2, 0, conclude_shift
    lw $t6, 0($t4)
    
    beq $t6, 2, shift_down      # shift red down
    
    addi $t2, $t2, -4            # increment count
    addi $t4, $t4, -4
    
    j shift_down_loop
    
conclude_shift:
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra
    
shift_down:
    li $t6, 0
    # calc shift down amount
    li $t9, 0
    
    jal calc_shift
    # t6 now contains shift down amount   
    add $t6, $t6, $t4 
    
    li $t9, -3      # black
    sw $t9, 0($t4)  # set it black
    li $t9, 2       # red
    sw $t9, 0($t6)
    
    addi $t2, $t2, -4            # increment count
    addi $t4, $t4, -4
    j shift_down_loop

# t9 is counter set to 0 before call
# t1 contains # of shifts down
calc_shift:
    beq $t9, $t1, return    # return to loop
    addi $t6, $t6, 128
    addi $t9, $t9, 1
    j calc_shift
    
return:
    jr $ra
    

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
    
    j draw_game_init
    
    
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
    
    j draw_game_init

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
    
    j draw_game_init
    
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
    
    j draw_game_init
    
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
	li $a0, 100
	li $v0, 32
	syscall

    #5. Go back to 1
    b game_loop
    
exit:
    li $v0, 10              # terminate the program gracefully
    syscall
