PROCESSOR 16F628A
#include <xc.inc>
; CONFIG
  CONFIG  FOSC = INTOSCIO      ; Oscillator Selection bits (INTOSC oscillator: CLKOUT function on RA6/OSC2/CLKOUT pin, I/O function on RA7/OSC1/CLKIN)
  CONFIG  WDTE = OFF            ; Watchdog Timer Enable bit (WDT disabled)
  CONFIG  PWRTE = OFF           ; Power-up Timer Enable bit (PWRT disabled)
  CONFIG  MCLRE = OFF           ; RA5/MCLR/VPP Pin Function Select bit (RA5/MCLR/VPP pin function is digital input, MCLR internally tied to VDD)
  CONFIG  BOREN = OFF           ; Brown-out Detect Enable bit (BOD disabled)
  CONFIG  LVP = OFF             ; Low-Voltage Programming Enable bit (RB4/PGM pin has digital I/O function, HV on MCLR must be used for programming)
  CONFIG  CPD = OFF             ; Data EE Memory Code Protection bit (Data memory code protection off)
  CONFIG  CP = OFF              ; Flash Program Memory Code Protection bit (Code protection off)
  
;***********************************************************
;******************** variables ****************************
cout_1 equ 0x20
cout_2 equ 0x21
cout_3 equ 0x22
cout_4 equ 0x23
;****************** fin de variables ***********************
;***********************************************************
 
 
 
 ;**********************************************************
 ;********************* macros ***************************** 
CONTROL_LED macro register, bit_modify
    movlw bit_modify
    movwf register
ENDM
;******************* fin de macros ************************
;**********************************************************
    
    
PSECT MAIN_LOOP, class=code, delta=2,abs
    
    

;*****************************************************************
;************ configuracin de los registros A y B ****************
    bsf     STATUS, 5    ; banco 1, para la configuración de tris
    bcf     STATUS, 6
    movlw   0x00               
    movwf   TRISA        ; Puerto A como salida
    movwf   TRISB        ; Puerto B como salida
    bcf     STATUS, 5    ; banco 0, para la configuracion de port
    movlw   0x07 
    movwf   CMCON 
;****************************************************************
;****************************************************************
    
    
    CONTROL_LED PORTB,0x00
    
MAIN_LOOP:
    CONTROL_LED PORTB,0x01
    call retardo
    CONTROL_LED PORTB,0x02
    call retardo
    CONTROL_LED PORTB,0x04
    call retardo
    CONTROL_LED PORTB,0x08
    call retardo
    CONTROL_LED PORTB,0x10
    call retardo
    CONTROL_LED PORTB,0x20
    call retardo
    CONTROL_LED PORTB,0x40
    call retardo
    CONTROL_LED PORTB,0x80
    call retardo
    GOTO MAIN_LOOP

;********** sub rutinas *****************************************
;****************************************************************  
retardo:
    movlw 0x10
    movwf cout_1
temp1:
    movlw 0x10
    movwf cout_2
temp2:
    movlw 0x10
    movwf cout_3
temp3:
    movlw 0x44
    movwf cout_4
temp4:
    decfsz cout_4,1
    goto temp4
    decfsz cout_3,1
    goto temp3
    decfsz cout_2,1
    goto temp2
    decfsz cout_1,1
    goto temp1
    return

    
END


