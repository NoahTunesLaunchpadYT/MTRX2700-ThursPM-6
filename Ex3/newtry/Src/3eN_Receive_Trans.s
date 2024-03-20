.syntax unified

.thumb



#include "3eN_info.s"



.text



receive:



    BL initialise_power          // Initialize power

    BL enable_peripheral_clocks  // Enable peripheral clocks

    BL enable_uart5             // Enable USART1



    LDR R1, =rx_buffer      // Load the address of the rx_buffer

    LDR R2, =incoming_couter  // Load the max count of incoming characters

    LDR R2, [R2]           // Load the max count value



    MOV R3, #0x00



    LDR R6, =rx_end

    LDR R6, [R6]



    BL receive_loop

    BL receive_reset



receive_loop:



	LDR R0, =UART5

	LDR R4, [R0, USART_ISR]



	TST R4, 1 << UART_ORE | 1 << UART_FE

	BNE clear_error



	TST R4, 1 << UART_RXNE

	BEQ receive_loop



	LDRB R5, [R0, USART_RDR]

	STRB R5, [R1, R3]

	ADD R3, #1



	CMP R5, R6



	BEQ terminating_char



	CMP R2, R3

	BGT receive_reset

	MOV R3, #0



	BX LR



terminating_char:



	B transmit



receive_reset:



	LDR R4, [R0, USART_RQR]

	ORR R4, 1 << UART_RXFRQ

	STR R4, [R0, USART_RQR]



    BGT receive_loop                 // Return from subroutine



clear_error:



	LDR R4, [R0, USART_ICR]

	ORR R4, 1 << UART_ORECF | 1 << UART_FECF @ clear the flags (by setting flags to 1)

	STR R4, [R0, USART_ICR]

	B receive_loop





transmit:



    BL tx_loop



	BL tx_uart               // Reset index for transmission loop



tx_loop:



	BL enable_usart1



    LDR R0, =USART1

             // Load the base address for USART1

    LDR R1, =rx_buffer



                       // Loop back to transmit the next character

tx_uart:



	LDR R11, [R0, USART_ISR] @ load the status of the UART

	ANDS R11, 1 << UART_TXE  @ 'AND' the current status with the bit mask that we are interested in

						    @ NOTE, the ANDS is used so that if the result is '0' the z register flag is set



	@ loop back to check status again if the flag indicates there is no byte waiting

	BEQ tx_uart



	@ load the next value in the string into the transmit buffer for the specified UART

	LDRB R4, [R1], #1

	STRB R4, [R0, USART_TDR]



	@ note the use of the S on the ends of the SUBS, this means that the register flags are set

	@ and this subtraction can be used to make a branch

	SUBS R3, #1



	@ keep looping while there are more characters to send

	BGT tx_uart



	@ make a delay before sending again

	LDR R8, =tx_end

	LDR R9, =tx_end_length

	LDR R9, [R9]

	BL tx_terminate



	BL delay_loop







tx_terminate:



    LDR R11, [R0, USART_ISR]

    ANDS R11, 1 << UART_TXE

    BEQ tx_terminate



    LDRB R10, [R8], #1            // Load the terminating character



    STRB R10, [R0, USART_TDR]     // Transmit the terminating character



    SUBS R9, #1



    BGT tx_terminate



    BX LR                     // Loop back to main or finish program





delay_loop:



	LDR R7, =0x01



delay_inner:



	SUBS R7, #1

	BGT delay_inner

	BX LR

