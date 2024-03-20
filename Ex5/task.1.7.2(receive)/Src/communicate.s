.syntax unified
.thumb

#include "_info.s"
#include "receive.s"

communicate:
    @ initialise
    BL initialise_power
    BL enable_peripheral_clocks
    BL enable_uart4

    BL receive
