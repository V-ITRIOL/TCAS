class Aircraft {
  float x;
  float y;
  float velx;
  float vely;
  
  Aircraft() {
    x = random(135, 660);
    y = 500 - sin(PI);
  }
  
  void update() {
    y = y + 5;
  }
  
  void show() {
    noFill();
    stroke(255);
    strokeWeight(0.5);
    
    
    quad(x, y, x+5, y+8, x+10, y, x+5, y-8);
  }
}
