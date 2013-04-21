
int blinkLed=13; // Where the led will blink
int sensorPin=0; // Analog Pin In
int sum=0;	 // Variable to calculate SUM
int avgrange=50; // Quantity of values to average
int sensorValue; // Value for te average
int i,media,d; // Variables
float cm,inch; // Converted to cm

void setup()
{
  pinMode(12, OUTPUT);
  digitalWrite(12, HIGH); 
Serial.begin(9600); // To check what is being read on the Serial Port
}

void loop() {

d=analogRead(sensorPin); // Read the analog value
//digitalWrite(blinkLed,HIGH); // Turn on LED
delay(50); // Delay changes with the analogread
//digitalWrite(13,LOW); // Turn off LED
//delay(d);	 // Another delay

cm = (d / 2) * 2.4; // Convert the value to centimeters
inch = d/2; // Value in inches

Serial.println(inch); //Print average of all measured values

// This is the code if you want to make an average of the read values

/*

for(i = 0; i < avgrange ; i++) {
sum+=analogRead(sensorPin);
delay(10);
}

media = sum/avgrange;
Serial.println(media); //Print average of all measured values

sum=0;
media=0;

*/

}
