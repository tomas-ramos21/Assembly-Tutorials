
    #####################################################
    # AUTHOR: Tomas Ramos
    # NAME: FPU Math Operations
    # PURPOSE: Perform math operations on the FPU stack
    # COMPILER: CLang
    # OS: OSx
    #####################################################


.section __DATA,__data

_value1:
    .float 43.65

_value2:
    .int 22

_value3:
    .float 76.34

_value4:
    .float 3.1

_value5:
    .float 12.43

_value6:
    .int 6

_value7:
    .float 140.2

_value8:
    .float 94.21

_result:
    .float 0.0

_msg:
    .asciz "Result: %f\n"

.section __TEXT,__text
    .globl _main

_main:
    nop
    finit
    flds _value1(%rip)          # Load value_1
    fidivl _value2(%rip)        # Divide by integer value_2
    flds _value3(%rip)          # Load value_3
    flds _value4(%rip)          # Load value_4
    fmul %st(1), %st(0)         # Multiply value_3 by value_4
    fadd %st(2), %st(0)         # Add Result of multiplication to division of value_1 by value_2
    flds _value5(%rip)          # Load value_5
    fimull _value6(%rip)        # Multiply value_5 by value_6
    flds _value7(%rip)          # Load value_7
    flds _value8(%rip)          # Load value_8
    fdivr %st(1), %st(0)        # Divide value_7 by value_8
    fsubr %st(2), %st(0)        # Subtract the division from value_5 and value_6 multiplication
    fdivr %st(3), %st(0)        # Divide result from first section by the previous result
    fstps _result(%rip)         # Move final top of FPU stack to memory

_show:
    subq $0x8, %rsp             # Align the stack
    cvtss2sd _result(%rip), %xmm0 # Convert single-precision to double-precision
    leaq _msg(%rip), %rdi         # Load string pointer
    movq $0x1, %rax               # Number of arguments in XMM
    call _printf                  # Call C's printf

_exit:
    movq $0x2000001, %rax       # Set exit system call number
    movq $0x0, %rdi             # Set exit status to 0
    syscall
