#include "def.inc"
 __CONFIG   _CP_OFF & _CPD_OFF & _BODEN_OFF & _MCLRE_OFF & _WDT_OFF & _PWRTE_ON & _INTRC_OSC_NOCLKOUT

 extern	OLED_Init
 extern	Delay1000
 extern	OLED_StartScreen
 extern	OLED_ClearScreen
 extern	OLED_Orgin
 extern	UART_SendByte
 extern	OLED_StartText
 extern	OLED_SendNull
 extern	UART_Init
 extern WELCOME
 extern	MENU
 extern	A2D_Init
 org 0x00

Init
		clrf	GPIO			; Clear Port
		movlw	07h
		movwf	CMCON
		BANK1
		call   	0x3FF      		; retrieve factory calibration value
		movwf   OSCCAL	   		; update register with factory cal value 
		movlw	B'00100101'
		movwf	TRISIO
		BANK0					; BANK 0

		call	UART_Init
		call	OLED_Init
		call	A2D_Init

		call	WELCOME
Main	call	MENU
		goto	Main
 END