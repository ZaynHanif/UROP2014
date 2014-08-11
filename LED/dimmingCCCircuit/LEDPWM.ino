// Set brightness as a percentage (from 0-100)
int brightness = 10;

void setup() {
  // put your setup code here, to run once:
  pinMode(11,OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  /*digitalWrite (11, HIGH);
  delayMicroseconds(10*brightness);
  digitalWrite (11, LOW);
  delayMicroseconds (10*(100-brightness));
  */analogWrite(11,255);
}
