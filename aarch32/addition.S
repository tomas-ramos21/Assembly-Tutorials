
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@ AUTHOR: Tomas Ramos
	@ NAME: Addition
	@ PURPOSE: Use addition instruction
	@ COMPILER: GCC
	@ OS: Linux
	@ ARCH: ARMv7 32-Bits
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


.section .data

integer:
	.word 0xa	@ Integer constant 10

.section .text
.globl main

main:
	ldr r5, =integer @ Load address of "integer"
	ldr r5, [r5]     @ Load one 4 bytes of data from pointer in R5
	movw r6, #10     @ Set register to 10
	add r5, r6	 @ Add R6 into R5
	
leave:
	movs r0, #0
	bl exit
