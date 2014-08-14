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
    int brightness = Serial.parseInt();
    if (Serial.read() == '\n') 
    {
      if (brightness >= 0 && brightness <= 255)
      {
        analogWrite(ledPin, brightness);
      }
      else
      {
        Serial.write("Please enter a brightness value from 0-255.\n");
      }
    }
  }
}
