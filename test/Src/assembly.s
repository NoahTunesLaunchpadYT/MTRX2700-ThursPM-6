.syntax unified
.thumb

#include "initialise.s"
#include "definitions.s"

.global main

.data
LED_Pattern: .word 0b00000000 @ each bit is an LED they start at LD4 and go clockwise to LD6.

.text

set_leds:
	LDR R1, =GPIOE
	STRB R0, [R1, #ODR + 1]
	BX LR


main:
	BL enable_peripheral_clocks
	BL initialise_discovery_board

	LDR R1, =GPIOA


	@LDR R0, =LED_Pattern
	@LDR R0, [R0]
	@B set_leds

program_loop:
	LDRB R1,[R0, #IDR]
	ANDS R1, #0x01 @ands (cpu flags, if 0 flag is up, if 1 flag is down
	BNE pressed

	B program_loop

pressed:
	LDR R0, =LED_Pattern
	LDR R2, [R0]
	MOVS R3, #1
	BX LR
find_zero_bit:
	TST R2, R3
	BNE shift_bit
	ORRS R2, R2, R3
	STR R2,[R0]
	BX LR
shift_bit:
	LSLS R3, R3, #1
	CMP R3, #0
	BNE find_zero_bit
	BX LR

	B set_leds
