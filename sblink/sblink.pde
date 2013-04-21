int inByte;
String cmd=' ';
void setup() {
  // initialize serial communication:
  Serial.begin(115200); 
   // initialize the LED pins:
        pinMode(13,OUTPUT);
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
    case 127:
      Serial.println("Cleared");    
      cmd=' ';
      break;
    case 13:
      cmd=cmd.substring(1);
      //Serial.println(cmd);
      if (cmd=="red"){
        digitalWrite(13, HIGH);
        digitalWrite(12, LOW);
        digitalWrite(11, LOW);}
      else if (cmd=="blue"){
        digitalWrite(13, LOW);
        digitalWrite(12, HIGH);
        digitalWrite(11, LOW);}
      else if (cmd=="green"){
        digitalWrite(13, LOW);
        digitalWrite(12, LOW);
        digitalWrite(11, HIGH);}
      else if (cmd=="off"){
        digitalWrite(13, LOW);
        digitalWrite(12, LOW);
        digitalWrite(11, LOW);}
      cmd=' ';
      break;

default:
    //Serial.println(inByte);
    char mychar=inByte;
    cmd+=String(mychar);
    } 
  }
}
