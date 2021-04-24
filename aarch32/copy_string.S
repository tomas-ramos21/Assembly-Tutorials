
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@ AUTHOR: Tomas Ramos
	@ NAME: Copy String
	@ PURPOSE: Copy a string
	@ COMPILER: GCC
	@ OS: Linux
	@ ARCH: ARM 32-Bits
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

.section .data

string:
	.asciz "Copy me!"	@ Storing literal to copy

dst:
	.lcomm buff, 9		@ Destination 

present:
	.asciz "Copied: %s\n"

.section .text
.globl main

copy:
	ldrb r2, [r0]		@ Load first byte of the string
	strb r2, [r1]		@ Store first byte at destination
	add  r0, r0, #1		@ Increment pointer
	add  r1, r1, #1		@ Increment pointer
	tst r2, r2		@ Check if it's the null character
	bne copy		@ Loop back
	mov r0, #1		@ Return 1 if successful
	bx lr			@ Return from function

main:
	ldr r0, =string 	@ Setup first argument (Source)
	ldr r1, =buff		@ Setup second argument (Destination)
	bl copy			@ Execute string copy
	ldr r0, =present	@ Load presentation string pointer
	ldr r1, =buff		@ Load second argument
	bl printf		@ Print copied string

leave:
	mov r0, #0		@ Set exit status
	bl exit			@ Exit program
