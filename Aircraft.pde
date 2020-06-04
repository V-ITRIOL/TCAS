class Aircraft {
  float x;
  float y;
  float velx;
  float vely;
  float deg;
  float distance;
  color yellow = color(255, 204, 0);
  color red = color(255, 0, 0);
  
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
    distance = dist(x, y, width/2, 500);
  }
  
  void show() {
    if (distance < 400 && distance > 300 && y < 520) {
      noFill();
      stroke(255);
      strokeWeight(0.5);
      quad(x, y, x+8, y+10, x+16, y, x+8, y-10);
    }
    if (distance <= 300 && distance > 200 && y < 520) {
      fill(255);
      stroke(255);
      strokeWeight(0.5);
      quad(x, y, x+8, y+10, x+16, y, x+8, y-10);
    }
    if (distance <= 200 && distance > 100 && y < 520) {
      fill(yellow);
      stroke(yellow);
      strokeWeight(0.5);
      circle(x+8, y, 16);
    }
    if (distance < 100 && y < 520) {
      fill(red);
      stroke(red);
      strokeWeight(0.5);
      rect(x, y-8, 16, 16);
    }
  }
}
