const int ledPin = 11;

void setup() {
  // put your setup code here, to run once: 
  pinMode(ledPin,OUTPUT);
  digitalWrite(ledPin, LOW);
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:  
  while(Serial.available()>0)
  {
    int b1=Serial.parseInt();
    if (Serial.read() == '\n') 
    {
      if(b1==1)
      {
        digitalWrite(ledPin, HIGH);
      }
      else
        digitalWrite(ledPin, LOW);
    }
  }
  /*analogWrite(ledPin, 10);
  delay(5000);
  analogWrite(ledPin, 50);
  delay(5000);
  analogWrite(ledPin, 100);
  delay(5000);
  analogWrite(ledPin, 150);
  delay(5000);
  analogWrite(ledPin, 200);
  delay(5000);
  analogWrite(ledPin, 250);
  delay(5000);*/
}
