.syntax unified
.thumb

.global main

.data

string: .asciz "Hello Tutor\0"
byte_array: .byte 0, 1, 2, 3, 4, 5, 6
word_array: .word 0x00, 0x40, 0x80, 0xc0, 0x10, 0x14, 0xffffffff

.text

main:

    LDR R1, =string
    MOV R2, #3

convert_case:

    LDRB R3, [R1]
    CMP R3, #0
    BEQ done

    SUBS R4, R3, #'A'
    CMP R4, #26
    BLT Upper_case

    SUBS R4, R3, #'a'
    CMP R4, #26
    BLT Lower_case

Upper_case:

    ADD R4, R4, R2
    AND R4, R4, #0x1F
    ADD R3, R4, #'A'
    STRB R3, [R1]
    B next_char

Lower_case:

    ADD R4, R4, R2
    AND R4, R4, #0x1F
    ADD R3, R4, #'a'
    STRB R3, [R1]
    B next_char


next_char:
    ADD R1, R1, #1
    B convert_case

done:
    B done
