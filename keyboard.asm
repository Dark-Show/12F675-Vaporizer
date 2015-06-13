#include <def.inc>
 UDATA_SHR
kb_x	res	1
kb_y	res	1
lc		res	1
ge		res	1	; Generator end count
ga		res 1	; Generator addition var
gs		res 1	; Generator start possition
kb_adr	res	1
kb_len	res	1
kb_cur	res	1
kb_end	res	1

 global	KEYBOARD
 global	kb_adr
 global	kb_len
 extern	OLED_ClearScreen
 extern	Delay125
 extern	UART_SendByte
 extern	OLED_StartText
 extern	OLED_SendNull
 extern OLED_Orgin
 extern OLED_NextLine
 extern	EEPROM_Read
 extern	EEPROM_Write
 extern OLED_DMNULL
 extern OLED_DMNOT
 extern OLED_FillRect
 extern OLED_DrawLine
 extern	ee_adr
 extern ee_dat

 code

KEYBOARD
		call	OLED_ClearScreen
		clrf	kb_end
		clrf	lc				; cursor tracker
		movlw	0x08			;
		movwf	kb_x				;
		movlw	0x0D			;
		movwf	kb_y				
		movf	kb_adr,w
		movwf	ee_adr
		movwf	kb_cur
		call	KB_DRAW
		call	DISPLOOP

KB		call	Ctrl_loop
		movf	kb_end,w
		sublw	0x01
		BTFSS	STATUS,Z
		goto	KB
		call	OLED_ClearScreen
		call	OLED_Orgin
		return
KB_DRAW
		call	KB_CLR_LINE
		call	OLED_Orgin
		call	OLED_StartText
		movf	kb_adr,w
		movwf	ee_adr
		movwf	kb_cur
		call	KB_EEPROM
		call	OLED_SendNull
		call	OLED_NextLine
		call	CHARSET
		call	OLED_DrawLine
		movlw	0x00
		call	UART_SendByte
		movlw	0x0C
		call	UART_SendByte
		movlw	0xFF
		call	UART_SendByte
		movlw	0x0C
		call	UART_SendByte
		return
CHARSET
		call 	OLED_StartText
		movlw	" "
		call	UART_SendByte
		movlw	0x01
		movwf	gs
		movlw	0x0D
		movwf	ge
		movlw	0x40
		movwf	ga
		call	GEN
		call 	OLED_SendNull
		call 	OLED_NextLine
		call 	OLED_StartText
		movlw	" "
		call	UART_SendByte
		movlw	0x0E
		movwf	gs
		movlw	0x1A
		movwf	ge
		call	GEN
		call 	OLED_SendNull
		call 	OLED_NextLine
		call 	OLED_StartText
		movlw	" "
		call	UART_SendByte
		movlw	"D"
		call	UART_SendByte
		movlw	"E"
		call	UART_SendByte
		movlw	"L"
		call	UART_SendByte
		movlw	" "
		call	UART_SendByte
		movlw	" "
		call	UART_SendByte
		movlw	" "
		call	UART_SendByte
		movlw	" "
		call	UART_SendByte
		movlw	" "
		call	UART_SendByte
		movlw	" "
		call	UART_SendByte
		movlw	" "
		call	UART_SendByte
		movlw	"E"
		call	UART_SendByte
		movlw	"N"
		call	UART_SendByte
		movlw	"D"
		call	UART_SendByte
		call 	OLED_SendNull
		return
KB_CLR_LINE
		call	KB_LINE
		call	OLED_DMNOT
		call	KB_LINE
		call	OLED_DMNULL
		return
KB_LINE
		call	OLED_FillRect
		movlw	0x00
		call 	UART_SendByte
		movlw	0x00
		call 	UART_SendByte
		addlw	0x80
		call 	UART_SendByte
		addlw	0x0A
		call 	UART_SendByte
		return
Ctrl_loop
		btfss	BTN1
		goto	BTN1_D
		btfss	BTN2
		goto	BTN2_D
		call	Delay125
		return
BTN1_D
		call	Delay125
		btfsc	BTN2
		goto	$+7
		call	DISPLOOP
		movlw	0x08
		addwf	kb_x,f
		incf	lc,f
		call	LIMITLOOP
		call	DISPLOOP
		return
BTN2_D
		call	Delay125
		btfsc	BTN1
		goto	$+5
		call	BTN_COMMAND
		call	DISPLOOP
		call	KB_DRAW
		call	DISPLOOP
		return
BTN_COMMAND
		movf	lc,w
		sublw	0x1A
		BTFSS	STATUS,Z
		goto	$+3
		call	KB_DEL
		goto	$+7
		movf	lc,w
		sublw	0x1B
		BTFSS	STATUS,Z
		goto	$+4
		call	KB_END
		goto	$+8
		goto	$+7
		movf	kb_adr,w
		subwf	kb_cur,w
		subwf	kb_len,w
		BTFSC	STATUS,Z
		goto	$+3
		call	KB_ALP
		call	EEPROM_Write
		return
KB_ALP
		movf	lc,w
		addlw	0x41
		movwf	ee_dat
		movf	kb_cur,w
		movwf	ee_adr
		return
KB_DEL
		movlw	0xFF
		movwf	ee_dat
		movf	kb_cur,w
		subwf	kb_adr,w
		movf	kb_cur,w
		BTFSC	STATUS,Z
		goto	$+2
		decf	kb_cur,w
		movwf	ee_adr
		return
KB_END
		movlw	0x01
		movwf	kb_end
		return
DISPLOOP
		call	OLED_DMNOT
		call	OLED_FillRect
		movf	kb_x,w
		call 	UART_SendByte
		movf	kb_y,w
		call 	UART_SendByte
		movf	kb_x,w
		addlw	0x07
		call 	UART_SendByte
		movf	kb_y,w
		addlw	0x0B
		call 	UART_SendByte
		call	OLED_DMNULL
		return
LIMITLOOP
		movf	kb_y,w
		sublw	0x27
		BTFSS	STATUS,Z
		goto	$+4
		movf	kb_x,w
		sublw	0x60
		BTFSS	STATUS,Z
		goto	$+6
		movlw	0x08
		movwf	kb_x
		movlw	0x0D
		movwf	kb_y
		clrf	lc

		movf	kb_y,w
		sublw	0x27
		BTFSS	STATUS,Z
		goto	$+4
		movf	kb_x,w
		sublw	0x10
		BTFSS	STATUS,Z
		goto	$+3
		movlw	0x58
		movwf	kb_x

		movf	kb_x,w
		sublw	0x70
		BTFSS	STATUS,Z
		goto	$+5
		movlw	0x08
		movwf	kb_x
		movlw	0x0D
		addwf	kb_y,f
		return
GEN							; for(I=gs;I==gc;I++){sendbyte(I+ga);}
		movf	gs,w
		incf	gs,f
		addwf	ga,w
		call 	UART_SendByte
		movf	gs,w
		subwf	ge,w
		BTFSS	STATUS,C
		goto	$+2
		goto	GEN
		return
KB_EEPROM
		call	EEPROM_Read
		sublw	0xFF
		btfsc	STATUS,Z
		goto	$+5
		movf	ee_dat,w
		call 	UART_SendByte
		incf	kb_cur,f
		goto	KB_EEPROM
		return
 END