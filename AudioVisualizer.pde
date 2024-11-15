class AudioVisualizer{
  PVector p1, p2;    // top left and bottom right of graph
 
  
  AudioVisualizer(PVector pos1, PVector pos2){
    this.p1 = pos1;
    this.p2 = pos2;
  }
  
  void update(){
    fft.input(playlist.get(songIndex).song);

    fft.analyze(spectrum);
    for(int i = 0; i < bands; i++){
      line(map(i, 0, 512, 0, width), height, map(i, 0, 512, 0, width), height - spectrum[i]*height*20);
      
    }
    printArray(spectrum);

    //Song currentSong = playlist.get(songIndex);
    //if(currentSong.song.isPlaying()){
      
    //  }
  }
}
