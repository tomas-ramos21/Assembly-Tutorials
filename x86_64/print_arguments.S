
    #######################################
    # AUTHOR: Tomas Ramos
    # NAME: Print CLI Arguments
    # PURPOSE: Print the CLI Arguments
    # COMPILER: CLang
    # OS: OSx
    #######################################

.section __DATA,__data

msg:
    .asciz "Argument: %s\n"

.section __TEXT,__text
    .globl _main

_main:
    nop
    subq $0x8, %rsp      # Increase the stack
    movq %rdi, %rcx      # Move ARGC to counter

_show_arguments:
    pushq %rsi           # Push current ARGV argument
    pushq %rcx           # Push counter
    movq (%rsi), %rsi    # Dereference ARGV argument
    leaq msg(%rip), %rdi # Load string pointer
    call _printf         # Call C's printf
    popq %rcx            # Get counter
    popq %rsi            # Get Current ARGV argument
    addq $0x8, %rsi      # Increment to next argument
    decq %rcx            # Decrement counter
    jnz _show_arguments  # Loop back

_exit:
    movq $0x2000001, %rax # Setup exit system call number
    movq $0x0, %rdi       # Setup exit status code
    syscall
