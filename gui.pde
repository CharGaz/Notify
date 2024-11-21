
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
  if(!delete){
    playSong = true;
    displayPlay = false;
  } 
} 

public void pauseClicked(GImageButton source, GEvent event) { //_CODE_:pause_button:527890:
  if(!delete){
    playSong = false;
    displayPlay = true;
  }
} 

public void fastfowardClicked(GImageButton source, GEvent event) { //_CODE_:fast_foward_button:334872:
  if(!delete){
    playlist.get(songIndex).stopSong();
    if(!isLooping){
      songIndex = (songIndex + 1) % playlist.size();
    }

    else{
      //playlist.get(songIndex).song.jump(0.0);
      songIndex = (songIndex) % playlist.size();
    }
    
    playStatus = false;
  }
} //_CODE_:fast_foward_button:334872:

public void rewindClicked(GImageButton source, GEvent event) { //_CODE_:rewind_button:710650:
  if(!delete){
    playlist.get(songIndex).stopSong();
    songIndex = (songIndex-1 + playlist.size()) % playlist.size();
    playStatus = false;
  }
} 

public void loopClicked(GImageButton source, GEvent event) { //Loops and unloops song
  if(!delete){
    loopIndex += 1;
    if((loopIndex % 2) == 0){
      isLooping = true;
      
    }
    else{
      isLooping = false;
    }
  }
  
} 

public void whiteLoopClicked(GImageButton source, GEvent event) { //Loops and unloops song
  if(!delete){
    loopIndex += 1;

    if((loopIndex % 2) == 0){
      isLooping = true;
    }
    else{
      isLooping = false;
    }
  }
} 


public void shuffleClicked(GImageButton source, GEvent event) { //_CODE_:shuff_button:228625:
  if(!delete){
    if(playlist.get(songIndex).song.isPlaying()){
      playlist.get(songIndex).stopSong();
    }

    shufflePlaylist(playlist);
    songIndex = 0;

    playStatus = false;
    playSong = true;
    displayPlay = false;
    
    redraw();
  }

} 

public void speedChanged(GSlider source, GEvent event) { //_CODE_:speed_slider:867952:
  if(!delete){
    float displaySpeed = speed_slider.getValueF(); //getting values from the slider

    playBackSpeed = map(displaySpeed, 0.0,2, 0.6, 1.4);
    if(playlist.get(songIndex).song.isPlaying()){
      playlist.get(songIndex).song.rate(playBackSpeed);
    }
  }
  
} 

public void volumeChanged(GSlider source, GEvent event) { //_CODE_:volume:779657:
  if(!delete){
    float displayVolume = volume.getValueF();

    setVolume = map(displayVolume, 0,10, 0.0,3.0);

    if(playlist.get(songIndex).song.isPlaying()){
      playlist.get(songIndex).song.amp(setVolume);
    }
  }
} 

public void show_playlistClicked(GDropList source, GEvent event) { //_CODE_:dropList1:447654:
  if(!delete){
    int selectedIndex = source.getSelectedIndex();
    println("Selected playlist index: " + selectedIndex);
    setActivePlaylist(selectedIndex);
  }
} //_CODE_:dropList1:447654:

 public void youtubeUrlChanged(GTextField source, GEvent event) { //_CODE_:YoutubeUrl:779815:
   println("YoutubeUrl - GTextField >> GEvent." + event + " @ " + millis());
   youtubeURL = youtubeUrl.getText();
 } //_CODE_:YoutubeUrl:779815:

 public void youtubeCommitClicked(GButton source, GEvent event) { //_CODE_:youtubeCommit:244925:
   println("youtubeCommit - GButton >> GEvent." + event + " @ " + millis());
   getYoutube(youtubeURL);
 } //_CODE_:youtubeCommit:244925:

public void editPlaylistClicked(GButton source, GEvent event) { //_CODE_:createPlaylist:727161:
  println("createPlaylist - GButton >> GEvent." + event + " @ " + millis());
} //_CODE_:createPlaylist:727161:

public void deletePlaylistClicked(GButton source, GEvent event) { //_CODE_:deletePlaylist:748042:
  delete = true;
  playSong = false;
  displayPlay = true;
} 

public void returnClicked(GButton source, GEvent event){
  delete = false;
}


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
  show_playlist = new GDropList(this, 30, 200, 150, 150, allPlaylists.size(), 15);
  show_playlist.setItems(new String[] {"All Songs", "Playlist 1", "Playlist 2", "Playlist 3", "Playlist 4"},0);
  show_playlist.addEventHandler(this, "show_playlistClicked");

  editPlaylist = new GButton(this, 30, 275, 150, 25);
  editPlaylist.setText("Edit Playlist"); 
  editPlaylist.addEventHandler(this, "editPlaylistClicked");
  deletePlaylist = new GButton(this, 30, 325, 150, 25);
  deletePlaylist.setText("Delete Playlist");
  deletePlaylist.addEventHandler(this, "deletePlaylistClicked");

  returnButton = new GButton(this, 220, 415, 100, 25);
  returnButton.setText("Return");
  returnButton.addEventHandler(this,"returnClicked");
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
// GTextField youtubeUrl; 
// GButton youtubeCommit; 
GButton editPlaylist; 
GButton deletePlaylist; 
GButton returnButton;
GTextField youtubeUrl; 
GButton youtubeCommit; 
