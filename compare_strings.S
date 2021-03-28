
    #####################################################
    # AUTHOR: Tomas Ramos
    # NAME: Moving Strings
    # PURPOSE: Move Strings between locations with REP
    # COMPILER: CLang
    # OS: OSx
    #####################################################

.section __DATA,__data

_string1:
    .ascii "Test"
    len = . - _string1

_string2:
    .ascii "Test"

_equal:
    .asciz "Strings are equal.\n"

_different:
    .asciz "Strings are NOT equal.\n"

.section __TEXT,__text
    .globl _main

_main:
    nop                         # No operation
    cld                         # Clean DF flag
    subq $0x8, %rsp             # Align stack
    movq $len, %rcx             # Set up counter with string length
    leaq _string1(%rip), %rsi   # Load string 1
    leaq _string2(%rip), %rdi   # Load string 2

_compare:
    cmpsb                       # Compare string byte
    jne _not_equal              # Jump to _not_equal
    decq %rcx                   # Decrement counter
    jnz _compare                # Loop back
    leaq _equal(%rip), %rdi     # Load equality string
    call _printf                # Call C's printf
    movq $0x2000001, %rax       # Set up system's exit call number
    movq $0x0, %rdi             # Move 0 to exit status
    syscall

_not_equal:
    leaq _different(%rip), %rdi # Load not equal string
    call _printf                # Call C's printf
    movq $0x2000001, %rax       # Set up system's exit call number
    movq $0x0, %rdi             # Move 0 to exit status
    syscall
