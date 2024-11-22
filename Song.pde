class Song{
    String name;
    String album; 
    String artWork;
    boolean clicked;
    SoundFile song;
    PImage cover; 
    PImage noCover;

    //CONSTRUCTOR
    Song(PApplet sketch, String n, String a, String aw){
        this.name = n;
        this.album = a;
        this.artWork = aw;
        this.clicked = false;
        this.song = new SoundFile(sketch, n);
        this.cover = sketch.loadImage(aw);
        this.noCover = sketch.loadImage("Image.jpeg");
    }

    void displayInfo(PApplet sketch){
        String songName = this.name.substring(0,this.name.length()-4); //Removing .mp3 on the file names to get the song names
        float fontSize = 20; //base font size
        sketch.textSize(fontSize); //setting text size to font size

        while(sketch.textWidth(songName) > 215 ){  //Checking if the song name will go out of the skech
            fontSize -= 0.5; //Makes font size smaller until text fits into the panal
            sketch.textSize(fontSize); //setting text size to the new font size
        }

        sketch.textAlign(LEFT, BASELINE); //centering the text to the panal
        fill(0); //Making the text black
        sketch.text("Album: " + this.album, 935,240); //Drawing the text to the canvas/sketch
        sketch.text("Song: " + songName, 935,265);

        if(cover != null){
            sketch.image(this.cover, 967,20, 200,200); //If there is an album cover, then is will be drawn
        }

        else{
            sketch.image(this.noCover,967,20, 200,200);//if there is no cover, then a set picture will go in its place
        }

        
    }

    void playSong(float speed, float volume){
        if(playSong){ //If user presses play
            if(!this.song.isPlaying() && !playStatus){ //Checking if a song is already playing
                playStatus = true;
                this.song.play(speed,volume); //Playing song with the requested speed and volume of the user
            }
        } 

        else if(!playSong && playStatus){ //Checking if the user presses pause
            this.song.pause(); //Pauses song
            playStatus = false;
        }
    }

    void stopSong(){
        if(this.song.isPlaying()){
            this.song.stop(); //Full stoping the song
        }
    }

    void reset(){
        this.song.stop(); //Full stops the song
        this.song.cue(0.0); //Resests the song back to 0.0
    }

    void printSongs(PApplet sketch, int x, int y){ //printing the song name
        
        String displayName = this.name.substring(0, this.name.length()-4); // taking off .mp3 to get the song name

        float fontSize = 16; //base font size
        sketch.textSize(fontSize);

        while(sketch.textWidth(displayName) > 105 ){ //100 is the width of the rect - the edge of rect 
            fontSize -= 0.5; //Makes font size smaller until text fits into the rectangle
            sketch.textSize(fontSize);
        }

        if(this.clicked && create){ //When the user is creating a playlist and clicks a certain song
            sketch.fill(0,255,0); //Changes the song colour to be green to indicate being selected
        }
        else{
            sketch.fill(0); //Base colour is black 
        }
        
        sketch.textAlign(CENTER,CENTER); //Centers text in the rectangle
        sketch.text(displayName,x+20,y); //displaying the text into the rectangle

        sketch.textAlign(LEFT, BASELINE); //Reseting the text align 
    }

}