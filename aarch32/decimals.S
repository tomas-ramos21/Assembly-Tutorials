
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@ AUTHOR: Tomas Ramos
	@ NAME: Floating points and double operations
	@ PURPOSE: Manipulate single/double precision
	@ COMPILER: GCC
	@ OS: Linux
	@ ARCH: ARMv7 32-Bits
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

.section .data

num1:
	.float 3.12345

num2:
	.double 3.12345

str:
	.asciz "Result: %f\n"

.section .text
.globl main

main:
	ldr r0, =num1		@ Load first number address
	ldr r1, =num2		@ Load second number address
	vldr.f32 s0, [r0]	@ Load single precision
	vldr.f64 d1, [r1]	@ Load double precision
	vcvt.f64.f32 d2, s0	@ Convert single to double precision
	vadd.f64 d0, d1, d2	@ Add numbers
	vmov r2, r3, d0		@ Move the 64-bits to R2 and R3
	ldr r0, =str		@ Load string pointer
	eor r1, r1, r1		@ Zero R1
	bl printf(PLT)		@ Call printf 
	movs r0, #0		@ Set exit status
	bl exit(PLT)		@ Exit
