void setup(){
  size(1200, 600);
  background(150);
}

void draw(){
  background(150);
  
  drawUI();
}

void drawUI(){
  // left frame
  fill(165, 250, 196);
  strokeWeight(0);
  rect(0, 0, 200, height);
  
  // bottom frame
  rect(200, height - 150, width, height - 150);
  
  // divisor lines
  stroke(45, 227, 112);
  fill(43, 181, 94);
  strokeWeight(2);
  rect(200, 0, 5, height);    // left line
  
  rect(205, height - 150, width, 5);    // bottom line
  
  
}
