.syntax unified
.thumb


#include "initialise.s"
#include "definitions.s"
#include "count_character1.s"
#include "delay.s"
.global main

.data
@ define variables
Word: .asciz "abbcccddddeeeeeffffffggggggghhhhhhhhiiiiiiijjjjjjkkkkkllllmmmnnoppqqqrrrrsssssttttttuuuuuuuvvvvvvvvwwwwwwwxxxxxxyyyyyzzzz"
Default_LED_Pattern: .word 0b00000000
DelayValue: .word 500000
Defaultletter: .asciz "a"

.text

set_leds: @R6 is the pattern
    LDR R5, =GPIOE
    STRB R6, [R5, #ODR + 1]
    BX LR


main:
    BL enable_peripheral_clocks
    BL initialise_discovery_board

	LDR R6, =Default_LED_Pattern
	LDR R6, [R6]
	LDR R0, =Defaultletter @load addy
	LDRB R0, [R0] @load actaul letter
	LDR R1, =Word @load word

	LDR R2, =Defaultletter
	LDRB R2, [R2] @load actual letter


	BL count_character1
	BL create_led_pattern
	LDR R1, =Word @load word
	BL set_leds

program_loop: @check if button pressed

	BL delay

 	LDR R7, =GPIOA
    LDR R4, [R7, #IDR]
    TST R4, #1
    BNE button_pressed

	B program_loop

button_pressed:
	CMP R2, #122 @if letter =z load default letter
	BEQ load_default
	ADD R2, R2, #1
	MOV R0, R2

	LDR R1, =Word @load word
	BL count_character1 @after this R0 contains letter count
	BL create_led_pattern
	BL set_leds


	B program_loop

load_default:
	LDR R2, =Defaultletter
	LDRB R2, [R2]
	B program_loop

