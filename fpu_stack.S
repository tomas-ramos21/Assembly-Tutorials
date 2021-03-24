
    #####################################################
    # AUTHOR: Tomas Ramos
    # NAME: FPU Stack
    # PURPOSE: Perform standards operations on FPU Stack
    # COMPILER: CLang
    # OS: OSx
    #####################################################

.section __DATA,__data

_value1:
    .int 40

_value2:
    .float 92.4405

_value3:
    .double 221.440321

_msg:
    .asciz "Result: %f\n"

.section __BSS,__bss

    .lcomm _int1, 4
    .lcomm _control, 2
    .lcomm _status, 2
    .lcomm _result, 4

.section __TEXT,__text
    .global _main

_main:
    finit                       # Set control and status register to defaults
    fstcw _control(%rip)        # Move control register to memory
    fstsw _status(%rip)         # Move status register to memory
    filds _value1(%rip)         # Load integer value to FPU stack
    fists _int1(%rip)           # Move top of the stack to memory
    flds _value2(%rip)          # Load single-precision number
    fldl _value3(%rip)          # Load double-precision number
    fst %st(4)                  # Copy ST0 to ST4
    fxch %st(1)                 # Exchange ST0 with ST1
    fstps _result(%rip)         # Move result to memory

_show:
    subq $0x8, %rsp               # Stack Alignment
    cvtss2sd _result(%rip), %xmm0 # Convert Single-Precision to Double-Precision
    leaq _msg(%rip), %rdi         # Load String pointer
    movq $0x1, %rax               # Number of floats inside XMM0 to be printed
    callq _printf                 # Call C's printf

_exit:
    movq $0x2000001, %rax         # Exit code call number
    movq $0x0, %rdi               # Exit status code
    syscall
