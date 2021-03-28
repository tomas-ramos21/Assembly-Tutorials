
    #####################################################
    # AUTHOR: Tomas Ramos
    # NAME: FPU Conditional Tricks
    # PURPOSE: Use assembly trick for FP conditionals
    # COMPILER: CLang
    # OS: OSx
    #####################################################

.section __DATA,__data

_value_1:
    .float 10.5532

_value_2:
    .float 4.923

_smaller:
    .asciz "Value 1 is smaller.\n"

_greater:
    .asciz "Value 1 is greater or equal.\n"

.section __TEXT,__text
    .global _main

_main:
    subq $8, %rsp                  # Align stack
    movss _value_1(%rip), %xmm0    # Move single-precision to XMM0
    ucomiss _value_2(%rip), %xmm0  # Compare with another value
    jb _lessThan                   # Jump if below
    leaq _greater(%rip), %rdi      # Load is greater string
    call _printf                   # Call C's printf
    jmp _exit                      # Exit

_lessThan:
    leaq _smaller(%rip), %rdi      # Load is smaller string
    call _printf                   # Call C's printf
    jmp _exit                      # Exit

_exit:
    movq $0x2000001, %rax          # Set exit system call
    movq $0x0, %rdi                # Set exit status
    syscall
