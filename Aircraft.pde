class Aircraft {
  float x;
  float y;
  float velx;
  float vely;
  
  Aircraft() {
    translate(0,0);
    x = random(200, 600);
    y = random(200, 600);
    velx = 0;
    //vely = 0;
  }
  
  void update() {
    velx = velx + 10;
    //vely = vely + 10;
  }
  
  void show() {
    noFill();
    stroke(255);
    strokeWeight(0.5);
    
    float sx = map(x/velx, 1, 0, 0, width);
    float sy = map(y/velx, 1, 0, 0, height);
    
    quad(sx, sy, sx+5, sy+8, sx+10, sy, sx+5, sy-8);
  }
}
