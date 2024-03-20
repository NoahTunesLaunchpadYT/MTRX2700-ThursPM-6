.syntax unified
.thumb

#include "3e_info.s"
#include "3e_receive.s"

communicate:
    @ initialise
    BL initialise_power
    BL enable_peripheral_clocks
    BL enable_uart4

    B receive
