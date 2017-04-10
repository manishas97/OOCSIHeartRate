import processing.serial.*;
Serial Buttons;
String val; 
int value;


void setup()
{
  size(200, 200);
  
  String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  Buttons = new Serial(this, portName, 115200);
}

void draw()
{
while (Buttons.available() > 0){
 int val = Buttons.read();
 println(val);
 if ( val == 1){ //pauseplay
   fill(10, 100, 30);
   rect(50,50,100,100);
}
 else if ( val == 2){ //next
   fill(0, 100, 130);
   rect(50,50,100,100);
}
 else if ( val == 3){ //up
   fill(200, 100, 30);
   rect(50,50,100,100);
}
 else if ( val == 4){ //down
   fill(0, 0, 0);
   rect(50,50,100,100);
}
 else if ( val == 5){ //previous
   fill(200, 0, 30);
   rect(50,50,100,100);
}
}
   rect(50,50,100,100);

}