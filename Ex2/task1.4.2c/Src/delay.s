.syntax unified
.thumb

.extern DelayValue

@ Simple delay function
delay:
    PUSH {R8, LR}      @ Save R8 and Link Register
    LDR R8, =DelayValue @ Load address of DelayValue
    LDR R8, [R8]        @ Load actual delay value into R8
    delay_loop:
        SUBS R8, R8, #1  @ Decrement R8
        BNE delay_loop   @ If R8 is not zero, continue looping
    POP {R8, PC}        @ Restore R8 and return from function
