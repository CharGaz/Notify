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
    background(197, 211, 232);

    playlist.add(new Song(this,"Benzi Box.mp3","Mouse and the Mask", "Mouse and the Mask.jpeg"));
    playlist.add(new Song(this, "Darling I.mp3","Chromakopia","Chromakopia Album.jpeg" ));
    playlist.add(new Song(this,"St Chroma.mp3","Chromakopia","Chromakopia Album.jpeg"));
    playlist.add(new Song(this, "Doomsday.mp3", "Operation: DOOMSDAY","Operation Doomsday Album Cover.jpeg" ));
    playlist.add(new Song(this, "Rhymes Like Dimes.mp3", "Operation: DOOMSDAY","Operation Doomsday Album Cover.jpeg" ));

    bands = 256;
    spectrum = new float[bands];
    fft = new FFT(this, bands);
    //in = new AudioIn(this, 0);
    
    //in.start();
   
    audioVisualizer = new AudioVisualizer(new PVector(0, 0), new PVector(0, 0));
    
    createGUI();
    //soundImg = loadImage("Audio button.png");
}

void draw(){
  background(197, 211, 232);
  drawUI();
  //image(soundImg,880,530, 48,48);
   
    
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
  fill(208, 232, 197);
  strokeWeight(0);
  rect(0, 0, 200, height);
  
  // bottom frame
  rect(200, height - 150, 925, height - 150);

  //right frame
  fill(208,232,197);
  strokeWeight(0);
  rect(925,0, width, height);
  
  // divisor lines
  stroke(166, 174, 191);
  fill(166, 174, 191);
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
