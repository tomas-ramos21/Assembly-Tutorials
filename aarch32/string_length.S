
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@ AUTHOR: Tomas Ramos
	@ NAME: String Length
	@ PURPOSE: Find string length
	@ COMPILER: GCC
	@ OS: Linux
	@ ARCH: ARM 32-Bits
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

.section .data

string:
	.asciz "Some string for us to count!"

present:
	.asciz "Counter: %d\n"

.section .text
.globl main

count:
	ldrb r2, [r0]		@ Load first character 
	tst r2, r2		@ Check if it's zero
	add r0, r0, #1		@ Increment pointer
	addne r1, r1, #1	@ Increment Counter if not zero
	bne count		@ Loop if not zero
	mov r0, r1		@ Move counter to return register
	bx lr			@ Return from function

main:
	ldr r0, =string		@ Get string address
	mov r1, #0		@ Initialize counter
	bl count		@ Call subroutine
	movs r1, r0		@ Move counter to R1
	ldr r0, =present	@ Presentation string pointer
	bl printf(PLT)		@ Call printf

leave:
	mov r0, #0		@ Set exit status
	bl exit(PLT)		@ Exit

