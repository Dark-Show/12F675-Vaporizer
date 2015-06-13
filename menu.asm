#include <def.inc>
 UDATA_SHR
mu_y	res	1
mu_pos	res	1
mu_sel	res	1
		
 extern	OLED_Init
 extern	Delay125
 extern	OLED_StartScreen
 extern	OLED_ClearScreen
 extern	UART_SendByte
 extern	OLED_StartText
 extern	OLED_SendNull
 extern OLED_Orgin
 extern OLED_TextPos
 extern OLED_NextLine
 extern	OLED_EEPROM
 extern OLED_DMNULL
 extern OLED_DMNOT
 extern OLED_FillRect
 extern OLED_DrawLine
 extern	WELCOME
 extern KEYBOARD
 extern ANALOG
 extern	kb_len
 extern kb_adr
 global	MENU

 code

MENU
		call	OLED_ClearScreen
		clrf	mu_pos	
		call	MENU_0
		movlw	0x0D
		movwf	mu_y
		call	MU_Disp
MU		call	MU_Ctrl
		goto	MU

MU_Ctrl
		btfss	GPIO,GP3
		goto	MU_GP3
		btfss	GPIO,GP5
		goto	MU_GP5
		call	Delay125
		return

MENU_0
		call	OLED_TextPos	
		movlw	0x04
		call	UART_SendByte
		movlw	0x00
		call	UART_SendByte

		call	OLED_StartText
		movlw	"S"
		call	UART_SendByte
		movlw	"E"
		call	UART_SendByte
		movlw	"T"
		call	UART_SendByte
		movlw	"T"
		call	UART_SendByte
		movlw	"I"
		call	UART_SendByte
		movlw	"N"
		call	UART_SendByte
		movlw	"G"
		call	UART_SendByte
		movlw	"S"
		call	UART_SendByte
		call	OLED_SendNull

		call	OLED_DrawLine
		movlw	0x00
		call	UART_SendByte
		movlw	0x0C
		call	UART_SendByte
		movlw	0xFF
		call	UART_SendByte
		movlw	0x0C
		call	UART_SendByte

		call	OLED_Orgin
		call	OLED_NextLine


		call	OLED_StartText
		movlw	"C"
		call	UART_SendByte
		movlw	"h"
		call	UART_SendByte
		movlw	"a"
		call	UART_SendByte
		movlw	"n"
		call	UART_SendByte
		movlw	"g"
		call	UART_SendByte
		movlw	"e"
		call	UART_SendByte
		movlw	" "
		call	UART_SendByte
		movlw	"N"
		call	UART_SendByte
		movlw	"a"
		call	UART_SendByte
		movlw	"m"
		call	UART_SendByte
		movlw	"e"
		call	UART_SendByte
		call	OLED_SendNull



		call	OLED_NextLine
		call	OLED_StartText
		movlw	"W"
		call	UART_SendByte
		movlw	"E"
		call	UART_SendByte
		movlw	"L"
		call	UART_SendByte
		movlw	"C"
		call	UART_SendByte
		movlw	"O"
		call	UART_SendByte
		movlw	"M"
		call	UART_SendByte
		movlw	"E"
		call	UART_SendByte
		call	OLED_SendNull

		call	OLED_NextLine
		call	OLED_StartText
		movlw	"A"
		call	UART_SendByte
		movlw	"n"
		call	UART_SendByte
		movlw	"a"
		call	UART_SendByte
		movlw	"l"
		call	UART_SendByte
		movlw	"o"
		call	UART_SendByte
		movlw	"g"
		call	UART_SendByte
		call	OLED_SendNull
		return

MU_Limit
		movf	mu_y,w
		sublw	0x34
		BTFSS	STATUS,Z
		goto	$+4
		movlw	0x0D
		movwf	mu_y
		clrf	mu_pos
		return
MU_GP5
		call	Delay125
		btfsc	GPIO,GP5
		goto	$+7
		call	MU_Disp
		movlw	0x0D
		addwf	mu_y,f
		incf	mu_pos,f
		call	MU_Limit
		call	MU_Disp
		return
MU_GP3
		call	Delay125
		btfsc	GPIO,GP3
		goto	$+2
		call	MU_Command
		return

MU_Command
		call	OLED_ClearScreen
		movf	mu_pos,w
		sublw	0x00
		BTFSS	STATUS,Z
		goto	$+6
		clrf	kb_adr
		movlw	0x08
		movwf	kb_len
		call	KEYBOARD
		goto	MENU
		movf	mu_pos,w
		sublw	0x01
		BTFSS	STATUS,Z
		goto	$+3
		call	WELCOME
		goto	MENU
		movf	mu_pos,w
		sublw	0x02
		BTFSS	STATUS,Z
		goto	$+3
		call	ANALOG
		goto	MENU
		return
MU_Disp
		call	OLED_DMNOT
		call	OLED_FillRect
		movlw	0x00
		call 	UART_SendByte
		movf	mu_y,w
		call 	UART_SendByte
		addlw	0x80
		call 	UART_SendByte
		movf	mu_y,w
		addlw	0x0B
		call 	UART_SendByte
		call	OLED_DMNULL
		return
 END