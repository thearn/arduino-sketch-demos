/***********************
 Bluetooth test program
***********************/

int counter = 0;
int incomingByte;

void setup() {
  Serial.begin(115200);
}

void loop() {
  // see if there's incoming serial data:
  if (Serial.available() > 0) {
    // read the oldest byte in the serial buffer:
    incomingByte = Serial.read();
    // if it's a capital R, reset the counter
    if (incomingByte == 'R') {
      Serial.println("RESET");
      counter=0;
    }
  }
  
  Serial.println(counter);
  counter++;
  
  delay(250);
}
