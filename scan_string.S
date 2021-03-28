
    #####################################################
    # AUTHOR: Tomas Ramos
    # NAME: Scan String
    # PURPOSE: Scan String Instruction
    # COMPILER: CLang
    # OS: OSx
    #####################################################

.section __DATA,__data

_string1:
    .ascii "This is a test - a long text string to scan.\0"
    len = . - _string1

_string2:
    .ascii "-\0"

_contains:
    .asciz "The string contains the char at: %d.\n"

_not_contains:
    .asciz "The string does NOT contain the char: %s.\n"

.section __TEXT,__text
    .globl _main

_main:
    nop
    cld                         # Clear DF Flag
    subq $0x8, %rsp             # Align stack
    movq $len, %rcx             # Set counter to the length of the string
    leaq _string1(%rip), %rdi   # Load String to be searched for a character
    leaq _string2(%rip), %rsi   # Load character to search for
    lodsb                       # Load character byte into RAX

_search:
    scasb                          # Scan for the character
    je _found                      # If found break loop
    decq %rcx                      # Decrement counter
    jnz _search                    # Loop
    leaq _not_contains(%rip), %rdi # Load output string pointer
    leaq _string2(%rip), %rsi      # Load character string pointer
    call _printf                   # Call C's printf

_exit:
    movq $0x2000001, %rax        # Setup exit system call number
    movq $0x0, %rdi              # Setup exit status
    syscall

_found:
    movq $len, %rsi             # Load length of the string
    subq %rcx, %rsi             # Get character position
    leaq _contains(%rip), %rdi  # Load output string pointer
    call _printf                # Call C's printf
    jmp _exit                   # Exit
