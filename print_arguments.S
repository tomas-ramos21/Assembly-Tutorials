
    #######################################
    # AUTHOR: Tomas Ramos
    # NAME: Print CLI Arguments
    # PURPOSE: Print the CLI Arguments
    # COMPILER: CLang
    # OS: OSx
    #######################################

.section __DATA,__data

msg:
    .asciz "Argument: %s.\n"

.section __TEXT,__text
    .globl _main

_main:
    nop
    subq $0x8, %rsp              # Align the stack
    movq %rdi, %rcx
    pushq %rbp
    movq %rsp, %rbp
    subq $0x8, %rsp
    pushq %rsi

_show_arguments:
    pushq %rcx                   # Push counter
    movq -0x8(%rbp), %rsi        # Get argument vector
    movq (%rsi), %rsi            # Dereference Pointer
    leaq msg(%rip), %rdi         # Load string pointer
    call _printf                 # Call C's printf
    popq %rcx                    # Get counter
    decq %rcx                    # Decrement counter
    jnz _show_arguments          # Loop back

_exit:
    movq $0x2000001, %rax
    movq $0x0, %rdi
    syscall
