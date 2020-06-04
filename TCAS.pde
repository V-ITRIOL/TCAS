import garciadelcastillo.dashedlines.*;
DashedLines dash;
float r1=600, r2=400,r3=200, r4=800;
void setup(){
    dash = new DashedLines(this);
    dash.pattern(5,10);
    size(800,600);
    background(0);
}

void draw(){
    //float chordl;
    int radi=200, radf=340;

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

    //RECTANGULO GPS PRIMARY
    stroke(255);
    noFill();
    rect(230,540,340,20);

    //TEXTO GPS PRIMARY
    fill(255,255,255);
    PFont font;
    font = createFont("SansSerif", 17);
    textFont(font);
    text("GPS PRIMARY", 335, 557);

}
