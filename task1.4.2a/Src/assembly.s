..syntax unified
.thumb

#include "initialise.s"

.global main

.data
@ define variables

.text
@ define text

@ Function to set LEDs based on a bitmask in R0
set_leds:
    LDR R1, =GPIOE         @ Load GPIOE base address into R1
    STRB R0, [R1, #ODR + 1]@ Store the bitmask to ODR
    BX LR                  @ Return from function

@ Main entry function
main:
	@ Branch with link to set the clocks for the I/O and UART
	BL enable_peripheral_clocks

	@ Once the clocks are started, need to initialise the discovery board I/O
	BL initialise_discovery_board

	@ Set the initial LED pattern using the set_leds function
	LDR R0, =0b00110011     @ Load initial pattern for the set of LEDs
	BL set_leds             @ Set LEDs to initial pattern
	EOR R0, R0, #0xFF       @ Toggle all bits in the pattern (inverting the LED states)
	BL set_leds             @ Update LEDs with the toggled pattern

program_loop:
	@ Task: read the input button
	LDR R0, =GPIOA          @ Load address of port for the input button into R0
	LDR R1, [R0, #IDR]      @ Read the input data register of GPIOA into R1

	@ Place additional program logic here

	B program_loop          @ Loop indefinitely
