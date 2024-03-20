.syntax unified
.thumb

#include "definitions.s"

@ enable the clocks for peripherals (GPIOA, C and E)
enable_peripheral_clocks1:
	LDR R0, =RCC  @ load the address of the RCC address boundary (for enabling the IO clock)
	LDR R1, [R0, #AHBENR]  @ load the current value of the peripheral clock registers
	ORR R1, 1 << GPIOA_ENABLE | 1 << GPIOC_ENABLE | 1 << GPIOE_ENABLE  @ 21st bit is enable GPIOE clock, 17 is GPIOA clock
	STR R1, [R0, #AHBENR]  @ store the modified register back to the submodule
	BX LR @ return from function call



@ initialise the discovery board I/O (just outputs: inputs are selected by default)
initialise_discovery_board:
	LDR R7, =GPIOA
	LDR R4, [R7, GPIO_MODER]
	BIC R4, R4, #0x3
	STR R4, [R7, GPIO_MODER]

	LDR R5, =GPIOE 	@ load the address of the GPIOE register into R0
	LDR R6, =0x5555  @ load the binary value of 01 (OUTPUT) for each port in the upper two bytes
							 @ as 0x5555 = 01010101 01010101
	STRH R6, [R5, GPIO_MODER + 2]   @ store the new register values in the top half word representing
								@ the MODER settings for pe8-15

	BX LR @ return from function call