#include <def.inc>
 UDATA_SHR
NumH	res	1
NumL	res	1
hextmp 	res 1

 global ANALOG
 global	A2D_Init
 global	A2D_Read
 global NumH
 global NumL
 extern	OLED_HEX
 extern	Delay1000
 extern	OLED_ClearScreen
 extern	OLED_Orgin
 extern	UART_SendByte
 extern	OLED_StartText
 extern	OLED_SendNull
 extern	OLED_DOUT

 code
A2D_Init
; Set ADCON0

			bsf		ADCON0,ADON			; Turn on A2D
    		movlw   b'00010001'
    		movwf   ANSEL
			return

A2D_Read
	   		bsf		ADCON0, GO_DONE		;initiate conversion
   			btfsc   ADCON0, GO_DONE
   			goto    $-1					;wait for ADC to finish

	   		movf    ADRESH,W
   			movwf   NumH
	   		BANKSEL ADRESL
    		movf    ADRESL,W
    		BANKSEL	ADRESH
			movwf	NumL				;return result in NumL and NumH
			return 

ANALOG		call	Delay1000
			call	OLED_ClearScreen
			call	OLED_Orgin
			call	A2D_Read
			call	A2D_StatLight
			call	OLED_StartText
			movf	NumH,w
			call	OLED_HEX
			movf	NumL,w
			call	OLED_HEX
			call	OLED_SendNull
			goto	ANALOG

A2D_StatLight
			call	OLED_DOUT
			movf	NumH,w
			sublw	0xEF
			btfsc   STATUS,C
			goto	$+4
			movlw	b'00000001'
			call	UART_SendByte
			goto	$+3
			movlw	b'00000010'
			call	UART_SendByte
			return
 END