.syntax unified
.thumb

.global count_character

@ R0 = ASCII value of character
@ R1 = Pointer to string
@ Returns count in R0
count_character1:
    PUSH {R2, R3, LR}
    MOVS R0, R2
    MOVS R3, #0

count_loop:
    LDRB R0, [R1], #1 @Load byte from string and post-increment address
    CMP R0, #0 @Cmp byte to null
    BEQ count_d @If null end
    CMP R0, R2 @Cmp letter
    BNE count_loop @If not continue
    ADDS R3, R3, #1
    B count_loop

count_done:
    MOVS R0, R3
    POP {R2, R3, PC}
