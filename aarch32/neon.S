
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@ AUTHOR: Tomas Ramos
	@ NAME: Neon
	@ PURPOSE: Use Neon instructions
	@ COMPILER: GCC - Must pass argument "-mfpu=neon"
	@ OS: Linux
	@ ARCH: ARMv7-A 32-Bits
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


.section .data

array1:
	.word 10,20

array2:
	.word 10,20

.section .text
.globl main

main:
	ldr r0, =array1
	ldr r1, =array2
	vld1.64 d0, [r0]
	vld1.64 d1, [r1]
	vadd.u32 d0, d0, d1

leave:
	mov r0, #0
	bl exit(PLT)
