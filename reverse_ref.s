#
#   Offcourse::RISC-V
#       - Reverse a string
#
#   Copyright: Gijs Jongenelen && e.t.s.v. Thor
#   License: GPLv3 or later
#

.data
prompt:   .ascii "Enter a word: \0"
result:   .ascii "Reversed word: \0"
newline:  .ascii "\n\0"
buffer:   .space 100

.text
.global main

main:
    la a0, prompt
    call print_string
    la a0, buffer
    call read_string
    la a0, buffer
    call strlen
    mv s0, a0  
    la a0, buffer
    li a1, 0
    addi a2, s0, -1
    call reverse
    la a0, result
    call print_string
    la a0, buffer
    call print_string
    la a0, newline
    call print_string
    call exit
    ret

reverse:
    # Base case: if start >= end, stop
    bge a1, a2, reverse_end
    
    # Calculate character positions
    add t0, a0, a1  # t0 = address of start character
    add t1, a0, a2  # t1 = address of end character
    
    # Load characters
    lb t2, 0(t0)    # t2 = first character
    lb t3, 0(t1)    # t3 = last character
    
    # Swap characters
    sb t3, 0(t0)    # store last character at start
    sb t2, 0(t1)    # store first character at end
    
    # Move pointers inward
    addi a1, a1, 1  # start++
    addi a2, a2, -1 # end--
    
    # Save return address
    addi sp, sp, -4
    sw ra, 0(sp)
    
    # Recursive call
    call reverse
    
    # Restore return address
    lw ra, 0(sp)
    addi sp, sp, 4

reverse_end:
    ret
    
