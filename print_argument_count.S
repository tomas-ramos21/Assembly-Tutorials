
    ######################################################
    # AUTHOR: Tomas Ramos
    # NAME: Print Argument Count
    # PURPOSE: Print the number of argument onto the screen
    # COMPILER: CLang
    # OS: OSx
    ######################################################

.section __DATA,__data

msg:
    .asciz "Argument Count: %d.\n"

.section __TEXT,__text
    .globl _main

_main:
    nop
    subq $0x8, %rsp
    movq %rdi, %rsi
    leaq msg(%rip), %rdi
    call _printf
    movq $0x2000001, %rax
    movq $0x0, %rdi
    syscall
