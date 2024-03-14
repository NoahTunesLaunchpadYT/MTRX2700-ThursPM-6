.syntax unified
.thumb

#include "initialise.s"

.global main

.data
@ define variables
LED_Pattern: .word 0b00000011 @each bit is an LED they start at LD4 and go clockwise
@ to LD6.

.text
@ define text
increment_led_pattern:
    PUSH {LR}          @ Save Link Register
    MOVS R1, #0x01     @ Start with the first LED
    CMP R0, #0         @ Compare the current pattern with 0
    BEQ set_leds       @ If pattern is 0, load R1
    LSL R0, R0, #1     @ Shift pattern left by one bit


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

	LDR R0, =GPIOA
	LDR R1, [R0, #MODER]
	AND R1, #0b11111100
	STRB R1,[R0, #MODER]

	TST R1, #1 @TST instruction to test if the least significant bit (corresponding to PA0) is set.
	@This bit represents the button state.
	BEQ button_not_pressed

	LDR R0, =LED_Pattern
    LDR R1, [R0]
    BL increment_led_pattern
    STR R1, [R0]
    BL set_leds



button_not_pressed:
	B program_loop @ Loop indefinitely



