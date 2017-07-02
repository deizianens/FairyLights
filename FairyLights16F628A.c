/*TRABALHO PRATICO 3
	DEIZIANE SILVA
	LORENA BARRETO
*/

// CONFIG
#pragma config WDTE = ON        // Watchdog Timer Enable bit (WDT enabled)
#pragma config PWRTE = OFF      // Power-up Timer Enable bit (PWRT disabled)
#pragma config MCLRE = ON       // MCLR Pin Function Select bit (MCLR pin is MCLR function and weak internal pull-up is enabled)
#pragma config CP = OFF         // Code Protection bit (Program memory is not code protected)
#pragma config WRT = OFF        // Flash Program Memory Self Write Enable bits (Write protection off)

#define S2 RA1_bit  //botão RA1
#define S3 RA2_bit	//botão RA2
#define S4 RA3_bit	//botão RA3
#define S5 RA4_bit	//botão RA4

// Lcd pinout settings
sbit LCD_RS at RB3_bit;
sbit LCD_EN at RB2_bit;
sbit LCD_D7 at RB7_bit; //pinos de dados
sbit LCD_D6 at RB6_bit; //pinos de dados
sbit LCD_D5 at RB5_bit; //pinos de dados
sbit LCD_D4 at RB4_bit; //pinos de dados

// Pin direction
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
	//IMPORTANTE: Deixar a chave led acionada na board e não a display
     Lcd_Init();
     Lcd_Cmd(_LCD_CLEAR);
     Lcd_Cmd(_LCD_CURSOR_OFF);
     init_io();

     while(1){
              padrao1(); //inicia com padrão 1 até que haja um interrupção e algum botão é pressionado
     }
}

//inicia os parametros
void init_io(){
     CMCON = 0x07;       //desabilita os comparadores
     OPTION_REG = 0x86;   //Timer0 incrementa com o ciclo de instruçao, prescaler 1:128
     GIE_bit = 0x01;     //habilita interrupção global
     PEIE_bit = 0x01;    //habilita interrupção por perifericos
     T0IE_bit = 0x01;    //habilita interrupção por timer0
     TMR0 = 0x6C;        //inicia o timer0
     
     trisa.f1 =1;	 //define porta a como entrada (porta dos botões)
     trisa.f2 =1;	//define porta a como entrada (porta dos botões)
     trisa.f3 =1;	//define porta a como entrada (porta dos botões)
     trisa.f4 =1;	//define porta a como entrada (porta dos botões)
     porta.f1 =1;	
     porta.f2 =1;
     porta.f3 =1;
     porta.f4 =1;
     
     trisb.f0 =0;    //define porta como saida (porta do led)
     trisb.f1 =0;    //define porta como saida (porta do led)
     trisb.f2 =0;    //define porta como saida (porta do led)
     trisb.f3 =0;    //define porta como saida (porta do led)
     trisb.f4 =0;    //define porta como saida (porta do led)
     trisb.f5 =0;    //define porta como saida (porta do led)
     trisb.f6 =0;    //define porta como saida (porta do led)
     trisb.f7 =0;    //define porta como saida (porta do led)
}

//essa função gera uma interrupção por overflow no timer0, serve para verificar se algum botão esta sendo pressionado assim que um padrão acaba de ser executado.
//é preciso ficar pressionando o botão até que a interrupção seja chamada
void interrupt(){  //verifica estouro (função do mikroc para tratamento de interrupções)
      if(T0IF_bit){ //caso haja estouro no timer0
            T0IF_bit = 0x00; //limpa flag
            TMR0 = 0x6C;     //inicia timer0 novamente

            if(!S2){ //caso RA1 seja pressionado
                while(S3 && S4 && S5){
                         padrao2(); //muda padrão dos leds
                }
              }
              else if(!S3){ //caso RA2 seja pressionado
                while(S2 && S4 && S5){
                         padrao3(); //muda padrão dos leds
                }
              }
              else if(!S4){ //caso RA3 seja pressionado
                while(S3 && S2 && S5){
                         padrao4(); //muda padrão dos leds
                }
              }
              else if(!S5){ //caso RA4 seja pressionado
                while(S3 && S4 && S2){
                         padrao5(); //muda padrão dos leds
                }
              }
      }
}

void apagaLeds(){
     portb.f0 =0;    //led apagado
     portb.f1 =0;    //led apagado
     portb.f2 =0;    //led apagado
     portb.f3 =0;    //led apagado
     portb.f4 =0;    //led apagado
     portb.f5 =0;    //led apagado
     portb.f6 =0;    //led apagado
     portb.f7 =0;    //led apagado
}

void acendeLeds(){
     portb.f0 =1; //acende led
     portb.f1 =1; //acende led
     portb.f2 =1; //acende led
     portb.f3 =1; //acende led
     portb.f4 =1; //acende led
     portb.f5 =1; //acende led
     portb.f6 =1; //acende led
     portb.f7 =1; //acende led
}

void padrao1(){
     acendeLeds();
     delay_ms(200);  //espera um tempo de 200ms = 0.2s
     apagaLeds();
     delay_ms(200);  //espera um tempo de 200ms = 0.2s
}

void padrao2(){
     apagaLeds();
     portb.f0 =1; //acende led
     portb.f1 =1; //acende led
     delay_ms(200);  //espera um tempo de 200ms = 0.2s
     portb.f0 =0;    //led apagado
     portb.f1 =0;    //led apagado
     delay_ms(200);  //espera um tempo de 200ms = 0.2s
     portb.f2 =1; //acende led
     portb.f3 =1; //acende led
     delay_ms(200);  //espera um tempo de 200ms = 0.2s
     portb.f2 =0;    //led apagado
     portb.f3 =0;    //led apagado
     delay_ms(200);  //espera um tempo de 200ms = 0.2s
     portb.f4 =1;    //led aceso
     portb.f5 =1; //acende led
     delay_ms(200);  //espera um tempo de 200ms = 0.2s
     portb.f5 =0;    //led apagado
     portb.f4 =0;    //led apagado
     delay_ms(200);  //espera um tempo de 200ms = 0.2s
     portb.f6 =1; //acende led
     portb.f7 =1; //acende led
     delay_ms(200);  //espera um tempo de 200ms = 0.2s
     portb.f6 =0;    //led apagado
     portb.f7 =0;    //led apagado
}

void padrao3(){
     apagaLeds();
     portb.f7 =1; //acende led
     delay_ms(150);  //espera um tempo de 150ms = 0.15s
     portb.f7 =0;    //led apagado
     delay_ms(150);  //espera um tempo de 150ms = 0.15s
     portb.f6 =1; //acende led
     delay_ms(150);  //espera um tempo de 150ms = 015s
     portb.f6 =0;    //led apagado
     delay_ms(150);  //espera um tempo de 150ms = 0.15s
     portb.f5 =1; //acende led
     delay_ms(150);  //espera um tempo de 150ms = 0.15s
     portb.f5 =0;    //led apagado
     delay_ms(150);  //espera um tempo de 150ms = 0.15s
     portb.f4 =1; //acende led
     delay_ms(150);  //espera um tempo de 150ms = 0.15s
     portb.f4 =0;    //led apagado
     delay_ms(150);  //espera um tempo de 150ms = 0.15s
     portb.f3 =1; //acende led
     delay_ms(150);  //espera um tempo de 150ms = 0.15s
     portb.f3 =0;    //led apagado
     delay_ms(150);  //espera um tempo de 150ms = 0.15s
     portb.f2 =1; //acende led
     delay_ms(150);  //espera um tempo de 150ms = 0.15s
     portb.f2 =0;    //led apagado
     delay_ms(150);  //espera um tempo de 150ms = 0.15s
     portb.f1 =1; //acende led
     delay_ms(150);  //espera um tempo de 150ms = 0.15s
     portb.f1 =0;    //led apagado
     delay_ms(150);  //espera um tempo de 150ms = 0.15s
     portb.f0 =1; //acende led
     delay_ms(150);  //espera um tempo de 150ms = 0.15s
     portb.f0 =0;    //led apagado
}

void padrao4(){
     int i=0;
     apagaLeds();
     portb.f0=1; //acende led
     portb.f1=1; //acende led
     portb.f2=1;  //acende led
     portb.f3=1; //acende led
     delay_ms(100);  //espera um tempo de 200ms = 0.2s
     while(i<5){
         portb.f4=1;
         delay_ms(100);  //espera um tempo de 200ms = 0.2s
         portb.f4=0;
         portb.f5=1;
         delay_ms(100);  //espera um tempo de 200ms = 0.2s
         portb.f5=0;
         portb.f6=1;
         delay_ms(100);  //espera um tempo de 200ms = 0.2s
         portb.f6=0;
         portb.f7=1;
         delay_ms(100);  //espera um tempo de 200ms = 0.2s
         portb.f7=0;
         i++;
     }
     i=0;
     apagaLeds();
     portb.f7=1; //acende led
     portb.f6=1; //acende led
     portb.f5=1; //acende led
     portb.f4=1; //acende led
     delay_ms(100);  //espera um tempo de 100ms = 0.1s
     while(i<5){
         portb.f3=1;
         delay_ms(100);  //espera um tempo de 100ms = 0.1s
         portb.f3=0;
         portb.f2=1;
         delay_ms(100);  //espera um tempo de 100ms = 0.1s
         portb.f2=0;
         portb.f1=1;
         delay_ms(100);  //espera um tempo de 100ms = 0.1s
         portb.f1=0;
         portb.f0=1;
         delay_ms(100);  //espera um tempo de 100ms = 0.1s
         portb.f0=0;
         i++;
     }
}

void padrao5(){
    apagaLeds();
    portb.f0=1; //acende led
    portb.f7=1; //acende led
    delay_ms(200); //espera um tempo de 0.2s
    portb.f0=0; //apaga led
    portb.f7=0; //apaga led
    portb.f1=1; //acende led
    portb.f6=1; //acende led
    delay_ms(200); //espera um tempo de 0.2s
    portb.f1=0; //apaga led
    portb.f6=0; //apaga led
    portb.f2=1; //acende led
    portb.f5=1; //acende led
    delay_ms(200); //espera um tempo de 0.2s
    portb.f2=0; //apaga led
    portb.f5=0; //apaga led
    portb.f3=1; //acende led
    portb.f4=1; //acende led
    delay_ms(200); //espera um tempo de 0.2s
    portb.f3=0; //apaga led
    portb.f4=0; //apaga led
}