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
        String songName = this.name.substring(0,this.name.length()-4);
        float fontSize = 20; //base font size
        sketch.textSize(fontSize);

        while(sketch.textWidth(songName) > 215 ){ 
            fontSize -= 0.5; //Makes font size smaller until text fits into the rectangle
            sketch.textSize(fontSize);
        }

        sketch.textAlign(LEFT, BASELINE);
        fill(0);
        sketch.text("Album: " + this.album, 935,240);
        sketch.text("Song: " + songName, 935,265);
        sketch.text("Artist: ", 935, 290);

        if(cover != null){
            sketch.image(this.cover, 967,20, 200,200);
        }

        else{
            sketch.image(this.noCover,967,20, 200,200);
        }

        
    }

    void playSong(float speed, float volume){
        if(playSong){
            if(!this.song.isPlaying() && !playStatus){
                playStatus = true;
                this.song.play(speed,volume);
            }
        } 

        else if(!playSong && playStatus){
            this.song.pause();
            playStatus = false;
        }
    }
    void stopSong(){
        if(this.song.isPlaying()){
            this.song.stop();
        }
    }

    void reset(){
        this.song.stop();
        this.song.cue(0.0);
    }

    void printSongs(PApplet sketch, int x, int y){
        
        String displayName = this.name.substring(0, this.name.length()-4);

        float fontSize = 16; //base font size
        sketch.textSize(fontSize);

        while(sketch.textWidth(displayName) > 105 ){ //100 is the width of the rect - the edge of rect 
            fontSize -= 0.5; //Makes font size smaller until text fits into the rectangle
            sketch.textSize(fontSize);
        }
        if(this.clicked && create){
            sketch.fill(0,255,0);
        }
        else{
            sketch.fill(0);
        }
        
        sketch.textAlign(CENTER,CENTER); //Centers text in the rectangle
        sketch.text(displayName,x+20,y);

        sketch.textAlign(LEFT, BASELINE);
    }

}