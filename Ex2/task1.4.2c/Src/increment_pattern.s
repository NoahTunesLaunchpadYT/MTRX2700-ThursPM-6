.syntax unified
.thumb

increment_pattern:
    PUSH {LR} @put on the stack
    LDR R2, =Buffer_LED_Pattern
    LDR R3, [R2]
    MOVS R4, #1

find_next_led:
    TST R3, R4
    BNE already_on
    ORR R3, R3, R4
    STR R3, [R2]
    POP {PC} @take off the stack

already_on:
    LSL R4, R4, #1
    CMP R4, #0
    BEQ all_leds_on
    B find_next_led

all_leds_on:
    MOVS R3, #1
    STR R3, [R2]
    POP {PC}
