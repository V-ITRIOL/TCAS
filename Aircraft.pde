class Aircraft {
  float x, y, z, velX, velY, velZ, deg, distance, timeX, timeY, velUserX, velUserY, velUserZ, velZTotal;
  color yellow = color(255, 204, 0);
  color red = color(255, 0, 0);
  int flagTraffic = -1, flagClear = -1;
  
  Aircraft(float pos, float vx, float vy, float vz) {
    
    //deg = map(pos, 0, 1, 0, 360);
    deg = map(pos, 0, 1, 49, 132);
    x = width/2 - 400*cos(radians(deg));
    y = -10 + 500 - 400*sin(radians(deg));
    z = 0;

    velX = vx;
    velY = vy;
    velZ = vz;
    
    velUserY = 0;
    velUserX = 0;
    velUserZ = 0;
  }
  
  void update() {
    //User input
    if (keyPressed) {
      switch (key) {
        case 'w':
        case 'W':
          velUserY = velUserY - 1;
          break;
        case 's':
        case 'S':
          velUserY = velUserY + 1;
          break;
        case 'd':
        case 'D':
          velUserX = velUserX + 1;
          break;
        case 'a':
        case 'A':
          velUserX = velUserX - 1;
          break;
        case ' ':
          velUserZ = velUserZ + 0.0001;
          break;
        case 'x':
        case 'X':
          velUserZ = velUserZ - 0.0001;
        default:
          break;
      }
    }
    
    // Calculations and updates
    x = x + velX + velUserX;
    y = y + velY + velUserY;
    
    // grasiosada aki abajo
    velZTotal = velZTotal + velZ + velUserZ;
    z = z + velZTotal;
    distance = dist(x, y, width/2, 500);
    timeX = distance/velX;
    timeY = distance/velY;
    
    
    velUserX = 0;
    velUserY = 0;
    velUserZ = 0;
  }
  
  void show() {
    
    PFont data;
    data = createFont("SansSerif", 15);
    textFont(data);
    
    
    //Diamantes próximos
    
    if (distance < 400 && distance > 300 && y < 510) {
      //Clear of conflict cuando ya no haya naves próximas
        if (flagClear == 0) {
        clear.play();
        flagClear = 1;
      }
      
      noFill();
      stroke(255);
      strokeWeight(0.5);
      translate((x + 8), y);  //ROTACION AERONAVES
      rotate(-rotation);  //ROTACION AERONAVES
      translate(-(x + 8), -y);  //ROTACION AERONAVES
      quad(x, y, x+8, y+10, x+16, y, x+8, y-10);
      
      fill(255);
      //altura
      if (z > 0) {
        if(z >= 10) {
          text("+" + int(z), x - 5, y - 13);
        } else {
          text("+" + "0" + int(z), x - 5, y - 13);
        }
      } else {
        if(z <= -10) {
          text(int(z), x - 5, y + 23);
        } else {
          text("-" + "0" + -1*int(z), x - 5, y + 23);
        }
      }
      //Arror velocity
      if (velZTotal > 0) {
        text("↑", x + 16, y + 10);
      } else {
        text("↓", x + 16, y + 8);
      }
      
      translate((x + 8), y);  //ROTACION AERONAVES
      rotate(rotation);  //FINAL ROTACION AERONAVES
      translate(-(x + 8), -y);  //ROTACION AERONAVES
      flagTraffic = 0;
    }
    
    
    
    //Diamantes Rellenos (TRAFICO)
    
    
    if (distance <= 300 && distance > 200 && y < 510) {
      if (flagTraffic == 0) {
        traffic.play();
        flagTraffic = 1;
      }
      
      fill(255);
      stroke(255);
      strokeWeight(0.5);
      translate((x + 8), y);  //ROTACION AERONAVES
      rotate(-rotation);  //ROTACION AERONAVES
      translate(-(x + 8), -y);  //ROTACION AERONAVES
      quad(x, y, x+8, y+10, x+16, y, x+8, y-10);
      
      //text(str(distance), x + 20, y + 5);
      
      //altura
      if (z > 0) {
        if(z >= 10) {
          text("+" + int(z), x - 5, y - 13);
        } else {
          text("+" + "0" + int(z), x - 5, y - 13);
        }
      } else {
        if(z <= -10) {
          text(int(z), x - 5, y + 23);
        } else {
          text("-" + "0" + -1*int(z), x - 5, y + 23);
        }
      }
      //Arror velocity
      if (velZTotal > 0) {
        text("↑", x + 16, y + 10);
      } else {
        text("↓", x + 16, y + 8);
      }
      
      translate((x + 8), y);  //ROTACION AERONAVES
      rotate(rotation);  //FINAL ROTACION AERONAVES
      translate(-(x + 8), -y);  //ROTACION AERONAVES
      flagClear = 0;
    }
    
    
    if (distance <= 200 && distance > 100 && y < 510) {
      fill(yellow);
      stroke(yellow);
      strokeWeight(0.5);
      translate((x + 8), y);  //ROTACION AERONAVES
      rotate(-rotation);  //ROTACION AERONAVES
      translate(-(x + 8), -y);  //ROTACION AERONAVES
      circle(x+8, y, 16);
      
      //text(str(distance), x + 20, y + 5);
      
      //altura
      if (z > 0) {
        if(z >= 10) {
          text("+" + int(z), x - 5, y - 13);
        } else {
          text("+" + "0" + int(z), x - 5, y - 13);
        }
      } else {
        if(z <= -10) {
          text(int(z), x - 5, y + 23);
        } else {
          text("-" + "0" + -1*int(z), x - 5, y + 23);
        }
      }
      //Arror velocity
      if (velZTotal > 0) {
        text("↑", x + 16, y + 10);
      } else {
        text("↓", x + 16, y + 8);
      }
      
      translate((x + 8), y);  //ROTACION AERONAVES
      rotate(rotation);  //FINAL ROTACION AERONAVES
      translate(-(x + 8), -y);  //ROTACION AERONAVES
    }
    
    
    if (distance < 100 && y < 510) {
      fill(red);
      stroke(red);
      strokeWeight(0.5);
      translate((x + 8), y);  //ROTACION AERONAVES
      rotate(-rotation);  //ROTACION AERONAVES
      translate(-(x + 8), -y);  //ROTACION AERONAVES
      rect(x, y-8, 16, 16);
      
      //text(str(distance), x + 20, y + 5);
      
      //altura
      if (z > 0) {
        if(z >= 10) {
          text("+" + int(z), x - 5, y - 13);
        } else {
          text("+" + "0" + int(z), x - 5, y - 13);
        }
      } else {
        if(z <= -10) {
          text(int(z), x - 5, y + 23);
        } else {
          text("-" + "0" + -1*int(z), x - 5, y + 23);
        }
      }
      //Arror velocity
      if (velZTotal > 0) {
        text("↑", x + 16, y + 10);
      } else {
        text("↓", x + 16, y + 8);
      }
      
      translate((x + 8), y);  //ROTACION AERONAVES
      rotate(rotation);  //FINAL ROTACION AERONAVES
      translate(-(x + 8), -y);  //ROTACION AERONAVES
    }
    
    
    
  }
}
