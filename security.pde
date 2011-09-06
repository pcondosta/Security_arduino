#include <Wire.h>
#include <inttypes.h>
#include <LCDi2cNHD.h>                    
#include <avr/eeprom.h>
LCDi2cNHD lcd = LCDi2cNHD(2,16,0x50>>1,0);

uint8_t rows = 2;
uint8_t cols = 16;
int buttonPin = 2;
int rfidSense = 4;
int fdState = 5;
int bsdrState = 6;
int bslrState = 7;
int secState = 8;
int buttonState = 0;
int security = 0;

void setup() {
  lcd.init();
  
  lcd.clear();
  pinMode(buttonPin, INPUT);
  pinMode(secState, OUTPUT);
  pinMode(rfidSense, INPUT);
  pinMode(fdState, INPUT);
  pinMode(bsdrState, INPUT);
  pinMode(bslrState, INPUT);
  eeprom_read_block((void*)&security, (void*)0, sizeof(security));
}

void loop()
{
  buttonState = digitalRead(buttonPin);

  if (buttonState == HIGH)
  {
    if (security)
    {
      security = 0;
      digitalWrite(ledPin, LOW);
      lcd.clear();
      eeprom_write_block((const void*)&security, (void*)0, sizeof(security));
    }
    else
    {
      security = 1;
      digitalWrite(ledPin, HIGH);
      lcd.clear();
      eeprom_write_block((const void*)&security, (void*)0, sizeof(security));
    }
  }
  lcd.setCursor(0,0);
  lcd.print("Security System");
  lcd.setCursor(1,0);
  if (security)
    lcd.print("Status: ARMED");
  else
    lcd.print("Status: DISARMED");
}
