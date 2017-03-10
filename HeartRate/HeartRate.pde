import java.io.*;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import nl.tue.id.oocsi.*;
import nl.tue.id.oocsi.client.*;
import nl.tue.id.oocsi.client.behavior.*;
import nl.tue.id.oocsi.client.behavior.state.*;
import nl.tue.id.oocsi.client.data.*;
import nl.tue.id.oocsi.client.protocol.*;
import nl.tue.id.oocsi.client.services.*;
import nl.tue.id.oocsi.client.socket.*;

/*TFC Group 1- Module Heart Rate
 *
 *
 */

//Declarations
SimpleDateFormat dateFormat = new SimpleDateFormat("MMMM dd, 'at' HH:mm");
String oocsiServer = "oocsi.id.tue.nl";
String oocsiChannel = "HeartRate";
String tagline1 = "Low/Calm";
String tagline2 = "Passive/Normal";
String tagline3 = "Active";
String tagline4 = "HyperActive";
List<String> taglists = new ArrayList<String>(2);
//Add Tags
   public void addTags() { 
       taglists.add("tagline1");
       taglists.add("tagline2");
       taglists.add("tagline3");
       taglists.add("tagline4");
   }

//OOCSI Setup
 void setup(){
  
  //Setup OOCSI
  OOCSI oocsi = new OOCSI(this, "heartRate", "oocsi.id.tue.nl");
  oocsi.subscribe("heartRate");
  
  //Set tags
 taglists.get(0);
 
  //Get Frame Rate
  frameRate(100); 
  textAlign(CENTER);
  rectMode(CENTER);
  ellipseMode(CENTER);  
   

//OOCSI Receiving client to be handled
OOCSIClient bpmReciever = new OOCSIClient("bpmReciever");
bpmReciever.connect("oocsi.id.tue.nl", 4500);
bpmReciever.subscribe("heartRate");

 }
//OOCSI event to be handled
public void heartRate(OOCSIEvent event) {

 //...............Declarations.........................................
 int BPM = 20; // seeded so the graph starts nice
 
 float[] powerPointX;      // array of power spectrum power points
 float[] powerPointY;
 int maxDots = 500;  // after this number of beats the oldest dots begin to disappear
 //................Extra functionality..................................

 //int beatCount = 0;
 // boolean firstTime = true;  
 // boolean flatLine = false;
 // boolean pulseData = false;
 //int IBI = 200; // inter beat interval in millis
  
//.................Formatting...........................................
int LabelSize = 24;
int WaveWindowX = 0; // start xposition of main waveform window
int BPMWindowWidth = 300;
int BPMWindowHeight = 200;
int BPMWindowY = 50;
int BPMxPos = 50;



//.................PHASE 2 : Needed for Ardruino............................
//Serial myPort; 
/* FIND THE ARDUINO
  println(Serial.list());    // print a list of available serial ports
  // choose the number between the [] that is connected to the Arduino
  port = new Serial(this, Serial.list()[0], 115200);  // make sure Arduino is talking serial at this baud rate
  port.clear();            // flush buffer
  port.bufferUntil('\n');  // set buffer full flag on receipt of carriage return
*/

//Setup 

//void setupMain() {
//Window cannot be resized by user since scaling will be affected
  surface.setResizable(false); 
  size(400, 300);
//Array holds number of dots protrayed before resetting of graph
  powerPointX = new float[maxDots];   
  powerPointY = new float[maxDots];
  
  for (int i=0; i<maxDots; i++) {      // startup values out of view
    powerPointX[i] = -10;
    powerPointY[i] = -10;
  }

  background(255);
  
  rect(1, WaveWindowX, width-3, height-WaveWindowX-2, 5); 
  strokeWeight(1.8);
  fill(0);
  rect(BPMWindowY-1, 30, BPMWindowWidth+1, BPMWindowHeight+1, 5); // bpm window
 
 // draw BPM scale
  text("0", BPMWindowY+1, WaveWindowX-15);
  text(BPMWindowWidth/2, BPMWindowY+ (BPMWindowWidth/2) - 15, WaveWindowX-15);
  text(BPMWindowWidth, BPMWindowY+ BPMWindowWidth - 15, WaveWindowX-15);
  text("20-", BPMWindowY-17, BPMWindowHeight+33);
  text("40-", BPMWindowY-17, BPMWindowHeight+33-20);
  text("60-", BPMWindowY-17, BPMWindowHeight+33-40);
  text("80-", BPMWindowY-17, BPMWindowHeight+33-60);
  text("100-", BPMWindowY-23, BPMWindowHeight+33-80);
  text("120-", BPMWindowY-23, BPMWindowHeight+33-100);
  text("140-", BPMWindowY-23, BPMWindowHeight+33-120);
  text("160-", BPMWindowY-23, BPMWindowHeight+33-140);
  text("180-", BPMWindowY-23, BPMWindowHeight+33-160);
  text("200-", BPMWindowY-23, BPMWindowHeight+33-180);
  text("220-", BPMWindowY-23, BPMWindowHeight+33-200);



//Draw graph 

//void draw() {
  
  // clear labels
  fill(255);
  rect(BPMWindowY, 0, BPMWindowWidth, 30, 5); // clear BPM label data
    
  //Set color Red and size for graph bars
  strokeWeight(1.8); 
  stroke(255, 0, 0);
  
  //Test value without Sensor attached
  //BPM = 120;
  
  int BPMmax = BPM-20;
  if (BPMmax > 220) // keeps line from drawing into title box
    BPMmax = 220;  

  line(BPMxPos, 229, BPMxPos, 230-BPMmax); // left to right+1;
 //Reset BPM 
  if (BPMxPos == BPMWindowWidth+BPMWindowY) 
  {
    stroke(0);
    fill(0);
    rect(BPMWindowY-1, 30, BPMWindowWidth+1, BPMWindowHeight+1, 5); 
    BPMxPos = BPMWindowY+1;
  }
  //Reset
  stroke(0);
  fill(0);

  textSize(LabelSize);
  text("BPM: "+ BPM, BPMWindowY + 10, 0, width, height);
  if(BPM <= 30) {
    taglists.get(0);
  } else { 
    if(BPM <= 80 && BPM > 30) {
      taglists.get(1);
    } else {
      if(BPM <=120 && BPM >80) {
        taglists.get(2);
      }
      else {
        if(BPM >120 && BPM <200){
        taglists.get(3);
      } else {
        println("Error : heart beat is out of bound");
      }
    }
  }
  }