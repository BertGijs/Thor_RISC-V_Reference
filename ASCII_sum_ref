#
#   Offcourse::RISC-V
#       - Sum of characters
#
#   Copyright: Gijs Jongenelen && e.t.s.v. Thor
#   License: GPLv3 or later
#

.data
prompt:   .ascii "Enter a word: \0"
result:   .ascii "Sum of ASCII values: \0"
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
    call sum_of_ASCII
    mv s0, a0
    la a0, result
    call print_string
    mv a0, s0 
    call print_int
    la a0, newline
    call print_string
    call exit
    ret

sum_of_ASCII:
    li t0, 0            # Initialize sum (t0 = 0)
sum_loop:
    lbu t1, 0(a0)        # Load unsigned byte (character)
    beqz t1, sum_end    # Exit on null terminator
    add t0, t0, t1      # Accumulate sum
    addi a0, a0, 1      # Move to next character
    j sum_loop
sum_end:
    mv a0, t0           # Return result in a0
    ret
