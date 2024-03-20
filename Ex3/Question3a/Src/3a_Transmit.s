.syntax unified
.thumb

#include "3a_info.s"


for_button:

	BL initialise_power
	BL enable_peripheral_clocks
	BL enable_usart1

	LDR R5, =GPIOA

	BL check_button

	B transmit


check_button:

	LDRB R6, [R5, #IDR]
	ANDS R6, #0x01
	BEQ check_button

	BX LR

transmit:

	BL tx_loop

	BL tx_uart

tx_loop:

	@ the base address for the register to set up UART
	LDR R0, =USART1

	@ load the memory addresses of the buffer and length information
	LDR R1, =tx_string
	LDR R2, =tx_length

	@ dereference the length variable
	@ notice how memory address R4 is replaced by the value that was at that memory address
	LDR R2, [R2]

	BX LR

tx_uart:

	LDR R3, [R0, USART_ISR] @ load the status of the UART
	ANDS R3, 1 << UART_TXE  @ 'AND' the current status with the bit mask that we are interested in
						    @ NOTE, the ANDS is used so that if the result is '0' the z register flag is set

	@ loop back to check status again if the flag indicates there is no byte waiting
	BEQ tx_uart

	@ load the next value in the string into the transmit buffer for the specified UART
	LDRB R4, [R1], #1
	STRB R4, [R0, USART_TDR]

	@ note the use of the S on the end of the SUBS, this means that the register flags are set
	@ and this subtraction can be used to make a branch
	SUBS R2, #1

	@ keep looping while there are more characters to send
	BGT tx_uart

	@ make a delay before sending again
	LDR R8, =tx_end
	LDR R9, =tx_end_length
	LDR R9, [R9]
	BL tx_terminate

	BL delay_loop

	B for_button

tx_terminate:

	LDR R3, [R0, USART_ISR]
	ANDS R3, 1 << UART_TXE
	BEQ tx_terminate

	LDR R10, [R8], #1

	STRB R10, [R0, USART_TDR]

	SUBS R9, #1
	BGT tx_terminate

	BX LR

delay_loop:

	LDR R9, =0xfffff

delay_inner:
	@ notice the SUB has an S on the end, this means it alters the condition register
	@ and can be used to make a branching decision.
	@ SUBS R9, #1
	@BGT delay_inner
	BX LR @ return from function call
