class Song{
    String name;
    String album; //may be temperory
    String artWork; //may be temperory
    SoundFile song;
    PImage cover; //Only temp if art will not be displayed

    //CONSTRUCTOR
    Song(PApplet sketch, String n, String a, String aw){
        this.name = n;
        this.album = album;
        this.artWork = aw;
        this.song = new SoundFile(sketch, n, false);
        this.cover = sketch.loadImage(aw);
    }

    void playSong(){
        if(playSong){
            if(!this.song.isPlaying() && !playStatus){
                this.song.play();
                playStatus = true;
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

}
