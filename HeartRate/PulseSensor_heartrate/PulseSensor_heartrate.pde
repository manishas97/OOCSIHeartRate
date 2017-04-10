
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
boolean beat = false;
boolean caffee_order_record = false;
PFont font; //FONT STYLE FOR SKETCHES
Serial port;   
String currentActivity;
int caffee_order;
int output_type;
String mood;
String order_pizza;
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
   oocsi = new OOCSI(this,"manisha123","oocsi.id.tue.nl");
   oocsi.subscribe("SmartClock");
   oocsi.subscribe("coffee_channel");
   oocsi.subscribe("choosePizza", "responseEvent");   

//....................ARDUINO CONNECTION..........................................//
  println(Serial.list());    // print a list of available serial ports
  // choose the number between the [] that is connected to the Ardui9no
  port = new Serial(this, Serial.list()[0], 115200);  // make sure Arduino is talking serial at this baud rate
  port.clear();            // flush buffer
  port.bufferUntil('\n');  // set buffer full flag on receipt of carriage return
 
 
 //GROUPING BPM ACCORDING TO THE RANGE 
 //NORMAL BPM IS 70-90
 if(beat == true){
   
 if(BPM > 70 && BPM <=90){
    BPMrange = "normal";
      }
  //LOW BPM IS 30-70 
 else if(BPM > 30 && BPM <=70){   
      BPMrange = "low";
      }
  //EXTREME LOW BPM IS 0-30
 else if(BPM > 0 && BPM <=30){
       BPMrange = "extremelylow";
       }
 else if(BPM < 90 && BPM <=120){
  //HIGH IS 90-120
        BPMrange = "high";
       }
else if(BPM < 120) {
  //EXTREMELY HIGH IS MORE THAN 120 
        BPMrange = "extremelyhigh";
       }     
    }     
 else{
   //IF BEAT==FALSE
   BPMrange = "Out of order";
 }
 
 //SETTING MOODS ACCORDING TO BPM
 if(BPMrange.equals("low")){
   mood = "Sad/Sleep";
 } else if(BPMrange.equals("extremelylow")){
   mood = "Alert: BPM is too low";
 } else if(BPMrange.equals("high")) {
   mood = "Happy";
 } else if(BPMrange.equals("extremelyhigh")) {
   mood = "Excited";
 } else if(BPMrange.equals("normal")){
   mood = "Neutral";
 }
 else{
   mood = "Error";
      }
}
 


void handleOOCSIEvent(OOCSIEvent event) {
  
  /*
  CHECK FOR COFFEE ORDER 
  Coffee + BPM range helps define whether user is stressed/studying or chilling  
  */
  if(beat == true) {
     
  //GET COFFEE STATUS 
  caffee_order = event.getInt("output_type", 0);
   
    if(caffee_order_record == true){
    
        if(caffee_order == 1 && (BPMrange.equals("low") || BPMrange.equals("normal"))) {
        //play coffee playlist       
         
        } 
        else if(caffee_order == 1 && ( BPMrange.equals("high"))){   
             if(caffee_order == 4) {
             //play coffee is ready music       
               }
        }
       
        else if(caffee_order == 4 && BPMrange.equals("extremelyhigh")){
             
                //play coffeeStress playlist 
        } 
        
        else if(caffee_order == 4 && BPMrange.equals("low")){  
                   //play coffeeCalm playlist  
           } 
   }  
 }
  
 else {  
   
  //GET ACTIVITY STRING 
   
 //REQUEST ACTIVITY AND SEND MOODS TO SMARTCLOCK 
oocsi
  .channel("SmartClock")
        .data("currentActivity", "retrieve")
          .data("returnChannel","HeartRateModule")
            .data("range",BPMrange)
              .data("mood",mood)
            .send();

  currentActivity = event.getObject("currentActivity").toString();
   
     if(currentActivity != null){
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
      else {
           if(mood.equals("Sad/Sleep")){
            
           } else if(mood.equals("Alert: BPM is too low")){
             //error message
           } else if(mood.equals("Happy")) {
           } else if(mood.equals("Excited")) {
           } else if(BPMrange.equals("Neutral")){
           }
      }  
}
  
  //SEND BPMrange to COFFEE group
  oocsi
  .channel("coffee_channel")
       .data("range",BPMrange)
         .send();
         
 //GET PIZZA RESPONSE AND SEND MOOD TO PIIZA GROUP
 oocsi
  .channel("choosePizza")
       .data("range",BPMrange)
         .data("mood",mood)
           .send();
   
  order_pizza = event.getString("response");
  
  if(order_pizza == "The button has been pressed."){
    //play pizza ordered music to confirm order
  }
  
}

void draw(){
  if(beat == true) {
     println(mood);
     println(BPMrange);     
  }
  else {
    println("No heartbeat detected");
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

boolean coffeeError(boolean caffee_order_record){
  //maxBeat and minBeat are set to so system gives error message
 caffee_order_record = false;
 
 for(int i = 0; i < 5; i++){
   if(caffee_order == i){
     caffee_order_record = true;
   }
 }
  
 return caffee_order_record;
}

  