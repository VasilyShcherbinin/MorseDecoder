#include <avr/io.h> 				
	
	;; Initialising the segments of the seven-segment display
	SEG_A = 7		; top
	SEG_B = 1 		; upper right
	SEG_C = 2		; lower right
	SEG_D = 3		; buttom
	SEG_E = 4		; lower left
	SEG_F = 5		; upper right
	SEG_G = 6		; middle


	;; Initialising the letters and activating appropriate segments of the display to display the letters 
	ALL_SEGS = _BV(SEG_A) | _BV(SEG_B) | _BV(SEG_C) | _BV(SEG_D) | _BV(SEG_E) | _BV(SEG_F) | _BV(SEG_G)
	CHAR_A = ~(_BV(SEG_A) | _BV(SEG_B) | _BV(SEG_C) | _BV(SEG_E) | _BV(SEG_F) | _BV(SEG_G))
	CHAR_B = ~(_BV(SEG_C) | _BV(SEG_D) | _BV(SEG_E) | _BV(SEG_F) | _BV(SEG_G))
	CHAR_C = ~(_BV(SEG_A) | _BV(SEG_D) | _BV(SEG_E) | _BV(SEG_F))
	CHAR_D = ~(_BV(SEG_B) | _BV(SEG_C) | _BV(SEG_D) | _BV(SEG_E) | _BV(SEG_G))
	CHAR_E = ~(_BV(SEG_A) | _BV(SEG_D) | _BV(SEG_E) | _BV(SEG_F) | _BV(SEG_G))
	CHAR_F = ~(_BV(SEG_A) | _BV(SEG_E) | _BV(SEG_F) | _BV(SEG_G))
	CHAR_G = ~(_BV(SEG_A) | _BV(SEG_C) | _BV(SEG_D) | _BV(SEG_E) | _BV(SEG_F))
	CHAR_H = ~( _BV(SEG_C) | _BV(SEG_E) | _BV(SEG_F) | _BV(SEG_G))
	CHAR_I = ~( _BV(SEG_E) | _BV(SEG_F))
	CHAR_J = ~(_BV(SEG_B) | _BV(SEG_C) | _BV(SEG_D) | _BV(SEG_E))
	CHAR_K = ~(_BV(SEG_A) | _BV(SEG_C) | _BV(SEG_E) | _BV(SEG_F) | _BV(SEG_G))
	CHAR_L = ~( _BV(SEG_D) | _BV(SEG_E) | _BV(SEG_F))
	CHAR_M = ~(_BV(SEG_A) | _BV(SEG_C) | _BV(SEG_E))
	CHAR_N = ~(_BV(SEG_A) | _BV(SEG_B) | _BV(SEG_C) | _BV(SEG_E) | _BV(SEG_F))
	CHAR_O = ~(_BV(SEG_A) | _BV(SEG_B) | _BV(SEG_C) | _BV(SEG_D) | _BV(SEG_E) | _BV(SEG_F))
	CHAR_P = ~(_BV(SEG_A) | _BV(SEG_B) | _BV(SEG_E) | _BV(SEG_F) | _BV(SEG_G))
	CHAR_Q = ~(_BV(SEG_A) | _BV(SEG_B) | _BV(SEG_C) | _BV(SEG_F) | _BV(SEG_G))
	CHAR_R = ~(_BV(SEG_A) | _BV(SEG_B) | _BV(SEG_E) | _BV(SEG_F))
	CHAR_S = ~(_BV(SEG_A) | _BV(SEG_C) | _BV(SEG_D) | _BV(SEG_F) | _BV(SEG_G))
	CHAR_T = ~(_BV(SEG_D) | _BV(SEG_E) | _BV(SEG_F) | _BV(SEG_G))
	CHAR_U = ~(_BV(SEG_B) | _BV(SEG_C) | _BV(SEG_D) | _BV(SEG_E) | _BV(SEG_F))
	CHAR_V = ~(_BV(SEG_B) | _BV(SEG_C) | _BV(SEG_D) | _BV(SEG_F))
	CHAR_W = ~(_BV(SEG_B) | _BV(SEG_D) | _BV(SEG_F))
	CHAR_X = ~(_BV(SEG_B) | _BV(SEG_C) | _BV(SEG_E) | _BV(SEG_F) | _BV(SEG_G))
	CHAR_Y = ~(_BV(SEG_B) | _BV(SEG_C) | _BV(SEG_D) | _BV(SEG_F) | _BV(SEG_G))
	CHAR_Z = ~(_BV(SEG_A) | _BV(SEG_B) | _BV(SEG_D) | _BV(SEG_G))
	ERROR = ~(_BV(SEG_A) | _BV(SEG_B) | _BV(SEG_C) | _BV(SEG_D) | _BV(SEG_G))
