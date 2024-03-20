.syntax unified
.thumb

#include "definitions.s"

@ enable the clocks for peripherals (GPIOA, C and E)
enable_peripheral_clocks_z:
	LDR R0, =RCC  @ load the address of the RCC address boundary (for enabling the IO clock)
	LDR R1, [R0, #AHBENR]  @ load the current value of the peripheral clock registers
	ORR R1, 1 << GPIOA_ENABLE | 1 << GPIOC_ENABLE | 1 << GPIOE_ENABLE  @ 21st bit is enable GPIOE clock, 17 is GPIOA clock
	STR R1, [R0, #AHBENR]  @ store the modified register back to the submodule
	BX LR @ return from function call


