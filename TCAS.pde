import garciadelcastillo.dashedlines.*;
DashedLines dash;
float r1=600, r2=400,r3=200, r4=800;

void setup(){
    dash = new DashedLines(this);
    dash.pattern(5,10);
    size(800,600);
    background(0);
    strokeWeight(1.5);
}

void draw(){
    //float chordl;
    int radi=200, radf=340;
    float angleStep=HALF_PI/10;
    boolean longStroke=false;
    
    //Arcs
    stroke(255);
    noFill();
    arc(width/2, 500, r4, 800, radians(229),radians(310));
    dash.arc(width/2, 500, r1, 600, radians(210),radians(330));
    dash.arc(width/2, 500, r2, 400, radians(radi),radians(radf));
    dash.arc(width/2, 500, r3, 200, radians(radi),radians(radf));
    
    //chordl=2*100*sin(140/2);
    rect(135, 40, 525,550); 
    
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
    
    
    //LINEA VERDE
    noStroke();
    fill(0,204,0);
    rect(400,470,2,-370);
    //LINEA PUNTEADA VERDE
    stroke(0,204,0);
    dash.line(399, 470, 399,100);


  //TEXTO BLANCO
    noStroke();
    fill(255,255,255);
    rect(220,557,14,3);
    PFont font, font2;
    font = createFont("SansSerif", 19);
    textFont(font);
    text("VOR1", 172, 533);
    text("VOR2", 625, 533);
    text("POL", 160, 555);
    font2 = createFont("SansSerif", 16);
    textFont(font2);
    text("M", 220, 555);
    fill(51,204,255);
    text("NM", 220, 580);
    
    //Compass
    translate(radians(220),200);
    for (float angle=radians(220); angle<radians(330); angle+=angleStep){
      rotate(angleStep);
      if (longStroke){
        line(0,-200,0,-180);
      }
      else{
        line(0, -190,0,-180);
      }
      longStroke=!longStroke;
    }

}
