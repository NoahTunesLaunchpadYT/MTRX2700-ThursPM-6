.syntax unified
.thumb

@.global decode

@allow var string into this function
.extern cipher

.data
byte_array: .byte 0, 1, 2, 3, 4, 5, 6
word_array: .word 0x00, 0x40, 0x80, 0xc0, 0x10, 0x14, 0xffffffff

.text

@R4 is the input word
@R11 is the output word

decode:
	PUSH {R2, R3, R5, LR} @on the stack
    @LDR R1, =string
    LDR R2, =cipher @cipher value
    LDR R2, [R2]

convert_case:

    LDRB R3, [R11]
    CMP R3, #0
    BEQ done

    SUBS R11, R3, #'A'
    CMP R11, #26 @checking if outside of letter range
    BLT Letter_process @if more then it either lowercase or not a letter

    SUBS R11, R3, #'a'
    CMP R11, #26 @checking if outside of letter range
    BLT Letter_process @if more then its not a letter

    B next_char

Letter_process:

    ADDS R11, R11, R2
    ADDS R11, R11, #26
    MOV R5, #26

MOD_loop:

    SUBS R11, R11, R5
    BCS MOD_loop

    ADD R11, R11, R5

    CMP R3, #'a'
    BLT Upper_case
    ADD R11, R11, #'a'
    B store_char


Upper_case:

    ADD R11, R11, #'A'

store_char:

    STRB R11, [R11]

next_char:

    ADD R11, R11, #1
    B convert_case

done:
POP {R2 ,R3, R5, PC} @ Restore R2,R3,R5 off the stack.
