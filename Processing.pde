import processing.sound.*;
import g4p_controls.*;


boolean playSong = false;
boolean playStatus = false; //Stops the terminal from being filled with messages

ArrayList<Song> playList1 = new ArrayList<Song>();
int songIndex = 0;
void setup(){
    size(1200,600);
    background(0);
    playList1.add(new Song(this,"Benzi Box.mp3","The Mouse and The Mask", "Mouse and the Mask.jpeg"));
    playList1.add(new Song(this, "Darling I.mp3","Chromakopia","Chromakopia Album.jpeg" ));
    playList1.add(new Song(this,"St Chroma.mp3","Chromakopia","Chromakopia Album.jpeg"));
    playList1.add(new Song(this, "Doomsday.mp3", "Operation: DOOMSDAY","Operation Doomsday Album Cover.jpeg" ));
    
    createGUI();
    
}

void draw(){
    if(playList1.size() > 0){
        playList1.get(songIndex).displayArt(this);
    }
    playList1.get(songIndex).playSong();

    if(!playList1.get(songIndex).song.isPlaying() && playStatus ){
        playStatus = false;
        songIndex = (songIndex + 1) % playList1.size(); //loops songs in playlist
    }
    
    
}

void shufflePlaylist(ArrayList<Song> playlist){
    if(playList1.size() < 2){
        return;
    }

    for(int i = playlist.size() - 1; i > 0; i-- ){
        int j = int(random(i+1)); //Random index from 1 - the size of the playlist
        Song temp = playlist.get(i);
        playlist.set(i, playlist.get(j));
        playlist.set(j,temp);
    }

}