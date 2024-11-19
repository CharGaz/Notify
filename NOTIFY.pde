import processing.sound.*;
import g4p_controls.*;

PImage soundImg;
PImage speedImg;
PImage logo;

boolean playSong = false;
boolean playStatus = false;
boolean displayPlay = true;
boolean isLooping = false;



ArrayList<ArrayList<Song>> allPlaylists = new ArrayList<ArrayList<Song>>();
ArrayList<Song> defaultPlaylist = new ArrayList<Song>();
ArrayList<Song> playlist1 = new ArrayList<Song>();
ArrayList<Song> playlist2 = new ArrayList<Song>();

ArrayList<Song> playlist;

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
  frameRate(120);

  
  initializePlaylists();
  setActivePlaylist(0); //Sets the active playlist to all songs

  bands = 512;
  spectrum = new float[bands];
  fft = new FFT(this, bands);
   
  audioVisualizer = new AudioVisualizer(950, width-25);
    
  createGUI();
  soundImg = loadImage("Audio button.png");
  speedImg = loadImage("Stop Watch.png");
  logo = loadImage("logo.png");
}

void draw(){
  background(197, 211, 232);
  drawUI();
  image(soundImg,880,530, 48,48);
  image(speedImg, 881, 480, 39, 39);
  image(logo,0,45, 190,50);
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

void setActivePlaylist(int index){ //Switches between the playlists
  if(index >= 0 && index < allPlaylists.size()){

    if(playlist != null && playlist.size() > 0 && playlist.get(songIndex).song.isPlaying()){ //Stoping the song when it switches playlists
      playlist.get(songIndex).stopSong();
      
    }
    playStatus = false; // Reset play status
    playSong = false;
    displayPlay = true;

    playlist = allPlaylists.get(index);
    songIndex = 0; // Reset songIndex when switching playlists
  } 
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
  rect(0,190, 200,5); //left panal dvisor
  
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

void drawSongs(){
  int x = 250; //Setting base x and y values 
  int y = 50;

  for(int i = 0; i < playlist.size(); i++){
    playlist.get(i).printSongs(this,x,y); //Inputs all song info into printSongs function
    noFill();
    strokeWeight(5);
    rect(x-40,y-25, 125,50);
    x += 180; //Moves x over by 200 every time
    
    if(x > 900){
      x = 250; //When x reaches the end of panal, it resest to the start
      y += 75; //When x resets, y moves down to create a new row
    }
  }
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