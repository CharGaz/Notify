void setup(){
  size(1200, 600);
  background(197, 211, 232);
}

void draw(){
  background(197, 211, 232);
  
  drawUI();
}

void drawUI(){
  // left frame
  fill(208, 232, 197);
  strokeWeight(0);
  rect(0, 0, 200, height);
  
  // bottom frame
  rect(200, height - 150, width, height - 150);
  
  // divisor lines
  stroke(166, 174, 191);
  fill(166, 174, 191);
  strokeWeight(2);
  rect(200, 0, 5, height);    // left line
  rect(205, height - 150, width, 5);    // bottom line
  
  
}
