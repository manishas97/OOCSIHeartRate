//Get values from Arduino in a suitable form
//NOT OF IMPORTANCE TO OTHER GROUPS 
/*
void serialEvent(Serial port){ 
   String inData = port.readStringUntil('\n');
   inData = trim(inData);                 // cut off white space (carriage return)
   
   if (inData.charAt(0) == 'S'){          // leading 'S' for sensor data
     inData = inData.substring(1);        // cut off the leading 'S'
     Sensor = int(inData);                // convert the string to usable int
   }
   if (inData.charAt(0) == 'B'){          // leading 'B' for BPM data
     inData = inData.substring(1);        // cut off the leading 'B'
     BPM = int(inData);                   // convert the string to usable int
     beat = true;                         // set beat flag to advance heart rate graph
     //heart = 20;                          // begin heart image 'swell' timer
   }
 
}
*/