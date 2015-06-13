 list      p=12f675          		; list directive to define processor
 processor   12F675
 errorlevel  -302              		; suppress message 302 from list file 
 #include <p12f675.inc>      		; processor specific variable definitions 

#define	BANK1		banksel 0x80	;Select Bank1
#define	BANK0		banksel 0x00	;Select Bank0
#define UART		GPIO,4			;UART Output Pin
#define BTN1		GPIO,3			;UART Output Pin
#define BTN2		GPIO,5			;UART Output Pin
#define BTN3		GPIO,4			;UART Output Pin