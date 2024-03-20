# MTRX2700-ThursPM_6
## Group Members
Tiago Trindade
Benjamin Wood
Mudakkir Sultan

## Roles and Responbilities
Tiago is responable for team minutes and allocating tasks, and formatting the git repo, author to Exericse 1, 2 and 5.
Benjamin author to Exercise 1, 3 and 5.
Mudakkir author to Exercise 4.

## Project Overview

## Exercise 1
Converting functions, involving converting a string to all to uppercase, all to lowercase, a ceasar cipher and a Substitution Cipher.

## Exercise 2
Functions that involve using LEDs as output and user button used as inputs to create a bunch of patterns.

## Exercise 3
Functions that demostrate commuincation through the GPIO ports, involving communication from the computer to the board and board to board.

## Exercise 4
using the boards inbuilt/hardware timers to manipulate them into different frequencies and wave types.

## Exercise 5
Implementing all the previous tasks into 1, the overview of the function is that it board 1 using USART1 sends a messenge to board 1, then the board encodes the messenge 
and sends it through UART4 to UART5 on board 2. board 2 decodes the messenge, then shows the letter count on the boards leds, similar to Ex2 D.


### Summary
Comfirmed Ex that are completed/working are 1, 2, 3. Ex5 was started but not in working condition. Ex4 unknown. 

### Valid input


### Functions and modularity
Ex1 is not modularize as the code is very short and does not include a lot of reusable code. Ex2 is modularized as much as can be separating most of the code into reused functions some 
include delay and create pattern. Ex3 . Ex4 . Ex5 is broken down into multiple reused functions from the previous 4 exerices.

### Testing
For Ex1 and Ex2, testing involved going set up set in the debugger and mainly looking at what each register was doing, and also look for looping problems. 
Ex3 involved a lot of trial n error, we used a program called puTTy to view the outputs of the commports e.g. everything that gets transmitting
Ex4 
Ex5 used puTTy to view the outputs of the commports, and used the debugger to go through step by step to view the registers and looping problems

### Notes
Ex3 is really hard