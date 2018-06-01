;; r18 = displays letter reps onto 7seg.
;; r24 = morse sequence.
;; r23 = morse length.
;; DOT_OR_DASH is time between dots and dashes/inter letter delay.
;; GAPS is time between letters.

#define __SFR_OFFSET 0
#include <avr/io.h>
#include "7segment.S"
	CPU_FREQ = 16000000 ;; CPU Frequency in Hertz(HZ)
	TICKS_PER_SEC = CPU_FREQ / (256 * 1024) ;; Number of clock ticks per second
	DOT_OR_DASH = TICKS_PER_SEC / 4 		;; Time between dots and dashes (inter letter delay = 250ms)  
	GAPS = TICKS_PER_SEC / 2 		 		;; Time between letters (500ms)
	
	BUTTON = 0 								;; Button variable points to pin 0.		

	.global main 		
main:

	ldi r18, ALL_SEGS						;; Loading all segments of the 7 segment display into register 18.
	out DDRD, r18							;; Make register 18 output to port D.

	
	sbi PORTB, BUTTON 						;; Pin 0 is set as an output for port B.

;; Setting up the timer
	clr r16									;; Clearing register.
	sts TCCR1A, r16							;; Store r16 in Timer Counter Control Register.
											;; Basically set value of TCCR1A to 0.

	
	ldi r16, GAPS							;; Load GAPS variable into r16.
	sts OCR1AH, r16							;; Store r16 in Output Compare Register A High Byte.
											;; Basically set value of OCR1AH to 0.
	
	clr r16									;; Clearing register;
	sts OCR1AL, r16							;; Store r16 in Output Compare Register A Low Byte.
											;; Basically set value of OCR1AL to 0.

	ldi r16, _BV(ICIE1) | _BV(OCIE1A)		;; Enable the Input Capture Interrupt (ICIE1) and Output Compare A Match Interrupt (OCIE1A)
	sts TIMSK1, r16
			
	ldi r16,  _BV(ICNC1) | _BV(CS12) | _BV(CS10) | _BV(WGM12) ;;Noise canceller, clock select, and  WGM12 (CTC, clear timer on compare) loaded into r16.
	sts TCCR1B, r16 									      ;; r16 stored in the Timer/Counter Control Register, where the prescaler is configured.

	clr r19									
	ldi r18, ALL_SEGS						;; Set display to blank.

	sei										;; Enable interrupts globally.

waitforint:	rjmp waitforint 				;; Wait for an interrupt.


	.global timer1_compa_isr
timer1_compa_isr:							 
	push r16								;;r16 is pushed onto the stack.	
	in r16, SREG							
	push r16

	lds r16, TCCR1B							;; Load r16 from Timer Control Register B.
	sbrs r16, ICES1 						;; Skip this if waiting for rising edge (ICES = 1).
	rjmp wait_for_press						;; Jump to wait_for_press.

wait_for_release:							
	ser r19 								;; Making sure any signal longer than the overflow timer is counted as a long signal.
	rjmp 1f

wait_for_press:
	rcall get_length                        ;; Recall get_length to output letter.
	rcall output								;; Output.


;; Restoring SREG and r16, and returning from the interrupt.	
1:	pop r16			;;r16 is popped from the stack, effectively saving its contents.
	out SREG, r16 							
	pop r16			

	reti			;;Returns from interrupt, carrying on with previous routine.

	.global timer1_cpt_isr
timer1_cpt_isr:
	push r10		;;Pushing register onto the stack for use in the routine.
	push r16		
	push r17		

	in r16, SREG 		

	push r16

	lds r10, ICR1L	 ;;	Load r10 into ICR1L (Input capture register low).
	lds r10, ICR1H   ;; Load r10 ICR1H (Input capture register high).      

	mov r17,r19  	 ;; Copy value of r19 into r17.	
	or r17,r16		 ;; OR r17 and r16 to see if equal.
 
;; If r16=r17=0, input should be ignored.

	breq debounce		

;; Resetting timer.	
	clr r17
	sts TCNT1H, r17 	
	sts TCNT1L, r17		

;; Checking which of the two types of edges was detected
	lds r17, TCCR1B				;; Load r17 from TCCR1B.
	sbrs  r17, ICES1			;; If rising edge, skip.

	rjmp pressed				;;If the button has been pressed, jump to pressed routine.
	rcall released				;;If the button has been released, call the released routine.
	

	andi r17, ~(_BV(ICES1))		;; After rising edge, we need to look for falling edge, so we set ICES1 to zero through r17.

	rjmp 1f

pressed:
	rcall signal_start			;;When a button press is detected, the signal start routine is called.
	ori r17, _BV(ICES1)			;; Looking for a rising edge.	

1:
	sts TCCR1B, r17 	
;;When the button is released, all the registers below are popped from the stack.
debounce:
	pop r16			
	out SREG, r16			
	pop r17			
	pop r16			
	pop r10			

	reti			

;; Testing whether this is a first dot/dash of a sequence of a letter. 
signal_start:
	tst r23			
	breq clear	;; Keep display clear in the case when it is the first dot/dash.
	ret			;; Return to the previous routine.

;; Clearing the display.	
clear:
	ldi r18, ALL_SEGS	;; Load all segments into r18.
	call output			;; Call output routine.
	ret					;; Return to previous routine.


released:
	push r16			;; Push r16 onto the stack.

	tst r19 			
	brne lp				;; If r19 is set, we have an overflowed signal i.e. a long signal.
	ldi r16, DOT_OR_DASH
	cp r10,r16			;; Testing whether DOT_OR_DASH is larger than value stored in r10.
	brcs sp				;; If it is, that means we have a short signal (dot), and so we branch to sp.

lp:
	rjmp long_press		;; Jumping to long_press.

sp:
	rjmp short_press	;; Jumping to short_press.

;; Resetting and outputting letter stored in r18 to the 7segment display.	
output:
	clr r23				
	clr r24				
	out PORTD, r18
	ret
