.syntax unified
.thumb

#include "letter_counter.s"
#include "decode.s"

.global main

.data
Word: .asciz "aaabcc" @remove this when transmitting ONLY FOR TESTING
.text

main:

@set up bens shit

@transmitted encoded word and save it to R1
LDR R1, =Word @remove this when transmitting ONLY FOR TESTING
BL decode
LDR R1, [R4]
BL letter_counter @this function will loop forever

B main



@functions needed/structure
@for receive an encoded word/messenge

@use a modified verison of task 1c decode.s to decode the messenge
@input for decoder is R1


@output from decode should be R4, input word from letter_count should be R1.

@use task2d to get the decoded string and turn it into a pattern
@no stack needed for task2d cos registers not needed after uses.
@loop in letter_count



