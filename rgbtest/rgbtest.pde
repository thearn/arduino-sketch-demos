void setup() {
  // initialize serial communication:
   // initialize the LED pins:
        pinMode(2,OUTPUT);//red
        pinMode(3,OUTPUT);//green
        pinMode(4,OUTPUT);//blue
}
//13 enter
//32 space
//127 bac
void loop() {
  // read the sensor:
  //yellow: 250,80,100
  //red:255 0 0
  //green:0 255 0
  //blue:0 0 255
  
  
  analogWrite(2, 255);
  analogWrite(3, 0);
  analogWrite(4, 150);

}
