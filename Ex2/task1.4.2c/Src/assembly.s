.syntax unified
.thumb

#include "initialise.s"
#include "definitions.s"
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

increment_led_pattern:
    PUSH {LR}
    LDR R2, =Buffer_LED_Pattern
    LDR R3, [R2]
    MOVS R4, #1

    find_next_led:
        TST R3, R4
        BNE already_on
        ORR R3, R3, R4
        STR R3, [R2]
        POP {PC}

    already_on:
        LSL R4, R4, #1
        CMP R4, #0
        BEQ all_leds_on
        B find_next_led

    all_leds_on:
    	MOVS R3, #0xFF
        STR R3, [R2]
        POP {PC}

decrement_led_pattern:
    PUSH {LR}
    LDR R2, =Buffer_LED_Pattern
    LDR R3, [R2]
    MOVS R4, #1

    find_next_led_to_turn_off:
        TST R3, R4
        BEQ next_led
        BICS R3, R3, R4
        STR R3, [R2]
        POP {PC}

    next_led:
        LSL R4, R4, #1
        CMP R4, #0
        BNE find_next_led_to_turn_off
        MOVS R3, #0x00        @ Reset pattern to all LEDs off
        STR R3, [R2]
        POP {PC}

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
    LDR R2, =Buffer_LED_Pattern
    LDR R2, [R2]
    B program_loop

program_loop:
    LDR R0, =GPIOA
    LDR R1, [R0, #IDR]
    TST R1, #1
    BNE button_pressed
    BL set_leds
    B program_loop

button_pressed:
    LDR R0, =Buffer_LED_Pattern
    LDR R0, [R0]
    TST R0, #0x80
    BNE decrement_led_pattern_link
    BL increment_led_pattern
    BL delay
    LDR R2, =Buffer_LED_Pattern
    LDR R2, [R2]
    BL set_leds
    B program_loop

    decrement_led_pattern_link:
    BL decrement_led_pattern
    BL delay
    LDR R2, =Buffer_LED_Pattern
    LDR R2, [R2]
    BL set_leds
    B program_loop
