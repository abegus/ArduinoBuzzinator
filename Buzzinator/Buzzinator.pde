import processing.serial.*; 
import cc.arduino.*;
import controlP5.*;
Arduino arduino;


int speed;
int[] speakerPower = new int[2];
//int sliderValue3 = 50;
//int sliderValue5 = 50;
ControlP5 cp5;

Radio[] buttonsA = new Radio[8];
Radio[] startStop = new Radio[2];

/* replace with new sliders */
Scrollbar NOTE;
Scrollbar VOLUME;

PImage img;
PImage img2;
int note, volume;
int lastComPort;
Serial serial; 
PFont font; 

void setup() {
 size(910,510); 
 println (Serial.list());
 lastComPort = (Serial.list().length -1);//find the last active Com port and assign it as the serial port
 String portName = Serial.list()[lastComPort]; 
 serial = new Serial(this,portName,9600); 
 println (portName);
 font = createFont("Calibri",24); 
 textFont(font); 
 //                      xpos,ypos,size,base color,fill color,ID number, array of others
 startStop[0] = new Radio(50,415,30, color(250), color(0), 0, startStop);//START
 //startStop[1] = new Radio(50,300,30, color(250), color(0),1,startStop);//STOP
 
 //change to the sliders 
 NOTE = new Scrollbar(40, 350, 550, 25,33,200);
 VOLUME = new Scrollbar(40, 450, 550, 25, 0, 255); 
 //cp5.addSlider("sliderValue3").setPosition(100,400).setRange(20,255).setWidth(500).setHeight(25);//onChange(sliderChanged());
 //cp5.addSlider("sliderValue5").setPosition(100,475).setRange(20,100).setWidth(500).setHeight(25);//onChange(sliderChanged());

  /* declare buttons for speakers 4-7, 14-17 (pins) */
  buttonsA[0] = new Radio(575,100,30, color(250), color(0),0,buttonsA);
  buttonsA[1] = new Radio(575,150,30, color(250), color(0),1,buttonsA);
  buttonsA[2] = new Radio(575,200,30, color(250), color(0),2,buttonsA); 
  buttonsA[3] = new Radio(575,250,30, color(250), color(0),3,buttonsA); 
  buttonsA[4] = new Radio(775,100,30, color(250), color(0),4,buttonsA); 
  buttonsA[5] = new Radio(775,150,30, color(250), color(0),2,buttonsA); 
  buttonsA[6] = new Radio(775,200,30, color(250), color(0),3,buttonsA); 
  buttonsA[7] = new Radio(775,250,30, color(250), color(0),4,buttonsA); 

  //for the bee picture
  img = loadImage("bee1.png");
  img2 = loadImage("z.png");
  
 } 

void draw() { 
  background(150);
  //background(255,221,000);
  textSize(64);
  fill(255);
  text("THE 'Buzzinator'", 50, 70);
  textSize(36);
  fill(0,0,255);
  text("Frequency",600, 375);
  text(note, 800, 375);
  text("Volume", 600, 475);
  text(volume, 800, 475); 
  textSize(28);
  text("Speaker pins 4-7, 14-17",560,50);
  textSize(18);
  fill(0);
  text("Bay 1",600,100);
  text("Bay 2",600,150);
  text("Bay 3",600,200);
  text("Bay 4",600,250);
  text("Bay 5",800,100);
  text("Bay 6",800,150);
  text("Bay 7",800,200);
  text("Bay 8",800,250);
  text("On / Off",75,420);
  textSize(12);
  //text("***Click on the Bee after you change the Volume/Frequency to update the settings",25,525);

  startStop[0].display();
 // startStop[1].display();
  buttonsA[0].display();
  buttonsA[1].display();
  buttonsA[2].display();
  buttonsA[3].display();
  buttonsA[4].display();
  buttonsA[5].display();
  buttonsA[6].display();
  buttonsA[7].display();
  NOTE.display();
  VOLUME.display();

  note = int(NOTE.getPos());
  volume = int (VOLUME.getPos());
  NOTE.update(mouseX,mouseY);
  VOLUME.update(mouseX,mouseY);

  //for bee picture
  image(img, 90, 85);
  image(img2, 325,100);
  img2.resize(100,100);
}
void mousePressed(){

  startStop[0].press(mouseX,mouseY);
  //startStop[1].press(mouseX,mouseY);
  buttonsA[0].press(mouseX,mouseY);
  buttonsA[1].press(mouseX,mouseY);
  buttonsA[2].press(mouseX,mouseY);
  buttonsA[3].press(mouseX,mouseY);
  buttonsA[4].press(mouseX,mouseY);
  buttonsA[5].press(mouseX,mouseY);
  buttonsA[6].press(mouseX,mouseY);
  buttonsA[7].press(mouseX,mouseY);
  
  
  NOTE.press(mouseX,mouseY);
  note = int(NOTE.getPos());
  VOLUME.press(mouseX,mouseY);
  volume = int (VOLUME.getPos());
 
  /*
  if (startStop[0].checked ){
      String n = "n"+note;
      serial.write(n);
    //serial.write("d051");
    
  }
  else{
    serial.write("n000");
  }
  
  // pins 4-7 on/off 14-17
  //if (startStop[1].checked) serial.write("n000");
  //pin4
  if(buttonsA[0].checked){
    serial.write("a0");
  }
  else{
    serial.write("b0");
  }
  //pin5
  if(buttonsA[1].checked){
    serial.write("a1");
  }
  else{
    serial.write("b1");
  }
  //pin6
  if(buttonsA[2].checked){
    serial.write("a2");
  }
  else{
    serial.write("b2");
  }
  //pin7
  if(buttonsA[3].checked){
    serial.write("a3");
  }
  else{
    serial.write("b3");
  }
  //pin14
  if(buttonsA[4].checked){
    serial.write("a4");
  }
  else{
    serial.write("b4");
  }
  //pin15
  if(buttonsA[6].checked){
    serial.write("a5");
  }
  else{
    serial.write("b5");
  }
  //pin16
  if(buttonsA[7].checked){
    serial.write("a6");
  }
  else{
    serial.write("b6");
  }
  //pin17
  if(buttonsA[4].checked){
    serial.write("a7");
  }
  else{
    serial.write("b7");
  }
  
  String v = "v"+volume;
  //serial.write("s");
  serial.write(v);
*/
}

void mouseReleased(){
  NOTE.release();
  VOLUME.release(); 
  //mousePressed();
  
 // NOTE.press(mouseX,mouseY);
  note = int(NOTE.getPos());
  //VOLUME.press(mouseX,mouseY);
  volume = int (VOLUME.getPos());
 
  
  if (startStop[0].checked ){
      String n = "n"+note;
      serial.write(n);
    //serial.write("d051");
    
  }
  else{
    serial.write("n000");
  }
  
  // pins 4-7 on/off 14-17
  //if (startStop[1].checked) serial.write("n000");
  //pin4
  if(buttonsA[0].checked){
    serial.write("a0");
  }
  else{
    serial.write("b0");
  }
  //pin5
  if(buttonsA[1].checked){
    serial.write("a1");
  }
  else{
    serial.write("b1");
  }
  //pin6
  if(buttonsA[2].checked){
    serial.write("a2");
  }
  else{
    serial.write("b2");
  }
  //pin7
  if(buttonsA[3].checked){
    serial.write("a3");
  }
  else{
    serial.write("b3");
  }
  //pin14
  if(buttonsA[4].checked){
    serial.write("a4");
  }
  else{
    serial.write("b4");
  }
  //pin15
  if(buttonsA[6].checked){
    serial.write("a5");
  }
  else{
    serial.write("b5");
  }
  //pin16
  if(buttonsA[7].checked){
    serial.write("a6");
  }
  else{
    serial.write("b6");
  }
  //pin17
  if(buttonsA[4].checked){
    serial.write("a7");
  }
  else{
    serial.write("b7");
  }
  
  String v = "v"+volume;
  //serial.write("s");
  serial.write(v);

}  