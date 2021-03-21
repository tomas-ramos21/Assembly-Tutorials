
    ########################################
    # AUTHOR: Tomas Ramos
    # NAME: Signed Multiplication
    # PURPOSE: Signed Multiplication instruction
    # COMPILER: CLang
    # OS: OSx
    ########################################


.section __DATA,__data

_value_1:
    .int 4

_value_2:
    .int -3

_msg:
    .asciz "Result: %d\n"

.section __TEXT,__text
    .global _main

_main:
    movl _value_1(%rip), %eax   # Load value to multiply
    imull _value_2(%rip), %eax  # Load multiplier and apply it
    subq $0x8, %rsp             # Align Stack to 16 byte
    movq %rax, %rsi             # Move result
    pushq %rsi                  # Push variadic argument
    leaq _msg(%rip), %rdi       # Fetch string pointer
    pushq %rdi                  # Push string pointer
    call _printf                # Call C's printf

_exit:
    movq $0x2000001, %rax       # Exit system call
    movq $0x0, %rdi             # Exit status
    syscall
