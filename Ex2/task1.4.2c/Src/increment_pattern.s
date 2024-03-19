.syntax unified
.thumb

increment_pattern:
    PUSH {LR} @put on the stack
    LDR R2, =Buffer_LED_Pattern
    LDR R3, [R2]
    MOVS R4, #1

find_next_led:
    TST R3, R4
    BNE already_on @if R3=R4 then the bit is already on
    ORR R3, R3, R4
    STR R3, [R2]
    POP {PC} @take off the stack

already_on:
    LSL R4, R4, #1 @shift left by 1 bit
    CMP R4, #0 @if shfited is =0 then all on
    BEQ all_leds_on
    B find_next_led

all_leds_on:
    MOVS R3, #1
    STR R3, [R2]
    POP {PC}
