class AudioVisualizer{
  PVector p1, p2;    // top left and bottom right of graph
  
  AudioVisualizer(PVector pos1, PVector pos2){
    this.p1 = pos1;
    this.p2 = pos2;
  }
  
  void update(){
    Song currentSong = playlist.get(songIndex);
    if(currentSong.song.isPlaying()){
      // FFT / WAVEFORM
    }
  }
}
