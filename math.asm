#include <def.inc>
 UDATA_SHR

mtmp 	res 1

math1	res	1
math2	res	1
mcount	res	1

 global	math1
 global	math2
 global	mtmp
 global	DIV_8NC
 global	MUL_8
 global CONV_ALPHA
 global CONV_HEX
 global CONV_NUMERIC
 	
 code

; math1/math2

DIV_8NC
		clrf	mtmp
		movf	math2,w
D8NC
		subwf	math1,f
		BTFSS	STATUS,C
		goto	$+3
		incf	mtmp
		goto	D8NC
		movf	mtmp,w
		return


; Enter with multiplier in W-Reg, multiplicand in "math1".
; Exits with product in math2:math1.
MUL_8
		CLRF	math2
		CLRF	mcount
		BSF		mcount,3
		RRF		math1,F
M8:
		btfsc	STATUS,C
		ADDWF	math2,F
		RRF		math2,F
		RRF		math1,F
		DECFSZ	mcount
		GOTO	M8
		return

CONV_ALPHA
		addlw	0x41
		return
CONV_NUMERIC
		addlw	0x30
		return
CONV_HEX
		movwf	mtmp
		sublw	0x09
		BTFSS	STATUS,C
		goto	$+4
		movf	mtmp,w
		addlw	0x30
		return
		movf	mtmp,w
		addlw	0x37
		return
 END