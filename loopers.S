
    ########################################
    # AUTHOR: Tomas Ramos
    # NAME: Loopers
    # PURPOSE: Use the loop instruction
    # COMPILER: CLang
    # OS: OSx
    ########################################

.section __DATA,__data

_msg:
    .asciz "Iteration: %d\n"

.section __TEXT,__text

    .global _main

_main:
    nop
    subq $0x8, %rsp            # Align stack
    movq $0xa, %rcx            # Setup counter

_show:
    nop
    movq %rcx, %rsi             # Move current iteration to RSI
    leaq _msg(%rip), %rdi       # Fetch string pointer
    pushq %rcx                  # Push variadic arguments
    pushq %rdi                  # Push string pointer
    callq _printf               # Call C's printf
    addq $0x8, %rsp             # 'Decrement' stack pointer by 8 bytes (i.e. 1 Address)
    popq %rcx                   # Get counter previous state
    loop _show                  # Loop over show

_exit:
    movq $0x2000001, %rax       # Set Darwin system call Number
    movq $0x0, %rdi             # Set exit status
    syscall
