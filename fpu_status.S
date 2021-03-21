
    ########################################
    # AUTHOR: Tomas Ramos
    # NAME: FPU Status
    # PURPOSE: Get FPU status register
    # COMPILER: CLang
    # OS: OSx
    ########################################

.section __DATA,__data

_msg:
    .asciz "Status: 0x%x\n"

.section __TEXT,__text
    .global _main

_main:
    nop
    xorq %rax, %rax             # Cleanup RAX
    fstsw %ax                   # Get FPU 16-bit status
    movq %rax, %rsi             # Move Bits into correct register
    leaq _msg(%rip), %rdi       # Fetch string pointer
    subq $0x8, %rsp             # Align stack
    pushq %rsi                  # Push variadic argument
    pushq %rdi                  # Push string pointer
    call _printf                # Call C's printf

_exit:
    movq $0x2000001, %rax       # Set exit system code
    movq $0x0, %rdi             # Set exit status
    syscall
