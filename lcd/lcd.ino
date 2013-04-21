#include <SoftwareSerial.h>


int incomingByte = 0;    // for incoming serial data

//SoftwareSerial LCD = SoftwareSerial(0, txPin);
SoftwareSerial *LCD = NULL;
// since the LCD does not send data back to the Arduino, we should only define the txPin

void setup()
{
 Serial.begin(9600);
 pinMode(2, OUTPUT);
  delete LCD;
  LCD = new SoftwareSerial(0, 2);
  LCD->begin(9600);
}

void loop()
{
 if (Serial.available() > 0) {
 // read the incoming byte:
  incomingByte = Serial.read();
 //Serial.write(incomingByte);
 //LCD->write(0x02);
 LCD->write('test');
 }
}

