//Feel free to use this code.
//Please be respectful by acknowledging the author in the code if you use or modify it.
//Author: Bruce Allen
//Date: 23/07/09

//Digital pin 7 for reading in the pulse width from the MaxSonar device.
//This variable is a constant because the pin will not change throughout execution of this code.
const int pwPin = 7; 
//variables needed to store values
float pulse, inches, cm;
int fpulse;
void setup() {

  //This opens up a serial connection to shoot the results back to the PC console
  Serial.begin(9600);
  pinMode(11, OUTPUT);
  digitalWrite(11, HIGH); 
}

void loop() {

  pinMode(pwPin, INPUT);
    //Used to read in the pulse that is being sent by the MaxSonar device.
  //Pulse Width representation with a scale factor of 147 uS per Inch.

  pulse = pulseIn(pwPin, HIGH);
  //fpulse=pulse;
  
  pulse = constrain(map(pulse, 809., 3200., 10.,1000. ),1,1001);
  Serial.println(pulse);
  //147uS per inch
  //inches = pulse/147;
  //change inches to centimetres
  //cm = inches * 2.54;
  /*
  Serial.print(inches);
  Serial.print("in, ");
  Serial.print(cm);
  Serial.print("cm");
  Serial.println();
  */
  delay(25);
}
