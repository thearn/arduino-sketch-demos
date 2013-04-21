
float x=0;

void setup()   {       
  Serial.begin(9600);  
  // initialize the digital pin as an output:
  pinMode(11, OUTPUT);
  digitalWrite(11,HIGH);  
 pinMode(12, INPUT);
 Serial.begin(9600);
 pinMode(13, OUTPUT);
}

void loop()                     
{  
 x=digitalRead(12);
 Serial.println(x);
 if (x==1.0)
 {digitalWrite(13,HIGH);}
 else {digitalWrite(13,LOW);}
}
