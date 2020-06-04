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
    fill(255);
    stroke(255);
    quad(x, y, x+5, y+7, x+10, y, x+5, y-7);
  }
}
