class AudioVisualizer{
  float p1, p2;    // top left and bottom right of graph
  int f = 0;
  
  AudioVisualizer(float pos1, float pos2){
    this.p1 = pos1;
    this.p2 = pos2;
  }
  
  void update(){
    fft.input(playlist.get(songIndex).song);
    
    if(f%1==0) fft.analyze(spectrum);
    
    float highestBand = 0;
    float lowestBand = 0;
    for(int i = 0; i < bands; i++){
      if(highestBand > spectrum[i]){
        highestBand = spectrum[i];
      }
      if(spectrum[i] < lowestBand){
        lowestBand = spectrum[i];
      }
    }
    
    float[] reducedSpectrum = new float[bands/2];
    
    for(int i = 0; i < bands; i+=2){
      reducedSpectrum[i/2] = (spectrum[i] + spectrum[i+1]) / 2;
    }
    
    for(int i = 0; i < reducedSpectrum.length; i++){
      stroke(128, 0, 128 + i);
      strokeWeight(3);
      float newI = map(i, 0, (bands - 1)/2, p1, p2);
      //float newY = map(height - 50 - spectrum[i]*height*10, 0, height - 50 - spectrum[i]*height*10, 0, height - 50 - highestBand*height*10);
    
      float newY = height - 50 - reducedSpectrum[i]*height*10;
      line(newI, height - 50, newI, newY);
      println(newY);
    }
    f++;
  }
}
