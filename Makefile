# MPLAB IDE generated this makefile for use with GNU make.
# Project: Main.mcp
# Date: Tue May 13 00:40:41 2014

AS = MPASMWIN.exe
CC = 
LD = mplink.exe
AR = mplib.exe
RM = rm

Main.cof : main.o uart.o oled.o timer.o eeprom.o keyboard.o menu.o math.o welcome.o analog.o
	$(CC) /p12F675 "main.o" "uart.o" "oled.o" "timer.o" "eeprom.o" "keyboard.o" "menu.o" "math.o" "welcome.o" "analog.o" /u_DEBUG /z__MPLAB_BUILD=1 /z__MPLAB_DEBUG=1 /m"Main.map" /w /o"Main.cof"

main.o : main.asm def.inc ../../../../../../Program\ Files\ (x86)/Microchip/MPASM\ Suite/p12f675.inc
	$(AS) /q /p12F675 "main.asm" /l"main.lst" /e"main.err" /o"main.o" /d__DEBUG=1

uart.o : uart.asm def.inc ../../../../../../Program\ Files\ (x86)/Microchip/MPASM\ Suite/p12f675.inc
	$(AS) /q /p12F675 "uart.asm" /l"uart.lst" /e"uart.err" /o"uart.o" /d__DEBUG=1

oled.o : oled.asm def.inc ../../../../../../Program\ Files\ (x86)/Microchip/MPASM\ Suite/p12f675.inc
	$(AS) /q /p12F675 "oled.asm" /l"oled.lst" /e"oled.err" /o"oled.o" /d__DEBUG=1

timer.o : timer.asm def.inc ../../../../../../Program\ Files\ (x86)/Microchip/MPASM\ Suite/p12f675.inc
	$(AS) /q /p12F675 "timer.asm" /l"timer.lst" /e"timer.err" /o"timer.o" /d__DEBUG=1

eeprom.o : eeprom.asm def.inc ../../../../../../Program\ Files\ (x86)/Microchip/MPASM\ Suite/p12f675.inc
	$(AS) /q /p12F675 "eeprom.asm" /l"eeprom.lst" /e"eeprom.err" /o"eeprom.o" /d__DEBUG=1

keyboard.o : keyboard.asm def.inc ../../../../../../Program\ Files\ (x86)/Microchip/MPASM\ Suite/p12f675.inc
	$(AS) /q /p12F675 "keyboard.asm" /l"keyboard.lst" /e"keyboard.err" /o"keyboard.o" /d__DEBUG=1

menu.o : menu.asm def.inc ../../../../../../Program\ Files\ (x86)/Microchip/MPASM\ Suite/p12f675.inc
	$(AS) /q /p12F675 "menu.asm" /l"menu.lst" /e"menu.err" /o"menu.o" /d__DEBUG=1

math.o : math.asm def.inc ../../../../../../Program\ Files\ (x86)/Microchip/MPASM\ Suite/p12f675.inc
	$(AS) /q /p12F675 "math.asm" /l"math.lst" /e"math.err" /o"math.o" /d__DEBUG=1

welcome.o : welcome.asm def.inc ../../../../../../Program\ Files\ (x86)/Microchip/MPASM\ Suite/p12f675.inc
	$(AS) /q /p12F675 "welcome.asm" /l"welcome.lst" /e"welcome.err" /o"welcome.o" /d__DEBUG=1

analog.o : analog.asm def.inc ../../../../../../Program\ Files\ (x86)/Microchip/MPASM\ Suite/p12f675.inc
	$(AS) /q /p12F675 "analog.asm" /l"analog.lst" /e"analog.err" /o"analog.o" /d__DEBUG=1

clean : 
	$(CC) "main.o" "main.err" "main.lst" "uart.o" "uart.err" "uart.lst" "oled.o" "oled.err" "oled.lst" "timer.o" "timer.err" "timer.lst" "eeprom.o" "eeprom.err" "eeprom.lst" "keyboard.o" "keyboard.err" "keyboard.lst" "menu.o" "menu.err" "menu.lst" "math.o" "math.err" "math.lst" "welcome.o" "welcome.err" "welcome.lst" "analog.o" "analog.err" "analog.lst" "Main.cof" "Main.hex" "Main.map"

