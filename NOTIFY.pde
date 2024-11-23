// NOTIFY by Lachlan O'Keefe and Charlie Gazzola
//
// NOTIFY allows a user to create, store and delete songs/playlists. Songs can be skipped, paused/played,
// sped up, shuffled, and more at just the push of a button. Using NOTIFY, Youtube videos, most often songs,
// can be downloaded for offline, ad-free listening. An Audio Visualizer is included to enhance the aesthetic
// listening experience.


// Importing Libraries
import processing.sound.*;
import g4p_controls.*;
import java.io.File;
import java.io.InputStreamReader;


//Importing Images
PImage soundImg;
PImage speedImg;
PImage logo;


// Creating boolean variables
boolean playSong = false;
boolean playStatus = false;
boolean displayPlay = true;
boolean isLooping = false;
boolean delete = false;
boolean create = false;


// Creating Arraylists for all the playlist/songs
ArrayList<ArrayList<Song>> allPlaylists = new ArrayList<ArrayList<Song>>(); //2D arraylist to hold all playlists
ArrayList<Song> defaultPlaylist = new ArrayList<Song>(); //Defualt playlist with all the songs

ArrayList<Song> playlist; //Arraylist that will hold the songs of the current playlist
ArrayList<Song> selectedSongs = new ArrayList<Song>(); // Arraylist that will hold the selected songs by the user when making a new playlist
ArrayList<String> displayNames = new ArrayList<String>();//Arraylist to hold the names of the playlists


// Int values
int songIndex = 0;
int loopIndex = 1;
int selectedIndex;
int playlistCounter = 3;
int pageNumber = 1;
int numPages = 1;


// Float values
float playBackSpeed = 1.0;
float setVolume = 0.9;


// Audio Analyzer Setup
int bands;
float[] spectrum;
AudioIn in;
FFT fft;
AudioVisualizer audioVisualizer;

// Youtube Downloader variables
String youtubeURL;

void setup() {
  //Setting up background and size of the canvas:
  size(1200, 600);
  background(197, 211, 232);
  frameRate(120);


  initializePlaylists(); //Initializeds all the playlists
  setActivePlaylist(0); //Sets the active playlist to all songs

  regenerateDefaultPlaylist();


  bands = 512;
  spectrum = new float[bands];
  fft = new FFT(this, bands);

  audioVisualizer = new AudioVisualizer(950, width-25);

  createGUI(); //Creating the GUI

  //Loading the images into the sketch
  soundImg = loadImage("Audio button.png");
  speedImg = loadImage("Stop Watch.png");
  logo = loadImage("logo.png");
}

void draw() {
  //Drawing the background, images and songs
  background(158, 163, 210);
  drawUI();
  image(soundImg, 880, 530, 48, 48);
  image(speedImg, 881, 480, 39, 39);
  image(logo, 0, 45, 190, 50);
  drawSongs();

  //Displaying the info of the songs(Title, Album and Album Cover)
  if (playlist.size() > 0) {
    playlist.get(songIndex).displayInfo(this);
  }

  playlist.get(songIndex).playSong(playBackSpeed, setVolume);//Putting the playback speed and volume into the song class
  if (!playlist.get(songIndex).song.isPlaying() && playStatus) { //Checking if a songs is playing

    playStatus = false;
    if (!isLooping) { //Checking if the user wants the song to be looping
      songIndex = (songIndex + 1) % playlist.size(); //If not looping, plays next song
    }
  }
  
  audioVisualizer.update();

}

void setActivePlaylist(int index) { //Switches between the playlists
  println("Index: " + index + " Size: " + allPlaylists.size());
  if (index >= 0 && index < allPlaylists.size()) {
    println("SETSPLAYLIST");
    if (playlist != null && playlist.size() > 0 && playlist.get(songIndex).song.isPlaying()) { //Stoping the song when it switches playlists
      playlist.get(songIndex).stopSong();
    }
    playStatus = false; // Reset play status
    playSong = false; // Pauses the songs
    displayPlay = true; // Displays the play button to indicate pause

    playlist = allPlaylists.get(index); //Putting the requested playlists song into arraylist that will be used by program
    songIndex = 0; // Reset songIndex when switching playlists
  }
}

void drawUI() {
  // left frame
  fill(158, 163, 210);
  strokeWeight(0);
  rect(0, 0, 200, height);

  // bottom frame
  fill(184, 186, 204);
  rect(200, height - 150, 925, height - 150);

  //Bottom right frame:
  fill(209, 211, 234);
  rect(925, 300, width, height);

  //right frame
  strokeWeight(0);
  rect(925, 0, width, height);

  // divisor lines
  stroke(2, 1, 10);
  fill(2, 1, 10);
  strokeWeight(2);
  rect(200, 0, 5, height);    // left line
  rect(205, height - 150, 723, 5);    // bottom line
  rect(925, 0, 5, height); //right line
  rect(925, 300, width, 5); // right panal divisor
  rect(0, 190, 200, 5); //left panal dvisor

  //Having either play or pause button on the screen at one given time
  if (displayPlay) {
    play_button.setVisible(true);
    pause_button.setVisible(false);
  } else {
    play_button.setVisible(false);
    pause_button.setVisible(true);
  }


  //Changing the loop button from black(off) to white(on)
  if ((loopIndex % 2) == 0) {
    loop_button.setVisible(false);
    loop_buttonWhite.setVisible(true);
  } else {
    loop_button.setVisible(true);
    loop_buttonWhite.setVisible(false);
  }

  //Having the delete playlist screen come up
  if (delete) {
    returnButton.setVisible(true);
    deletePlaylist();
  }

  //Having the create playlist screen come up
  else if (create) {
    returnButton.setVisible(true);
    confirmButton.setVisible(true);
    playlistCreateDisplay();
  } else {
    returnButton.setVisible(false);
    confirmButton.setVisible(false);
  }
}

void drawSongs() {
  if (!delete && playlist != null) {
    int x = 275; //Setting base x and y values
    int y = 50;

    // Find the number of pages
    numPages = 1 + (playlist.size() / 20);

    for (int i = 20*(pageNumber - 1); i < Math.min(playlist.size(), 20*(pageNumber-1) + 20); i++) { //Checking how many songs are in the playlist
      playlist.get(i).printSongs(this, x, y); //Inputs all song info into printSongs function
      noFill();
      strokeWeight(5);
      rect(x-40, y-25, 125, 50);
      x += 180; //Moves x over by 200 every time

      if (x > 900) {
        x = 275; //When x reaches the end of panal, it resest to the start
        y += 75; //When x resets, y moves down to create a new row
      }
    }
  }
}

void getYoutubeWindows(String url) {
  try {
    String downloadPath = sketchPath("data");  // where to download videos to
    
    // commands to run for downloading a youtube video
    String[] commands = {"yt-dlp", "-o", downloadPath + "/%(title)s.%(ext)s", "--extract-audio", "--audio-format", "mp3", url};
   
    // setup required to run commands
    ProcessBuilder processBuilder = new ProcessBuilder(commands);
    processBuilder.directory(new File(downloadPath));
    
    Process process = processBuilder.start();  // begin running commands
    process.waitFor();  // wait for process to finish

    Thread.sleep(500);  // ensure file is fully written before continuing 

    regenerateDefaultPlaylist();  // redo the default playlist
  }
  catch (IOException e) {
    println(e.getMessage());
  }
  catch (InterruptedException e) {
    println(e.getMessage());
  }
}

void regenerateDefaultPlaylist() {
  // find the download path
  String downloadPath = sketchPath("data");
  File[] songsDataDir = new File(sketchPath("data")).listFiles();

  // begin by reformatting all .webm files to .mp3
  try {
    for (File file : songsDataDir) {
      // if a .webm file is found
      if (file.getName().endsWith(".webm")) {
        boolean fileFound = false;
        for (File searchFile : songsDataDir) {
          // if there exists a .webm file with a .mp3 counterpart, skip it
          if (searchFile.getName().equals(file.getName().substring(0, file.getName().length() - 5) + ".mp3")) fileFound = true;
        }

        // if there is no .mp3 version of a .webm file, convert it
        if (!fileFound) {
          String inputFile = file.getAbsolutePath();
          String outputFile = inputFile.substring(0, inputFile.length() - 5) + ".mp3";

          String ffmpegSource = "/usr/local/bin/ffmpeg";

          String[] commands = {ffmpegSource, "-i", inputFile, outputFile};
          ProcessBuilder processBuilder = new ProcessBuilder(commands);
          processBuilder.directory(new File(downloadPath));
          Process process = processBuilder.start();
          process.waitFor();    // wait for process to finish before continuing
        }
      }
    }
  }

  catch (IOException e) {
    println(e.getMessage());
  }
  catch (InterruptedException e) {
    println(e.getMessage());
  }

  // after reformatting .webm files to .mp3, add them to the default playlist, which contains all songs
  downloadPath = sketchPath("data");
  songsDataDir = new File(sketchPath("data")).listFiles();

  // find if a .mp3 already exists within the default playlist
  for (File file : songsDataDir) {
    if (file.getName().endsWith(".mp3")) {
      boolean fileFound = false;
      for (Song song : defaultPlaylist) {
        if (file.getName().equals(song.name)) {
          fileFound = true;
        }
      }
      
      // if it doesnt exist in the default playlist, add it
      if (!fileFound) {
        Song tempSong = new Song(this, file.getName(), "Image.jpeg");
        defaultPlaylist.add(tempSong);
        setActivePlaylist(0);
      }
    }
  }
}
