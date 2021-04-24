	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@ AUTHOR: Tomas Ramos
	@ NAME: Sum
	@ PURPOSE: Find sum of array
	@ COMPILER: GCC
	@ OS: Linux
	@ ARCH: ARM 32-Bits
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

.section .data

@ Array of 5 elements. The sum result should be 150
array:
	.word 10,20,30,40,50

.section .text
.globl main

main:
	ldr r0, =array	@ Load pointer to array
	mov r1, #0	@ Set accumulator to 0
	mov r2, #4	@ Set loop counter

loop:
	ldr r3, [r0, r2, lsl #2] @ Load the last digit
	add r1, r3               @ Add to accumulator
	subs r2, #1              @ Decrement counter
	bge loop                 @ Loop if counter is not lower than 0

leave:
	movs r0, #0 @ Set exit status
	bl exit     @ Exit
