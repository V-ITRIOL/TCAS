class Aircraft {
  float x;
  float y;
  float velx;
  float vely;
  
  Aircraft() {
    translate(0,0);
    x = random(200, 600);
    y = random(200, 600);
    velx = x;
    vely = y;
  }
  
  void update() {
    velx = velx + 1;
    vely = vely + 1;
  }
  
  void show() {
    noFill();
    stroke(255);
    strokeWeight(0.5);
    
    float sx = map(x/velx, 0, 1, 0, width);
    float sy = map(y/vely, 0, 1, 0, height);
    
    quad(sx, sy, sx+5, sy+8, sx+10, sy, sx+5, sy-8);
  }
}
