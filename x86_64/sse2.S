
    ########################################
    # AUTHOR: Tomas Ramos
    # NAME: SIMD SSE 2
    # PURPOSE: Use SIMD instructions
    # COMPILER: CLang
    # OS: OSx
    ########################################

.section __DATA,__data

_vector_1:
    .int 128,256,1024,2056

_vector_2:
    .int 128,256,1024,2056

_vector_3:
    .int 0,0,0,0
    len = ((. - _vector_3)/4) - 1

_msg:
    .asciz "Number: %d\n"

.section __TEXT,__text
    .global _main

_main:
    movdqu _vector_1(%rip), %xmm0 # Fetch 128-bits
    movdqu _vector_2(%rip), %xmm1 # Fetch 128-bits
    paddq  %xmm0, %xmm1           # Add SSE2 registers
    movdqu %xmm1, _vector_3(%rip) # Move result to memory
    movq $len, %rcx               # Initialize index counter
    subq $0x8, %rsp               # Align the stack to 16 byte

_show:
    leaq _vector_3(%rip), %r8   # Fetch data pointer
    movl (%r8, %rcx, 0x4), %esi # Fetch element
    leaq _msg(%rip), %rdi       # Fetch string pointer
    pushq %rcx                  # Push counter
    subq $0x8, %rsp             # Align the stack to 16 byte
    pushq %rsi                  # Push variadic argument
    pushq %rdi                  # Push string pointer
    call _printf                # Call C's print
    addq $0x18, %rsp            # Decrement stack pointer to original position
    popq %rcx                   # Get counter from stack
    decq %rcx                   # Decrement counter
    jns _show                   # Jump if counter is not negative

_exit:
    movq $0x2000001, %rax       # Exit call number
    movq $0x0, %rdi             # Exit status code
    syscall
