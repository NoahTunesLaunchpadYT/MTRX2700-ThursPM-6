.syntax  unified
.thumb

decrement_pattern:
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
