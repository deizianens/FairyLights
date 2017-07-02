#line 1 "C:/TP3/FairyLights16F628A.c"
#pragma config WDTE = ON
#pragma config PWRTE = OFF
#pragma config MCLRE = ON
#pragma config CP = OFF
#pragma config WRT = OFF
#line 14 "C:/TP3/FairyLights16F628A.c"
sbit LCD_RS at RB3_bit;
sbit LCD_EN at RB2_bit;
sbit LCD_D7 at RB7_bit;
sbit LCD_D6 at RB6_bit;
sbit LCD_D5 at RB5_bit;
sbit LCD_D4 at RB4_bit;


sbit LCD_RS_Direction at TRISB3_bit;
sbit LCD_EN_Direction at TRISB2_bit;
sbit LCD_D7_Direction at TRISB7_bit;
sbit LCD_D6_Direction at TRISB6_bit;
sbit LCD_D5_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB4_bit;

void init_io();
void padrao1();
void padrao2();
void padrao3();
void padrao4();
void padrao5();
void apagaLeds();
void acendeLeds();
void interrupt();

void main() {

 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 init_io();

 while(1){

 padrao1();

 }
}


void init_io(){
 CMCON = 0x07;
 OPTION_REG = 0x86;
 GIE_bit = 0x01;
 PEIE_bit = 0x01;
 T0IE_bit = 0x01;
 TMR0 = 0x6C;

 trisa.f1 =1;
 trisa.f2 =1;
 trisa.f3 =1;
 trisa.f4 =1;
 porta.f1 =1;
 porta.f2 =1;
 porta.f3 =1;
 porta.f4 =1;

 trisb.f0 =0;
 trisb.f1 =0;
 trisb.f2 =0;
 trisb.f3 =0;
 trisb.f4 =0;
 trisb.f5 =0;
 trisb.f6 =0;
 trisb.f7 =0;
}


void interrupt(){
 if(T0IF_bit){
 T0IF_bit = 0x00;
 TMR0 = 0x6C;

 if(! RA1_bit ){
 while( RA2_bit  &&  RA3_bit  &&  RA4_bit ){
 padrao2();
 }
 }
 else if(! RA2_bit ){
 while( RA1_bit  &&  RA3_bit  &&  RA4_bit ){
 padrao3();
 }
 }
 else if(! RA3_bit ){
 while( RA2_bit  &&  RA1_bit  &&  RA4_bit ){
 padrao4();
 }
 }
 else if(! RA4_bit ){
 while( RA2_bit  &&  RA3_bit  &&  RA1_bit ){
 padrao5();
 }
 }
 }
}

void apagaLeds(){
 portb.f0 =0;
 portb.f1 =0;
 portb.f2 =0;
 portb.f3 =0;
 portb.f4 =0;
 portb.f5 =0;
 portb.f6 =0;
 portb.f7 =0;
}

void acendeLeds(){
 portb.f0 =1;
 portb.f1 =1;
 portb.f2 =1;
 portb.f3 =1;
 portb.f4 =1;
 portb.f5 =1;
 portb.f6 =1;
 portb.f7 =1;
}

void padrao1(){
 acendeLeds();
 delay_ms(200);
 apagaLeds();
 delay_ms(200);
}

void padrao2(){
 apagaLeds();
 portb.f0 =1;
 portb.f1 =1;
 delay_ms(200);
 portb.f0 =0;
 portb.f1 =0;
 delay_ms(200);
 portb.f2 =1;
 portb.f3 =1;
 delay_ms(200);
 portb.f2 =0;
 portb.f3 =0;
 delay_ms(200);
 portb.f4 =1;
 portb.f5 =1;
 delay_ms(200);
 portb.f5 =0;
 portb.f4 =0;
 delay_ms(200);
 portb.f6 =1;
 portb.f7 =1;
 delay_ms(200);
 portb.f6 =0;
 portb.f7 =0;
}

void padrao3(){
 apagaLeds();
 portb.f7 =1;
 delay_ms(150);
 portb.f7 =0;
 delay_ms(150);
 portb.f6 =1;
 delay_ms(150);
 portb.f6 =0;
 delay_ms(150);
 portb.f5 =1;
 delay_ms(150);
 portb.f5 =0;
 delay_ms(150);
 portb.f4 =1;
 delay_ms(150);
 portb.f4 =0;
 delay_ms(150);
 portb.f3 =1;
 delay_ms(150);
 portb.f3 =0;
 delay_ms(150);
 portb.f2 =1;
 delay_ms(150);
 portb.f2 =0;
 delay_ms(150);
 portb.f1 =1;
 delay_ms(150);
 portb.f1 =0;
 delay_ms(150);
 portb.f0 =1;
 delay_ms(150);
 portb.f0 =0;
}

void padrao4(){
 int i=0;
 apagaLeds();
 portb.f0=1;
 portb.f1=1;
 portb.f2=1;
 portb.f3=1;
 delay_ms(100);
 while(i<5){
 portb.f4=1;
 delay_ms(100);
 portb.f4=0;
 portb.f5=1;
 delay_ms(100);
 portb.f5=0;
 portb.f6=1;
 delay_ms(100);
 portb.f6=0;
 portb.f7=1;
 delay_ms(100);
 portb.f7=0;
 i++;
 }
 i=0;
 apagaLeds();
 portb.f7=1;
 portb.f6=1;
 portb.f5=1;
 portb.f4=1;
 delay_ms(100);
 while(i<5){
 portb.f3=1;
 delay_ms(100);
 portb.f3=0;
 portb.f2=1;
 delay_ms(100);
 portb.f2=0;
 portb.f1=1;
 delay_ms(100);
 portb.f1=0;
 portb.f0=1;
 delay_ms(100);
 portb.f0=0;
 i++;
 }
}

void padrao5(){
 apagaLeds();
 portb.f0=1;
 portb.f7=1;
 delay_ms(200);
 portb.f0=0;
 portb.f7=0;
 portb.f1=1;
 portb.f6=1;
 delay_ms(200);
 portb.f1=0;
 portb.f6=0;
 portb.f2=1;
 portb.f5=1;
 delay_ms(200);
 portb.f2=0;
 portb.f5=0;
 portb.f3=1;
 portb.f4=1;
 delay_ms(200);
 portb.f3=0;
 portb.f4=0;
}
