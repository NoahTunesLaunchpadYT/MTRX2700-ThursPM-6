.syntax unified
.thumb

#include "initialise.s"

.global main

.data
LED_Pattern: .word 0b11111111 @LED pattern

.text

set_leds: @R0 is the pattern
    LDR R1, =GPIOE
    STRB R0, [R1, #ODR + 1]
    BX LR

main:
	BL enable_peripheral_clocks
	BL initialise_discovery_board

	LDR R0, =LED_Pattern @load pattern
	LDR R0, [R0] @load pattern value
	B set_leds

program_loop:
	B program_loop


