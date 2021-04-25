
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@ AUTHOR: Tomas Ramos
	@ NAME: Reduce
	@ PURPOSE: Reduce arrays to sum with NEON
	@ COMPILER: GCC - Must use "-mfpu=neon"
	@ OS: Linux
	@ ARCH: ARM 32-Bits
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


.section .data

array1:
	.word 10,20,30,40,50,60	@ Array 1

array2:
	.word 10,20,30,40,50,60	@ Array 2

string:
	.asciz "Result: %d\n"

.section .text
.globl main

reduce:
	vld1.64 d0, [r0]!	@ Load 8 bytes from first array. Increment pointer
	vld1.64 d1, [r1]!	@ Load 8 bytes from second array. Increment pointer
	vadd.u32 d2, d0, d1	@ Add D0 and D1 into D2
	vadd.u32 d3, d3, d2	@ Add D2 and D3 into D3
	subs r2, r2, #1		@ Decrement loop counter
	bne reduce		@ Loop back if counter is not zero
	vmov r0, s7		@ Load last element D3[0]
	vmov r1, s6		@ Load last element D3[1]
	add r0, r1, r0		@ Add D3[0] to D3[1] into R0
	bx lr			@ Return the final sum

main:
	ldr r0, =array1		@ Load pointer to first array
	ldr r1, =array2		@ Load pointer to second array
	mov r2, #3		@ Initialize the counter
	bl reduce		@ Call REDUCE routine
	movs r1, r0		@ Move SUM to R1
	ldr  r0, =string	@ Load pointer to presentation string
	bl printf(PLT)		@ Call PRINTF
	movs r0, #0		@ Set exit status
	bl exit(PLT)		@ Exit
