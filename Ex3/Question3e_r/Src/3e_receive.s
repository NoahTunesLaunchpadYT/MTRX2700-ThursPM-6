.syntax unified
.thumb


#include "3e_definitions.s"


receive:

    LDR R1, =rx_buffer
    LDR R2, =incoming_counter
    LDR R2, [R2]


    MOV R11, #0x00


    LDR R6, =rx_end
    LDR R6, [R6]

    BL rx_loop

    BL reset_rx


rx_loop:


    LDR R0, =UART4
    LDR R4, [R0, USART_ISR]


    TST R4, 1 << UART_ORE | 1 << UART_FE
    BNE clear_error

    TST R4, 1 << UART_RXNE
    BEQ rx_loop


    LDRB R5, [R0, USART_RDR]
    STRB R5, [R1, R11]

    BL confirmation

    ADD R11, #1


    CMP R5, R6
    BEQ handle_terminating_char

    CMP R2, R11
    BGT reset_rx
    MOV R11, #0

    BX LR


reset_rx:

    LDR R4, [R0, USART_RQR]
    ORR R4, 1 << UART_RXFRQ
    STR R4, [R0, USART_RQR]

    BGT rx_loop


clear_error:

    LDR R4, [R0, USART_ICR]
    ORR R4, 1 << UART_ORECF | 1 << UART_FECF
    STR R4, [R0, USART_ICR]
    B rx_loop

confirmation:
    MOV R12, #1
    BX LR

handle_terminating_char:

    B handle_terminating_char
