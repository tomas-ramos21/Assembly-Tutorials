
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@ AUTHOR: Tomas Ramos
	@ NAME: 128-Bit NEON 
	@ PURPOSE: Make full use of 128-bit operations
	@ COMPILER: GCC - Must use "-mfpu=neon"
	@ OS: Linux
	@ ARCH: ARMv7 32-Bits
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

.section .data

array1:
	.word 32,32,32,32,64,64,64,64

str:
	.asciz "Result: %d\n"

.section .text
.globl main

reduce128:
	vld1.64 d0, [r0]!	@ load 64 bits and increment pointer
	vld1.64 d1, [r0]!	@ load 64 bits and increment pointer
	vld1.64 d2, [r0]!	@ load 64 bits and increment pointer
	vld1.64 d3, [r0]! 	@ load 64 bits and increment pointer
	vadd.u32 q0, q1, q0	@ add 2x 128-bit registers
	vadd.u32 d0, d0, d1	@ add 2x 64-bit registers
	vmov r0, r1, s0, s1	@ move 2x 32-bit registers
	add r0, r0, r1		@ add 2x 32-bit registers
	bx lr			@ return from function

main:
	ldr r0, =array1		@ load array pointer
	bl reduce128		@ call reduce function
	mov r1, r0		@ copy reduce's function result to R1
	ldr r0, =str		@ load string pointer
	bl printf(PLT)		@ call printf
	mov r0, #0		@ set exit status
	bl exit(PLT)		@ call exit function
