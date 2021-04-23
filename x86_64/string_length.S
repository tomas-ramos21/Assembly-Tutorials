
    #####################################################
    # AUTHOR: Tomas Ramos
    # NAME: Find String Length
    # PURPOSE: Find String Length
    # COMPILER: CLang
    # OS: OSx
    #####################################################

.section __DATA,__data

_string1:
    .asciz "Testing, one, two, three, testing.\n"

_result:
    .asciz "Length is: %d.\n"

.section __TEXT,__text
    .globl _main

_main:
    nop
    cld                         # Clear DF Flag
    subq $0x8, %rsp             # Align Stack
    leaq _string1(%rip), %rdi   # Load string pointer
    movq $0xffff, %rcx          # Load counter
    movq $0x0, %rax             # Null Character

_count:
    scasb                       # Compare character
    je _exit                    # Jump if equal
    decq %rcx                   # Decrement counter
    jnz _count                  # Loop back

_exit:
    leaq _result(%rip), %rdi    # Fetch string pointer
    movq $0xffff, %rsi          # Load Counter
    subq %rcx, %rsi             # Subtract distance
    call _printf                # Call C's printf
    movq $0x2000001, %rax       # Set exit system call number
    movq $0x0, %rdi             # Set exit status
    syscall
