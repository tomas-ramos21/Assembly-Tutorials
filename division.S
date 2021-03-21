
    ########################################
    # AUTHOR: Tomas Ramos
    # NAME: Division
    # PURPOSE: Division instruction
    # COMPILER: CLang
    # OS: OSx
    ########################################


.section __DATA,__data

_dividend:
    .quad 12

_divisor:
    .int 5

_quotient_msg:
    .asciz "Quotient: %d\n"

_remainder_msg:
    .asciz "Remainder: %d\n"

.section __TEXT,__text
    .global _main

_main:
    nop
    xorq %rdx, %rdx                 # Zero the upper bound of the dividend
    movq _dividend(%rip), %rax      # Load lower part of the dividend
    divl _divisor(%rip)             # Apply divisor
    subq $0x8, %rsp                 # Grow stack by 8 bytes
    pushq %rdx                      # Push remainder to stack
    subq $0x8, %rsp                 # Align stack
    movq %rax, %rsi                 # Move quotient to variafic arguments
    leaq _quotient_msg(%rip), %rdi  # Fetch string pointer
    pushq %rsi                      # Push variadic argument
    pushq %rdi                      # Push string pointer
    call _printf                    # Call C's printf
    addq $0x18, %rsp                # Walk back on the stack
    popq %rsi                       # Get the remainder value
    leaq _remainder_msg(%rip), %rdi # Get string pointer
    pushq %rsi                      # Push remainder to variafix arguments
    pushq %rdi                      # Push string pointer
    call _printf                    # Call C's printf

_exit:
    movq $0x2000001, %rax           # Set exit system call number
    movq $0x0, %rdi                 # Set exit status code
    syscall
