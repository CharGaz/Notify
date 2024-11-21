class AudioVisualizer{
  float p1, p2;    // top left and bottom right of graph
  int f = 0;
  int amp = 20;
  float lerpIntensity = 0.1;
  
  float[] prev1 = new float[bands];
  float[] prev2 = new float[bands];
  float[] prev3 = new float[bands];
  float[] prev4 = new float[bands];

  
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
      reducedSpectrum[i] = lerp(prev1[i], reducedSpectrum[i], lerpIntensity);
    }
    
    for(int i = 0; i < reducedSpectrum.length; i++){
      stroke(50+i, 0, 128 + 2*i);
      strokeWeight(3);
      float newI = map(i, 0, (bands - 1)/2, p1, p2);
      float newY;
      //float newY = map(height - 50 - spectrum[i]*height*10, 0, height - 50 - spectrum[i]*height*10, 0, height - 50 - highestBand*height*10);
      
      if(prev1 != null && prev2 != null && prev3 != null && prev4 != null){
        //newY = height - 50 - (reducedSpectrum[i]*height*amp + prev1[i]*height*amp + prev2[i]*height*amp + prev3[i]*height*amp + prev4[i]*height*amp) / 5;
        newY = (reducedSpectrum[i] + prev1[i] + prev2[i] + prev3[i] + prev4[i]) / 5;

      }
      else{
        //newY = height - 50 - reducedSpectrum[i]*height*amp;
        newY = reducedSpectrum[i];

      }
      strokeWeight(1);
      //line(newI, height - 50, newI, height - 50 - newY*amp*height);
      newY = constrain(newY*amp*400, 0, 250 + random(0, 5));
      ellipse(newI, height - 150, 1, newY);
      int tempWidth = 2;
      if(newI <= p1 + tempWidth || newI >= p2 - tempWidth) tempWidth = 1;
      circle(newI, height - 150, tempWidth);

    }
    
    prev4 = prev3;
    prev3 = prev2;
    prev2 = prev1;
    prev1 = reducedSpectrum;
    
    f++;
  }
}