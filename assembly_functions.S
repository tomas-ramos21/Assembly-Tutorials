
    ######################################################
    # AUTHOR: Tomas Ramos
    # NAME: Assembly Functions and use stack for arguments
    # PURPOSE: Create an assembly function and use stack
    # COMPILER: CLang
    # OS: OSx
    ######################################################

.section __DATA,__data

_msg:
    .asciz "The result is: %f.\n"

_radius:
    .int 15

.section __TEXT,__text
    .globl _main

_main:
    nop
    subq $0x8, %rsp        # Align stack
    pushq _radius(%rip)    # Push radius argument
    subq $0x8, %rsp        # Grow stack for return address
    call _area             # Call _area function
    cvtss2sd (%rsp), %xmm0 # Load result
    movq $0x1, %rax        #
    leaq _msg(%rip), %rdi  # Load string
    call _printf           # Call C's printf
    movq $0x2000001, %rax  # Setup system's exit call number
    movq $0x0, %rdi        # Setup exit status
    syscall

    .globl _area           # Make functional acessible everywhere
_area:
.cfi_startproc             # Indicate start of a function - Only usable for debug purposes
    pushq %rbp             # Save stack base pointer
    movq %rsp, %rbp        # Make old RSP the current RBP
    finit                  # Initialize the FPU
    fldpi                  # Load Pi into FPU
    filds 0x18(%rbp)       # Load Radius into FPU
    fmul %st(0), %st(0)    # Multiply Radius by itself
    fmul %st(1), %st(0)    # Multiply ST0 by Pi
    fstps 0x10(%rbp)       # Pop stack into return address
    movq %rbp, %rsp        # Restore RSP
    popq %rbp              # Restore RBP
    ret                    # Return from function
.cfi_endproc               # Indicate end of a function - Only usable for debug purposes
