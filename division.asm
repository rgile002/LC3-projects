; By Rolf Kinder Gilet
;
;
 	LD R0, VALUE   		; load value we want to divide 
				; load dividen….
 	LD R5, BIT_15		; load mask to compare bit 15

 	AND R4, R4, #0  	; set up counter to loop 17 times
 	ADD R4, R4, #15 
 	ADD R4, R4, #1

L1	ADD R1, R1, R1 		; left shift REM
	AND R6, R2, R0 		; look for over flow bit 15 in QUO
	BRZ #1			; if no overflow flag Z
	ADD R1, R1, #1 		; overflow so set low bit REM
	ADD R2, R2, R2		; left shift QUO

	AND R6, R6, #0		; Clear R6
	NOT R6 R3		; - DVR
	ADD R6, R6, #1
	ADD R6, R1, R6		; compare REM and DVR if REM>=DVR
	BRN L2			; Branch if DVR>REM
	ADD R2, R2, #1 		; set low bit QUO
	ADD R1, R1, R6		; update REM
L2	ADD R4, R4, #-1 	; Decrement counter 
	BRP L1			; Loop again




.ORIG x3000
LD R0, VALUE

SHIFT_RIGHT
    AND R2, R2, #0              ; Clear R2, used as the loop counter

    SR_LOOP
        ADD R3, R2, #-15        ; check to see how many times we've looped
        BRzp SR_END             ; If R2 - 15 = 0 then exit

        LD R3, BIT_15           ; load BIT_15 into R3
        AND R3, R3, R0          ; check to see if we'll have a carry
        BRz #3                  ; If no carry, skip the next 3 lines
        ADD R0, R0, R0          ; bit shift left once
        ADD R0, R0, #1          ; add 1 for the carry
        BRnzp #1                ; skip the next line of code
        ADD R0, R0, R0          ; bit shift left

        ADD R2, R2, #1          ; increment our loop counter
        BRnzp SR_LOOP           ; start the loop over again
    SR_END

    ST R0, ANSWER               ; we've finished looping 15 times, store R0
    HALT

BIT_15      .FILL   b1000000000000000
VALUE       .FILL   x3BBC       ; some random number we want to bit shift right
ANSWER      .BLKW   1

.END
