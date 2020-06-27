
    #####################################################################
    # AUTHOR: Tomas Ramos
    # NAME: CPUID2
    # PURPOSE: Display the CPU information using the C's library function
    # COMPILER: CLang
    # OS: OSx
    #####################################################################

    .bss
    .lcomm _buffer, 13

    .data
_output:
    .asciz "The processor Vendor ID is '%s'\n"  # String, to be used. The 'acsiz' directive adds the null terminator expected by the C library

    .text
    .global _main

_main:

    movq $0x0, %rax             # Output location for the CPUID call
    cpuid
   
    leaq _buffer(%rip), %rsi    # Move pointer to the buffer into the GPR
    movq %rbx, 0x0(%rsi)        # Move information into the buffer
    movq %rdx, 0x4(%rsi)
    movq %rcx, 0x8(%rsi)
    movq $0x0, 0x12(%rsi)       # Add null terminator
    leaq _output(%rip), %rdi

    subq $0x8, %rsp             # Align the stack to 16-byte address - Required in macOS
    pushq %rsi                  # Push the buffer
    pushq %rdi                  # Push the string
    callq _printf               # Call printf with the variables present on the stack
   
    callq _exit
