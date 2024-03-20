.syntax unified
.thumb

#include "letter_counter.s"
#include "decode.s"
#include "communicate.s"

.global main


.data
@Word: .asciz "aaabcc" @remove this when transmitting ONLY FOR TESTING
cipher: .byte 0 @cipher value

tx_end: .asciz ".\r\n"
tx_end_length: .byte 3


.align


rx_end: .asciz "!"

rx_buffer: .space 62
incoming_counter: .byte 62


.text

main:

@set up bens shit (functionize)
BL communicate

@transmitted encoded word and save it to R1
@LDR R1, =Word @remove this when transmitting ONLY FOR TESTING
@R1 is loaded Run decode
BL decode
LDR R1, [R4] @decodeed word/original is loaded into R1 for use in letter_count
BL letter_counter @this function will loop forever Updates to R1 shouldnt matter as
@ we will receive once and than be in the letter_count loop

B main
