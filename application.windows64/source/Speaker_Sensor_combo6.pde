import processing.serial.*;
import cc.arduino.*;
import controlP5.*;
Arduino arduino;

int peakToPeak = 0;
int signalMax = 0;
int signalMin = 1024;
float volts = 0;  
float averageVolts;
float time;
int LastComPort;
float averageA;
float averageB;
float[][] sensorAdata = new float[251][4];
float ReadingA;
float ReadingB;
float highReadingA;
float highReadingB;
float sampleTime;
int i =0;
float DataA = 0;
float DataB = 0;
int xPos = 600;
int sample;


void setup(){
  size(850,800);
  println(Arduino.list());
  String[] arduinoList = Arduino.list();
  LastComPort = (arduinoList.length-1);
  println (arduinoList.length-1);
  
  arduino = new Arduino(this,Arduino.list()[LastComPort], 57600);
 
  time = millis();
   arduino.pinMode(5, Arduino.INPUT);//setup pins to be input (A0 =0?)
   arduino.pinMode(3, Arduino.OUTPUT);
   arduino.pinMode(0, Arduino.INPUT);
   arduino.pinMode(1, Arduino.INPUT);

  for(int i=0; i<250; i++){
    for(int j=0; j<4; j++){
      sensorAdata[i][j] = 0;
    }
  }
  background(0);
  time = millis();
  sampleTime = millis();
}

void draw(){

 stroke(250,0,0);
 line(0.70*width, height, 0.70*width,0);
 line(0.70*width, height/4, width,height/4);
 line(0.70*width, height/2, width, height/2);
 line(0.70*width, 0.75*height, width, 0.75*height);


arduino.digitalWrite(3,Arduino.HIGH);
//else arduino.digitalWrite(3,Arduino.LOW);

  
ReadingA = arduino.analogRead(5);
ReadingB = arduino.analogRead(1);
sample = arduino.analogRead(0);

if (ReadingA > highReadingA && ReadingA < 1024) highReadingA = ReadingA;
if (ReadingB > highReadingB && ReadingB < 1024) highReadingB = ReadingB;
if (sample < 1024 && sample >signalMax) signalMax = sample;
if (sample < 1024 && sample < signalMin) signalMin = sample;

if (millis() > time+50){
  DataA = DataA + highReadingA;
  DataB = DataB + highReadingB;
  peakToPeak = signalMax - signalMin;
  volts = volts + peakToPeak;
  highReadingA = 0;
  highReadingB = 0;
  signalMax = 0;
  signalMin = 1024;
  i=i+1;
  time = millis();
  
}

if(millis()>sampleTime + 1000){
 averageA = DataA/i;
 averageB = DataB/i;
 averageVolts= 3.3*(volts/i);
 stroke(127,34,255);
 averageA = averageA-100;
 averageA = map(averageA, 0 , 400, 0, height/4);
 averageB = map(averageB, 0, 300, 0, height/4);
 averageVolts = map(averageVolts, 0, 400, 0, height/4);
 line(xPos, height/4, xPos, height/4-averageA);
 line(xPos, 3*height/4, xPos, 3*height/4-averageB);
 sensorAdata[xPos-600][0] = millis();
 /*
This draw method has the graphs stacked on top of one another.
Whe I export the program and run it on a laptop the screen gets resized.
The new window is too small and the output from one graph goes into the next!
Reorder the plots to be next to each other horizontally.

*/
 sensorAdata[xPos-600][1] = averageA;
 sensorAdata[xPos-600][2] = averageVolts;
 sensorAdata[xPos-600][3] = averageB;
 line (xPos, height/2, xPos, height/2-averageVolts);

 stroke(255,0,0);

 println (averageA);
 println (averageVolts);
 signalMax = 0;
 signalMin = 1024;
 volts = 0;
 highReadingA = 0;
 highReadingB = 0;
 DataA = 0;
 DataB = 0;
 i = 0;

 time = sampleTime = millis(); 
 xPos++;

}
  
if (xPos >= width){
 String[] eachrow = new String[250];
 for(int i=0; i<250; i++){
  eachrow[i] = sensorAdata[i][0]+ " "+sensorAdata[i][1] +" "+ sensorAdata[i][2] +" "+ sensorAdata[i][3];
  sensorAdata[i][0] = sensorAdata[i][1] = sensorAdata[i][2] = 0;
 }
saveStrings("data/sensorA.txt",eachrow); 
 xPos = 600;
 background(0);
}
  
}