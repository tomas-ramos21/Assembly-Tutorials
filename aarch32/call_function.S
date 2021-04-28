
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@ AUTHOR: Tomas Ramos
	@ NAME: Call a function 
	@ PURPOSE: Call a function build stack frame
	@ COMPILER: GCC
	@ OS: Linux
	@ ARCH: ARMv7 32-Bits
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

.section .data

data:
	.word 128

present:
	.asciz "Result: %d\n"

.section .text
.globl main

add:
	push {fp} 	  @ Save FP on the stack
	movs fp, sp	  @ Copy SP into FP
	sub sp, sp, #4	  @ Create space on the stack 
	str r0, [fp, #-4] @ Store Value on stack
	pop {r2}	  @ Pop value into R3
	add r0, r1, r2	  @ Add values
	movs sp, fp	  @ Rebuild previous stack
	pop {fp}	  @ Pop stack into FP
	bx lr		  @ Return from function

main:
	movs r0, #128	 @ Set first argument
	ldr r2, =data	 @ Load second argument pointer
	ldr r1, [r2]	 @ Fetch pointed value
	bl add		 @ Call function
	movs r1, r0	 @ Copy previous result R0 into R1
	ldr r0, =present @ Load string pointer
	bl printf(PLT)   @ Call C's printf
	movs r0, #0	 @ Set exit status
	bl exit		 @ Exit
