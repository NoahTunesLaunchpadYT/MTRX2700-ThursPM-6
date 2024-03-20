.syntax unified
.thumb

#include "decode.s"
#include "transmit.s"


.global main

.data
@define word in .data,
@word: .asciz "aaabcc" @decoded word
cipher: .byte 0 @cipher value

tx_end: .asciz ";\r\n"
tx_end_length: .byte 3

.align

tx_string: .asciz "aabbbbcccccc\r\n"
tx_length: .byte 10

.text

main:


@set up all bens shit (functionize)

@transmit output R4
LDR R1, =tx_string @setting the word in R1 for decode function
BL decode
LDR R1, R4 @setting the output of the decode function to R1 for the transmit function
@transmit Encoded word R4/R1 to other board
B for_button

