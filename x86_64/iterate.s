
    #########################################
    # AUTHOR: Tomas Ramos
    # NAME: Iterate
    # PURPOSE: Iterate over array and get sum
    # COMPILER: CLang
    # OS: OSx
    # NAME bs: Iterate
    #########################################

.section __DATA, __data

_values:
    .int 10,15,20,25,30,35,40,45

_msg:
    .ascii "Number: %d\n"
    len = . - _msg

.section __TEXT, __text
    .global _main

_main:
    nop
    movq $0x4, %rax             # Set up index counter
    xorq %rsi, %rsi             # Set up accumulator
    leaq _values(%rip), %rdx    # Load address of the array

_loop:
    movq (%rdx), %r8            # Fetch Digit 8 bytes of data (i.e. 2 Numbers)
    addl %r8d, %esi             # Add the first 4 bytes Digit
    shrq $0x20, %r8             # Shift left most bytes to the right
    addl %r8d, %esi             # Add remaining data to the accumulator
    addq $0x8, %rdx             # Increment pointer to next element
    dec  %rax                   # Decrement counter
    jnz  _loop

_show:
    subq $0x8, %rsp             # Align stack
    pushq %rsi                  # Push printf arguments 2
    leaq _msg(%rip), %rdi       # Get pointer to the string
    pushq %rdi                  # Push printf argument 1
    callq _printf

_exit:
    movq $0x2000001, %rax       # System call for exit
    movq $0x0, %rdi             # Exit status
    syscall
