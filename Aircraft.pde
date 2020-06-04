class Aircraft {
  float x;
  float y;
  float velx;
  float vely;
  float deg;
  float distance;
  float timex;
  float timey;
  color yellow = color(255, 204, 0);
  color red = color(255, 0, 0);
  
  Aircraft(float pos, float vx, float vy) {
    
    deg = map(pos, 0, 1, 49, 132);
    x = width/2 - 400*cos(radians(deg));
    y = -10 + 500 - 400*sin(radians(deg));

    velx = vx;
    vely = vy;
  }
  
  void update() {
    x = x + velx;
    y = y + vely;
    distance = dist(x, y, width/2, 500);
    timex = distance/velx;
    timey = distance/vely;
  }
  
  void show() {
    PFont data;
    data = createFont("SansSerif", 10);
    textFont(data);
    if (distance < 400 && distance > 300 && y < 510) {
      noFill();
      stroke(255);
      strokeWeight(0.5);
      quad(x, y, x+8, y+10, x+16, y, x+8, y-10);
    }
    if (distance <= 300 && distance > 200 && y < 510) {
      fill(255);
      stroke(255);
      strokeWeight(0.5);
      quad(x, y, x+8, y+10, x+16, y, x+8, y-10);
      text(str(distance), x + 20, y + 5);
    }
    if (distance <= 200 && distance > 100 && y < 510) {
      fill(yellow);
      stroke(yellow);
      strokeWeight(0.5);
      circle(x+8, y, 16);
      text(str(distance), x + 20, y + 5);
    }
    if (distance < 100 && y < 510) {
      fill(red);
      stroke(red);
      strokeWeight(0.5);
      rect(x, y-8, 16, 16);
      text(str(distance), x + 20, y + 5);
    }
  }
}
