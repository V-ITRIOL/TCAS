//Arreglo que contiene las aeronaves.
Aircraft[] crafts = new Aircraft[2];

import garciadelcastillo.dashedlines.*;
DashedLines dash;

import processing.sound.*;
SoundFile traffic, clear;

float r1=600, r2=400,r3=200, r4=800;

float rotation;
float degreeDiff;
float degreeIn = 0;
float degreeUser = 0;
float degreeTotal = 0;
int f2;

float windSpeed=15;
float heightIn=30000;
float heightOut=0;
float groundSpeedOut=0;
float heightDiff=0;
float verSpeedUser=0;
float airSpeedIn=340;
float airSpeedOut=0;
float airSpeedUser=0;
float airSpeedDiff= 0; 
int f1=0;

int mi=millis();
int m = minute();
int h = hour();
String sm= str(m);
String sh= str(h);

void setup(){
    dash = new DashedLines(this);
    dash.pattern(5,10);
    size(800, 700);
    for (int i = 0; i < crafts.length; i++) {
      crafts[i] = new Aircraft(random(0, 1), 0, 0.05, 0);
    }
    traffic = new SoundFile(this, "traffic.wav");
    clear = new SoundFile(this, "clear.wav");
}

void draw(){
    //Cálculo de los ángulos en rotation:
    if (keyPressed) {
      switch (key) {
        case 'j':
        case 'J':
          degreeUser = 1/60.0;
          f2 = -1;
          break;
        case 'l':
        case 'L':
          degreeUser = -1/60.0;
          f2 = -1;
          break;
        default:
          break;
      }
    }
    degreeDiff = degreeDiff + degreeUser;
    degreeTotal = degreeTotal + degreeIn + degreeDiff;
    
    if (f2 == 0 && degreeDiff > 0) {
      degreeDiff = degreeDiff - 1/60.0;
      if (abs(degreeDiff) < 0.01) {
        degreeDiff = 0;
      }
    } else if (f2 == 0 && degreeDiff < 0) {
      degreeDiff = degreeDiff + 1/60.0;
      if (abs(degreeDiff) < 0.01) {
        degreeDiff = 0;
      }
    }
    
    if (degreeTotal > 360) {
      degreeTotal = degreeTotal - 360;
    } else if (degreeTotal < 0) {
      degreeTotal = degreeTotal + 360;
    }
    
    rotation = radians(degreeTotal);
    f2 = 0;
    degreeUser = 0;
    translate(0, 30);
    
    //DEJAR EL BACKGROUND AQUI SINO LOS MATO
    background(0);
    strokeWeight(1.5);
    
    //TEXTO BLANCO
    noStroke();
    fill(255,255,255);
    rect(220,557,14,3);
    rect(538,557,14,3);
    
    //TEXTO BLANCO
    noStroke();
    fill(255,255,255);
    rect(220,557,14,3);

    PFont font, font2, font3;
    font = createFont("SansSerif", 19);
    textFont(font);
    text("VOR1", 172, 533);
    text("VOR2", 555, 533);
    text("POL", 160, 555);
    text("INT", 560, 555);
    text("POL", 547, 10);
    text("/", 175, 30);
    fill(0,204,0);
    
    
    //Grados compass
    text(360-int(degrees(rotation))+"°", 590, 10);
    //text("292", 140, 30);
    
    //WINDSPEED
    if (millis()>mi+1000){
      windSpeed += random(-2,2);
      mi=millis();
    }
    String swind= str(int(windSpeed));
    text(swind, 210, 30);
    
    
    //ALTURA DEL AVIÓN PROPIO Y VELOCIDADES
    if (keyPressed){
      switch(key) {
        case 'i':
        case 'I':
          verSpeedUser = 15.0;//15 ft/s
          airSpeedUser = -5; // 5 nm/h
          f1=-1;
          break;
        case 'k':
        case 'K':
          verSpeedUser = -15.0;//-15 ft/s
          airSpeedUser = 5; // 5 nm/h
          f1=-1;
          break;
        default:
        break;
      }
    }
    
    heightDiff = heightDiff + verSpeedUser/60.0;
    heightOut = heightIn + heightDiff;
    airSpeedDiff = airSpeedDiff + airSpeedUser/(60.0);
    airSpeedOut = airSpeedIn + (airSpeedDiff);
    groundSpeedOut = airSpeedOut - windSpeed;
    
    if(airSpeedOut<340 && f1==0){      
      airSpeedDiff = airSpeedDiff + 5/(60.0);
    }
    else if(airSpeedOut>340 && f1==0){
      airSpeedDiff = airSpeedDiff - 5/(60.0);
    }
    
    //IMPRESIÓN DE GS Y TAS
    text(int(groundSpeedOut), 170, 10);
    text(int(airSpeedOut), 250, 10);
    
    airSpeedUser = 0;
    verSpeedUser = 0;
    f1 = 0;
    
    
    //NM VOR 1 Y VOR 2
    text("30", 575, 30);
    text("30", 180, 580);
    text("14.7", 520, 580);
    
    //Timer
    PFont ftimer;
    ftimer = createFont("SansSerif", 19);
    textFont(ftimer);
    text(sh,580,50);
    text(":",604, 50);
    text(sm,612,50);
    
    font2 = createFont("SansSerif", 16);
    textFont(font2);
    fill(255,255,255);
    text("GS", 140, 10);
    text("TAS", 210, 10);
    text("M", 220, 555);
    text("M", 538, 555);
    fill(51,204,255);
    text("NM", 220, 580);
    text("NM", 560, 580);
    text("NM", 617, 30);
    font3 = createFont("SansSerif", 22);
    textFont(font3);
    fill(0,204,0);
    text("VOR APP", 350, 10);
    int radi=200, radf=340;
    
    //Arcs
    stroke(255);
    noFill();
    arc(width/2, 500, r4, 800, radians(228),radians(311));
    dash.arc(width/2, 500, r1, 600, radians(210),radians(330));
    dash.arc(width/2, 500, r2, 400, radians(radi),radians(radf));
    dash.arc(width/2, 500, r3, 200, radians(radi),radians(radf));
    
    //recuadro TCAS
    rect(135, -15, 525,625); 
    
    //AVION PROPIO
    noStroke();
    fill(255,255,60);
    rect(400,470,4,45);
    rect(380,480,45,4);
    rect(394,505,16,4);
    rect(400,70,2.5,30);
    
    //FLECHA BLANCA
    fill(255,255,255);
    rect(153,560,1.5,-25);
    stroke(255);
    noFill();
    triangle(140,535,170,535,155,515);
   
    
    //FLECHA DERECHA
    noStroke();
    fill(255,255,255);
    rect(625,560,1.5,-25);
    rect(638,560,1.5,-25);
    stroke(255);
    line(612, 535, 625, 535);
    line(639, 535, 652, 535);
    line(612, 535, 634, 510);
    line(652, 535, 634, 510);
    //LINEA VERDE
    noStroke();
    fill(0,204,0);
    rect(400,470,2,-370);
    
    //LINEA PUNTEADA VERDE
    stroke(0,204,0);
    dash.line(399, 470, 399,100);
    
    translate(width/2, 500);  //ROTACION AERONAVES
    rotate(rotation);  //ROTACION AERONAVES
    translate(-width/2, -500);  //ROTACION AERONAVES
    
    //Movimiento Aeronaves y muestra de las mismas.
    for (int i = 0; i < crafts.length; i++) {
      crafts[i].update();
      crafts[i].show();
    }
    
    rotate(-rotation);  //FINAL ROTACION AERONAVES
    translate(-width/2, -500);  //FINAL ROTACION AERONAVES
    
    translate(width/2, 500);  //ROTACION COMPASS
    rotate(rotation);  //ROTACION COMPASS
    
    //Compass
    int grades=0;
    float angleStep=radians(90)/18;
    boolean longStroke=false;
    PFont fontcomp;
    fontcomp = createFont("SansSerif", 20);
    textFont(fontcomp);
    
    stroke(255);
    strokeWeight(1.5);
    translate(width/2, 500);
    for (float angle=0; angle<TWO_PI; angle+=angleStep) {
      rotate(angleStep);
        if (longStroke) {
          line(0, -400, 0, -420);      
          if(grades<72){
            if ((grades+1)/2 == 36) {
              String sg= "0";
              fill(255);
              text(sg,-8,-435);
            } else {
              String sg= str((grades+1)/2);
              fill(255);
              text(sg,-8,-435);
            }
          }
        } 
        else {
          line(0, -400, 0, -410);
        }
        longStroke=!longStroke;
        grades++;
    }
   rotate(-rotation);  //FINAL ROTACION COMPASS
  
  
   //Rectángulos negros
    fill(0);
    rotate(-angleStep);
    noStroke();
    rect(-400, -800, 135, 1000);
    rect(261, -800, 800, 1000);
    //ESTE COMANDO TE PONE EN LA ESQUINA SUPERIOR IZQUIERDA
    translate(-width/2, -500);
    rect(0, 611, 800, 800);
}
