.syntax unified
.thumb

.global main

#include "3e_communicate.s"


.data

tx_end: .asciz ".\r\n"
tx_end_length: .byte 3


.align


rx_end: .asciz "!"

rx_buffer: .space 62
incoming_counter: .byte 62


.text


main:
    B communicate






