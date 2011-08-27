#include <Wire.h>
#include <inttypes.h>
#include <LCDi2cNHD.h>                    
LCDi2cNHD lcd = LCDi2cNHD(2,16,0x50>>1,0);

uint8_t rows = 2;
uint8_t cols = 16;
int buttonPin = 2;
int ledPin = 5;
int buttonState = 0;
int security = 0;

void setup() {
  lcd.init();
  
  lcd.clear();
  pinMode(buttonPin, INPUT);
  pinMode(ledPin, OUTPUT);
}

void loop()
{
  buttonState = digitalRead(buttonPin);

  if (buttonState == HIGH)
  {
    if (security == 0)
    {
      security = 1;
      lcd.clear();
    }
    else if (security == 1)
    {
      security = 0;
      lcd.clear();
    }
  }
  if (security == 0)
  {
    lcd.setCursor(0,0);
    lcd.print("Security System");
    lcd.setCursor(1,0);
    lcd.print("Status: OFF");
    digitalWrite(ledPin, LOW);
  }
  else
  {
    lcd.setCursor(0,0);
    lcd.print("Security System");
    lcd.setCursor(1,0);
    lcd.print("Status: ON");
    digitalWrite(ledPin, HIGH);
  }
}
