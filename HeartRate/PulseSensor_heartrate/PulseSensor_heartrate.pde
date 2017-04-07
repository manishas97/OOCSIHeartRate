
/*
THIS PROGRAM WORKS WITH PulseSensorAmped_Arduino-Uno ARDUINO CODE
Group 1 - HeartBeat Module (TFC)
Manisha , Daan , Pleun , Stijn 
*/


import nl.tue.id.oocsi.*;
import java.util.ArrayList;
import java.util.*;
import processing.serial.*; //TALK WITH ARDUINO

int Sensor;      // HOLDS PULSE SENSOR DATA FROM ARDUINO
int BPM;         // HOLDS HEART RATE VALUE FROM ARDUINO
boolean beat=false;
PFont font; //FONT STYLE FOR SKETCHES
Serial port;   
String currentActivity;
String BPMval;
String labeledBPM;
String pizzaTags; //key for pizza tags
String caffeeTags; //key for caffee tags
String clockTags; //key for clock group tags
String pizza;  
String caffee;
String clock;
int output_type;
String mood;

String BPMrange;
OOCSI oocsi;

void setup() {
//....................FREUQNECY OF HOW OFTEN DATA IS SENT.....................//
   frameRate(1); 
   
//....................SKETCH SETUP............................................//
  size(200,200); 
  background(120);
  font = loadFont("Arial-BoldMT-24.vlw");
  textFont(font);
  textAlign(CENTER);  

//....................OOCSI SENDER CONnECTION...................................//
   oocsi = new OOCSI(this,"manisha786wegtwt68757","oocsi.id.tue.nl");
   oocsi.subscribe("SmartClock");
   oocsi.subscribe("coffee_channel");

//....................ARDUINO CONNECTION..........................................//
  println(Serial.list());    // print a list of available serial ports
  // choose the number between the [] that is connected to the Ardui9no
  port = new Serial(this, Serial.list()[0], 115200);  // make sure Arduino is talking serial at this baud rate
  port.clear();            // flush buffer
  port.bufferUntil('\n');  // set buffer full flag on receipt of carriage return
 
 
 //GROUPING BPM ACCORDING TO THE RANGE
 //NORMAL BPM IS 70-90
 if(BPM > 70 && BPM <=90){
    BPMrange = "normal";
 }
 else {
   //LOW BPM IS 30-70
    if(BPM > 30 && BPM <=70){
      BPMrange = "low";
   }
   else {
       //EXTREME LOW BPM IS 0-30
      if(BPM > 0 && BPM <=30){
       BPMrange = "extremelylow";
     }
     else {
        //HIGH IS 90-120
       if(BPM < 90 && BPM <=120){
        BPMrange = "high";
       }
       else {
        //EXTREMELY HIGH IS MORE THAN 120 
       if(BPM < 120){
        BPMrange = "extremelyhigh";
       }
       }
     } 
   }
 }
}
//Testing whether BPMrange functions correctly
 
void handleOOCSIEvent(OOCSIEvent event) {
  
  //SEND BPMrange to COFFEE group
  oocsi
  .channel("coffee_channel")
   //.data("BPMval",BPM)
       .data("range",BPMrange)
         .send();
  
  //CHECK FOR COFFEE ORDER
  int caffee_order = event.getInt("output_type", 0);
  if(beat == true){
  if(caffee_order == 1 && (BPMrange.equals("low") || BPMrange.equals("normal"))) {
    //int caffee_time_to_wait = event.getInt("caffee_time_to_wait", 0);
    //play coffee playlist       
      mood= "Chill";
     if(caffee_order == 4) {
    //int caffee_time_to_wait = event.getInt("caffee_time_to_wait", 0);
    //play coffee ready playlist       
    }
  }
  if(caffee_order == 1 && ( BPMrange.equals("normal") || BPMrange.equals("high"))) {
    //int caffee_time_to_wait = event.getInt("caffee_time_to_wait", 0);
    //play coffee playlist      
     if(caffee_order == 4) {
    //int caffee_time_to_wait = event.getInt("caffee_time_to_wait", 0);
    //play coffee ready playlist       
    }
     mood= "Focus";
  }  
   
  //SET MOODS FOR SMARTCLOCK ACTIVITY
 if(caffee_order == 4 && BPMrange.equals("extremelyhigh")){
   mood= "Stressed";
 }
 if(caffee_order == 4 && BPMrange.equals("low")){
   mood = "Calm";
 }
 if(BPMrange.equals("low")){
   mood = "Sad";
 }
 if(BPMrange.equals("extremelylow")){
   mood = "Alert: BPM is too low";
 }
 if(BPMrange.equals("high")) /*soemthing*/{
   mood = "Happy";
 }
 if(BPMrange.equals("extremelyhigh")) /*soemthing*/{
   mood = "Excited";
 }
  }
  //beat == false or malfunctioning
  else {
    if(caffee_order == 1){
      mood = "coffee";
    }
    else {
      mood = "no mood detected";
    }
  }  

 
 //REQUEST ACTIVITY AND SEND MOODS TO SMARTCLOCK 
oocsi
  .channel("SmartClock")
        .data("currentActivity", "retrieve")
          .data("returnChannel","HeartRateModule")
            .data("BPMval",BPM)
              .data("mood",mood)
            .send();

  //GET ACTIVITY STRING AND PLAY MUSIC
  currentActivity = event.getObject("currentActivity").toString(); 
  if(beat == false){
  while(currentActivity.equals("")){    
   //play music
    }
  while(currentActivity.equals("")){    
   //play music
    }
  while(currentActivity.equals("")){    
   //play music
    }
  }
  if(beat == true) {
    if(currentActivity != null){
      //play music based on current activity
  }
  else{
    //play music according to BPM
  
  }
}
}

void draw(){
  while (beat == true){
  println(BPM);
}
}

//............BEAT IS AN INACCURATE VALUE......................................//
boolean beatError(boolean beat, int maxBeat, int minBeat){
  //maxBeat and minBeat are set to so system gives error message
  beat = true;
  maxBeat = 200;
  minBeat = 0;
  
  if(BPM <= minBeat) {
   beat = false;
  }
 if(BPM > maxBeat) {
   beat = false;
  }
  
 return beat;
}

  