

int yPin =  12;
int bPin =  11;
int gPin =  10;


// The setup() method runs once, when the sketch starts

void setup()   {                
  // initialize the digital pin as an output:
  pinMode(yPin, OUTPUT);
pinMode(bPin, OUTPUT);    
pinMode(gPin, OUTPUT);    
}

// the loop() method runs over and over again,
// as long as the Arduino has power

void loop()                     
{
  digitalWrite(yPin, HIGH);
  digitalWrite(bPin, LOW);
  digitalWrite(gPin, LOW);
  delay(500);                  

  digitalWrite(yPin, LOW);
  digitalWrite(bPin, HIGH);
  digitalWrite(gPin, LOW);
  delay(500);       
  
  digitalWrite(yPin, LOW);
  digitalWrite(bPin, LOW);
  digitalWrite(gPin, HIGH);
  delay(500);       
}
