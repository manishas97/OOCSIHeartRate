void SerialEvent (){
  while (Buttons.available() > 0){
  int val = Buttons.read();
  println(val);
       
  //NEXTSONG                                              
  if ( val == 2){
  previousPlaying = randomSong;
  pauseOrPlay = true;
  //play a random song from the array from play(millis) into the song
  randomSong = int(random(playlist.length)); 
  playing = randomSong;
  println("playing song");
    }
    
  //PLAYPAUSE
  if ( val == 1);{
  if(pauseOrPlay == true){
      pauseOrPlay = false;
    }
    else if(pauseOrPlay == false){
      pauseOrPlay = true;
    }
      println("toggled pause/play");
  }
  
  //VOLUME DOWN
  if ( val == 4){
  if(volumeLevel > -60)  volumeLevel = volumeLevel - 15;
  println("volume -15");
  playlist[playing].setGain(volumeLevel);
  }
  
  //VOLUME UP
  if (val == 3){
    if(volumeLevel < 60)   volumeLevel = volumeLevel + 15;
  playlist[playing].setGain(volumeLevel);
  println("volume + 15");
  
  //PREVIOUS 
    if (val == 5){
      playing = previousPlaying;
      pauseOrPlay = true;
      println("previous Song started!");
    }
  }
  }
}