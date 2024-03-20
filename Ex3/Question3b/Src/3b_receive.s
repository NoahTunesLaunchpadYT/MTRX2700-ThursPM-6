.syntax unified
.thumb

#include "3b_info.s"



receive:

	BL initialise_power
	BL enable_peripheral_clocks
	BL enable_usart1

    LDR R1, =rx_buffer      // Load the address of the rx_buffer
    LDR R2, =incoming_couter  // Load the max count of incoming characters
    LDR R2, [R2]           // Load the max count value

    MOV R3, #0x00

    LDR R6, =tx_end

    BL receive_loop
    BL receive_reset

receive_loop:

	LDR R0, =USART1
	LDR R4, [R0, USART_ISR]

	TST R4, 1 << UART_ORE | 1 << UART_FE
	BNE clear_error

	TST R4, 1 << UART_RXNE
	BEQ receive_loop

	LDRB R5, [R0, USART_RDR]

	CMP R5, R6

	BEQ for_terminating_char

	STRB R5, [R1, R3]
	ADD R3, #1

	CMP R2, R3
	BGT receive_reset
	MOV R3, #0

	BX LR

receive_reset:

	LDR R4, [R0, USART_RQR]
	ORR R4, 1 << UART_RXFRQ
	STR R4, [R0, USART_RQR]

    BGT receive_loop                 // Return from subroutine


clear_error:

	LDR R4, [R0, USART_ICR]
	ORR R4, 1 << UART_ORECF | UART_FECF
	STR R4, [R0, USART_ICR]

	B receive_loop


for_terminating_char:

	B for_terminating_char







