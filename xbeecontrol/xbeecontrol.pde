int inByte;
void setup()
{
  Serial.begin(9600);
  pinMode(10, OUTPUT);    
}

void loop()
{
  if (Serial.available() > 0) {
    inByte = Serial.read();
    
    switch (inByte) {
    case 108:
    Serial.println(inByte);
    digitalWrite(10, HIGH);
    break;
    
    
    default:
    digitalWrite(10, LOW);
    Serial.println(inByte);
    break;
    }
  }
}

