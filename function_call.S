
    ###########################################################
    # AUTHOR: Tomas Ramos
    # NAME: Function Calls
    # PURPOSE: Perform function call while maintain stack info
    # COMPILER: CLang
    # OS: OSx
    # NAME: Function Calls
    ###########################################################

.section __DATA,__data

_msg:
    .asciz "You are in section: %d\n"

.section __TEXT,__text

    .global _main

_main:
    subq $0x8, %rsp          # Align stack
    movq $0x1, %rsi          # Fetch section number
    leaq _msg(%rip), %rdi    # Fecth string point
    pushq %rsi               # Push variadic argument to the stack
    pushq %rdi               # Push string pointer to the stack
    callq _printf            # Call C's printf
    callq _section_2         # Jump to 'section/function' 2
    movq $0x3, %rsi          # Fetch section number
    leaq _msg(%rip), %rdi    # Fecth string pointer
    pushq %rsi               # Push variadic argument
    pushq %rdi               # Push string pointer
    call _printf             # Call C's printf

_exit:
    movq $0x2000001, %rax    # Fetch system call number (OSx)
    movq $0x0, %rdi          # Exit status
    syscall

_section_2:
    pushq %rbp               # Push current stack base pointer to stack
    movq %rsp, %rbp          # Make the current top of stack pointer the base pointer
    movq $0x2, %rsi          # Fetch section number
    leaq _msg(%rip), %rdi    # Fetch string pointer
    pushq %rsi               # Push variadic argument
    pushq %rdi               # Push string pointer
    callq _printf            # Call C's printf
    movq %rbp, %rsp          # Restore top of stack pointer
    popq %rbp                # Restore stack base pointer
    retq
