.syntax unified
.thumb

#include "initialise.s"
#include "definitions.s"
#include "increment_pattern.s"
#include "decrement_pattern.s"
#include "delay.s"

.global main

.data
@ define variables
Buffer_LED_Pattern: .word 0b00000000
DelayValue: .word 500000

.text
set_leds:
    LDR R1, =GPIOE
    STRB R2, [R1, #ODR + 1]
    BX LR

main:
    BL enable_peripheral_clocks
    BL initialise_discovery_board
    LDR R2, =Buffer_LED_Pattern
    LDR R2, [R2] @load buffer
    B program_loop

program_loop:
    LDR R0, =GPIOA
    LDR R1, [R0, #IDR]
    TST R1, #1 @check if button is on
    BNE button_pressed
    BL set_leds
    B program_loop

button_pressed:
    LDR R0, =Buffer_LED_Pattern
    LDR R0, [R0]
    TST R0, #0x80 @test if R0 MSB is 1
    BNE decrement_led_pattern_link @branch if MSB is a non-zero (not linked)
    BL increment_pattern
    BL delay
    LDR R2, =Buffer_LED_Pattern
    LDR R2, [R2]
    BL set_leds
    B program_loop

    decrement_led_pattern_link:
    BL decrement_pattern
    BL delay
    LDR R2, =Buffer_LED_Pattern
    LDR R2, [R2]
    BL set_leds
    B program_loop
