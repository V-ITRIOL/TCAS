class Aircraft {
  float x, y, z, zDisplay, velX, velY, velZ, deg, distance, timeX, timeY, velUserX, velUserY, velUserZ, velZTotal;
  color yellow = color(255, 204, 0);
  color red = color(255, 0, 0);
  int flagTraffic = -1, flagClear = -1;
  
  //EQUIVALENCIA : 1 nmi = 10 pixeles.
  
  Aircraft(float pos, float vx, float vy, float vz) {
    
    //deg = map(pos, 0, 1, 0, 360);
    deg = map(pos, 0, 1, 49, 132);
    x = width/2 - 400*cos(radians(deg));
    y = -10 + 500 - 400*sin(radians(deg)); // every nmi is 10 pixels cause 400 pixels of radius, tcas only considers 40 nmi
    z = random(28000, 34400) - heightIn; // in ft

    velX = (10*vx)/(3600*60); // in pixels/s
    velY = (10*vy)/(3600*60); // in pixels/s
    velZ = vz; // in ft/s
    
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
          velUserZ = 15.0;
          break;
        case 'x':
        case 'X':
          velUserZ = -15.0;
        default:
          break;
      }
    }
    
    // Calculations and updates
    x = x + velX + velUserX;
    y = y + velY + velUserY;
    
    // grasiosada aki abajo
    velZTotal = velZ + velUserZ/60.0;
    z = z + velZTotal - (verSpeedUser/60.0); // feet
    zDisplay = z/100.0; // feet x 10e2
    
    distance = dist(x, y, width/2, 500); // en pixeles
    distance = distance/10;//en nmi
    
    timeX = distance/velX;
    timeY = distance/velY;
    
    println(z);
    
    velUserX = 0;
    velUserY = 0;
    velUserZ = 0;
  }
  
  
  
  
  void show() {
    
    PFont data;
    data = createFont("SansSerif", 15);
    textFont(data);
    
    
    //Diamantes próximos
    
    if (distance < 40 && distance > 30 && y < 510) {
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
        if(z >= 1000) {
          text("+" + nf(zDisplay, 2, -2), x - 5, y - 13);
        } else {
          text("+" + nf(zDisplay, 2, -2), x - 5, y - 13);
        }
      } else {
        if(z <= -1000) {
          text(nf(zDisplay, 2, -2), x - 5, y + 23);
        } else {
          text("-" + nf(-1*zDisplay, 2, -2), x - 5, y + 23);
        }
      }
      
      //Arrow velocity
      if (velZTotal > 0) {
        text("↑", x + 16, y + 10);
      } else if (velZTotal < 0){
        text("↓", x + 16, y + 8);
      }
      
      translate((x + 8), y);  //ROTACION AERONAVES
      rotate(rotation);  //FINAL ROTACION AERONAVES
      translate(-(x + 8), -y);  //ROTACION AERONAVES
      flagTraffic = 0;
    }
    
    
    
    //Diamantes Rellenos (TRAFICO)
    
    
    if (distance <= 30 && distance > 20 && y < 510) {
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
        if(z >= 1000) {
          text("+" + nf(zDisplay, 2, -2), x - 5, y - 13);
        } else {
          text("+" + nf(zDisplay, 2, -2), x - 5, y - 13);
        }
      } else {
        if(z <= -1000) {
          text(nf(zDisplay, 2, -2), x - 5, y + 23);
        } else {
          text("-" + nf(-1*zDisplay, 2, -2), x - 5, y + 23);
        }
      }
      
      //Arrow velocity
      if (velZTotal > 0) {
        text("↑", x + 16, y + 10);
      } else if (velZTotal < 0){
        text("↓", x + 16, y + 8);
      }
      
      translate((x + 8), y);  //ROTACION AERONAVES
      rotate(rotation);  //FINAL ROTACION AERONAVES
      translate(-(x + 8), -y);  //ROTACION AERONAVES
      flagClear = 0;
    }
    
    
    if (distance <= 20 && distance > 10 && y < 510) {
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
        if(z >= 1000) {
          text("+" + nf(zDisplay, 2, -2), x - 5, y - 13);
        } else {
          text("+" + nf(zDisplay, 2, -2), x - 5, y - 13);
        }
      } else {
        if(z <= -1000) {
          text(nf(zDisplay, 2, -2), x - 5, y + 23);
        } else {
          text("-" + nf(-1*zDisplay, 2, -2), x - 5, y + 23);
        }
      }
      
      //Arrow velocity
      if (velZTotal > 0) {
        text("↑", x + 16, y + 10);
      } else if (velZTotal < 0){
        text("↓", x + 16, y + 8);
      }
      
      translate((x + 8), y);  //ROTACION AERONAVES
      rotate(rotation);  //FINAL ROTACION AERONAVES
      translate(-(x + 8), -y);  //ROTACION AERONAVES
    }
    
    
    if (distance < 10 && y < 510) {
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
        if(z >= 1000) {
          text("+" + nf(zDisplay, 2, -2), x - 5, y - 13);
        } else {
          text("+" + nf(zDisplay, 2, -2), x - 5, y - 13);
        }
      } else {
        if(z <= -1000) {
          text(nf(zDisplay, 2, -2), x - 5, y + 23);
        } else {
          text("-" + nf(-1*zDisplay, 2, -2), x - 5, y + 23);
        }
      }
      
      //Arrow velocity
      if (velZTotal > 0) {
        text("↑", x + 16, y + 10);
      } else if (velZTotal < 0){
        text("↓", x + 16, y + 8);
      }
      
      translate((x + 8), y);  //ROTACION AERONAVES
      rotate(rotation);  //FINAL ROTACION AERONAVES
      translate(-(x + 8), -y);  //ROTACION AERONAVES
    }
    
    
    
  }
}
