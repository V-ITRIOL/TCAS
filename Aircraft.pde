class Aircraft {
  float x;
  float y;
  float z;
  
  Aircraft() {
    x = random(0, width);
    y = random(0, height);
  }
  
  void update() {
    
  }
  
  void show() {
    noFill();
    stroke(255);
    strokeWeight(0.5);
    quad(x, y, x+5, y+8, x+10, y, x+5, y-8);
  }
}
