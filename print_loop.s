
    ############################################################
    # AUTHOR: Tomas Ramos
    # NAME: print_loop
    # PURPOSE: Print variables of an array using loop structure
    # COMPILER: CLang
    # OS: OSx
    ############################################################

    .bss

    .data
values:
    .int 10,15,20,25,30,35,40,45,50
output:
    .asciz "The value is '%d'.\n"

    .text
    .global _main

_main:
    nop                     # Prepare the loop's static information
    subq $0x8, %rsp         # Align stack to 16-byte address
    movq $0x0, %rcx         # Starting Index
    leaq output(%rip), %rdi # Set the pointer to the string to be used
    leaq values(%rip), %rbx # Set the pointer to the base address of the array
    jmp _loop

_loop:
    movq (%rbx, %rcx, 0x4), %rsi
    pushq %rdi
    pushq %rsi
    call _printf
    popq %r10
    popq %r10
    incq %rcx
    cmpq $0x8, %rcx
    jne _loop
    pushq $0x0
    call _exit
