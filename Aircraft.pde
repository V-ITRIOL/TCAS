class Aircraft {
  float x;
  float y;
  float velx;
  float vely;
  
  Aircraft() {
    x = random(width/2 - 400*cos(radians(49)), width/2 - 400*cos(radians(132)));
    y = random(500 - 400*sin(radians(49)), 500 - 400*sin(radians(132)));
  }
  
  void update() {
    y = y + 1;
  }
  
  void show() {
    noFill();
    stroke(255);
    strokeWeight(0.5);
    
    
    quad(x, y, x+5, y+8, x+10, y, x+5, y-8);
  }
}
