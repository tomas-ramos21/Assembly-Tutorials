
    ###########################################
    # AUTHOR: Tomas Ramos
    # NAME: CPUID
    # PURPOSE: Display processor manufacturer
    # COMPILER: CLang
    # OS: OSx
    ###########################################

    .bss

    .data

output:
    .ascii "The processor Vendor ID is xxxxxxxxxxxx\n"
    len = . - output

    .text

    .global _main

_main:

    movq $0x0, %rax         # Define stdin as the output location for the cpuid call
    cpuid                   # Then call cpuid
    leaq output(%rip), %rsi # Get pointer to the string
    movq %rbx, 0x1B(%rsi)   # Add information to the string x3
    movq %rdx, 0x1F(%rsi)
    movq %rcx, 0x23(%rsi)
    movq $0xA, 0x27(%rsi)   # Add new line character

    movq $0x2000004, %rax   # System call number, remember the string in already pointed to by RSI
    movq $0x1, %rdi         # Pass the file descriptor
    movq $len, %rdx         # Length of the string
    syscall

    jmp _exit

_exit:

    movq $0x2000001, %rax   # System call for exit
    movq $0x0, %rdi         # Exit status

    syscall
