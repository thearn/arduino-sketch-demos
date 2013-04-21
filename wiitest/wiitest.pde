/* This program is designed to allow two Wii Nunchucks to operate on the same I2C bus
by the use of 2 BJT transisters. This file includes a demenstration of each nunchuck
controlling their own LED by use of their z_button (made with arduino - 0010 Alpha), circuit schematic can be found at this forum:
http://www.wiimoteproject.com/tech-chat/2-nunchuck-with-arduino-help/
Nunchuks operate off of 3v3 supplied by arduino
First Few lines of twi.h edit...
#define ATMEGA8

#ifndef CPU_FREQ^M
#define CPU_FREQ 16000000L
#endif

#ifndef TWI_FREQ^M
#define TWI_FREQ 100000L
#endif

found at:
http://www.windmeadow.com/node/42

have fun

bd
(aka:johnnyonthespot)
*/
#include <Wire.h>
#include <string.h>

#undef int
#include <stdio.h>

uint8_t outbuf1[6];             // array to store nunchuck1 output
uint8_t outbuf2[6];		// array to store nunchuck2 output
int cnt = 0;                    // count to make sure 6 bytes are received from nunchuck
int nunPin1 = 8;                // Digital pin to select nunchuck1
int nunPin2 = 9;                // Digital pin to select nunchuck2
int led1 = 2;                   // Pin connected to LED1 (turns off when nunchuck1's z_button is pushed
int led2 = 3;                   // pin connected to LED2 (turns off when nunchuck2's z_button is pushed
int state = LOW;                // keeps tabs on which nunchuck is being read (Low = n1, High = n2)

void
setup ()
{  
  pinMode(nunPin1, OUTPUT);
  pinMode(nunPin2, OUTPUT);
  pinMode(led1, OUTPUT);
  pinMode(led2, OUTPUT);
  digitalWrite(nunPin1, HIGH);   // both nunchucks must start out high
  digitalWrite(nunPin2, HIGH);   //in order to initiate both at once
  Wire.begin ();		 // join i2c bus with address 0x52
  nunchuck_init ();              // send the initilization handshake
}

void
nunchuck_init ()
{
  Wire.beginTransmission (0x52);  // transmit to device 0x52
  Wire.send (0x40);		  // sends memory address
  Wire.send (0x00);		  // sends sent a zero.  
  Wire.endTransmission ();	  // stop transmitting
}

void
send_zero ()
{
  Wire.beginTransmission (0x52);	// transmit to device 0x52
  Wire.send (0x00);		// sends one byte
  Wire.endTransmission ();	// stop transmitting
}

void
change_nunchuck()      // Swaps between nunchucks
{
  if (state == LOW)
  {
    digitalWrite(nunPin1, LOW);
    digitalWrite(nunPin2,HIGH);
    state = HIGH;
  }
  else
  {
    digitalWrite(nunPin1, HIGH);
    digitalWrite(nunPin2,LOW);
    state = LOW;
  }
}

void
loop ()
{
 
  Wire.requestFrom (0x52, 6);	// request data from nunchuck
  while (Wire.available ())
    {
      outbuf1[cnt] = nunchuk_decode_byte (Wire.receive ());	// receive byte as an integer
      cnt++;
    }

  // If we recieved nunchuck1's 6 bytes, then go get nunchuck2's data
  if (cnt >= 5)
    {
      cnt = 0;
      change_nunchuck ();
      send_zero ();
      delay (10);        // This is necessary to ensure communication goes well
      
    Wire.requestFrom (0x52, 6);	// request data from nunchuck
    while (Wire.available ())
      {
        outbuf2[cnt] = nunchuk_decode_byte (Wire.receive ());	// receive byte as an integer
        cnt++;
      } 
    }

// if we received nunchuck2's 6 bytes, then output z_button status through LEDs
if (cnt >= 5)
{
  print ();
  change_nunchuck();
}
  cnt = 0;
  send_zero (); // send the request for next bytes
  delay (10);   //required
}

// Print the input data we have recieved
// accel data is 10 bits long
// so we read 8 bits, then we have to add
// on the last 2 bits.  That is why I
// multiply them by 2 * 2
void
print ()
{
//Nunchuck1's Data
  int joy_x_axis1 = outbuf1[0];
  int joy_y_axis1 = outbuf1[1];
  int accel_x_axis1 = outbuf1[2] * 2 * 2; 
  int accel_y_axis1 = outbuf1[3] * 2 * 2;
  int accel_z_axis1 = outbuf1[4] * 2 * 2;

  int z_button1 = 0;
  int c_button1 = 0;

//Nunchuck2's Data  
  int joy_x_axis2 = outbuf2[0];
  int joy_y_axis2 = outbuf2[1];
  int accel_x_axis2 = outbuf2[2] * 2 * 2; 
  int accel_y_axis2 = outbuf2[3] * 2 * 2;
  int accel_z_axis2 = outbuf2[4] * 2 * 2;

  int z_button2 = 0;
  int c_button2 = 0;

 // byte outbuf1[5] and outbuf2[5] contains bits for z and c buttons
 // it also contains the least significant bits for the accelerometer data
 // so we have to check each bit of byte outbufn[5]
  if ((outbuf1[5] >> 0) & 1)
    {
      z_button1 = 1;
    }
  if ((outbuf1[5] >> 1) & 1)
    {
      c_button1 = 1;
    }
    
if ((outbuf2[5] >> 0) & 1)
    {
      z_button2 = 1;
    }
    if ((outbuf2[5] >> 1) & 1)
    {
      z_button2 = 1;
    }

//Lights up corrosponding LEDs
  if (z_button1 == 1) 
  {  
    digitalWrite (led1, HIGH);    
  }
  else 
  {                               
    digitalWrite (led1, LOW);    
  }
  
  if (z_button2 == 1) 
  {  
    digitalWrite (led2, HIGH);    
  }
  else 
  {        
    digitalWrite (led2, LOW);    
  }  
}

// Encode data to format that most wiimote drivers except
// only needed if you use one of the regular wiimote drivers
char
nunchuk_decode_byte (char x)
{
  x = (x ^ 0x17) + 0x17;
  return x;
}
