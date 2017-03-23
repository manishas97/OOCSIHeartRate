
/*
THIS PROGRAM WORKS WITH PulseSensorAmped_Arduino-Uno ARDUINO CODE
Group 1 - HeartBeat Module (TFC)
Manisha , Daan , Pleun , Stijn 
*/


import nl.tue.id.oocsi.*;
import nl.tue.id.oocsi.client.*;
import nl.tue.id.oocsi.client.behavior.*;
import nl.tue.id.oocsi.client.behavior.state.*;
import nl.tue.id.oocsi.client.data.*;
import nl.tue.id.oocsi.client.protocol.*;
import nl.tue.id.oocsi.client.services.*;
import nl.tue.id.oocsi.client.socket.*;
import nl.tue.id.oocsi.OOCSIEvent;
 

import java.util.ArrayList;
import processing.serial.*; //TALK WITH ARDUINO

int Sensor;      // HOLDS PULSE SENSOR DATA FROM ARDUINO
int BPM;         // HOLDS HEART RATE VALUE FROM ARDUINO
boolean beat=false;
PFont font; //FONT STYLE FOR SKETCHES
Serial port;    

String BPMval;
String labeledBPM;
String pizzaTags; //key for pizza tags
String caffeeTags; //key for caffee tags
String clockTags; //key for clock group tags
String pizza;  
String caffee;
String clock;
OOCSI oocsi;
OOCSIClient bpmSender = new OOCSIClient("bpmSender");
//OOCSIClient bpmReciever = new OOCSIClient("bpmReciever");

void setup() {
//....................FREUQNECY OF HOW OFTEN DATA IS SENT.....................//
   frameRate(0.1); 
   
//....................SKETCH SETUP............................................//
  size(400,200); 
  background(120);
  font = loadFont("Arial-BoldMT-24.vlw");
  textFont(font);
  textAlign(CENTER);  
/*  
//....................OOCSI RECIEVER CLIENT ...................................//

bpmReciever.connect("localhost", 4444);
bpmReciever.subscribe("heartRateModule", new EventHandler(){
        public void receive(OOCSIEvent event) {
            //get labeledBPM with key BPMval
                //if(beat==false) {
                  //System.out.print("No heart beat");
                  //}   
                  System.out.println(event.getString("BPMval",labeledBPM));
      
                  //Please only use line that relates to your group
                      System.out.println(event.getString("pizzaTags",pizza));
                     //System.out.println(event.getString("caffeeTags","caffee"));
                     //System.out.println(event.getString("clockTags","clock"));
   }
});
*/
//....................OOCSI SENDER CONNECTION...................................//
bpmSender.connect("localhost",4444);
 // connect to OOCSI server 
 // with "heartRate" as my channel others can send data to 
   oocsi = new OOCSI(this,"heartRateModule","localhost");

//....................ARDUINO CONNECTION..........................................//
  println(Serial.list());    // print a list of available serial ports
  // choose the number between the [] that is connected to the Ardui9no
  port = new Serial(this, Serial.list()[0], 115200);  // make sure Arduino is talking serial at this baud rate
  port.clear();            // flush buffer
  port.bufferUntil('\n');  // set buffer full flag on receipt of carriage return
 
}



//....................SEND TO OOCSI.........................................//
//.............USE RELEVANT KEY FOR YOUR MODULE.............................//

void draw() {
  new OOCSIMessage(bpmSender,"heartRateModule")
  //We send data through channel heartRateModule via client bpmSender
  // data sent is BPM values(recommened for each group)
  .data("BPMval",labeledBPM)
    //data sent is tags for pizza group
      .data("pizzaTags",pizza)
      //data sent is tags for caffee group
       .data("caffeeTags",caffee)
       //data sent is tags for clock group
         .data("clockTags",clock)
         //send this data via OOCSI
           .send();  
  
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

  
/*
For all Modules : we try to send out personalized tags.If you want your tags changed or, 
wish to be added,please contact a member of Group 1, TFC.
*/

//.........MAIN : assign correct values to tags and BPM.....................//

public void handleOOCSIEvent(OOCSIEvent event) {
 //setup of sketch
  background(0);
  noStroke(); 
   
   //Assigning tags into arraylists for each type of BPM
  ArrayList<String> lowBPM = new ArrayList<String>();
   lowBPM.add("sleeping");
   lowBPM.add("low");
  
  ArrayList<String> mediumBPM = new ArrayList<String>();
   mediumBPM.add("active");
   mediumBPM.add("medium");

  ArrayList<String> highBPM = new ArrayList<String>();
   highBPM.add("workout");
   highBPM.add("high"); 
  

//Assigning correct tags to BPM values for each module/group
 if(BPM == 50) {
   pizza = lowBPM.get(0); 
   caffee = lowBPM.get(1);
 // clock = lowBPM.get(2); 
}
 if(BPM > 50 && BPM <100) {
   pizza = mediumBPM.get(0);
   caffee = mediumBPM.get(1);
 //  clock = mediumBPM.get(2); 
}
 if(BPM >100){
   pizza = highBPM.get(0);
   caffee = highBPM.get(1);
 // clock = highBPM.get(2); 
} 
   
//Assigning labeledBPM with int BPM and text "BPM" 
  labeledBPM = (BPM + " BPM");      // print the Beats Per Minute  
  text(labeledBPM,150,50);
  text(pizza,150,75);

}  //end of main loop