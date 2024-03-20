.syntax unified
.thumb

#include "letter_counter.s"
#include "decode.s"

.global main


.data
Word: .asciz "aaabcc" @remove this when transmitting ONLY FOR TESTING
cipher: .byte 0 @cipher value
.text

main:

@set up bens shit (functionize)

@transmitted encoded word and save it to R1
LDR R1, =Word @remove this when transmitting ONLY FOR TESTING
BL decode
LDR R1, [R4]
BL letter_counter @this function will loop forever

B main
