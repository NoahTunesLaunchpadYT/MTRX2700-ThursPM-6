.syntax unified

.thumb



.global main



#include "3eN_Receive_Trans.s"

.data

tx_end: .asciz ";\r\n"

tx_end_length: .byte 3

.align
rx_buffer: .space 62

incoming_couter: .byte 62

rx_end: .asciz "str#"

.text
main:


	B receive





