.syntax unified
.thumb

.global create_led_pattern
@ R0 = Number of LEDs to turn on
@ Resulting pattern is stored in R6
create_led_pattern:
    MOVS R6, #0x01@ Starting pattern 0b00000001
    MOVS R9, R0
    CMP R0, #0
    BEQ pattern_nothing
    SUBS R0, R0, #1@ Sub 1 from R0

create_pattern_loop:
    CMP R0, #0
    BEQ pattern_done@ If R0 is 0, the pattern is complete
    LSLS R6, R6, #1@ Shift left by 1 bit
    ORRS R6, R6, #1@ OR the pattern to turn on the next LED
    SUBS R0, R0, #1
    B create_pattern_loop


pattern_nothing:
	MOVS R6, #0
	B pattern_done

pattern_done:
    BX LR
