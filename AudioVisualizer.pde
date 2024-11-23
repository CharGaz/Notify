class AudioVisualizer {
  float p1, p2;    // top left and bottom right of graph
  int amp = 20;
  float lerpIntensity = 0.1;

  float[] prev1 = new float[bands];
  float[] prev2 = new float[bands];
  float[] prev3 = new float[bands];
  float[] prev4 = new float[bands];

  AudioVisualizer(float pos1, float pos2) {
    this.p1 = pos1;
    this.p2 = pos2;
  }

  void update() {
    if (playlist != null) {
      // input and apply the fast fourier transform to get data about sound frequencies
      fft.input(playlist.get(songIndex).song);
      fft.analyze(spectrum);

      // cut the number of lines in half for visual clarity
      float[] reducedSpectrum = new float[bands/2];
      for (int i = 0; i < bands; i+=2) {
        reducedSpectrum[i/2] = (spectrum[i] + spectrum[i+1]) / 2;
      }

      // use linear interpolation to smooth out graph movements
      for (int i = 0; i < reducedSpectrum.length; i++) {
        reducedSpectrum[i] = lerp(prev1[i], reducedSpectrum[i], lerpIntensity);
      }

      // draw all points/circles on the graph
      for (int i = 0; i < reducedSpectrum.length; i++) {
        // change color based on i
        stroke(50+i, 0, 128 + 2*i);
        strokeWeight(3);
        
        // change the range of x values to those that match the desired position of the graph
        float newI = map(i, 0, (bands - 1)/2, p1, p2);
        float newY;

        // smooth out the graph with previous iterations if they are available
        if (prev1 != null && prev2 != null && prev3 != null && prev4 != null) {
          newY = (reducedSpectrum[i] + prev1[i] + prev2[i] + prev3[i] + prev4[i]) / 5;
        } else {
          newY = reducedSpectrum[i];
        }

        strokeWeight(1);
        
        // ensure the Y values dont exceed a certain point
        newY = constrain(newY*amp*400, 0, 250 + random(0, 5));
        
        // draw the circles
        ellipse(newI, height - 150, 1, newY);
        
        // smooth out the horizontal ends of the graph
        int tempWidth = 2;
        if (newI <= p1 + tempWidth || newI >= p2 - tempWidth) tempWidth = 1;
        
        // draw very small points for better smoothing
        circle(newI, height - 150, tempWidth);
      }

      // Update previous spectrum arrays
      prev4 = prev3;
      prev3 = prev2;
      prev2 = prev1;
      prev1 = reducedSpectrum;

    }
  }
}
