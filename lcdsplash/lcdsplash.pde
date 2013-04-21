//sets serial lcd splash screen

// 1)make sure tx of lcd is unplugged
// 2)change lines to whatever you want (see below)
// 3)upload sketch to board
// 4)power down board and plug in tx of lcd
// 5)power up board
// 6)reset to test after the screen goes blank (old splash - new splash - blank screen - reset to test)
#include <SoftwareSerial.h>
#define txPin 3 
SoftwareSerial LCD = SoftwareSerial(0, txPin); 
void setup()
{
  Serial.begin(9600);
  backlightOn();
  delay(100);
  clearLCD();
  selectLineOne();
  delay(100);
  LCD.print("Hello, Dave"); //type in the first line of the splash here (16 char max)
  selectLineTwo();
  delay(100);
  LCD.print("..."); //type the second line of the splash here (16 char max)
  delay(500);
  LCD.print(0x7C, BYTE); //these lines...
  LCD.print(10, BYTE); //set the splash to memory (this is the <control> j char or line feed
  delay(100);
  clearLCD();
}

void loop()
{
  delay(100);
}

void selectLineOne(){  //puts the cursor at line 0 char 0.
   Serial.print(0xFE, BYTE);   //command flag
   Serial.print(128, BYTE);    //position
}
void selectLineTwo(){  //puts the cursor at line 0 char 0.
   Serial.print(0xFE, BYTE);   //command flag
   Serial.print(192, BYTE);    //position
}
void clearLCD(){
   Serial.print(0xFE, BYTE);   //command flag
   Serial.print(0x01, BYTE);   //clear command.
}
void backlightOn(){  //turns on the backlight
    Serial.print(0x7C, BYTE);   //command flag for backlight stuff
    Serial.print(157, BYTE);    //light level.
}
void backlightOff(){  //turns off the backlight
    Serial.print(0x7C, BYTE);   //command flag for backlight stuff
    Serial.print(128, BYTE);     //light level for off.
}
void serCommand(){   //a general function to call the command flag for issuing all other commands
  Serial.print(0xFE, BYTE);
}
 
