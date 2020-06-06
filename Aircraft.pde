// Altura de entre 20000 y 42000 ft, se utilizan los valores para tau de 48s para TA y 35s para RA


class Aircraft {
  float x, y, z, zDisplay, velX, velY, velZ, deg, distance, timeX, timeY, velUserX, velUserY, velUserZ, velXTotal, velYTotal, velZTotal, magVelXY, tauXY, tauZ;
  color yellow = color(255, 204, 0);
  color red = color(255, 0, 0);
  int flagTraffic = -1, flagClear = -1, speed = 0;
  
  //EQUIVALENCIA : 1 nmi = 10 pixeles.
  
  Aircraft(float pos, float vx, float vy, float vz) {
    
    //deg = map(pos, 0, 1, 0, 360);
    deg = map(pos, 0, 1, 49, 132);
    x = width/2 - 400*cos(radians(deg));
    y = -10 + 500 - 400*sin(radians(deg)); // every nmi is 10 pixels cause 400 pixels of radius, tcas only considers 40 nmi
    z = random(28000, 34400) - heightIn; // in ft

    velX = vx; // in nmi/h
    velY = vy; // in nmi/h
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
          if (speed == 0)
            velUserY = -10000; // nmi/h
          if (speed == 1)
            velUserY = -2000;
          break;
        case 's':
        case 'S':
          if (speed == 0)
            velUserY = 10000; // nmi/h
          if (speed == 1)
            velUserY = 2000;
          break;
        case 'd':
        case 'D':
          if (speed == 0)
            velUserX = 10000; // nmi/h
          if (speed == 1)
            velUserX = 2000;
          break;
        case 'a':
        case 'A':
          if (speed == 0)
            velUserX = -10000; // nmi/h
          if (speed == 1)
            velUserX = -2000;
          break;
        case ' ':
          velUserZ = 15.0;  // ft/s
          break;
        case 'x':
        case 'X':
          velUserZ = -15.0; // ft/s
          break;
        case 'f':
        case 'F':
          speed = speed + 1;
          if (speed > 1) {
            speed = 0;
          }
          delay(500);
          break;
        default:
          break;
      }
    }
    
    // Calculations and updates
    velXTotal = velX + velUserX;
    velYTotal = velY + velUserY;
    x = x + (10*velXTotal)/(3600*60);
    y = y + (10*velYTotal)/(3600*60);
    
    // grasiosada aki abajo
    velZTotal = velZ + velUserZ/60.0; // ft/s
    z = z + velZTotal - (verSpeedUser/60.0); // feet
    zDisplay = z/100.0; // feet x 10e2
    
    // Magnitude Velocity
    magVelXY = mag(velXTotal, velYTotal); // en nmi/h
    
    // Distance
    distance = dist(x, y, width/2, 500); // en pixeles
    distance = distance/10;//en nmi
    
    // CPA (Closest point of collision)
    tauXY = (distance/magVelXY)*3600; // en segundos
    if (velZTotal > 0) {
      tauZ = (-1*z)/15.0; // en segundos
    } else if (velZTotal < 0) {
      tauZ = (z)/15.0; // en segundos
    } else {
      tauZ = 999999; 
    }
    
    
    velUserX = 0;
    velUserY = 0;
    velUserZ = 0;
  }
  
  
  
  
  void show() {
    
    PFont data;
    data = createFont("SansSerif", 15);
    textFont(data);
    text("tauXY: " + tauXY, 550, 480);
    text("tauZ: " + tauZ, 550, 500);
    text("mode: " + speed, 550, 460);
    
    //
    // Trafico no amenazante
    //
    
    if (distance < 40 && distance > 6 && y < 520 && abs(z) > 1200 && tauXY > 48 && tauZ > 48) {
      
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
    
    
    //
    // Diamantes Rellenos (Trafico proximo)
    //
    
    if (distance < 40 && (distance <= 6 || abs(z) <= 1200) && y < 520 && tauXY > 48 && tauZ > 48) {
      
      //Clear of conflict cuando ya no haya naves amenazantes
        if (flagClear == 0) {
        clear.play();
        flagClear = 1;
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
      
      flagTraffic = 0;
      
    }
    
    //
    // Circulos amarillos (TA)
    //
    
    if (distance < 40 && y < 520 && (tauXY <= 48 || tauZ <= 48) && tauXY > 35 && tauZ > 35) {
      
      if (flagTraffic == 0) {
        traffic.play();
        flagTraffic = 1;
      }
      
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
      
      flagClear = 0;
    }
    
    //
    // Cuadrados Rojos (RA)
    //
    
    if (distance < 40 && y < 520 && (tauXY <= 35 || tauZ <= 35)) {
      
      if (flagTraffic == 0) {
        traffic.play();
        flagTraffic = 1;
      }
      
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
      
      flagClear = 0;
    }
    
    
    
  }
}
