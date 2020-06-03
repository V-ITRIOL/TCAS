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
    arc(width/2, 450, r4, 800, radians(229),radians(310));
    dash.arc(width/2, 450, r1, 600, radians(210),radians(330));
    dash.arc(width/2, 450, r2, 400, radians(radi),radians(radf));
    dash.arc(width/2, 450, r3, 200, radians(radi),radians(radf));
    //chordl=2*100*sin(140/2);
    rect(135, 20, 525,500); 
    
    stroke(0,204,0);
    dash.line(399, 50, 399, 400);
    
    noStroke();
    fill(255,255,50);
    rect(400,400,4,45);
    rect(380,410,45,4);
    rect(394,435,16,4);
    //VERDE
    fill(0,204,0);
    rect(400,50,2,350);
    //RECTANGULO GPS PRIMARY
    stroke(255);
    noFill();
    rect(230,470,340,20);
}
