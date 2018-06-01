	.global long_press
;; Counting position of long presses.
long_press:
	inc r23			;; Increment the press (signal) counter.
	cpi r23, 0x01	;; If counter = 1,
	breq LP_1		;; It is the first signal.
	cpi r23, 0x02	;; If counter = 2,
	breq LP_2		;; It is the second signal.
	cpi r23, 0x03	;; If counter = 3,
	breq LP_3		;; It is the third signal.
	cpi r23, 0x04	;; If counter = 4,
	breq LP_4		;; It is the fourth signal.
	rjmp 1f			;; If longer than 4 characters (so position number > 4), ignore as this is an impossible case for a valid Morse letter.

	.global LP_1
LP_1:
	ori r24, 0x08	;; Recording a single long signal (a dash).
	rjmp 1f

	.global LP_2
LP_2:
	ori r24, 0x04	;; Recording a long signal in the second position.
	rjmp 1f

	.global LP_3
LP_3:
	ori r24, 0x02	;; Recording a long signal in the third position.
	rjmp 1f

	.global LP_4
LP_4:
	ori r24, 0x01	;; Recording a long signal in the fourth position.
	rjmp 1f

	.global short_press

;; Counting position of short presses.
short_press:		
	inc r23			;; Increment the press (signal) counter.
	cpi r23, 0x01	;; If counter = 1,
	breq SP_1		;; It is the first signal.
	cpi r23, 0x02	;; If counter = 2,
	breq SP_2		;; It is the second signal.
	cpi r23, 0x03	;; If counter = 3,
	breq SP_3		;; It is the third signal.
	cpi r23, 0x04	;; If counter = 4,
	breq SP_4		;; It is the third signal.
	rjmp 1f			;; If longer than 4 characters (so position number > 4), ignore as this is an impossible case for a valid Morse letter.

	.global SP_1
SP_1:
	ori r24, 0x00	;; Recording a single short signal (a dot).
	rjmp 1f

	.global SP_2
SP_2:
	ori r24, 0x00	;; Recording a short signal in the second position.
	rjmp 1f

	.global SP_3
SP_3:
	ori r24, 0x00	;; Recording a short signal in the third position.
	rjmp 1f

	.global SP_4
SP_4:
	ori r24, 0x00	;; Recording a short signal in the fourth position.
	rjmp 1f			;; If longer than 4 characters (so position number > 4), ignore as this is an impossible case for a valid Morse letter.

1:
	pop r16			;; Pops r16 and clears the timer overflow (r19).
	clr r19	
	ret				;; Returns to the previous method.
