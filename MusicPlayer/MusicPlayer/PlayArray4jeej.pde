import processing.serial.*;
Serial Buttons; //create object from Serial class
String val;


import ddf.minim.*;
AudioPlayer [] playlist = new AudioPlayer[12];
Minim minim;

int randomSong; //place to store the last played song
int previousPlaying;
int playing;
boolean pauseOrPlay;       //true = playing                                                                          
int volumeLevel= 0;


void setup()
{
String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
Buttons = new Serial(this, portName, 115200); //open port using at the framerate 115200

  size(512, 300);
  background (255);
  smooth();
  // we pass this to Minim so that it can load files from the data directory
  minim = new Minim(this);
  
  //setupPlaylist
  playlist = new AudioPlayer[13];
  
////Personal Playlist
    //playlist[0] = minim.loadFile("68.mp3"); //this could also be loaded from computer, URL or linked to Spotify API
    //playlist[1] = minim.loadFile("78.mp3");
    //playlist[2] = minim.loadFile("85.mp3");
    //playlist[3] = minim.loadFile("92.mp3");
    //playlist[4] = minim.loadFile("97.mp3");
    //playlist[5] = minim.loadFile("109.mp3");
    //playlist[6] = minim.loadFile("112.mp3");
    //playlist[7] = minim.loadFile("116.mp3");
    //playlist[8] = minim.loadFile("122.mp3");
    //playlist[9] = minim.loadFile("123.mp3");
    //playlist[10] = minim.loadFile("128.mp3");
    //playlist[11] = minim.loadFile("160.mp3");
    //playlist[12] = minim.loadFile("165.mp3");
  //Heart Playlist
    playlist[0] = minim.loadFile("49.mp3"); //this could also be loaded from computer, URL or linked to Spotify API
    playlist[1] = minim.loadFile("77.mp3");
    playlist[2] = minim.loadFile("90.mp3");
    playlist[3] = minim.loadFile("98.mp3");
    playlist[4] = minim.loadFile("106.mp3");
    playlist[5] = minim.loadFile("118.mp3");
    playlist[6] = minim.loadFile("120.mp3");
    playlist[7] = minim.loadFile("128.mp3");
    playlist[8] = minim.loadFile("136.mp3");
    playlist[9] = minim.loadFile("143.mp3");
    playlist[10] = minim.loadFile("144.mp3");
    playlist[11] = minim.loadFile("174.mp3");
    playlist[12] = minim.loadFile("190.mp3"); 
}

//DRAW BUTTONS
void draw() 
{
  fill(255, 255, 255);
  rect(0, 0, 512, 300);
  
  fill(255, 0, 0);
  textSize(10);
  text("next song", 25, 25);
  fill(255,0,0);
  rect(25,25,50,50);
  
  textSize(10);
  text("pause play", 125, 25);
  fill(255,0,0);
  rect(125,25,50,50);
  
  textSize(10);
  text("volume down", 225, 25);
  fill(0, 103, 153); 
  fill(255,0,0);
  rect(225,25,50,50);
  
  textSize(10);
  text("volume up", 325, 25);
  fill(255,0,0);
  rect(325,25,50,50);
  
  textSize(10);
  text("previous", 425, 25);
  fill(255,0,0);
  rect(425,25,50,50);
  
  text(volumeLevel, 100, 100);
  
  musicPlayer();
  }

void mousePressed(){

//CHOOSE A RANDOM NEXT SONG FROM PLAYLIST
  if(mouseX > 25 && mouseX < 75 && mouseY > 25 && mouseY < 75){
  //pause a random song from the array
  previousPlaying = randomSong;
  pauseOrPlay = true;
  //play a random song from the array from play(millis) into the song
  randomSong = int(random(playlist.length)); 
  playing = randomSong;
  println("playing song");
  }      
  
//PAUSE AND PLAY SONG
  if(mouseX > 125 && mouseX < 175 && mouseY > 25 && mouseY < 75){
    if(pauseOrPlay == true){
      pauseOrPlay = false;
    }
    else if(pauseOrPlay == false){
      pauseOrPlay = true;
    }
      println("toggled pause/play");
  }
     
//VOLUME DOWN
  if (mouseX > 225 && mouseX < 275 && mouseY > 25 && mouseY < 75){
    if(volumeLevel > -60)  volumeLevel = volumeLevel - 15;
  println("volume -15");
  playlist[playing].setGain(volumeLevel);
  }
  


//VOLUME UP
  if (mouseX > 325 && mouseX < 375 && mouseY > 25 && mouseY < 75){
    if(volumeLevel < 60)   volumeLevel = volumeLevel + 15;
  playlist[playing].setGain(volumeLevel);
  println("volume + 15");
  }


//PREVIOUS 
    if (mouseX > 425 && mouseX < 475 && mouseY > 25 && mouseY < 75){
      playing = previousPlaying;
      pauseOrPlay = true;
      println("previous Song started!");
    }

}

//MUSICPLAYER SONG
void musicPlayer(){
    for(int i = 0; i < int(playlist.length); i++){
      if(i != playing){
        playlist[i].pause();
      }
    }
    
    if(pauseOrPlay == true){
    playlist[playing].play();
    }
    else{
    playlist[playing].pause();
    }
}