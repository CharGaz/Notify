//Importing Libraries
import processing.sound.*;
import g4p_controls.*;
import java.io.File;
import java.io.InputStreamReader;

//Importing Images
PImage soundImg;
PImage speedImg;
PImage logo;

//Creating boolean variables
boolean playSong = false;
boolean playStatus = false;
boolean displayPlay = true;
boolean isLooping = false;
boolean delete = false;
boolean create = false;



//Creating Arraylists for all the playlist/songs
ArrayList<ArrayList<Song>> allPlaylists = new ArrayList<ArrayList<Song>>(); //2D arraylist to hold all playlists
ArrayList<Song> defaultPlaylist = new ArrayList<Song>(); //Defualt playlist with all the songs
ArrayList<Song> playlist1 = new ArrayList<Song>(); //Another set playlist 
ArrayList<Song> playlist2 = new ArrayList<Song>(); //Another set playlist 

ArrayList<Song> playlist; //Arraylist that will hold the songs of the current playlist
ArrayList<Song> selectedSongs = new ArrayList<Song>(); // Arraylist that will hold the selected songs by the user when making a new playlist

ArrayList<String> displayNames = new ArrayList<String>();//Arraylist to hold the names of the playlists


//Int values
int songIndex = 0;
int loopIndex = 1;
int selectedIndex;
int playlistCounter = 3;

//Float values
float playBackSpeed = 1.0;
float setVolume = 0.9;

// Audio Analyzer Setup
int bands;
float[] spectrum;
AudioIn in;
FFT fft;
AudioVisualizer audioVisualizer;

String youtubeURL;

void setup(){
  //Setting up background and size of the canvas:
  size(1200, 600);
  background(197, 211, 232);
  frameRate(120);

  
  initializePlaylists(); //Initializeds all the playlists
  setActivePlaylist(0); //Sets the active playlist to all songs

  

  bands = 512;
  spectrum = new float[bands];
  fft = new FFT(this, bands);
   
  audioVisualizer = new AudioVisualizer(950, width-25);
    
  createGUI(); //Creating thew GUI

  //Loading the images into the sketch
  soundImg = loadImage("Audio button.png");
  speedImg = loadImage("Stop Watch.png");
  logo = loadImage("logo.png");
  
}

void draw(){
  //Drawing the background, images and songs
  background(158, 163, 210);
  drawUI();
  image(soundImg,880,530, 48,48);
  image(speedImg, 881, 480, 39, 39);
  image(logo,0,45, 190,50);
  drawSongs();
  
  //Displaying the info of the songs(Title, Album and Album Cover)
  if(playlist.size() > 0){
      playlist.get(songIndex).displayInfo(this);
    }

  

   playlist.get(songIndex).playSong(playBackSpeed, setVolume);//Putting the playback speed and volume into the song class
  
  if(!playlist.get(songIndex).song.isPlaying() && playStatus){ //Checking if a songs is playing
    
    playStatus = false;
    if(!isLooping){ //Checking if the user wants the song to be looping
      songIndex = (songIndex + 1) % playlist.size(); //If not looping, plays next song
    }

    
    
  }
  audioVisualizer.update(); //Updating Audio Visulizer

  
}

void setActivePlaylist(int index){ //Switches between the playlists
  if(index >= 0 && index < allPlaylists.size()){

    if(playlist != null && playlist.size() > 0 && playlist.get(songIndex).song.isPlaying()){ //Stoping the song when it switches playlists
      playlist.get(songIndex).stopSong();
      
    }
    playStatus = false; // Reset play status
    playSong = false; //Pauses the songs
    displayPlay = true; //Displays the play button to indicate pause

    playlist = allPlaylists.get(index); //Putting the requested playlists song into arraylist that will be used by program
    songIndex = 0; // Reset songIndex when switching playlists
  } 
}

void drawUI(){
  // left frame
  fill(158, 163, 210);
  strokeWeight(0);
  rect(0, 0, 200, height);
  
  // bottom frame
  fill(184,186,204);
  rect(200, height - 150, 925, height - 150);

  //Bottom right frame:
  fill(209,211,234);
  rect(925,300, width, height);

  //right frame
  strokeWeight(0);
  rect(925,0, width, height);
  
  // divisor lines
  stroke(2, 1, 10);
  fill(2, 1, 10);
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

  //Having the delete playlist screen come up
  if(delete){
    returnButton.setVisible(true);
    deletePlaylist();
  }
 
  //Having the create playlist screen come up
  else if(create){
    returnButton.setVisible(true);
    confirmButton.setVisible(true);
    playlistCreateDisplay();
    

  }
  else{
    returnButton.setVisible(false);
    confirmButton.setVisible(false);
  }
}

void drawSongs(){
  if(!delete){
    int x = 275; //Setting base x and y values 
    int y = 50;

    for(int i = 0; i < playlist.size(); i++){ //Checking how many songs are in the playlist
      playlist.get(i).printSongs(this,x,y); //Inputs all song info into printSongs function
      noFill();
      strokeWeight(5);
      rect(x-40,y-25, 125,50);
      x += 180; //Moves x over by 200 every time
      
      if(x > 900){
        x = 275; //When x reaches the end of panal, it resest to the start
        y += 75; //When x resets, y moves down to create a new row
      }
    }
  }
}

void getYoutubeWindows(String url){
  try {
    String downloadPath = sketchPath("data");
    String[] commands = {"yt-dlp", "-o", downloadPath + "/%(title)s.%(ext)s", "--extract-audio", "--audio-format", "mp3", url};    
    ProcessBuilder processBuilder = new ProcessBuilder(commands);
    processBuilder.directory(new File(downloadPath));
    Process process = processBuilder.start();
    process.waitFor();
    
    Thread.sleep(500);
    
    regenerateDefaultPlaylist();

  } 
  catch (IOException e) {
    println(e.getMessage()); 
  }
  catch (InterruptedException e){
    println(e.getMessage());
  }
}

void getYoutubeMac(String url){
  try {
    String downloadPath = sketchPath("data"); 
    String[] commands = {"/usr/local/bin/yt-dlp", "-o", downloadPath + "/%(title)s.%(ext)s", "--extract-audio", "--audio-format", "mp3", url};
    ProcessBuilder processBuilder = new ProcessBuilder(commands);
    processBuilder.directory(new File(downloadPath));
    Process process = processBuilder.start();
    process.waitFor();
    
    Thread.sleep(500);
    
    regenerateDefaultPlaylist();
    
  } 
  
  catch (IOException e) {
    println("Error: " + e.getMessage()); 
  }
  catch (InterruptedException e){
    println(e.getMessage());
  }
}



void regenerateDefaultPlaylist(){
  String downloadPath = sketchPath("data");
  File[] songsDataDir = new File(sketchPath("data")).listFiles();
  
  try{
    for(File file: songsDataDir){
      if(file.getName().endsWith(".webm")){
        String inputFile = file.getAbsolutePath();
        String outputFile = inputFile.substring(0, inputFile.length() - 5) + ".mp3";
        // TEMP FILE NAME  

        String[] findCommands = {"which", "ffmpeg"};
        ProcessBuilder findFfmpeg = new ProcessBuilder(findCommands);
        Process runFfmpeg = findFfmpeg.start();
        BufferedReader cmdOutput = new BufferedReader(new InputStreamReader(runFfmpeg.getInputStream()));
        String ffmpegSource = cmdOutput.readLine(); 
        println(ffmpegSource);
        //String ffmpegSource = "/usr/local/bin/ffmpeg";
        //"C:\\Users\\jeffw\\AppData\\Local\\Microsoft\\WinGet\\Packages\\Gyan.FFmpeg_Microsoft.Winget.Source_8wekyb3d8bbwe\\ffmpeg-7.1-full_build\\bin\\ffmpeg.exe"
       
        String[] commands = {ffmpegSource, "-i", inputFile, outputFile};        
        ProcessBuilder processBuilder = new ProcessBuilder(commands);
        processBuilder.directory(new File(downloadPath));
        Process process = processBuilder.start();
        process.waitFor();
      }
    }
  }
  
  catch (IOException e) {
    println(e.getMessage()); 
  }
  catch (InterruptedException e){
    println(e.getMessage());
  }
  
  downloadPath = sketchPath("data");
  songsDataDir = new File(sketchPath("data")).listFiles();
  
  for(File file: songsDataDir){
    if(file.getName().endsWith(".mp3")){
      boolean fileFound = false;
      for(Song song: defaultPlaylist){
        if(file.getName().equals(song.name)){
          fileFound = true;
        }
      }
      if(!fileFound){
        Song tempSong = new Song(this, file.getName(), "TEST ALBUM", "Image.jpeg");
        defaultPlaylist.add(tempSong);
       
      }
    } 
  }
}