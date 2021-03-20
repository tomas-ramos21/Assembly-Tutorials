
    #########################################
    # AUTHOR: Tomas Ramos
    # NAME: Exchange Instruction
    # PURPOSE: Exchange data between 2 registers
    # COMPILER: CLang
    # OS: OSx
    # NAME: Exchange
    #########################################

.section __DATA,__data

_value1:
    .quad 100

_value2:
    .quad 200

_msg:
    .ascii "Number: %d\n"

.section __TEXT,__text
    .global _main

_main:
    nop                         # No operation

_show_1:                        # Print _value1
    leaq _value1(%rip), %r8     # Load _value1 address
    movq (%r8), %rsi            # Fetch _value1 actual value
    leaq _msg(%rip), %rdi       # Load _msg address
    subq $0x8, %rsp             # Align Stack
    pushq %rsi                  # Push variadic argument
    pushq %rdi                  # Push string pointer
    callq _printf               # Call printf
    popq %r15                   # Clean up stack argument 1
    popq %r15                   # Clean up stack argument 2

_show_2:                        # Print _value2
    leaq _value2(%rip), %r10    # Load _value2 address
    movq (%r10), %rsi           # Fetch _value2 actual value
    leaq _msg(%rip), %rdi       # Load _msg address
    pushq %rsi                  # Push variadic argument
    pushq %rdi                  # Push string pointer
    callq _printf               # Call printf
    popq %r15                   # Clean up stack argument 1
    popq %r15                   # Clean up stack argument 2

_exchange:                      # Exchange value is both memory locations
                                # It can me more efficient this is just to
                                # use the 'xchg' operation
    leaq _value1(%rip), %r8     # Load _value1 address
    leaq _value2(%rip), %r10    # Load _value2 address
    movq (%r8), %r9             # Load _value1 actual value
    movq (%r10), %r11           # Load _value2 actual value
    xchgq %r9, %r11             # Exchange contents
    movq %r11, (%r10)           # Write _value1 actual value to _value2 address
    movq %r9, (%r8)             # Write _value2 actual value to _value1 address

_show_3:                        # Print new _value1
    leaq _value1(%rip), %r8     # Load _value1 address
    movq (%r8), %rsi            # Fetch _value1 actual value
    leaq _msg(%rip), %rdi       # Load _msg address
    pushq %rsi                  # Push variadic argument
    pushq %rdi                  # Push string pointer
    callq _printf               # Call printf
    popq %r15                   # Clean up stack argument 1
    popq %r15                   # Clean up stack argument 2

_show_4:                        # Print new _value2
    leaq _value2(%rip), %r10    # Load _value2 address
    movq (%r10), %rsi           # Load _value2 actual value
    leaq _msg(%rip), %rdi       # Load _msg address
    pushq %rsi                  # Push variadic argument
    pushq %rdi                  # Push string pointer
    callq _printf               # Call printf

_exit:                          # Perform exit call
    movq $0x2000001, %rax
    movq $0x0, %rdi
    syscall
