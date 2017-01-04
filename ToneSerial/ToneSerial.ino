//Upload to Arduino Card from Arduino IDE to be able to interface with Processing.
//This sketch is designed to control the shield after receiving signal from the Processing sketch through serial communication //Upload this sketch on Arduino first before opening the Processing sketch // // - 06/25/2015 -
 
#include <stdio.h>
#include <stdlib.h>
#include <SPI.h>

const int slaveSelectPin = 10;
int volume;
int TONE;
int const strSize = 4;
char strValue[strSize];

void setup() { 
  //pinMode(14, INPUT);
  pinMode(18, INPUT);
  pinMode(slaveSelectPin, OUTPUT);
  //set pins to output for speaker on/off 
  //test for 13 pin
  //pinMode(13,OUTPUT);
  pinMode(4,OUTPUT);
  pinMode(5,OUTPUT);
  pinMode(6,OUTPUT);
  pinMode(7,OUTPUT);
  pinMode(14,OUTPUT);
  pinMode(15,OUTPUT);
  pinMode(16,OUTPUT);
  pinMode(17,OUTPUT);

  digitalWrite(4,LOW);
  digitalWrite(5,LOW);
  digitalWrite(6,LOW);
  digitalWrite(7,LOW);
  digitalWrite(14,LOW);
  digitalWrite(15,LOW);
  digitalWrite(16,LOW);
  digitalWrite(17,LOW);
  SPI.begin();

  Serial.begin(9600); // baud rate 
  Serial.flush(); } 

void loop() { 

if (Serial.available()){
  char ch = Serial.read();
  if (ch == 'n'){
    strValue[0] = '0';
    for (int i=1; i<strSize; i++){
      delay(5); // Delay for 5 ms so the next char has time to be received 

      ch = Serial.read();
      strValue[i]= ch;
    }
    TONE = atoi(strValue); 
  }
  else if (ch == 'v'){
    strValue[0] = '0';
    for (int i =1; i<strSize; i++){
      delay (5);
      ch = Serial.read();
      strValue[i] = ch;
    } 
    volume = atoi(strValue);
 
  }

  //This is for turning the pins on and off
  if (ch == 'a'){
    delay(5);
    //strValue[0] = '0';

    ch = Serial.read();
    if(ch == '0'){
      digitalWrite(4,HIGH);
      //digitalWrite(13,HIGH);
    }
    else if(ch == '1'){
      digitalWrite(5,HIGH);
    }
    else if(ch == '2'){
      digitalWrite(6,HIGH);
    }
    else if(ch == '3'){
      digitalWrite(7,HIGH);
    }
    else if(ch == '4'){
      digitalWrite(14,HIGH);
    }
    else if(ch == '5'){
      digitalWrite(15,HIGH);
    }
    else if(ch == '6'){
      digitalWrite(16,HIGH);
    }
    else if(ch == '7'){
      digitalWrite(17,HIGH);
    }
  }
  //off
  else if (ch == 'b'){
    delay(5);
    //strValue[0] = '0';

    ch = Serial.read();
    if(ch == '0'){
      digitalWrite(4,LOW);
      //digitalWrite(13,LOW);
    }
    else if(ch == '1'){
      digitalWrite(5,LOW);
    }
    else if(ch == '2'){
      digitalWrite(6,LOW);
    }
    else if(ch == '3'){
      digitalWrite(7,LOW);
    }
    else if(ch == '4'){
      digitalWrite(14,LOW);
    }
    else if(ch == '5'){
      digitalWrite(15,LOW);
    }
    else if(ch == '6'){
      digitalWrite(16,LOW);
    }
    else if(ch == '7'){
      digitalWrite(17,LOW);
    }
 
  }

  Serial.flush();
} 

digitalPotWrite(0,volume);

if (TONE>32){
 tone(8,TONE); 
}
else noTone(8);





} 

void digitalPotWrite(int address, int value) {
  // take the SS pin low to select the chip:
  digitalWrite(slaveSelectPin,LOW);
  //  send in the address and value via SPI:
  SPI.transfer(address);
  SPI.transfer(value);
  // take the SS pin high to de-select the chip:
  digitalWrite(slaveSelectPin,HIGH); 
}
