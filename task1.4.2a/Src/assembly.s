.syntax unified
.thumb

#include "initialise.s"

.global main

.data
LED_Pattern: .word 0b00000001

.text

set_leds:
    LDR R1, =GPIOE
    STRB R0, [R1, #ODR + 1]
    BX LR

main:
	BL enable_peripheral_clocks
	BL initialise_discovery_board

	LDR R0, =LED_Pattern
	LDR R0, [R0]
	B set_leds

program_loop:
	B program_loop


