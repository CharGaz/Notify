/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

public void playClicked(GImageButton source, GEvent event) { //_CODE_:play_button:242900:
  playSong = true;
  displayPlay = false;
} 

public void pauseClicked(GImageButton source, GEvent event) { //_CODE_:pause_button:527890:
  playSong = false;
  displayPlay = true;
} 

public void fastfowardClicked(GImageButton source, GEvent event) { //_CODE_:fast_foward_button:334872:
  playlist.get(songIndex).stopSong();
  if(!isLooping){
    songIndex = (songIndex + 1) % playlist.size();
  }

  else{
    //playlist.get(songIndex).song.jump(0.0);
    songIndex = (songIndex) % playlist.size();
  }
  
  playStatus = false;
} //_CODE_:fast_foward_button:334872:

public void rewindClicked(GImageButton source, GEvent event) { //_CODE_:rewind_button:710650:
  playlist.get(songIndex).stopSong();
  songIndex = (songIndex-1 + playlist.size()) % playlist.size();
  playStatus = false;
} 

public void loopClicked(GImageButton source, GEvent event) { //Loops and unloops song
  loopIndex += 1;
  if((loopIndex % 2) == 0){
    isLooping = true;
    
  }
  else{
    isLooping = false;
  }
  
} 

public void whiteLoopClicked(GImageButton source, GEvent event) { //Loops and unloops song
  loopIndex += 1;

  if((loopIndex % 2) == 0){
    isLooping = true;
  }
  else{
    isLooping = false;
  }
} 


public void shuffleClicked(GImageButton source, GEvent event) { //_CODE_:shuff_button:228625:
  if(playlist.get(songIndex).song.isPlaying()){
    playlist.get(songIndex).stopSong();
  }

  shufflePlaylist(playlist);
  songIndex = 0;

  playStatus = false;
  playSong = true;
  displayPlay = false;
  

} 

public void speedChanged(GSlider source, GEvent event) { //_CODE_:speed_slider:867952:
  
  float displaySpeed = speed_slider.getValueF(); //getting values from the slider

  playBackSpeed = map(displaySpeed, 0.0,2, 0.6, 1.4);
  if(playlist.get(songIndex).song.isPlaying()){
    playlist.get(songIndex).song.rate(playBackSpeed);
  }
  
} 

public void volumeChanged(GSlider source, GEvent event) { //_CODE_:volume:779657:
  float displayVolume = volume.getValueF();

  setVolume = map(displayVolume, 0,10, 0.0,3.0);

  if(playlist.get(songIndex).song.isPlaying()){
    playlist.get(songIndex).song.amp(setVolume);
  }
} 

public void dropList1_click1(GDropList source, GEvent event) { //_CODE_:dropList1:447654:
  println("dropList1 - GDropList >> GEvent." + event + " @ " + millis());
} //_CODE_:dropList1:447654:

public void youtubeUrlChanged(GTextField source, GEvent event) { //_CODE_:YoutubeUrl:779815:
  println("YoutubeUrl - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:YoutubeUrl:779815:

public void youtubeCommitClicked(GButton source, GEvent event) { //_CODE_:youtubeCommit:244925:
  println("youtubeCommit - GButton >> GEvent." + event + " @ " + millis());
} //_CODE_:youtubeCommit:244925:


// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Sketch Window");
  play_button = new GImageButton(this, 600, 505, 60, 50, new String[] { "Black Play Button.png", "Black Play Button.png", "Black Play Button.png" } );
  play_button.addEventHandler(this, "playClicked");
  pause_button = new GImageButton(this, 575, 495, 100, 70, new String[] { "Black Pause Button.png", "Black Pause Button.png", "Black Pause Button.png" } );
  pause_button.addEventHandler(this, "pauseClicked");
  fast_foward_button = new GImageButton(this, 670, 505, 60, 50, new String[] { "Fast Forward Button.png", "Fast Forward Button.png", "Fast Forward Button.png" } );
  fast_foward_button.addEventHandler(this, "fastfowardClicked");
  rewind_button = new GImageButton(this, 520, 505, 60, 50, new String[] { "Rewind Button.png", "Rewind Button.png", "Rewind Button.png" } );
  rewind_button.addEventHandler(this, "rewindClicked");
  loop_button = new GImageButton(this, 320, 485, 100, 100, new String[] { "Black Loop Button.png","Black Loop Button.png" , "Black Loop Button.png" } );
  loop_button.addEventHandler(this, "loopClicked");
  loop_buttonWhite = new GImageButton(this, 320, 485, 100, 100, new String[] { "White Loop Button.png", "White Loop Button.png", "White Loop Button.png" } );
  loop_buttonWhite.addEventHandler(this, "whiteLoopClicked");
  shuff_button = new GImageButton(this, 420, 505, 100, 60, new String[] { "shuffle.png", "shuffle.png", "shuffle.png" } );
  shuff_button.addEventHandler(this, "shuffleClicked");
  speed_slider = new GSlider(this, 780, 480, 100, 50, 10.0);
  speed_slider.setShowValue(true);
  speed_slider.setShowLimits(true);
  speed_slider.setLimits(1.0, 0.1, 2.0);
  speed_slider.setNbrTicks(5);
  speed_slider.setStickToTicks(false);
  speed_slider.setShowTicks(false);
  speed_slider.setNumberFormat(G4P.DECIMAL, 1);
  speed_slider.setOpaque(false);
  speed_slider.addEventHandler(this, "speedChanged");
  volume = new GSlider(this, 780, 530, 100, 50, 10.0);
  volume.setShowValue(true);
  volume.setShowLimits(true);
  volume.setLimits(3, 0.0, 10);
  volume.setNbrTicks(10);
  volume.setStickToTicks(false);
  volume.setShowTicks(false);
  volume.setNumberFormat(G4P.DECIMAL, 2);
  volume.setOpaque(false);
  volume.addEventHandler(this, "volumeChanged");
  show_playlist = new GDropList(this, 50, 100, 103, 80, 3, 10);
  show_playlist.setItems(new String [] {"All Songs","Charlie's Songs","Lachlan's Songs"},0);
  show_playlist.addEventHandler(this, "show_playlistClicked");
  youtubeUrl = new GTextField(this, 173, 64, 120, 30, G4P.SCROLLBARS_NONE);
  youtubeUrl.setPromptText("Enter Url here");
  youtubeUrl.setOpaque(true);
  youtubeUrl.addEventHandler(this, "youtubeUrlChanged");
  youtubeCommit = new GButton(this, 191, 140, 80, 30);
  youtubeCommit.setText("Youtube Commit");
  youtubeCommit.addEventHandler(this, "youtubeCommitClicked");
}



// Variable declarations 
// autogenerated do not edit
GImageButton play_button; 
GImageButton pause_button; 
GImageButton fast_foward_button; 
GImageButton rewind_button; 
GImageButton loop_button; 
GImageButton shuff_button; 
GSlider speed_slider; 
GSlider volume; 
GDropList show_playlist; 
GImageButton loop_buttonWhite; 
GTextField youtubeUrl; 
GButton youtubeCommit; 
