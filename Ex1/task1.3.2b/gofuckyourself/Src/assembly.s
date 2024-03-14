.syntax unified
.thumb

#include "initialise.s"

.global main

.data
@ define variables
LED_Pattern: .word 0b00000001 @each bit is an LED they start at LD4 and go clockwise
@ to LD6.

.text
@ define text

set_leds:
    LDR R1, =GPIOE
    STRB R0, [R1, #ODR + 1]
    BX LR

leds_button_pattern:
	LSL R0, R0, #1 @shifts the pattern left by one
	ORR R0, R0, #1 @makes sure 1 LED is on
	BX LR
main:
	@ Branch with link to set the clocks for the I/O and UART
	BL enable_peripheral_clocks

	@ Once the clocks are started, need to initialise the discovery board I/O
	BL initialise_discovery_board

	@initilize
	LDR R0, =LED_Pattern
	LDR R0, [R0]
	@BL set_leds
	@EOR R0, R0, #0xFF
	B set_leds
program_loop:
	LDR R0, =GPIOA
	LDR R1, =GPIOA
	LDR R1, [R0, #IDR]

	TST R1, #1
	BEQ button_not_pressed

	@button is pressed
	LDR R0, =LED_Pattern
	LDR R0, [R0]
	BL leds_button_pattern
	STR R0, [LED_Pattern]
	BL set_leds

button_not_pressed:
	B program_loop          @ Loop indefinitely


