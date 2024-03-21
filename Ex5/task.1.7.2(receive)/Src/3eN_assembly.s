.syntax unified

.thumb

.global main

#include "3eN_Receive_Trans.s"
#include "letter_counter.s"

.data

tx_end: .asciz ";\r\n"
tx_end_length: .byte 3

.align
rx_buffer: .space 62
incoming_couter: .byte 62
rx_end: .asciz "#"
.text
main:

	B receive

next:
	LDR R1, [R7]
	B letter_counter
