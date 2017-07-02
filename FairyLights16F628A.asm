
_main:

;FairyLights16F628A.c,39 :: 		void main() {
;FairyLights16F628A.c,41 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;FairyLights16F628A.c,42 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;FairyLights16F628A.c,43 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;FairyLights16F628A.c,44 :: 		init_io();
	CALL       _init_io+0
;FairyLights16F628A.c,46 :: 		while(1){
L_main0:
;FairyLights16F628A.c,48 :: 		padrao1();
	CALL       _padrao1+0
;FairyLights16F628A.c,50 :: 		}
	GOTO       L_main0
;FairyLights16F628A.c,51 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_init_io:

;FairyLights16F628A.c,54 :: 		void init_io(){
;FairyLights16F628A.c,55 :: 		CMCON = 0x07;       //desabilita os comparadores
	MOVLW      7
	MOVWF      CMCON+0
;FairyLights16F628A.c,56 :: 		OPTION_REG = 0x86;   //Timer0 incrementa com o ciclo de instruçao, prescaler 1:128
	MOVLW      134
	MOVWF      OPTION_REG+0
;FairyLights16F628A.c,57 :: 		GIE_bit = 0x01;     //habilita interrupção global
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;FairyLights16F628A.c,58 :: 		PEIE_bit = 0x01;    //habilita interrupção por perifericos
	BSF        PEIE_bit+0, BitPos(PEIE_bit+0)
;FairyLights16F628A.c,59 :: 		T0IE_bit = 0x01;    //habilita interrupção por timer0
	BSF        T0IE_bit+0, BitPos(T0IE_bit+0)
;FairyLights16F628A.c,60 :: 		TMR0 = 0x6C;        //inicia o timer0
	MOVLW      108
	MOVWF      TMR0+0
;FairyLights16F628A.c,62 :: 		trisa.f1 =1;
	BSF        TRISA+0, 1
;FairyLights16F628A.c,63 :: 		trisa.f2 =1;
	BSF        TRISA+0, 2
;FairyLights16F628A.c,64 :: 		trisa.f3 =1;
	BSF        TRISA+0, 3
;FairyLights16F628A.c,65 :: 		trisa.f4 =1;
	BSF        TRISA+0, 4
;FairyLights16F628A.c,66 :: 		porta.f1 =1;
	BSF        PORTA+0, 1
;FairyLights16F628A.c,67 :: 		porta.f2 =1;
	BSF        PORTA+0, 2
;FairyLights16F628A.c,68 :: 		porta.f3 =1;
	BSF        PORTA+0, 3
;FairyLights16F628A.c,69 :: 		porta.f4 =1;
	BSF        PORTA+0, 4
;FairyLights16F628A.c,71 :: 		trisb.f0 =0;    //define porta como saida (porta do led)
	BCF        TRISB+0, 0
;FairyLights16F628A.c,72 :: 		trisb.f1 =0;    //define porta como saida (porta do led)
	BCF        TRISB+0, 1
;FairyLights16F628A.c,73 :: 		trisb.f2 =0;    //define porta como saida (porta do led)
	BCF        TRISB+0, 2
;FairyLights16F628A.c,74 :: 		trisb.f3 =0;    //define porta como saida (porta do led)
	BCF        TRISB+0, 3
;FairyLights16F628A.c,75 :: 		trisb.f4 =0;    //define porta como saida (porta do led)
	BCF        TRISB+0, 4
;FairyLights16F628A.c,76 :: 		trisb.f5 =0;    //define porta como saida (porta do led)
	BCF        TRISB+0, 5
;FairyLights16F628A.c,77 :: 		trisb.f6 =0;    //define porta como saida (porta do led)
	BCF        TRISB+0, 6
;FairyLights16F628A.c,78 :: 		trisb.f7 =0;    //define porta como saida (porta do led)
	BCF        TRISB+0, 7
;FairyLights16F628A.c,79 :: 		}
L_end_init_io:
	RETURN
; end of _init_io

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;FairyLights16F628A.c,82 :: 		void interrupt(){  //verifica estouro (função do mikroc para tratamento de interrupções)
;FairyLights16F628A.c,83 :: 		if(T0IF_bit){ //caso haja estouro no timer0
	BTFSS      T0IF_bit+0, BitPos(T0IF_bit+0)
	GOTO       L_interrupt2
;FairyLights16F628A.c,84 :: 		T0IF_bit = 0x00; //limpa flag
	BCF        T0IF_bit+0, BitPos(T0IF_bit+0)
;FairyLights16F628A.c,85 :: 		TMR0 = 0x6C;     //inicia timer0 novamente
	MOVLW      108
	MOVWF      TMR0+0
;FairyLights16F628A.c,87 :: 		if(!S2){ //caso RA1 seja pressionado
	BTFSC      RA1_bit+0, BitPos(RA1_bit+0)
	GOTO       L_interrupt3
;FairyLights16F628A.c,88 :: 		while(S3 && S4 && S5){
L_interrupt4:
	BTFSS      RA2_bit+0, BitPos(RA2_bit+0)
	GOTO       L_interrupt5
	BTFSS      RA3_bit+0, BitPos(RA3_bit+0)
	GOTO       L_interrupt5
	BTFSS      RA4_bit+0, BitPos(RA4_bit+0)
	GOTO       L_interrupt5
L__interrupt71:
;FairyLights16F628A.c,89 :: 		padrao2(); //muda padrão dos leds
	CALL       _padrao2+0
;FairyLights16F628A.c,90 :: 		}
	GOTO       L_interrupt4
L_interrupt5:
;FairyLights16F628A.c,91 :: 		}
	GOTO       L_interrupt8
L_interrupt3:
;FairyLights16F628A.c,92 :: 		else if(!S3){ //caso RA2 seja pressionado
	BTFSC      RA2_bit+0, BitPos(RA2_bit+0)
	GOTO       L_interrupt9
;FairyLights16F628A.c,93 :: 		while(S2 && S4 && S5){
L_interrupt10:
	BTFSS      RA1_bit+0, BitPos(RA1_bit+0)
	GOTO       L_interrupt11
	BTFSS      RA3_bit+0, BitPos(RA3_bit+0)
	GOTO       L_interrupt11
	BTFSS      RA4_bit+0, BitPos(RA4_bit+0)
	GOTO       L_interrupt11
L__interrupt70:
;FairyLights16F628A.c,94 :: 		padrao3(); //muda padrão dos leds
	CALL       _padrao3+0
;FairyLights16F628A.c,95 :: 		}
	GOTO       L_interrupt10
L_interrupt11:
;FairyLights16F628A.c,96 :: 		}
	GOTO       L_interrupt14
L_interrupt9:
;FairyLights16F628A.c,97 :: 		else if(!S4){ //caso RA3 seja pressionado
	BTFSC      RA3_bit+0, BitPos(RA3_bit+0)
	GOTO       L_interrupt15
;FairyLights16F628A.c,98 :: 		while(S3 && S2 && S5){
L_interrupt16:
	BTFSS      RA2_bit+0, BitPos(RA2_bit+0)
	GOTO       L_interrupt17
	BTFSS      RA1_bit+0, BitPos(RA1_bit+0)
	GOTO       L_interrupt17
	BTFSS      RA4_bit+0, BitPos(RA4_bit+0)
	GOTO       L_interrupt17
L__interrupt69:
;FairyLights16F628A.c,99 :: 		padrao4(); //muda padrão dos leds
	CALL       _padrao4+0
;FairyLights16F628A.c,100 :: 		}
	GOTO       L_interrupt16
L_interrupt17:
;FairyLights16F628A.c,101 :: 		}
	GOTO       L_interrupt20
L_interrupt15:
;FairyLights16F628A.c,102 :: 		else if(!S5){ //caso RA4 seja pressionado
	BTFSC      RA4_bit+0, BitPos(RA4_bit+0)
	GOTO       L_interrupt21
;FairyLights16F628A.c,103 :: 		while(S3 && S4 && S2){
L_interrupt22:
	BTFSS      RA2_bit+0, BitPos(RA2_bit+0)
	GOTO       L_interrupt23
	BTFSS      RA3_bit+0, BitPos(RA3_bit+0)
	GOTO       L_interrupt23
	BTFSS      RA1_bit+0, BitPos(RA1_bit+0)
	GOTO       L_interrupt23
L__interrupt68:
;FairyLights16F628A.c,104 :: 		padrao5(); //muda padrão dos leds
	CALL       _padrao5+0
;FairyLights16F628A.c,105 :: 		}
	GOTO       L_interrupt22
L_interrupt23:
;FairyLights16F628A.c,106 :: 		}
L_interrupt21:
L_interrupt20:
L_interrupt14:
L_interrupt8:
;FairyLights16F628A.c,107 :: 		}
L_interrupt2:
;FairyLights16F628A.c,108 :: 		}
L_end_interrupt:
L__interrupt75:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_apagaLeds:

;FairyLights16F628A.c,110 :: 		void apagaLeds(){
;FairyLights16F628A.c,111 :: 		portb.f0 =0;    //led apagado
	BCF        PORTB+0, 0
;FairyLights16F628A.c,112 :: 		portb.f1 =0;    //led apagado
	BCF        PORTB+0, 1
;FairyLights16F628A.c,113 :: 		portb.f2 =0;    //led apagado
	BCF        PORTB+0, 2
;FairyLights16F628A.c,114 :: 		portb.f3 =0;    //led apagado
	BCF        PORTB+0, 3
;FairyLights16F628A.c,115 :: 		portb.f4 =0;    //led apagado
	BCF        PORTB+0, 4
;FairyLights16F628A.c,116 :: 		portb.f5 =0;    //led apagado
	BCF        PORTB+0, 5
;FairyLights16F628A.c,117 :: 		portb.f6 =0;    //led apagado
	BCF        PORTB+0, 6
;FairyLights16F628A.c,118 :: 		portb.f7 =0;    //led apagado
	BCF        PORTB+0, 7
;FairyLights16F628A.c,119 :: 		}
L_end_apagaLeds:
	RETURN
; end of _apagaLeds

_acendeLeds:

;FairyLights16F628A.c,121 :: 		void acendeLeds(){
;FairyLights16F628A.c,122 :: 		portb.f0 =1; //acende led
	BSF        PORTB+0, 0
;FairyLights16F628A.c,123 :: 		portb.f1 =1; //acende led
	BSF        PORTB+0, 1
;FairyLights16F628A.c,124 :: 		portb.f2 =1; //acende led
	BSF        PORTB+0, 2
;FairyLights16F628A.c,125 :: 		portb.f3 =1; //acende led
	BSF        PORTB+0, 3
;FairyLights16F628A.c,126 :: 		portb.f4 =1; //acende led
	BSF        PORTB+0, 4
;FairyLights16F628A.c,127 :: 		portb.f5 =1; //acende led
	BSF        PORTB+0, 5
;FairyLights16F628A.c,128 :: 		portb.f6 =1; //acende led
	BSF        PORTB+0, 6
;FairyLights16F628A.c,129 :: 		portb.f7 =1; //acende led
	BSF        PORTB+0, 7
;FairyLights16F628A.c,130 :: 		}
L_end_acendeLeds:
	RETURN
; end of _acendeLeds

_padrao1:

;FairyLights16F628A.c,132 :: 		void padrao1(){
;FairyLights16F628A.c,133 :: 		acendeLeds();
	CALL       _acendeLeds+0
;FairyLights16F628A.c,134 :: 		delay_ms(200);  //espera um tempo de 200ms = 0.2s
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_padrao126:
	DECFSZ     R13+0, 1
	GOTO       L_padrao126
	DECFSZ     R12+0, 1
	GOTO       L_padrao126
	DECFSZ     R11+0, 1
	GOTO       L_padrao126
	NOP
;FairyLights16F628A.c,135 :: 		apagaLeds();
	CALL       _apagaLeds+0
;FairyLights16F628A.c,136 :: 		delay_ms(200);  //espera um tempo de 200ms = 0.2s
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_padrao127:
	DECFSZ     R13+0, 1
	GOTO       L_padrao127
	DECFSZ     R12+0, 1
	GOTO       L_padrao127
	DECFSZ     R11+0, 1
	GOTO       L_padrao127
	NOP
;FairyLights16F628A.c,137 :: 		}
L_end_padrao1:
	RETURN
; end of _padrao1

_padrao2:

;FairyLights16F628A.c,139 :: 		void padrao2(){
;FairyLights16F628A.c,140 :: 		apagaLeds();
	CALL       _apagaLeds+0
;FairyLights16F628A.c,141 :: 		portb.f0 =1; //acende led
	BSF        PORTB+0, 0
;FairyLights16F628A.c,142 :: 		portb.f1 =1; //acende led
	BSF        PORTB+0, 1
;FairyLights16F628A.c,143 :: 		delay_ms(200);  //espera um tempo de 200ms = 0.2s
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_padrao228:
	DECFSZ     R13+0, 1
	GOTO       L_padrao228
	DECFSZ     R12+0, 1
	GOTO       L_padrao228
	DECFSZ     R11+0, 1
	GOTO       L_padrao228
	NOP
;FairyLights16F628A.c,144 :: 		portb.f0 =0;    //led apagado
	BCF        PORTB+0, 0
;FairyLights16F628A.c,145 :: 		portb.f1 =0;    //led apagado
	BCF        PORTB+0, 1
;FairyLights16F628A.c,146 :: 		delay_ms(200);  //espera um tempo de 200ms = 0.2s
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_padrao229:
	DECFSZ     R13+0, 1
	GOTO       L_padrao229
	DECFSZ     R12+0, 1
	GOTO       L_padrao229
	DECFSZ     R11+0, 1
	GOTO       L_padrao229
	NOP
;FairyLights16F628A.c,147 :: 		portb.f2 =1; //acende led
	BSF        PORTB+0, 2
;FairyLights16F628A.c,148 :: 		portb.f3 =1; //acende led
	BSF        PORTB+0, 3
;FairyLights16F628A.c,149 :: 		delay_ms(200);  //espera um tempo de 200ms = 0.2s
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_padrao230:
	DECFSZ     R13+0, 1
	GOTO       L_padrao230
	DECFSZ     R12+0, 1
	GOTO       L_padrao230
	DECFSZ     R11+0, 1
	GOTO       L_padrao230
	NOP
;FairyLights16F628A.c,150 :: 		portb.f2 =0;    //led apagado
	BCF        PORTB+0, 2
;FairyLights16F628A.c,151 :: 		portb.f3 =0;    //led apagado
	BCF        PORTB+0, 3
;FairyLights16F628A.c,152 :: 		delay_ms(200);  //espera um tempo de 200ms = 0.2s
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_padrao231:
	DECFSZ     R13+0, 1
	GOTO       L_padrao231
	DECFSZ     R12+0, 1
	GOTO       L_padrao231
	DECFSZ     R11+0, 1
	GOTO       L_padrao231
	NOP
;FairyLights16F628A.c,153 :: 		portb.f4 =1;    //led aceso
	BSF        PORTB+0, 4
;FairyLights16F628A.c,154 :: 		portb.f5 =1; //acende led
	BSF        PORTB+0, 5
;FairyLights16F628A.c,155 :: 		delay_ms(200);  //espera um tempo de 200ms = 0.2s
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_padrao232:
	DECFSZ     R13+0, 1
	GOTO       L_padrao232
	DECFSZ     R12+0, 1
	GOTO       L_padrao232
	DECFSZ     R11+0, 1
	GOTO       L_padrao232
	NOP
;FairyLights16F628A.c,156 :: 		portb.f5 =0;    //led apagado
	BCF        PORTB+0, 5
;FairyLights16F628A.c,157 :: 		portb.f4 =0;    //led apagado
	BCF        PORTB+0, 4
;FairyLights16F628A.c,158 :: 		delay_ms(200);  //espera um tempo de 200ms = 0.2s
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_padrao233:
	DECFSZ     R13+0, 1
	GOTO       L_padrao233
	DECFSZ     R12+0, 1
	GOTO       L_padrao233
	DECFSZ     R11+0, 1
	GOTO       L_padrao233
	NOP
;FairyLights16F628A.c,159 :: 		portb.f6 =1; //acende led
	BSF        PORTB+0, 6
;FairyLights16F628A.c,160 :: 		portb.f7 =1; //acende led
	BSF        PORTB+0, 7
;FairyLights16F628A.c,161 :: 		delay_ms(200);  //espera um tempo de 200ms = 0.2s
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_padrao234:
	DECFSZ     R13+0, 1
	GOTO       L_padrao234
	DECFSZ     R12+0, 1
	GOTO       L_padrao234
	DECFSZ     R11+0, 1
	GOTO       L_padrao234
	NOP
;FairyLights16F628A.c,162 :: 		portb.f6 =0;    //led apagado
	BCF        PORTB+0, 6
;FairyLights16F628A.c,163 :: 		portb.f7 =0;    //led apagado
	BCF        PORTB+0, 7
;FairyLights16F628A.c,164 :: 		}
L_end_padrao2:
	RETURN
; end of _padrao2

_padrao3:

;FairyLights16F628A.c,166 :: 		void padrao3(){
;FairyLights16F628A.c,167 :: 		apagaLeds();
	CALL       _apagaLeds+0
;FairyLights16F628A.c,168 :: 		portb.f7 =1; //acende led
	BSF        PORTB+0, 7
;FairyLights16F628A.c,169 :: 		delay_ms(150);  //espera um tempo de 150ms = 0.15s
	MOVLW      195
	MOVWF      R12+0
	MOVLW      205
	MOVWF      R13+0
L_padrao335:
	DECFSZ     R13+0, 1
	GOTO       L_padrao335
	DECFSZ     R12+0, 1
	GOTO       L_padrao335
;FairyLights16F628A.c,170 :: 		portb.f7 =0;    //led apagado
	BCF        PORTB+0, 7
;FairyLights16F628A.c,171 :: 		delay_ms(150);  //espera um tempo de 150ms = 0.15s
	MOVLW      195
	MOVWF      R12+0
	MOVLW      205
	MOVWF      R13+0
L_padrao336:
	DECFSZ     R13+0, 1
	GOTO       L_padrao336
	DECFSZ     R12+0, 1
	GOTO       L_padrao336
;FairyLights16F628A.c,172 :: 		portb.f6 =1; //acende led
	BSF        PORTB+0, 6
;FairyLights16F628A.c,173 :: 		delay_ms(150);  //espera um tempo de 150ms = 015s
	MOVLW      195
	MOVWF      R12+0
	MOVLW      205
	MOVWF      R13+0
L_padrao337:
	DECFSZ     R13+0, 1
	GOTO       L_padrao337
	DECFSZ     R12+0, 1
	GOTO       L_padrao337
;FairyLights16F628A.c,174 :: 		portb.f6 =0;    //led apagado
	BCF        PORTB+0, 6
;FairyLights16F628A.c,175 :: 		delay_ms(150);  //espera um tempo de 150ms = 0.15s
	MOVLW      195
	MOVWF      R12+0
	MOVLW      205
	MOVWF      R13+0
L_padrao338:
	DECFSZ     R13+0, 1
	GOTO       L_padrao338
	DECFSZ     R12+0, 1
	GOTO       L_padrao338
;FairyLights16F628A.c,176 :: 		portb.f5 =1; //acende led
	BSF        PORTB+0, 5
;FairyLights16F628A.c,177 :: 		delay_ms(150);  //espera um tempo de 150ms = 0.15s
	MOVLW      195
	MOVWF      R12+0
	MOVLW      205
	MOVWF      R13+0
L_padrao339:
	DECFSZ     R13+0, 1
	GOTO       L_padrao339
	DECFSZ     R12+0, 1
	GOTO       L_padrao339
;FairyLights16F628A.c,178 :: 		portb.f5 =0;    //led apagado
	BCF        PORTB+0, 5
;FairyLights16F628A.c,179 :: 		delay_ms(150);  //espera um tempo de 150ms = 0.15s
	MOVLW      195
	MOVWF      R12+0
	MOVLW      205
	MOVWF      R13+0
L_padrao340:
	DECFSZ     R13+0, 1
	GOTO       L_padrao340
	DECFSZ     R12+0, 1
	GOTO       L_padrao340
;FairyLights16F628A.c,180 :: 		portb.f4 =1; //acende led
	BSF        PORTB+0, 4
;FairyLights16F628A.c,181 :: 		delay_ms(150);  //espera um tempo de 150ms = 0.15s
	MOVLW      195
	MOVWF      R12+0
	MOVLW      205
	MOVWF      R13+0
L_padrao341:
	DECFSZ     R13+0, 1
	GOTO       L_padrao341
	DECFSZ     R12+0, 1
	GOTO       L_padrao341
;FairyLights16F628A.c,182 :: 		portb.f4 =0;    //led apagado
	BCF        PORTB+0, 4
;FairyLights16F628A.c,183 :: 		delay_ms(150);  //espera um tempo de 150ms = 0.15s
	MOVLW      195
	MOVWF      R12+0
	MOVLW      205
	MOVWF      R13+0
L_padrao342:
	DECFSZ     R13+0, 1
	GOTO       L_padrao342
	DECFSZ     R12+0, 1
	GOTO       L_padrao342
;FairyLights16F628A.c,184 :: 		portb.f3 =1; //acende led
	BSF        PORTB+0, 3
;FairyLights16F628A.c,185 :: 		delay_ms(150);  //espera um tempo de 150ms = 0.15s
	MOVLW      195
	MOVWF      R12+0
	MOVLW      205
	MOVWF      R13+0
L_padrao343:
	DECFSZ     R13+0, 1
	GOTO       L_padrao343
	DECFSZ     R12+0, 1
	GOTO       L_padrao343
;FairyLights16F628A.c,186 :: 		portb.f3 =0;    //led apagado
	BCF        PORTB+0, 3
;FairyLights16F628A.c,187 :: 		delay_ms(150);  //espera um tempo de 150ms = 0.15s
	MOVLW      195
	MOVWF      R12+0
	MOVLW      205
	MOVWF      R13+0
L_padrao344:
	DECFSZ     R13+0, 1
	GOTO       L_padrao344
	DECFSZ     R12+0, 1
	GOTO       L_padrao344
;FairyLights16F628A.c,188 :: 		portb.f2 =1; //acende led
	BSF        PORTB+0, 2
;FairyLights16F628A.c,189 :: 		delay_ms(150);  //espera um tempo de 150ms = 0.15s
	MOVLW      195
	MOVWF      R12+0
	MOVLW      205
	MOVWF      R13+0
L_padrao345:
	DECFSZ     R13+0, 1
	GOTO       L_padrao345
	DECFSZ     R12+0, 1
	GOTO       L_padrao345
;FairyLights16F628A.c,190 :: 		portb.f2 =0;    //led apagado
	BCF        PORTB+0, 2
;FairyLights16F628A.c,191 :: 		delay_ms(150);  //espera um tempo de 150ms = 0.15s
	MOVLW      195
	MOVWF      R12+0
	MOVLW      205
	MOVWF      R13+0
L_padrao346:
	DECFSZ     R13+0, 1
	GOTO       L_padrao346
	DECFSZ     R12+0, 1
	GOTO       L_padrao346
;FairyLights16F628A.c,192 :: 		portb.f1 =1; //acende led
	BSF        PORTB+0, 1
;FairyLights16F628A.c,193 :: 		delay_ms(150);  //espera um tempo de 150ms = 0.15s
	MOVLW      195
	MOVWF      R12+0
	MOVLW      205
	MOVWF      R13+0
L_padrao347:
	DECFSZ     R13+0, 1
	GOTO       L_padrao347
	DECFSZ     R12+0, 1
	GOTO       L_padrao347
;FairyLights16F628A.c,194 :: 		portb.f1 =0;    //led apagado
	BCF        PORTB+0, 1
;FairyLights16F628A.c,195 :: 		delay_ms(150);  //espera um tempo de 150ms = 0.15s
	MOVLW      195
	MOVWF      R12+0
	MOVLW      205
	MOVWF      R13+0
L_padrao348:
	DECFSZ     R13+0, 1
	GOTO       L_padrao348
	DECFSZ     R12+0, 1
	GOTO       L_padrao348
;FairyLights16F628A.c,196 :: 		portb.f0 =1; //acende led
	BSF        PORTB+0, 0
;FairyLights16F628A.c,197 :: 		delay_ms(150);  //espera um tempo de 150ms = 0.15s
	MOVLW      195
	MOVWF      R12+0
	MOVLW      205
	MOVWF      R13+0
L_padrao349:
	DECFSZ     R13+0, 1
	GOTO       L_padrao349
	DECFSZ     R12+0, 1
	GOTO       L_padrao349
;FairyLights16F628A.c,198 :: 		portb.f0 =0;    //led apagado
	BCF        PORTB+0, 0
;FairyLights16F628A.c,199 :: 		}
L_end_padrao3:
	RETURN
; end of _padrao3

_padrao4:

;FairyLights16F628A.c,201 :: 		void padrao4(){
;FairyLights16F628A.c,202 :: 		int i=0;
	CLRF       padrao4_i_L0+0
	CLRF       padrao4_i_L0+1
;FairyLights16F628A.c,203 :: 		apagaLeds();
	CALL       _apagaLeds+0
;FairyLights16F628A.c,204 :: 		portb.f0=1; //acende led
	BSF        PORTB+0, 0
;FairyLights16F628A.c,205 :: 		portb.f1=1; //acende led
	BSF        PORTB+0, 1
;FairyLights16F628A.c,206 :: 		portb.f2=1;  //acende led
	BSF        PORTB+0, 2
;FairyLights16F628A.c,207 :: 		portb.f3=1; //acende led
	BSF        PORTB+0, 3
;FairyLights16F628A.c,208 :: 		delay_ms(100);  //espera um tempo de 200ms = 0.2s
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_padrao450:
	DECFSZ     R13+0, 1
	GOTO       L_padrao450
	DECFSZ     R12+0, 1
	GOTO       L_padrao450
	NOP
	NOP
;FairyLights16F628A.c,209 :: 		while(i<5){
L_padrao451:
	MOVLW      128
	XORWF      padrao4_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__padrao482
	MOVLW      5
	SUBWF      padrao4_i_L0+0, 0
L__padrao482:
	BTFSC      STATUS+0, 0
	GOTO       L_padrao452
;FairyLights16F628A.c,210 :: 		portb.f4=1;
	BSF        PORTB+0, 4
;FairyLights16F628A.c,211 :: 		delay_ms(100);  //espera um tempo de 200ms = 0.2s
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_padrao453:
	DECFSZ     R13+0, 1
	GOTO       L_padrao453
	DECFSZ     R12+0, 1
	GOTO       L_padrao453
	NOP
	NOP
;FairyLights16F628A.c,212 :: 		portb.f4=0;
	BCF        PORTB+0, 4
;FairyLights16F628A.c,213 :: 		portb.f5=1;
	BSF        PORTB+0, 5
;FairyLights16F628A.c,214 :: 		delay_ms(100);  //espera um tempo de 200ms = 0.2s
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_padrao454:
	DECFSZ     R13+0, 1
	GOTO       L_padrao454
	DECFSZ     R12+0, 1
	GOTO       L_padrao454
	NOP
	NOP
;FairyLights16F628A.c,215 :: 		portb.f5=0;
	BCF        PORTB+0, 5
;FairyLights16F628A.c,216 :: 		portb.f6=1;
	BSF        PORTB+0, 6
;FairyLights16F628A.c,217 :: 		delay_ms(100);  //espera um tempo de 200ms = 0.2s
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_padrao455:
	DECFSZ     R13+0, 1
	GOTO       L_padrao455
	DECFSZ     R12+0, 1
	GOTO       L_padrao455
	NOP
	NOP
;FairyLights16F628A.c,218 :: 		portb.f6=0;
	BCF        PORTB+0, 6
;FairyLights16F628A.c,219 :: 		portb.f7=1;
	BSF        PORTB+0, 7
;FairyLights16F628A.c,220 :: 		delay_ms(100);  //espera um tempo de 200ms = 0.2s
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_padrao456:
	DECFSZ     R13+0, 1
	GOTO       L_padrao456
	DECFSZ     R12+0, 1
	GOTO       L_padrao456
	NOP
	NOP
;FairyLights16F628A.c,221 :: 		portb.f7=0;
	BCF        PORTB+0, 7
;FairyLights16F628A.c,222 :: 		i++;
	INCF       padrao4_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       padrao4_i_L0+1, 1
;FairyLights16F628A.c,223 :: 		}
	GOTO       L_padrao451
L_padrao452:
;FairyLights16F628A.c,224 :: 		i=0;
	CLRF       padrao4_i_L0+0
	CLRF       padrao4_i_L0+1
;FairyLights16F628A.c,225 :: 		apagaLeds();
	CALL       _apagaLeds+0
;FairyLights16F628A.c,226 :: 		portb.f7=1; //acende led
	BSF        PORTB+0, 7
;FairyLights16F628A.c,227 :: 		portb.f6=1; //acende led
	BSF        PORTB+0, 6
;FairyLights16F628A.c,228 :: 		portb.f5=1; //acende led
	BSF        PORTB+0, 5
;FairyLights16F628A.c,229 :: 		portb.f4=1; //acende led
	BSF        PORTB+0, 4
;FairyLights16F628A.c,230 :: 		delay_ms(100);  //espera um tempo de 100ms = 0.1s
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_padrao457:
	DECFSZ     R13+0, 1
	GOTO       L_padrao457
	DECFSZ     R12+0, 1
	GOTO       L_padrao457
	NOP
	NOP
;FairyLights16F628A.c,231 :: 		while(i<5){
L_padrao458:
	MOVLW      128
	XORWF      padrao4_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__padrao483
	MOVLW      5
	SUBWF      padrao4_i_L0+0, 0
L__padrao483:
	BTFSC      STATUS+0, 0
	GOTO       L_padrao459
;FairyLights16F628A.c,232 :: 		portb.f3=1;
	BSF        PORTB+0, 3
;FairyLights16F628A.c,233 :: 		delay_ms(100);  //espera um tempo de 100ms = 0.1s
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_padrao460:
	DECFSZ     R13+0, 1
	GOTO       L_padrao460
	DECFSZ     R12+0, 1
	GOTO       L_padrao460
	NOP
	NOP
;FairyLights16F628A.c,234 :: 		portb.f3=0;
	BCF        PORTB+0, 3
;FairyLights16F628A.c,235 :: 		portb.f2=1;
	BSF        PORTB+0, 2
;FairyLights16F628A.c,236 :: 		delay_ms(100);  //espera um tempo de 100ms = 0.1s
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_padrao461:
	DECFSZ     R13+0, 1
	GOTO       L_padrao461
	DECFSZ     R12+0, 1
	GOTO       L_padrao461
	NOP
	NOP
;FairyLights16F628A.c,237 :: 		portb.f2=0;
	BCF        PORTB+0, 2
;FairyLights16F628A.c,238 :: 		portb.f1=1;
	BSF        PORTB+0, 1
;FairyLights16F628A.c,239 :: 		delay_ms(100);  //espera um tempo de 100ms = 0.1s
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_padrao462:
	DECFSZ     R13+0, 1
	GOTO       L_padrao462
	DECFSZ     R12+0, 1
	GOTO       L_padrao462
	NOP
	NOP
;FairyLights16F628A.c,240 :: 		portb.f1=0;
	BCF        PORTB+0, 1
;FairyLights16F628A.c,241 :: 		portb.f0=1;
	BSF        PORTB+0, 0
;FairyLights16F628A.c,242 :: 		delay_ms(100);  //espera um tempo de 100ms = 0.1s
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_padrao463:
	DECFSZ     R13+0, 1
	GOTO       L_padrao463
	DECFSZ     R12+0, 1
	GOTO       L_padrao463
	NOP
	NOP
;FairyLights16F628A.c,243 :: 		portb.f0=0;
	BCF        PORTB+0, 0
;FairyLights16F628A.c,244 :: 		i++;
	INCF       padrao4_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       padrao4_i_L0+1, 1
;FairyLights16F628A.c,245 :: 		}
	GOTO       L_padrao458
L_padrao459:
;FairyLights16F628A.c,246 :: 		}
L_end_padrao4:
	RETURN
; end of _padrao4

_padrao5:

;FairyLights16F628A.c,248 :: 		void padrao5(){
;FairyLights16F628A.c,249 :: 		apagaLeds();
	CALL       _apagaLeds+0
;FairyLights16F628A.c,250 :: 		portb.f0=1; //acende led
	BSF        PORTB+0, 0
;FairyLights16F628A.c,251 :: 		portb.f7=1; //acende led
	BSF        PORTB+0, 7
;FairyLights16F628A.c,252 :: 		delay_ms(200); //espera um tempo de 0.2s
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_padrao564:
	DECFSZ     R13+0, 1
	GOTO       L_padrao564
	DECFSZ     R12+0, 1
	GOTO       L_padrao564
	DECFSZ     R11+0, 1
	GOTO       L_padrao564
	NOP
;FairyLights16F628A.c,253 :: 		portb.f0=0; //apaga led
	BCF        PORTB+0, 0
;FairyLights16F628A.c,254 :: 		portb.f7=0; //apaga led
	BCF        PORTB+0, 7
;FairyLights16F628A.c,255 :: 		portb.f1=1; //acende led
	BSF        PORTB+0, 1
;FairyLights16F628A.c,256 :: 		portb.f6=1; //acende led
	BSF        PORTB+0, 6
;FairyLights16F628A.c,257 :: 		delay_ms(200); //espera um tempo de 0.2s
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_padrao565:
	DECFSZ     R13+0, 1
	GOTO       L_padrao565
	DECFSZ     R12+0, 1
	GOTO       L_padrao565
	DECFSZ     R11+0, 1
	GOTO       L_padrao565
	NOP
;FairyLights16F628A.c,258 :: 		portb.f1=0; //apaga led
	BCF        PORTB+0, 1
;FairyLights16F628A.c,259 :: 		portb.f6=0; //apaga led
	BCF        PORTB+0, 6
;FairyLights16F628A.c,260 :: 		portb.f2=1; //acende led
	BSF        PORTB+0, 2
;FairyLights16F628A.c,261 :: 		portb.f5=1; //acende led
	BSF        PORTB+0, 5
;FairyLights16F628A.c,262 :: 		delay_ms(200); //espera um tempo de 0.2s
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_padrao566:
	DECFSZ     R13+0, 1
	GOTO       L_padrao566
	DECFSZ     R12+0, 1
	GOTO       L_padrao566
	DECFSZ     R11+0, 1
	GOTO       L_padrao566
	NOP
;FairyLights16F628A.c,263 :: 		portb.f2=0; //apaga led
	BCF        PORTB+0, 2
;FairyLights16F628A.c,264 :: 		portb.f5=0; //apaga led
	BCF        PORTB+0, 5
;FairyLights16F628A.c,265 :: 		portb.f3=1; //acende led
	BSF        PORTB+0, 3
;FairyLights16F628A.c,266 :: 		portb.f4=1; //acende led
	BSF        PORTB+0, 4
;FairyLights16F628A.c,267 :: 		delay_ms(200); //espera um tempo de 0.2s
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_padrao567:
	DECFSZ     R13+0, 1
	GOTO       L_padrao567
	DECFSZ     R12+0, 1
	GOTO       L_padrao567
	DECFSZ     R11+0, 1
	GOTO       L_padrao567
	NOP
;FairyLights16F628A.c,268 :: 		portb.f3=0; //apaga led
	BCF        PORTB+0, 3
;FairyLights16F628A.c,269 :: 		portb.f4=0; //apaga led
	BCF        PORTB+0, 4
;FairyLights16F628A.c,270 :: 		}
L_end_padrao5:
	RETURN
; end of _padrao5
