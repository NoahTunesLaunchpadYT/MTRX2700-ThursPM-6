syntax unified
.thumb

.global main


.data
@ define variables

string_buffer: .asciz "yourmom" @ Define a null-terminated string
ascii_string: .asciz "yourmom" @ Define a null-terminated string
byte_array: .byte 0, 1, 2, 3, 4, 5, 6
word_array: .word 0x00, 0x40, 0x80, 0xc0, 0x10, 0x14, 0xffffffff


.text
@ define text


@ this is the entry function called from the startup file
main:

	LDR R0, =ascii_string  @ the address of the string
	LDR R1, =string_buffer  @ the address of the string
	LDR R2, =0x00 	@ counter to the current place in the string
	BL convert_to_uppercase

	LDR R1, =string_buffer
	MOV R4, #3 @cipher value
	BL convert_cipher @apply cipher

convert_cipher:
PUSH {LR}

ceasar_loop:
LDRB R5,[R0], #1
CMP R5, #0 @check if null
BEQ ceasar_end @if null end

CMP R5, #65 @compare to "A"
BLT ceasar_next @if less not a letter
CMP R5, #90 @compare to "Z"
BGT ceasar_next @if more not a uppercase letter

ADD R6, R5, R4
CMP R6, #90 @compare to "Z"
BGT wrap_around @if greater than wrap around
CMP R6, #65
BLT wrap_around @if less than wrap around

STRB R6, [R0, #-1] @store the shifted character
B caesar_next


wrap_around:
    CMP R6, #90            @compare to 'Z'
    BGT positive_wrap      @if greater postive wrap-around
    CMP R6, #65            @compare to 'A'
    BLT negative_wrap      @if less negitive wrap-around
    B caesar_next

positive_wrap:
    SUB R6, R6, #26        @ Subtract 26 (total number of alphabets) to wrap around
    B caesar_next

negative_wrap:
    ADD R6, R6, #26        @ Add 26 to wrap around to the other end of the alphabet
    B caesar_next


caesar_next:
    B caesar_loop    @ Loop for the next character

caesar_end:
    POP {PC}         @ Return to the calling function

string_loop:

	LDRB R3, [R0, R2]	@ load the byte from the ascii_string (byte number R2)
	STRB R3, [R1, R2]	@ store the byte in the string_buffer (byte number R2)
	CMP R3, #0	@ Test to see whether this byte is zero (for null terminated)
	BEQ finished_string  @ if it was null (0) then jump out of the loop
	ADD R2, #1  @ increment the offset R2

	B string_loop  @ loop to the next byte

finished_string:

	LDR R0, =word_array  @ the address of the word array
	LDR R2, =0x00 	@ counter to the current place in the array
	LDR R4, =0xffffffff  @ this register provides the termination word (that ends the array)

word_loop:

	LDR R3, [R0, R2]	@ load the word from the word_array (byte number R2)
	CMP R3, R4	@ Test to see whether this word is 0xffffffff (for a special terminator)
	BEQ finished_everything  @ if it was the terminating character (0xffffffff) then jump out of the loop
	ADD R2, #4  @ increment the offset R2 by 4 (the word is 4 bytes, so increment to the next word

	B word_loop  @ loop to the next word


finished_everything:

	B finished_everything 	@ infinite loop here


convert_to_uppercase:
    PUSH {LR}          @ Save the return address
    LDR R1, =string_buffer  @ Load the address of the string_buffer

convert_loop:
    LDRB R2, [R1], #1  @ Load the current character and post-increment the address
    CMP R2, #0        @ Check if it's the null terminator
    BEQ convert_end   @ If it's null, exit the loop

    CMP R2, #97       @ Compare with ASCII of 'a'
    BLT convert_next  @ If less, it's uppercase
    CMP R2, #122      @ Compare with ASCII of 'z'
    BGT convert_next  @ If greater, it's uppercase

    SUB R2, R2, #32   @ Convert to uppercase
    STRB R2, [R1, #-1] @ Store the uppercase character back

convert_next:
    B convert_loop    @ Loop for the next character

convert_end:
    POP {PC}          @ Return to the calling function

