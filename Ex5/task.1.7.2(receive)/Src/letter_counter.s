.syntax unified
.thumb


#include "initalise.s"
#include "count_character.s"
#include "delay.s"
#include "_info.s"

@.global letter_counter

.extern Word
.extern DelayValue

.data
Default_LED_Pattern: .word 0b00000000
DelayValue: .word 2000000 @running the delay @ 1/2 sec, that means clock speed is 4MHz
Defaultletter: .asciz "a"

.text

set_leds: @R6 is the pattern
    LDR R5, =GPIOE
    STRB R6, [R5, #ODR + 1]
    BX LR


letter_counter:
	PUSH {R1, R2, R3, R4, R5, R6, R7, LR}
    BL enable_peripheral_clocks_z
    BL initialise_discovery_board_z

	LDR R6, =Default_LED_Pattern
	LDR R6, [R6]
	LDR R0, =Defaultletter @load addy
	LDRB R0, [R0] @load actaul letter
	LDR R1, =Word @load word

	LDR R2, =Defaultletter
	LDRB R2, [R2] @load actual letter


	BL count_character
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
	BL count_character @after this R0 contains letter count
	BL create_led_pattern
	BL set_leds


	B program_loop

load_default:
	LDR R2, =Defaultletter
	LDRB R2, [R2]
	B program_loop


Error:
POP{{R1, R2, R3, R4, R5, R6, R7, PC}
