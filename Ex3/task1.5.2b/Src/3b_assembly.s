.syntax unified
.thumb

.global main

#include "3b_receive.s"


.data

tx_end: .asciz ";\r\n"


.align

rx_buffer: .space 62
incoming_couter: .byte 62

.text

main:

	B receive
