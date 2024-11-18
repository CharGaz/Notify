import processing.sound.*;
import g4p_controls.*;

PImage soundImg;
PImage speedImg;

boolean playSong = false;
boolean playStatus = false;
boolean displayPlay = true;
boolean isLooping = false;



ArrayList<Song> playlist = new ArrayList<Song>();
int songIndex = 0;
int loopIndex = 1;

float playBackSpeed = 1.0;
float setVolume = 0.9;

// Audio Analyzer Setup
int bands;
float[] spectrum;
AudioIn in;
FFT fft;
AudioVisualizer audioVisualizer;


void setup(){
    size(1200, 600);
    //background(197, 211, 232);
    background(158,163,210);

    frameRate(120);

    playlist.add(new Song(this,"Benzi Box.mp3","Mouse and the Mask", "Mouse and the Mask.jpeg"));
    playlist.add(new Song(this, "Darling I.mp3","Chromakopia","Chromakopia Album.jpeg" ));
    playlist.add(new Song(this,"St Chroma.mp3","Chromakopia","Chromakopia Album.jpeg"));
    playlist.add(new Song(this, "Doomsday.mp3", "Operation: DOOMSDAY","Operation Doomsday Album Cover.jpeg" ));
    playlist.add(new Song(this, "Rhymes Like Dimes.mp3", "Operation: DOOMSDAY","Operation Doomsday Album Cover.jpeg" ));
    playlist.add(new Song(this, "Potholderz.mp3", "MM Food","MM Food.jpeg" ));

    bands = 512;
    spectrum = new float[bands];
    fft = new FFT(this, bands);
    //in = new AudioIn(this, 0);
    
    //in.start();
   
    audioVisualizer = new AudioVisualizer(950, width-25);
    
    createGUI();
    //soundImg = loadImage("Audio button.png");
}

void draw(){
  //background(197, 211, 232);
  background(158,163,210);
  drawUI();
  //image(soundImg,880,530, 48,48);
   
    
  //image(soundImg,880,530, 48,48);
  drawSongs();
  
  if(playlist.size() > 0){
      playlist.get(songIndex).displayInfo(this);
    }

  

   playlist.get(songIndex).playSong(playBackSpeed, setVolume);//Putting the playback speed and volume into the song class
  
  if(!playlist.get(songIndex).song.isPlaying() && playStatus){
    
    playStatus = false;
    if(!isLooping){
      songIndex = (songIndex + 1) % playlist.size();
    }

    
    
  }
  audioVisualizer.update();


}

void drawUI(){
  // left frame
  //fill(208, 232, 197);
  fill(158,163,210);
  strokeWeight(0);
  rect(0, 0, 200, height);
  
  // bottom frame
  fill(184, 186, 204);
  rect(200, height - 150, 925, height - 150);

  //right frame
  strokeWeight(0);
  rect(925,0, width, 300);
  
  // bottim right audio visualizer frame
  fill(209, 211, 234);
  rect(925, 300, width, height);
  
  // divisor lines
  //stroke(166, 174, 191);
  //fill(166, 174, 191);
  stroke(2, 1, 10);
  fill(2, 1, 10);
  strokeWeight(2);
  rect(200, 0, 5, height);    // left line
  rect(205, height - 150, 723, 5);    // bottom line
  rect(925, 0, 5, height); //right line
  rect(925,300, width, 5); // right panal divisor
  
  //Having either play or pause button on the screen at one given time
  if(displayPlay){
    play_button.setVisible(true);
    pause_button.setVisible(false);
  }
  else{
    play_button.setVisible(false);
    pause_button.setVisible(true);
  }


  //Changing the loop button from black(off) to white(on)
  if((loopIndex % 2) == 0){
    loop_button.setVisible(false);
    loop_buttonWhite.setVisible(true);
  }

  else{
    loop_button.setVisible(true);
    loop_buttonWhite.setVisible(false);

  }
  
}

// TODO: rename varaibles, DOES NOT FULLY WORK, TEMP SOLUTION
void drawSongs(){
  
  int startX = 200;
  int endX = 900;
  int startY = 100;
  int rowSize = 3;
  int boxWidth = 150;
  int spacing = (endX - startX) / (rowSize + 1);
  
  int i = 1;
  
  for(Song song: playlist){
    noFill();
    stroke(0);
    strokeWeight(5);
    rect(startX + i*spacing - boxWidth / 2, startY - boxWidth / 2, boxWidth, boxWidth);
    song.printSongs(this, startX + i*spacing, startY);
    
    i++;
    if(i > rowSize){
      i = 1;
      startY += spacing;
    }
  }
}

void shufflePlaylist(ArrayList<Song> d){
    if(playlist.size() < 2){
        return;
    }

    //Resets each song in playlist to make sure it starts from beginning of song 
    for(Song song : d){
      song.reset();
    }

    for(int i = d.size() - 1; i > 0; i--){
        int j = int(random(i+1));
        Song temp = d.get(i);
        playlist.set(i,d.get(j));
        playlist.set(j,temp);
    }
}
