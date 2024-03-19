.syntax unified
.thumb

@.global decode

@allow var string into this function

.data
byte_array: .byte 0, 1, 2, 3, 4, 5, 6
word_array: .word 0x00, 0x40, 0x80, 0xc0, 0x10, 0x14, 0xffffffff

.text

@R1 is the input word
@R4 is the output word

decode:
	PUSH {R2, R3, R5, LR} @on the stack
    @LDR R1, =string
    MOV R2, #1 @cipher value

convert_case:

    LDRB R3, [R1]
    CMP R3, #0
    BEQ done

    SUBS R4, R3, #'A'
    CMP R4, #26 @checking if outside of letter range
    BLT Letter_process @if more then it either lowercase or not a letter

    SUBS R4, R3, #'a'
    CMP R4, #26 @checking if outside of letter range
    BLT Letter_process @if more then its not a letter

    B next_char

Letter_process:

    ADDS R4, R4, R2
    ADDS R4, R4, #26
    MOV R5, #26

MOD_loop:

    SUBS R4, R4, R5
    BCS MOD_loop

    ADD R4, R4, R5

    CMP R3, #'a'
    BLT Upper_case
    ADD R4, R4, #'a'
    B store_char


Upper_case:

    ADD R4, R4, #'A'

store_char:

    STRB R4, [R1]

next_char:

    ADD R1, R1, #1
    B convert_case

done:
POP {R2 ,R3, R5, PC} @ Restore R2,R3,R5 off the stack.

