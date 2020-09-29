# for addr in range(32):
#     if memory[addr][31] != 0:
#         word = ~word

# while testing with mars "lw   $a0, 0($0)" was the reason of "out of range" exception
# while copy to main.S replace "lw   $a0, 0x10010000($v0)" to "lw   $a0, 0($v0)"
# and the same do with "sw" instruction
# and delete .data section

# $t0 contains 32 constant
# $t1 contains memory_loop counter
# $t2 contains word_loop counter
# $v0 contains memory address of the next word to load
# $v1 contains the last one bit from loaded word
# $a0 contains loaded from memory word


.text

init:
            addi $t0, $t0, 32		# clear
            addi $t1, $t1, 0		#
            addi $t2, $t2, 0		#
            addi $v0, $v0, 0		#
            addi $v1, $v1, 0		#
            addi $a0, $a0, 0		#

memory_loop:				# for addr in range(32):
            sll  $v0, $t1, 2		# multiply t1 (memory_loop counter) by 4
            lw   $a0, 0x00000000($v0)	# load word from memory
            
if:
            andi $v1, $a0, 0x00000001	# bitwise mask on loaded word
            beq  $v1, $0, memory_loop_next # if memory[addr][31] == 0 goto memory_loop_next

invert:
            xori $a0, $a0, 0xffffffff	# bitwose xor == inversion
            sw   $a0, 0x00000000($v0)	# store inverted word

memory_loop_next:            
            addi $t1, $t1, 1		# incriment t1 by 1
            sub  $t3, $t0, $t1		# t3 = t0 - t1
            bgez $t3, memory_loop	# if t3 >= 0 then goto memory_loop



# .data
# 0x11111111
# 0x00000000
# 0x22222222
# 0x00000000
# 0x33333333