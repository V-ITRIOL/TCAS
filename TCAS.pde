import garciadelcastillo.dashedlines.*;
DashedLines dash;

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
    dash.arc(width/2, 450, 600, 600, radians(210),radians(330));
    dash.arc(width/2, 450, 400, 400, radians(radi),radians(radf));
    dash.arc(width/2, 450, 200, 200, radians(radi),radians(radf));
    //chordl=2*300*sin(140/2);
    rect(135, 20, 525,500);
    
    
}
