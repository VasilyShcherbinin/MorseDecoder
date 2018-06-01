#include "7segment.S"

	.global get_length

;; Getting the length of the inputted Morse signal 
get_length:
	cpi r23, 0x00	;; In the case when signal is of length 0
	breq 1f			
	cpi r23, 0x01	;; In the case when signal is of length 1
	breq length_1	;; go to appropriate loop for letters of length 1
	cpi r23, 0x02	;; In the case when signal is of length 2 
	breq length_2	;; go to appropriate loop for letters of length 2
	cpi r23, 0x03	;; In the case when signal is of length 3 
	breq length_3	;; go to appropriate loop for letters of length 3
	cpi r23, 0x04	;; In the case when signal is of length 4 
	breq length_4	;; go to appropriate loop for letters of length 4
	rjmp error		;; else jump to error code

1:	
	ret

	.global length_1

;; Defining characters of length 1
length_1:
	ldi r18, CHAR_E	;; The letter E is length 1
	cpi r24, 0x00	;; Compare the inputted bit pattern (using hex) with the morse code sequence.
	breq 1f			;; Go to next 1 routine.

	ldi r18, CHAR_T ;; The letter T is length 1
	cpi r24, 0x08	;; Compare the inputted bit pattern (using hex) with the morse code sequence. 
	breq 1f			;; Go to next 1 routine.

	rjmp error		;; else jump to error code.

1:	
	ret

	.global length_2

;; Similar procedure as for length_1
length_2:

	ldi r18, CHAR_I
	cpi r24, 0x00
	breq 1f

	ldi r18, CHAR_A
	cpi r24, 0x04
	breq 1f
	
	ldi r18, CHAR_N
	cpi r24, 0x08
	breq 1f
	
	ldi r18, CHAR_M
	cpi r24, 0x0C
	breq 1f

	rjmp error

1:	
	ret

	.global length_3

length_3:

	ldi r18, CHAR_D
	cpi r24, 0x08
	breq 1f

        ldi r18, CHAR_G
	cpi r24, 0x0C
	breq 1f

	ldi r18, CHAR_K
	cpi r24, 0x0A
	breq 1f

	ldi r18, CHAR_O
	cpi r24, 0x0E
	breq 1f

	ldi r18, CHAR_R
	cpi r24, 0x04
	breq 1f

	ldi r18, CHAR_S
	cpi r24, 0x00
	breq 1f

	ldi r18, CHAR_U
	cpi r24, 0x02
	breq 1f

	ldi r18, CHAR_W
	cpi r24, 0x06
	breq 1f

	rjmp error

1:	
	ret

	.global length_4
length_4:
	ldi r18, CHAR_B
	cpi r24, 0x08
	breq 1f

	ldi 18, CHAR_C
	cpi r24, 0x0A
	breq 1f

	ldi r18, CHAR_F
	cpi r24, 0x02
	breq 1f

	ldi r18, CHAR_H
	cpi r24, 0x00
	breq 1f

	ldi r18, CHAR_J
	cpi r24, 0x07
	breq 1f

	ldi r18, CHAR_L
	cpi r24, 0x04
	breq 1f

	ldi r18, CHAR_P
	cpi r24, 0x06
	breq 1f

	ldi r18, CHAR_Q
	cpi r24, 0x0D
	breq 1f

	ldi r18, CHAR_V
	cpi r24, 0x01
	breq 1f

	ldi r18, CHAR_X
	cpi r24, 0x09
	breq 1f

	ldi r18, CHAR_Y
	cpi r24, 0x0B
	breq 1f

	ldi r18, CHAR_Z
	cpi r24, 0x0C
	breq 1f

	rjmp error

1:	
	ret

	.global error
;; In case of error
error:
	ldi r18, ERROR ;; Load 7segment character that represents an error.
	ret
