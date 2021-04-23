

# movtest1.s - An exa,ple of oving data from memory to a register

.section __DATA, __data

_value:
    .int 1

.section __TEXT, __text
.global _main

_main:
    nop
    leaq _value(%rip), %rcx
    movq $0x2000001, %rax
    movq $0x0, %rbx
    syscall
