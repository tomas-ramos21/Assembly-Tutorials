
    #########################################
    # AUTHOR: Tomas Ramos
    # NAME: Conditional move instruction
    # PURPOSE: Find largest number in array
    # COMPILER: CLang
    # OS: OSx
    # NAME: Conditinal Move
    #########################################

.section __DATA,__data

_numbers:
    .quad 100,201,400,99,600,105,500,250
    len = (. - _numbers)/8

_output:
    .asciz "The largest number is %d\n"

.section __TEXT,__text
    .global _main

_main:
    nop
    leaq _output(%rip), %rdi     # Load string address
    leaq _numbers(%rip), %r9     # Load number array address
    xorq %rsi, %rsi              # Current lowest
    movq $len, %rcx              # Get array size

_loop:
    nop
    movq (%r9), %r11             # Load 8 bytes of data
    addq $0x8, %r9               # Increment pointer
    cmp %rsi, %r11               # Compare loaded with current lowest
    cmova %r11, %rsi             # Move data if loaded value is larger
    dec %rcx                     # Decrement counter
    jnz _loop

_show:
    nop
    subq $0x8, %rsp              # Align the stack
    pushq %rsi                   # Push printf variadic arguments
    pushq %rdi                   # Push string to be printed
    callq _printf

_exit:
    movq $0x2000001, %rax       # System call for exit
    movq $0x0, %rdi             # Exit status
    syscall
