
    ########################################
    # AUTHOR: Tomas Ramos
    # NAME: FPU Control
    # PURPOSE: Get FPU Control register
    # COMPILER: CLang
    # OS: OSx
    ########################################

.section __DATA,__data

_new_flag:
    .byte 0x7f,0x0

_tmp:
    .byte 0x0,0x0

_msg:
    .asciz "Control Status: 0x%x\n"

.section __TEXT,__text
    .global _main

_main:
    nop
    xorq %rax, %rax             # Zero RAX
    fstcw _tmp(%rip)            # Move FP control register to memory
    movw _tmp(%rip), %ax        # Fetch FP control register info
    fldcw _new_flag(%rip)       # Load new FP control flag
    fstcw _tmp(%rip)            # Move FP control register to memory
    xorq %rsi, %rsi             # Zero RSI
    movw _tmp(%rip), %si        # Move FP control information to SI
    leaq _msg(%rip), %rdi       # Move string pointer to RDI
    subq $0x10, %rsp            # Grow stack space
    andq $-0x10, %rsp           # Align stack space
    pushq %rsi                  # Push variafix argument
    pushq %rdi                  # Push string pointer
    call _printf                # Call C's printf

_exit:
    movq $0x2000001, %rax       # Set Exit system call number
    movq $0x0, %rdi             # Set exit status
    syscall
