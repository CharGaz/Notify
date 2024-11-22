
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
  if(!delete && !create){ //Cheking if delete or create screen are being displayed --> will not run if one of them are
    playSong = true; //Playing the song when true
    displayPlay = false; //Switiching the play button to a pause button
  } 
} 

public void pauseClicked(GImageButton source, GEvent event) { //_CODE_:pause_button:527890:
  if(!delete && !create){ //Cheking if delete or create screen are being displayed --> will not run if one of them are
    playSong = false; //Pausing the song when pressed
    displayPlay = true; //Switiching the pause button to a play button
  }
} 

public void fastfowardClicked(GImageButton source, GEvent event) { //_CODE_:fast_foward_button:334872:
  if(!delete && !create){ //Cheking if delete or create screen are being displayed --> will not run if one of them are
    playlist.get(songIndex).stopSong(); //getting the current index of playlist(Checking wich song is being played) and stoping the song
    
    if(!isLooping){ //Cheking if the the user wants the song to being looping or not
      songIndex = (songIndex + 1) % playlist.size(); //if not, then the song index gets added by one(goes to next song)(% playlist.size is to keep the playlist looping when it reaches the last song)
    }

    else{
      songIndex = (songIndex) % playlist.size(); //if looping, then song restarts
    }
    
    playStatus = false;
  }
} //_CODE_:fast_foward_button:334872:

public void rewindClicked(GImageButton source, GEvent event) { //_CODE_:rewind_button:710650:
  if(!delete && !create){ //Cheking if delete or create screen are being displayed --> will not run if one of them are
    playlist.get(songIndex).stopSong(); //Stopping the current song
    songIndex = (songIndex-1 + playlist.size()) % playlist.size(); //Setting the songIndex to the last song to play the prevoius song --> if the song is the first in que, then the rewined song will be the last in que
    playStatus = false;
  }
} 

public void loopClicked(GImageButton source, GEvent event) { //Loops and unloops song
  if(!delete && !create){ //Cheking if delete or create screen are being displayed --> will not run if one of them are
    loopIndex += 1; 
    if((loopIndex % 2) == 0){ //Cheking if loop index is odd or even as to be able to loop and unloop with one button
      isLooping = true; //Sets looping to true and turns the button white to indicate looping
      
    }
    else{
      isLooping = false; //Sets looping to false and turns button back to black to indicate NO looping
    }
  }
  
} 

//Need a second button that does the same thing as before but this one is white to show the user that looping is true
public void whiteLoopClicked(GImageButton source, GEvent event) { //Loops and unloops song
  if(!delete && !create){ //Cheking if delete or create screen are being displayed --> will not run if one of them are
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
  if(!delete && !create){ //Cheking if delete or create screen are being displayed --> will not run if one of them are
    if(playlist.get(songIndex).song.isPlaying()){ //Checks to see if the current selected song is playing
      playlist.get(songIndex).stopSong(); //Stops the song if it is being played 
    }

    shufflePlaylist(playlist); //Puts playlist to be shuffledn
    songIndex = 0; //Resets the song index to 0 --> resets the que 

    //When shuffle is pressed it also plays the songs acting like a play button aswell 
    playStatus = false; 
    playSong = true;
    displayPlay = false;
    
    redraw();//redrawing all the song names and boxes to match up with the shuffled que/order of songs
  }

} 

public void speedChanged(GSlider source, GEvent event) { //_CODE_:speed_slider:867952:
  if(!delete && !create){ //Cheking if delete or create screen are being displayed --> will not run if one of them are
    float displaySpeed = speed_slider.getValueF(); //getting values from the slider

    playBackSpeed = map(displaySpeed, 0.0,2, 0.6, 1.4); //Mapping the values of the slider to new values to make it sound better when slowed down and sped up
    if(playlist.get(songIndex).song.isPlaying()){
      playlist.get(songIndex).song.rate(playBackSpeed); //Changing the rate/speed of the song to match up with the slider
    }
  }
  
} 

public void volumeChanged(GSlider source, GEvent event) { //_CODE_:volume:779657:
  if(!delete && !create){ //Cheking if delete or create screen are being displayed --> will not run if one of them are
    float displayVolume = volume.getValueF();//getting values from the slider

    setVolume = map(displayVolume, 0,10, 0.0,3.0); //mapping the values to avoid glitching of the song

    if(playlist.get(songIndex).song.isPlaying()){
      playlist.get(songIndex).song.amp(setVolume); //Changing the volume of the song to match up with the slider 
    }
  }
} 

public void show_playlistClicked(GDropList source, GEvent event) { //_CODE_:dropList1:447654:
  if(!delete && !create){ //Cheking if delete or create screen are being displayed --> will not run if one of them are
    selectedIndex = source.getSelectedIndex(); //Getting the index of the selected box in the dropdown menu
  
    setActivePlaylist(selectedIndex); //Setting the selected playlist as the current/active playlist 
  }
} //_CODE_:dropList1:447654:

 public void youtubeUrlChanged(GTextField source, GEvent event) { //_CODE_:YoutubeUrl:779815:
   youtubeURL = youtubeUrl.getText(); //Getting the text from the text field
 } //_CODE_:YoutubeUrl:779815:

 public void youtubeCommitClicked(GButton source, GEvent event) { //_CODE_:youtubeCommit:244925:
   getYoutubeWindows(youtubeURL); //Calling getYoutubeWindows to download the song
 } //_CODE_:youtubeCommit:244925:

public void createPlaylistClicked(GButton source, GEvent event) { //_CODE_:createPlaylist:727161:
   if(!delete){ //Cheking if delete screen is being displayed --> will not run if it is
     setActivePlaylist(0); //Displays defaultPlaylist(Displays this playlist since it hold all the songs in the program)
     create = true; //Setting create to true to indicate to the rest of the program that it is on the create screen
   }
  } //_CODE_:createPlaylist:727161:

public void deletePlaylistClicked(GButton source, GEvent event) { //_CODE_:deletePlaylist:748042:
  if(!create){ //Cheking if create screen is being displayed --> will not run if it is
   delete = true; //Setting delete as true to indicate to the rest of the program this it is on the delete playlist screen
   playSong = false; //Pauses the song
   displayPlay = true; //Displaying the Play button to replace pause button if it is on the screen

  }
} 

public void returnClicked(GButton source, GEvent event){ //For returning to the normal screen from either the delete or create playlist screen
  delete = false; //setting delete to false
  create = false; //setting create to false
  if(selectedIndex == allPlaylists.size()){ //if the prevoiusly selected playlist was deleted, user gets returned to the all songs screen
    setActivePlaylist(0);
  }
  else{
    setActivePlaylist(selectedIndex); //Other wise the user gets returned to their past playlist
  }
  

  
}

public void confirmButtonClicked(GButton source, GEvent event){ //Similair to return button 
  delete = false;  //setting delete to false
  create = false; //setting create to false
  for(Song song : defaultPlaylist){ //goes through all the songs in default playlist to unselect them/ go from green text back to black
    song.clicked = false;  // Resets all songs to unselected
  }
  createNewPlaylist(); //creates the new playlist
  setActivePlaylist(selectedIndex); //returns user to their past playlist
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
  show_playlist.setItems(displayNames,0);
  show_playlist.addEventHandler(this, "show_playlistClicked");
  createPlaylist = new GButton(this, 30, 275, 150, 25);
  createPlaylist.setText("Create Playlist"); 
  createPlaylist.addEventHandler(this, "createPlaylistClicked");
  deletePlaylist = new GButton(this, 30, 325, 150, 25);
  deletePlaylist.setText("Delete Playlist");
  deletePlaylist.addEventHandler(this, "deletePlaylistClicked");
  returnButton = new GButton(this, 220, 415, 100, 25);
  returnButton.setText("Return");
  returnButton.addEventHandler(this,"returnClicked");
  confirmButton = new GButton(this, 815, 415, 100, 25);
  confirmButton.setText("Confirm");
  confirmButton.addEventHandler(this, "confirmButtonClicked");
  youtubeUrl = new GTextField(this, 30, 425, 150, 25, G4P.SCROLLBARS_NONE);
  youtubeUrl.setPromptText("Enter Url here");
  youtubeUrl.setOpaque(true);
  youtubeUrl.addEventHandler(this, "youtubeUrlChanged");
  youtubeCommit = new GButton(this, 30, 475, 150, 25);
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
GButton createPlaylist; 
GButton deletePlaylist; 
GButton returnButton;
GTextField youtubeUrl; 
GButton youtubeCommit; 
GButton confirmButton;
