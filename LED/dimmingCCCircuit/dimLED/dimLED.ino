// To set brightness pass integer '0' along with brightness value
// To get brightness pass integer '1'
// Run LED test sequency pass integer '2'

const int ledPin = 11;

void setup() {
  // put your setup code here, to run once:
  pinMode(ledPin,OUTPUT);
  digitalWrite(ledPin, LOW);
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  // Variable to store current brightness
  static int brightnessLevel = 0;
  
  if (Serial.available() > 0)
  {
    int instruction = Serial.parseInt();
    
    // Set the brightness level
    if (instruction == 0)
    {
      int brightness = Serial.parseInt();
      brightnessLevel = brightness;
      
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
    
    // Get the current brightness level
    if (instruction == 1)
    {
      Serial.println(brightnessLevel);
    }
    
    // Run LED test sequency
    if (instruction == 2)
    {
      for(int i = 0 ; i <= 255; i+=1) 
      {
        analogWrite(ledPin, i);
        delay(2);
      }
      
      for(int i = 255 ; i >= 0; i-=1) 
      {
        analogWrite(ledPin, i);
        delay(2);
      }
    }
  }
}
