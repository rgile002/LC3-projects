; Processes input from the keyboard in decimal format. 
; PRINT displays an unsigned integer in any base up to 16

; PROGRAMMER    : Rolf Kinder Gilet  ID 5734407
;
; CLASS         : CDA 3103   TT 9:30 AM
;
; INSTRUCTOR    : Norman Pestaina  ECS 340
;
; ASSIGNMENT    : Assignment2   DUE Sunday 11/20
;
; CERTIFICATION : I certify that this work is my own and that
;                 none of it is the work of any other person.
;

	.ORIG	x3000
	LEA	R0, MPROMPT
	TRAP	x22
LOOP
	JSR	GETDEC		;Input an unsigned (decimal) integer
	ADD	R0, R0, #0	;Exit if the input integer is 0
	BRZ	EXIT

	JSR	NEWLN		;Move cursor to the start of a new line
	AND	R1, R1, #0	;R1 = 10 (output base 10 DECIMAL)
	ADD	R1, R1, #10	
	JSR	PRINT		;Print the integer in decimal

	JSR	NEWLN		;Move cursor to the start of a new line
	AND	R1, R1, #0	;R1 = 2 (output base 2 BINARY)
	ADD	R1, R1, #2
	JSR	PRINT		;Print the integer in binary

	JSR	NEWLN		;Move cursor to the start of a new line
	AND	R1, R1, #0	;R1 = 8 (output base 8 OCTAL)
	ADD	R1, R1, #8
	JSR	PRINT		;Print the integer in octal

	JSR	NEWLN		;Move cursor to the start of a new line
	AND	R1, R1, #0	;R1 = 16 (output base 16 HEXADECIMAL)
	ADD	R1, R1, #15
	ADD	R1, R1, #1
	JSR	PRINT		;Print the integer in hexadecimal

	JSR	NEWLN		;Move cursor to the start of a new line

	BRNZP	LOOP
EXIT				;Loop exit point
	TRAP	x25		;HALT program execution
MPROMPT	.STRINGZ "Enter a sequence of unsigned integer values\nEnter 0 To Quit\n"

;Subroutine NEWLN*************************************************************
;Advances the console cursor to the start of a new line
NEWLN	
	ST	R7, NEW7	;Save working registers
	ST	R0, NEW0

	LD	R0, NL		;Output a newline character
	TRAP	x21

	LD	R0, NEW0	;Restore working registers
	LD	R7, NEW7
	RET			;Return
;Data
NL	.FILL	x000A		;Newline character
NEW0	.BLKW	1		;Save area - R0
NEW7	.BLKW	1		;Save area - R7

;Subroutine GETDEC************************************************************
;Inputs an unsigned integer typed at the console in decimal format
;The input value is returned in R0
GETDEC
	ST	R1, GET1	;Save the working Registers
	ST	R2, GET2	
	ST	R3, GET3	
	ST	R4, GET4	
	ST	R5, GET5	
	ST	R6, GET6	
	ST	R7, GET7	
					
	LEA	R0, GPROMPT	;Output Promt Message
	TRAP	x22
	 	 
	LD R3 ASCIIZ 		;LOADS R3 WITH x0030
	NOT R3 R3 		;Get -30
	ADD R3 R3 1 		
	AND R2 R2 0 		;Clear R2 
	ADD R2 R2 -10 		;Set R2 to Evaluate for the sentinel Enter(x0A)
	
	BRNZP 5 		;Do while loop (Read character)
	ADD R4 R4 R4		;Add the number to itself 2X
	ADD R7 R4 0 		;Hold 2x into R7 
	ADD R4 R4 R4 		;Add the number to itself 4X 
	ADD R4 R4 R4 		;Add the number to itself 8X 
	ADD R4 R7 R4 		;Add R4(8x) with R7(2x) = 10x
	TRAP x20 		;Reads a single character but no echo
	ADD R5 R2 R0 		;Evaluate THE INPUT for Enter(X0A)
	
	BRZ 5			;Exit the loop if the result is ZERO 
	ADD R0 R3 R0		;RO have value -30
	ADD R0 R0 R4 		;Adds previous value (previous 40 + curent 3 = 43)
	ADD R4 R0 0		;Previous value now is current value
	ADD R1 R0 0 		;Total into R1
	
	BRNZP -13 		;Branches to multiply by 10x 
	AND R0 R0 0 		;Clears R0 
	ADD R0 R1 0 		;Adds total (Full Number) into R0 

	LD	R1, GET1   	;Restore working registers
	LD	R2, GET2
	LD	R3, GET3
	LD	R4, GET4
	LD	R5, GET5
	LD	R6, GET6
	LD	R7, GET7
	RET			;Return
;Data
ASCIIZ	.FILL	x0030  
GET1	.BLKW	1	;Save area - R1
GET2	.BLKW 	1 	;Save area - R2
GET3	.BLKW 	1 	;Save area - R3
GET4	.BLKW 	1 	;Save area - R4
GET5	.BLKW 	1 	;Save area - R5
GET6	.BLKW 	1 	;Save area - R6
GET7	.BLKW 	1 	;Save area - R7
GPROMPT	.STRINGZ "Enter an unsigned integer> "	;Input Prompt

;Subroutine PRINT*************************************************************
;Displays an unsigned integer in any base up to 16, e.g. binary, octal, decimal
;Parameters - R0: the integer - R1: the base
PRINT
	ST	R2, PRT2	;Save the working Registers
	ST	R3, PRT3	
	ST	R4, PRT4	
	ST	R5, PRT5	
	ST	R6, PRT6	
	ST	R7, PRT7	 	 
	 
	ST R0 CURRENT 		;Save current value
	 
	LEA R6 STORE		;Load 1st addres to save in R6  
	AND R2 R2 0 		;Clears r2
	LEA R5 DIGITS 		;Load 1st addres of String Digit
	
	BRNZP 2			;Branch to Divide (for convesion)
	ADD R0 R2 0 		;Qotient(R2) is the new numerator

	BRZ DISPLAY 		;Branche to Display if Numerator is Zero
	JSR DIVIDE		;Divide the current value by curent base
	ADD R3 R5 R3		;Evaluate the location in Digit (Remainder + R5)
	LDR R0 R3 0		;Get Chart at that location from String Digit
	STR R0 R6 0		;Store Char in stor earea
	ADD R6 R6 1		;Increment store adress
	AND R3 R3 0 		;Clears Remainder R3
	BRNZP -9 		;Loop  
 

DISPLAY
	AND R7 R7 0		;Clear Registers
	AND R5 R5 0

	ADD R6 R6 -1		;Decrement store Adress 
	LDR R5 R6 0 		;Get Char from location in R6
	ADD R7 R5 0 		;Check if data we just get from R6 is Null

	BRZ END  		;Branch to END if Char Retrieved is Null
	ADD R0 R5 0 		;Else Adds Char into R0 
	TRAP x21 		;Print Char to the console  
	BRNZP -7 		;loop
END	
	AND R0 R0 0 		;Clear R0
	LD R0 CURRENT 		;load initial value so we can make the other convertions
	

	LD	R2, PRT2	;Restore working registers
	LD	R3, PRT3
	LD	R4, PRT4
	LD	R5, PRT5
	LD	R6, PRT6
	LD	R7, PRT7
	RET			;Return
;Data
CURRENT 	.FILL x0000	; place to store the current value
PRT2	.BLKW	1	;Save Area R2
PRT3	.BLKW	1	;Save Area R3
PRT4	.BLKW	1	;Save Area R4
PRT5	.BLKW	1	;Save Area R5
PRT6	.BLKW	1	;Save Area R6
PRT7	.BLKW	1	;Save Area R7

DIGITS	.STRINGZ "0123456789ABCDEF"	;Digits
BUFFER	.FILL	x0000			;Null
STORE	.BLKW	18			;Output Buffer

;Subroutine DIVIDE************************************************************
;Perform unsigned integer division to obtain Quotient and Remainder
;Parameters (IN)  : R0 - Numerator,  R1 - Divisor
;Parameters (OUT) : R2 - Quotient,   R3 - Rremainder
DIVIDE	
	ST	R4, DIV4	;Save the working Registers
	ST	R5, DIV5	
	ST	R6, DIV6	
	ST	R7, DIV7		

	AND R2 R2 0 		;Clears Registers
	AND R3 R3 0 	
	AND R4 R4 0 	
	AND R5 R5 0 	
	AND R6 R6 0 	
	AND R7 R7 0 	

	ADD R3 R0 0		;Copy the numerator into the remainder(R3)
	ADD R5 R1 0 		;Copy the divisor(R1) into R5 
	NOT R5 R5 		;Negates divisor(R5) 
	ADD R5 R5 1 		;Add 1 to get (-R5) 
	ADD R6 R3 R5 		;Substract 
	  
	BRN 3 			;If Zero Exit the loop (Return R3) 
	ADD R2 R2 1 		;Else increment Quotient(R2) 
	ADD R3 R3 R5 		;Substract  Remainder and Divisor 
	BRNZP -5 		;Loop  


	LD R4, DIV4 		;Restore working registers
	LD R5, DIV5 	
	LD R6, DIV6 	
	LD R7, DIV7 	
	
	RET			;Return
;Data
DIV4 	.BLKW 	1 	; Save area R4
DIV5 	.BLKW 	1 	; Save area R5
DIV6 	.BLKW 	1 	; Save area R6
DIV7 	.BLKW 	1 	; Save area R7

	.END
