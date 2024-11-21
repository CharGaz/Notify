
void initializePlaylists(){
  //Adding all the songs to defult playlist
  defaultPlaylist.add(new Song(this,"Benzi Box.mp3","Mouse and the Mask", "Mouse and the Mask.jpeg"));
  defaultPlaylist.add(new Song(this,"Doomsday.mp3", "Operation: DOOMSDAY","Operation Doomsday Album Cover.jpeg" ));
  defaultPlaylist.add(new Song(this,"Rhymes Like Dimes.mp3", "Operation: DOOMSDAY","Operation Doomsday Album Cover.jpeg" ));
  defaultPlaylist.add(new Song(this,"Potholderz.mp3", "MM Food","MM Food.jpeg" ));
  defaultPlaylist.add(new Song(this,"Deep Fried Frenz.mp3", "MM Food","MM Food.jpeg" ));
  defaultPlaylist.add(new Song(this,"Crosshairs.mp3", "Mouse and the Mask","Mouse and the Mask.jpeg" ));
  defaultPlaylist.add(new Song(this,"Darling I.mp3","Chromakopia","Chromakopia Album.jpeg" ));
  defaultPlaylist.add(new Song(this,"St Chroma.mp3","Chromakopia","Chromakopia Album.jpeg"));
  defaultPlaylist.add(new Song(this,"See You Again.mp3","Flower Boy","Flower Boy.jpeg"));
  defaultPlaylist.add(new Song(this,"911 Mr lonely.mp3","Flower Boy","Flower Boy.jpeg"));
  defaultPlaylist.add(new Song(this,"Pink White.mp3","Blonde","Blonde.jpeg"));
  defaultPlaylist.add(new Song(this,"Goodbye Angels.mp3","The Getaway","The Getaway.jpeg"));
  defaultPlaylist.add(new Song(this,"Sick Love.mp3","The Getaway","The Getaway.jpeg"));
  defaultPlaylist.add(new Song(this,"White Braids & Pillow Chair.mp3","Unlimited Love","Unlimited Love.jpeg"));
  defaultPlaylist.add(new Song(this,"Black Summer.mp3","Unlimited Love","Unlimited Love.jpeg"));
  defaultPlaylist.add(new Song(this,"Billie Jean.mp3","Thriller","Thriller"));


  

  //Setting up  playlist1
  playlist1.add(new Song(this,"Potholderz.mp3", "MM Food","MM Food.jpeg" ));
  playlist1.add(new Song(this,"Black Summer.mp3","Unlimited Love","Unlimited Love.jpeg"));
  playlist1.add(new Song(this,"St Chroma.mp3","Chromakopia","Chromakopia Album.jpeg"));
  playlist1.add(new Song(this,"911 Mr lonely.mp3","Flower Boy","Flower Boy.jpeg"));
  playlist1.add(new Song(this,"Crosshairs.mp3", "Mouse and the Mask","Mouse and the Mask.jpeg" ));
  playlist1.add(new Song(this,"Pink White.mp3","Blonde","Blonde.jpeg"));


  //Setting up playlist2
  playlist2.add(new Song(this,"Rhymes Like Dimes.mp3", "Operation: DOOMSDAY","Operation Doomsday Album Cover.jpeg" ));
  playlist2.add(new Song(this,"Doomsday.mp3", "Operation: DOOMSDAY","Operation Doomsday Album Cover.jpeg" ));
  playlist2.add(new Song(this,"Benzi Box.mp3","Mouse and the Mask", "Mouse and the Mask.jpeg"));
  playlist2.add(new Song(this,"Billie Jean.mp3","Thriller","Thriller.jpeg"));
  playlist2.add(new Song(this,"See You Again.mp3","Flower Boy","Flower Boy.jpeg"));
  playlist2.add(new Song(this, "Crosshairs.mp3", "Mouse and the Mask","Mouse and the Mask.jpeg" ));
  playlist2.add(new Song(this,"Goodbye Angels.mp3","The Getaway","The Getaway.jpeg"));
  playlist2.add(new Song(this,"St Chroma.mp3","Chromakopia","Chromakopia Album.jpeg"));
  playlist2.add(new Song(this, "Darling I.mp3","Chromakopia","Chromakopia Album.jpeg" ));



  
  //Adding all the playlists to 2d array
  allPlaylists.add(defaultPlaylist);
  allPlaylists.add(playlist1);
  allPlaylists.add(playlist2);  
 


  displayNames.add("All Songs");
  displayNames.add("Playlist 1");
  displayNames.add("Playlist 2");

}
void shufflePlaylist(ArrayList<Song> d){
    if(d.size() < 2){
        return;
    }

    //Resets each song in playlist to make sure it starts from beginning of song 
    for(Song song : d){
      song.reset();
    }

    for(int i = d.size() - 1; i > 0; i--){
      int j = int(random(i+1));
      Song temp = d.get(i);
      d.set(i,d.get(j));
      d.set(j,temp);
    }
   
}

void deletePlaylist(){
    int x = 275;
    int y = 50;
    
    boolean playlistDeleted = false;
    
    
    for(int i = allPlaylists.size() - 1; i >= 1; i--){
        drawPlaylist(i, x, y);
        
        

        //drawing the boxes 
        noFill();
        strokeWeight(5);
        rect(x-40,y-25, 125,50);
        

        if(mousePressed && mouseX > x-40 && mouseX < x+85 && mouseY > y-25 && mouseY < y+50){
            allPlaylists.remove(i);
            displayNames.remove(i);
            playlistDeleted = true;
            show_playlist.setItems(displayNames,0);
            
            break;
        }

        x += 180;

        if(x > 900){
            x = 275;
            y += 75;
        }
    }

    if (playlistDeleted) {
        mousePressed = false;
    }  
}

void drawPlaylist(int i, int x, int y){
    String displayName = displayNames.get(i);
    float fontSize = 16;
    textSize(fontSize);

    while(textWidth(displayName) > 105){
        fontSize -= 0.5;
        textSize(fontSize);
    }


    fill(0);
    textAlign(CENTER,CENTER);
    text(displayName, x+20, y);

    
}

void createNewPlaylist(){
    if(selectedSongs.isEmpty()){
        println("No songs selected!");
        return;
    }

    String newPlaylistName = "Playlist " + displayNames.size();

    displayNames.add(newPlaylistName);

    ArrayList<Song> newPlaylist = new ArrayList<Song>();

    for(Song song : selectedSongs){
        newPlaylist.add(song);
    }

    allPlaylists.add(newPlaylist);

    selectedSongs.clear();

    show_playlist.setItems(displayNames,0);
}

void playlistCreateDisplay() {
    drawSongs();
    int x = 275; 
    int y = 50;  //

    for (int i = 0; i < defaultPlaylist.size(); i++) { 
        Song song = defaultPlaylist.get(i);

        // Check if mouse is over the current song
        if (mousePressed && mouseX > x - 40 && mouseX < x + 85 && mouseY > y - 25 && mouseY < y + 50) {
            if(!selectedSongs.contains(song)){
                selectedSongs.add(song);
                song.clicked = true; // Mark the song as clicked
            }
            
        }

        // Update position for the next song
        x += 180; 
        if (x > 900) { // Check if the row is full
            x = 275; 
            y += 75; 
        }
    }
}
