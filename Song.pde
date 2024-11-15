class Song{
    String name;
    String album; //may be temperory
    String artWork; //may be temperory
    SoundFile song;
    PImage cover; //Only temp if art will not be displayed

    //CONSTRUCTOR
    Song(PApplet sketch, String n, String a, String aw){
        this.name = n;
        this.album = a;
        this.artWork = aw;
        this.song = new SoundFile(sketch, n, false);
        this.cover = sketch.loadImage(aw);
    }

    void displayInfo(PApplet sketch){
        
        fill(0);
        textSize(20);
        sketch.text("Album: " + this.album, 935,240);
        sketch.text("Song: " + this.name.substring(0,this.name.length()-4), 935,265);
        sketch.text("Artist: ", 935, 290);

        if(cover != null){
            sketch.image(cover, 967,20, 200,200);
        }

        else{
            sketch.text("no album cover found", 900,200);
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
        fill(0);
        sketch.text(this.name.substring(0, this.name.length()-4),x,y);
    }

}
