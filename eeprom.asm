;*******************************************************
; EEPROM Memory Functions
;*******************************************************

#include "def.inc"
 UDATA_SHR
ee_adr	res	1					; Start address for reading eeprom
ee_dat	res	1					; Resulting byte
 global	ee_adr
 global ee_dat
 global	EEPROM_Read
 global	EEPROM_Write

 code

EEPROM_Read
		movf	ee_adr,w
		incf	ee_adr,f			; Update var with next address.
		BANK1
		movwf	EEADR			
		bsf		EECON1,0 		; Starts EEPROM read operation with result in EEDATA
		movf	EEDATA,w 		; Move read data into w
		BANK0				
		movwf	ee_dat			; Move result into ee_dat
		return

EEPROM_Write
		movf	ee_dat,w		; Use Data Var
		BANK1
		movwf	EEDATA						
		BANK0
		movf	ee_adr,w		; Use Address Var
		incf	ee_adr,f		; Update var with next address.
		BANK1	
		movwf	EEADR			
		bsf		EECON1,WREN		;enable write.
		bcf		INTCON,GIE		;Disable INTs
		movlw	0x55				;55h is an unlock code
		movwf	EECON2			;along with aah to prevent
		movlw	0xAA			;glitches writing to EEPROM.
		movwf	EECON2
		bsf		EECON1,WR		;write begins
		bsf		INTCON,GIE		;Enable INTs
		BANK0					;select bank0		
		btfss	PIR1,EEIF		;wait for write to complete
		goto	$-1
		bcf		PIR1,EEIF
		BANK1
		bcf		EECON1,WREN		;disable other writes
		BANK0			
		return
 END