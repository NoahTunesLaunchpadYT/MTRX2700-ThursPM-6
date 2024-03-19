.syntax unified
.thumb

#include "initialise.s"
#include "definitions.s"
#include "increment_pattern.s"

.global main

.data
@ define variables
Default_LED_Pattern: .word 0b00000000 @default bit pattern loaded straight away
Buffer_LED_Pattern: .word 0b00000000 @altered bit pattern
DelayValue: .word 500000

.text

set_leds:
	LDR R1, =GPIOE
    STRB R2, [R1, #ODR + 1]
    BX LR


delay:
    PUSH {R5, LR}
    LDR R5, =DelayValue
    LDR R5, [R5]
delay_loop:
    SUBS R5, R5, #1
    BNE delay_loop
    POP {R5, PC}


main:
	BL enable_peripheral_clocks
	BL initialise_discovery_board
	LDR R2, =Default_LED_Pattern
	LDR R2, [R2] @load actaul pattern


	LDR R0, =GPIOA @button
	LDR R1, =GPIOE @LEDs

	B program_loop

program_loop:

	LDR R0, =GPIOA
	LDR R1, [R0, #IDR]
	TST R1, #1 @test if button is not pressed
	BNE button_pressed @branch if not equal

	B program_loop

button_pressed:
	BL increment_pattern @change pattern
	BL delay @call delay
    LDR R2, =Buffer_LED_Pattern @loads current value into R2
    LDR R2, [R2]
    BL set_leds

    B program_loop

