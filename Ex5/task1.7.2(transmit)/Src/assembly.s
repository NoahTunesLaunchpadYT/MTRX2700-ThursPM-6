.syntax unified
.thumb

#include "decode.s"

.global main

.data
@define word in .data,
Word: .asciz "aaabcc" @decoded word
cipher: .byte 0 @cipher value
.text

main:


@set up all bens shit (functionize)



@use function decode (renamed to encode) and use the word as R1 (input), the output should be R4.
@transmit output R4
LDR R1, =Word
BL decode
@transmit R4 to other board

B main
