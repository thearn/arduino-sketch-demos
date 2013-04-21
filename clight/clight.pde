int inByte;
String cmd=' ';
void setup() {
  // initialize serial communication:
  Serial.begin(115200); 
   // initialize the LED pins:
        pinMode(2,OUTPUT);
        pinMode(3,OUTPUT);
        pinMode(4,OUTPUT);
}
//13 enter
//32 space
//127 bac
void loop() {
  // read the sensor:
  if (Serial.available() > 0) {
    inByte = Serial.read();
    // do something different depending on the character received.  
    // The switch statement expects single number values for each case;
    // in this exmaple, though, you're using single quotes to tell
    // the controller to get the ASCII value for the character.  For 
    // example 'a' = 97, 'b' = 98, and so forth:

    switch (inByte) {
    case 'a':
        digitalWrite(2, HIGH);
        digitalWrite(3, LOW);
        digitalWrite(4, LOW);
      break;
    case 'b':
        digitalWrite(3, HIGH);
        digitalWrite(2, LOW);
        digitalWrite(4, LOW);
      break;
    case 'c':
        digitalWrite(3, LOW);
        digitalWrite(2, LOW);
        digitalWrite(3, HIGH);
      break;
      case 'z':
        digitalWrite(2, LOW);
        digitalWrite(4, LOW);
        digitalWrite(3, LOW);
      break;
    } 
  }
}
