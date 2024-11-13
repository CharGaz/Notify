class Song{
    String name;
    String album;
    String artWork;
    SoundFile song;
    PImage img;

    //CONSTRUCTOR:
    Song(PApplet sketch, String n, String a, String aw){
        this.name = n;
        this.album = a;
        this.artWork = aw;
        this.song = new SoundFile(sketch, n, false);
        this.img = sketch.loadImage(aw);
    }

    void displayArt(PApplet sketch){
        
        if(img != null){
            sketch.image(img, 0,0, 800,800);
        }
        else{
            sketch.text("no image found",100,100);
        }
    
        
    }

    void playSong(){
        if(playSong){
            if(!this.song.isPlaying() && !playStatus){ //Stops the song from playing 30 times per second
                this.song.play();
                playStatus = true;
                }
        }  
        else if(!playSong && playStatus){
            this.song.pause();
            playStatus = false;
        }
    }
    void stopSong(){ // Stopung the current song when skip button is pressed
        if(this.song.isPlaying()){
            this.song.stop();
        }

    } 
 
}