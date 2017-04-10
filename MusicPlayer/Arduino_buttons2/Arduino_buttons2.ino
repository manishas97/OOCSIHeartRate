#define controls_AnalogInput 0        // Analog input 0

#define btnVOLUMEDOWN 4               //define buttons
#define btnNEXT       2
#define btnVOLUMEUP   3
#define btnPLAYPAUSE  1
#define btnPREVIOUS   5
#define btnNONE       -1

int buttonpressed;
int analogPin = 0;

void setup()
{
  Serial.begin(115200);              // Set Serial Monitor lower right to 115200
  Serial.println("Analog Buttons "); // check
}

void loop()
{
  buttonpressed = read_controls();
  if (buttonpressed != btnNONE)
  {
    Serial.print(" Button Pressed = ");//
    Serial.println(buttonpressed);     //
    Serial.write(buttonpressed);
    }
  }

/*-------------------( Decode voltages to buttons )-------------------*/
int getButton()
{
  int i, v, button;
  int sum = 0;

  for (i = 0; i < 4; i++) {
    sum += analogRead(controls_AnalogInput);
  }
  v = sum / 4;
  if (v > 1000) button = 0;
  else if (v > 160  && v < 200)  button = 1; //PLAYPAUSE 186
  else if (v > 390 && v < 430) button = 2; //NEXT 409
  else if (v > 680 && v < 720) button = 3; //UP 704
  else if (v > 760 && v < 800) button = 4; //DOWN 782
  else if (v > 870 && v < 910) button = 5; //PREVIOUS 891
  else button = 0;
  
  return button;
}

/*-------------------( Debounce keystrokes, translate to buttons )-------------------*/
int old_button = 0;
int read_controls()
{
  int button, button2, pressed_button;
  button = getButton();         // Above
  if (button != old_button)     // A new button pressed
  {
    delay(50);                  // Delay to debounce
    button2 = getButton();
    if (button == button2)
    {
      old_button = button;
      pressed_button = button;
      if (button != 0)
      {
        //Serial.println(button);
        if (button == 1) return btnPLAYPAUSE;
        if (button == 2) return btnNEXT;
        if (button == 3) return btnVOLUMEUP;
        if (button == 4) return btnVOLUMEDOWN;
        if (button == 5) return btnPREVIOUS;
      }
    }
  }
  else
  {
    return btnNONE;
  }
}

