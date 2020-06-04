class Aircraft {
  float x;
  float y;
  float velx;
  float vely;
  float deg;
  
  Aircraft(float pos, float vx, float vy) {
    
    deg = map(pos, 0, 1, 49, 132);
    x = width/2 - 400*cos(radians(deg));
    y = 500 - 400*sin(radians(deg));

    velx = vx;
    vely = vy;
  }
  
  void update() {
    x = x + velx;
    y = y + vely;
  }
  
  void show() {
    noFill();
    stroke(255);
    strokeWeight(0.5);
    
    
    quad(x, y, x+5, y+8, x+10, y, x+5, y-8);
  }
}
