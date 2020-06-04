//Arreglo que contiene las aeronaves.
Aircraft[] crafts = new Aircraft[100];

import garciadelcastillo.dashedlines.*;
DashedLines dash;
float r1=600, r2=400,r3=200, r4=800;

void setup(){
    dash = new DashedLines(this);
    dash.pattern(5,10);
    size(800, 800);
    strokeWeight(1.5);
    for (int i = 0; i < crafts.length; i++) {
      crafts[i] = new Aircraft();
    }
}

void draw(){
    //DEJAR EL BACKGROUND AQUI SINO LOS MATO
    background(0);
    
  //TEXTO BLANCO
    noStroke();
    fill(255,255,255);
    rect(220,557,14,3);
    rect(538,557,14,3);
    
    //TEXTO BLANCO
    noStroke();
    fill(255,255,255);
    rect(220,557,14,3);

    PFont font, font2;
    font = createFont("SansSerif", 19);
    textFont(font);
    text("VOR1", 172, 533);
    text("VOR2", 555, 533);
    text("POL", 160, 555);
    text("INT", 560, 555);
    font2 = createFont("SansSerif", 16);
    textFont(font2);
    text("M", 220, 555);
    text("M", 538, 555);
    fill(51,204,255);
    text("NM", 220, 580);
    text("NM", 560, 575);
    
    int radi=200, radf=340;
    float angleStep=HALF_PI/20;
    boolean longStroke=false;
    
    //Arcs
    stroke(255);
    noFill();
    arc(width/2, 500, r4, 800, radians(229),radians(310));
    dash.arc(width/2, 500, r1, 600, radians(210),radians(330));
    dash.arc(width/2, 500, r2, 400, radians(radi),radians(radf));
    dash.arc(width/2, 500, r3, 200, radians(radi),radians(radf));
    
    //recuadro TCAS
    rect(135, 10, 525,600); 
    
    //AVION PROPIO
    noStroke();
    fill(255,255,50);
    rect(400,470,4,45);
    rect(380,480,45,4);
    rect(394,505,16,4);
    rect(400,83,4,35);
    
    //FLECHA BLANCA
    fill(255,255,255);
    rect(153,560,3,-25);
    stroke(255);
    noFill();
    triangle(140,535,170,535,155,515);
   
    
    //FLECHA DERECHA
    noStroke();
    fill(255,255,255);
    rect(625,560,3,-25);
    rect(638,560,3,-25);
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
    
    //Compass
    stroke(255);
    translate(width/2,500);
    for (float angle=0; angle<TWO_PI; angle+=angleStep){
      rotate(angleStep);
      if (longStroke){
        line(0,-400,0,-420);
      }
      else{
        line(0, -400,0,-410);
      }
      longStroke=!longStroke;
    }
    
    
    //Movimiento Aeronaves y muestra de las mismas.
    for (int i = 0; i < crafts.length; i++) {
      crafts[i].update();
      crafts[i].show();
    }
}
