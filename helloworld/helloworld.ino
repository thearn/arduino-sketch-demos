
void setup()                    // run once, when the sketch starts
{
  Serial.begin(9600);           // set up Serial library at 9600 bps
}

void loop()                     // we need this to be here even though its empty
{
  delay(100);
  Serial.println("hi ");
}
