.syntax unified
.thumb

.global main

#include "3c_Transmit.s"


.data

tx_end: .asciz ";\r\n"
tx_end_length: .byte 3

.align

tx_string: .asciz "hellotut\r\n"
tx_length: .byte 10

.text

main:

	B for_button









