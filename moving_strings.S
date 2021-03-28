
    #####################################################
    # AUTHOR: Tomas Ramos
    # NAME: Moving Strings
    # PURPOSE: Move Strings between locations
    # COMPILER: CLang
    # OS: OSx
    #####################################################


.section __DATA,__data

_some_string:
    .ascii "Copy Me!\n\0"
    len = (. - _some_string) + 1

.section _BSS,_bss

    .lcomm  buffer, 10

.section __TEXT,__text
    .globl _main

_main:
    subq $0x8, %rsp               # Align the stack
    movq $len, %rcx               # Get string length
    cld                           # Clear DF Flag
    leaq _some_string(%rip), %rsi # Load source string address
    leaq buffer(%rip), %rdi       # Load destination address

_copy:
    movsb                         # Move string's byte (Increments pointer too)
    decq %rcx                     # Decrement counter
    jnz _copy                     # Loop if needed
    leaq buffer(%rip), %rdi       # Load copied string initial address
    call _printf                  # Call C's printf

_exit:
    movq $0x2000001, %rax         # Set up Exit system call number
    movq $0x0, %rdi               # Set up exit status
    syscall
