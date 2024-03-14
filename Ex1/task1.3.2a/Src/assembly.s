.syntax unified
.thumb

.global main

.data
string_buffer: .asciz "yourmom"  @ Define a null-terminated string
ascii_string: .asciz "yourmom"  @ Define a null-terminated string
byte_array: .byte 0, 1, 2, 3, 4, 5, 6
word_array: .word 0x00, 0x40, 0x80, 0xc0, 0x10, 0x14, 0xffffffff

.text
main:
    LDR R0, =ascii_string  @ Address of the string
    LDR R1, =string_buffer  @ Address of the string buffer
    MOV R2, #0  @ Reset counter

string_loop:
    LDRB R3, [R0, R2]  @ Load byte from ascii_string
    CMP R3, #0  @ Check for null terminator
    BEQ finished_string  @ If null, exit loop

    BL convert_to_uppercase  @ Call conversion function
    ADD R2, #1  @ Increment index
    B string_loop  @ Continue loop

finished_string:
    LDR R0, =word_array  @ Address of the word array
    MOV R2, #0  @ Reset counter
    LDR R4, =0xffffffff  @ Load termination word
    B word_loop

word_loop:
    LDR R3, [R0, R2]  @ Load word from word_array
    CMP R3, R4  @ Check for termination word
    BEQ finished_everything  @ If termination word, exit loop
    ADD R2, R2, #4  @ Increment offset by 4 bytes
    B word_loop  @ Continue loop

finished_everything:
    B finished_everything  @ Infinite loop

convert_to_uppercase:
    PUSH {R2, R3, LR}  @ Save registers and return address

    LDRB R3, [R0, R2]
    CMP R3, #97  @ Compare with 'a'
    BLT convert_end  @ If less, not a lowercase letter
    CMP R3, #122  @ Compare with 'z'
    BGT convert_end  @ If greater, not a lowercase letter

    SUB R3, R3, #32  @ Convert to uppercase
    STRB R3, [R1, R2]  @ Store back into buffer

convert_end:
    POP {R2, R3, LR}  @ Restore registers and return address
    BX LR  @ Return from function

