/*
 *  Alternating switch
 */

int switchPin = 2;              // switch is connected to pin 2
int val;                        // variable for reading the pin status
int buttonState;                // variable to hold the last button state
int ledPin=12;
int x=0;
void setup() {
  pinMode(switchPin, INPUT);
pinMode(ledPin, OUTPUT);
Serial.begin(9600);         
  buttonState = digitalRead(switchPin);
}


void loop(){
  val = digitalRead(switchPin);      // read input value and store it in val

  if (val != buttonState) {          // the button state has changed!
    if (val == LOW) {                // check if the button is pressed
      Serial.println("Button just pressed");
      
      if (x==0) {digitalWrite(ledPin, LOW);x=1;}
      
      else {digitalWrite(ledPin, HIGH);x=0;}
      
            
    } else {                         // the button is -not- pressed...
      Serial.println("Button just released");
    }
  }

  buttonState = val;                 // save the new state in our variable
}
