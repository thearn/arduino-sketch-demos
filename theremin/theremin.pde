#include <SoftwareSerial.h>


#define txPin 3

SoftwareSerial LCD = SoftwareSerial(0, txPin); 

const int pwPin = 7; 
float pulse, inches, cm;
int fpulse;


float sum=0;	 // Variable to calculate SUM
int avgrange=60; // Quantity of values to average
float sensorValue; // Value for te average
int i,media,freq; // Variables
float inch,feet,d,d0; // Converted to cm
//const int buttonPin = 2;
float x=0;

int ledPin=13;

int potPin = 2;  
int val = 0;

void setup()
{
pinMode(txPin, OUTPUT); 
LCD.begin(9600); 
delay (1000); 
  //pinMode(12, OUTPUT);
  //pinMode(11, OUTPUT);
  pinMode(10, OUTPUT);
  pinMode(ledPin, OUTPUT);
  //digitalWrite(12, HIGH); 
   //digitalWrite(11, HIGH); 
  digitalWrite(10, HIGH); 
  pinMode(pwPin, INPUT);
LCDon();
 // To check what is being read on the Serial Port
}


void loop() {

//buttonState = digitalRead(buttonPin);
//clearLCD();

val = analogRead(potPin);
//pinMode(buttonPin, INPUT); 
freq=2000;
if (val<10){
   freq = pulseIn(pwPin, HIGH);
   inch=freq/147+2;
   delay(50);
 
  freq = constrain(map(freq, 809., 4000., 10.,2000. ),1,2001);
}
 if (val>10) {
 tone(8, val*4);
 selectLineOne();
 LCD.print("Freqwensy iz:");
  selectLineTwo();
LCD.print(val*4,DEC);
if (4*val<10) {LCD.print("   ");}
else if (4*val<100) {LCD.print("  ");}
else if (4*val<1000) {LCD.print(" ");}
LCD.print("Hz");

if (val*4<700){LCD.print("   ^__^");}
else if (val*4<1300){LCD.print("   ^__<");}
else {LCD.print("   >__<");}
 }
else if (freq>2000){
noTone(8);
digitalWrite(ledPin,LOW);
clearLCD();
}
else {
tone(8, freq);
digitalWrite(ledPin,HIGH);
 selectLineOne();
 LCD.print("Freqwensy iz:");
  selectLineTwo();
LCD.print(freq,DEC);
if (freq<10) {LCD.print("   ");}
else if (freq<100) {LCD.print("  ");}
else if (freq<1000) {LCD.print(" ");}
LCD.print("Hz  ");
LCD.print(inch,DEC);
LCD.print("in");
}


}

void selectLineOne(){ //puts the cursor at line 0 char 0. 
LCD.print(0xFE, BYTE); //command flag 
LCD.print(128, BYTE); //position 
} 
void selectLineTwo(){ //puts the cursor at line 0 char 0. 
LCD.print(0xFE, BYTE); //command flag 
LCD.print(192, BYTE); //position 
} 
void LCDon(){ //puts the cursor at line 0 char 0. 
LCD.print(0x7C, BYTE);
LCD.print(150, BYTE);
} 
void LCDoff(){ //puts the cursor at line 0 char 0. 
LCD.print(0x7C, BYTE);
LCD.print(128, BYTE);
} 
void clearLCD(){ 
LCD.print(0xFE, BYTE); //command flag 
LCD.print(0x01, BYTE); //clear command. 
delay(50); 
}



