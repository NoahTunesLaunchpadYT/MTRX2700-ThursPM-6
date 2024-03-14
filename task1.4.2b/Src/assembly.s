.syntax unified
.thumb

#include "initialise.s"
#include "definitions.s"

.global main

.data
@ define variables
Default_LED_Pattern: .word 0b00000000
Buffer_LED_Pattern: .word 0b00000000
DelayValue: .word 500000

.text

set_leds:
	LDR R1, =GPIOE
    STRB R2, [R1, #ODR + 1]
    BX LR

increment_led_pattern:
    PUSH {LR}               @ Save Link Register
    LDR R2, =Buffer_LED_Pattern
    LDR R3, [R2]            @ Load current pattern into R3
    MOVS R4, #1             @ Set R4 as our bitmask checker (starting with LSB)

find_next_led:
    TST R3, R4              @ Test current LED
    BNE already_on          @ If this LED is already on, check next
    ORR R3, R3, R4          @ Set the LED on
    STR R3, [R2]            @ Save updated pattern
    POP {PC}                @ Return from function

already_on:
    LSL R4, R4, #1          @ Shift our checker to next LED
    CMP R4, #0              @ Check if we have checked all LEDs
    BEQ all_leds_on         @ If all LEDs are on, start over
    B find_next_led         @ Check next LED

all_leds_on:
    MOVS R3, #1             @ Reset pattern: start with first LED only
    STR R3, [R2]            @ Store the reset pattern
    POP {PC}                @ Return from function

simple_delay:
    PUSH {R5, LR}           @ Save R5 and LR
    LDR R5, =DelayValue
    LDR R5, [R5]
delay_loop:
    SUBS R5, R5, #1         @ Decrement delay counter
    BNE delay_loop          @ If R5 is not zero, loop
    POP {R5, PC}            @ Restore R5 and LR, then return

main:
	BL enable_peripheral_clocks
	BL initialise_discovery_board
	LDR R2, =Default_LED_Pattern
	LDR R2, [R2]


	LDR R0, =GPIOA @button
	LDR R1, =GPIOE

	B program_loop

program_loop:

	LDR R0, =GPIOA
	LDR R1, [R0, #IDR]
	TST R1, #1 @test if button is not pressed
	BNE button_pressed @branch if not equal

 	LDR R0, =Default_LED_Pattern
 	LDR R0, [R0]
 	BL set_leds

	B program_loop

button_pressed:
	BL increment_led_pattern
	BL simple_delay       @ Call delay
    LDR R2, =Buffer_LED_Pattern
    LDR R2, [R2]
    BL set_leds
    B program_loop
