import processing.sound.*;
import g4p_controls.*;

boolean playSong = false;
boolean playStatus = false;
boolean displayPlay = true;

ArrayList<Song> playlist = new ArrayList<Song>();
int songIndex = 0;
void setup(){
    size(1200, 600);
    background(197, 211, 232);

    playlist.add(new Song(this,"Benzi Box.mp3","hi", "Mouse and the Mask.jpeg"));
    playlist.add(new Song(this, "Darling I.mp3","hello","Chromakopia Album.jpeg" ));
    playlist.add(new Song(this,"St Chroma.mp3","greetings","Chromakopia Album.jpeg"));
    playlist.add(new Song(this, "Doomsday.mp3", "welcom","Operation Doomsday Album Cover.jpeg" ));
    
    createGUI();
}

void draw(){
  background(197, 211, 232);
  drawUI();

  playlist.get(songIndex).playSong();

  if(!playlist.get(songIndex).song.isPlaying() && playStatus){
    playStatus = false;
    songIndex = (songIndex + 1) % playlist.size();
  }
}

void drawUI(){
  // left frame
  fill(208, 232, 197);
  strokeWeight(0);
  rect(0, 0, 200, height);
  
  // bottom frame
  rect(200, height - 150, width, height - 150);
  
  // divisor lines
  stroke(166, 174, 191);
  fill(166, 174, 191);
  strokeWeight(2);
  rect(200, 0, 5, height);    // left line
  rect(205, height - 150, width, 5);    // bottom line
  
  if(displayPlay){
    play_button.setVisible(true);
    pause_button.setVisible(false);
  }
  else{
    play_button.setVisible(false);
    pause_button.setVisible(true);
  }
  
}

void shufflePlaylist(ArrayList<Song> d){
    if(playlist.size() < 2){
        return;
    }

    for(int i = d.size() - 1; i > 0; i--){
        int j = int(random(i+1));
        Song temp = d.get(i);
        playlist.set(i,d.get(j));
        playlist.set(j,temp);
    }
}
