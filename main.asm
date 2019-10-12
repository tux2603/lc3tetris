; ##### CUSTOM TRAPS #####
; TRAP x30 - Checks to see if a character is available. Sets R0 to 1 if yes, 0 if no
; TRAP x31 - Clears the screen

    .ORIG x3000

    ; Use R6 as the loop counter
    LD R6, INPUT_LOOP_LENGTH

INPUT_LOOP
    ; Check if a character is available
    TRAP x30
    ; If there is no character available, continue with the loop
    BRnz CONTINUE_INPUT_LOOP

    ; If there is a character available, read it in
    GETC
    ST R0, LAST_CHAR
    JSR UPDATE_SCREEN

CONTINUE_INPUT_LOOP
    ; Check the loop count
    ; LD R0, LAST_CHAR
    ; OUT

    ADD R6, R6, x-1
    BRnp INPUT_LOOP

    ; If we have looped for the specified length, update the screen and reset the count
    JSR UPDATE_SCREEN
    LD R6, INPUT_LOOP_LENGTH
    BRnzp INPUT_LOOP

    ; How many times to loop through the input loop before continiung regardless
INPUT_LOOP_LENGTH
    .FILL xFFFF

LAST_CHAR
    .FILL  x41

R7_SAVE
    .BLKW x1

UPDATE_SCREEN
    ST R7, R7_SAVE
    ; Clear the screen 
    ; TRAP x31

    ; Print the most recently written character to the screen
    LD R0, LAST_CHAR
    OUT
    LD R7, R7_SAVE
    RET

LONG_STRING
    .STRINGZ "Hello, my name is Russel. I am a juinor wilderness explorer from troop something or other, May I assist you?"
    .END

