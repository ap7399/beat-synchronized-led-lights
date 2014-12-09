// color swirl! connect an RGB LED to the PWM pins as indicated
// in the #defines
// public domain, enjoy!
 
#define REDPIN 5
#define GREENPIN 6
#define BLUEPIN 3
#define FADESPEED 15
 
void setup() {
  pinMode(REDPIN, OUTPUT);
  pinMode(GREENPIN, OUTPUT);
  pinMode(BLUEPIN, OUTPUT);
  Serial.begin(19200);
}

int redValue, blueValue, greenValue;
int incominga, incomingb, incomingc;
int r, g, b, rout, gout, bout;

void loop() {
  if(Serial.available() > 0){//look for Serial data 
    incominga = Serial.read();//read and store teh value
 
       if (incominga > 99){
        rout = random(255);
        gout = random(255);
        bout = random(255);
       } else {
         if (rout > FADESPEED){
         rout = rout - FADESPEED;
         } else {rout = 0;}
         if (gout > FADESPEED){
         gout = gout - FADESPEED;
         } else {gout = 0;}
         if (bout > FADESPEED){
         bout = bout - FADESPEED;
         } else {bout = 0;}
       }
        analogWrite(REDPIN, rout);
        analogWrite(GREENPIN, gout);
        analogWrite(BLUEPIN, bout);
 
  }  
}
