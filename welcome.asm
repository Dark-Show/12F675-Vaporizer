#include <def.inc>
 UDATA_SHR
wel_onH		res	1
wel_onL		res	1
wel_c		res	1

 global	WELCOME
 extern	Delay1000
 extern	UART_SendByte
 extern	OLED_StartText
 extern	OLED_ClearScreen
 extern	OLED_SendNull
 extern OLED_Orgin
 extern OLED_NextLine
 extern OLED_DrawLine
 extern	OLED_HEX
 extern	EEPROM_Read
 extern	EEPROM_Write
 extern	ee_adr
 extern ee_dat

 code

WELCOME
		call	OLED_ClearScreen
		call	OLED_Orgin
		call	OLED_StartText
		movlw	"W"
		call	UART_SendByte
		movlw	"e"
		call	UART_SendByte
		movlw	"l"
		call	UART_SendByte
		movlw	"c"
		call	UART_SendByte
		movlw	"o"
		call	UART_SendByte
		movlw	"m"
		call	UART_SendByte
		movlw	"e"
		call	UART_SendByte
		movlw	" "
		call	UART_SendByte
		clrf	ee_adr
		call	WEL_EEPROM
		call	OLED_SendNull
		CALL	WEL_STATS
		call	Delay1000
		call	Delay1000
		return

WEL_EEPROM
		movlw	0x08	; Read Max 8char
		movwf	wel_c
WEL_E	call	EEPROM_Read
		sublw	0xFF
		btfsc	STATUS,Z
		goto	$+5
		movf	ee_dat,w
		call 	UART_SendByte
		decfsz	wel_c
		goto	WEL_E
		return
WEL_STATS
		call	OLED_Orgin
		call	OLED_NextLine
		call	OLED_StartText
		movlw	"T"
		call	UART_SendByte
		movlw	"u"
		call	UART_SendByte
		movlw	"r"
		call	UART_SendByte
		movlw	"n"
		call	UART_SendByte
		movlw	"O"
		call	UART_SendByte
		movlw	"n"
		call	UART_SendByte
		movlw	":"
		call	UART_SendByte
		movlw	" "
		call	UART_SendByte
		call	WEL_TURNON
		call	OLED_SendNull
		return

WEL_TURNON
		movlw	0x09
		movwf	ee_adr
		call	EEPROM_Read
		movwf	wel_onH
		movlw	0x0A
		movwf	ee_adr
		call	EEPROM_Read
		movwf	wel_onL

		call	WEL_INCON

		movf	wel_onH,w
		call	OLED_HEX
		movf	wel_onL,w
		call	OLED_HEX
		return
WEL_INCON
		incf	wel_onL
		btfsc	STATUS,Z
		incf	wel_onH
		movlw	0x09
		movwf	ee_adr
		movf	wel_onH,w
		movwf	ee_dat
		call	EEPROM_Write
		movlw	0x0A
		movwf	ee_adr
		movf	wel_onL,w
		movwf	ee_dat
		call	EEPROM_Write
		return
 END