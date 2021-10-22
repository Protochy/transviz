import java.util.*;

List<List<PVector>> planarLinesX = new ArrayList();
List<List<PVector>> planarLinesY = new ArrayList();
float lineWidth = 0.1;
float c = 1;
long inc = 0;
PVector scaling = new PVector(100,-100);
PImage ailu;
PGraphics masker;
PShape tex;


import com.hamoid.*;

VideoExport videoExport;

void setup(){
  size(1000,1000,P2D);
  videoExport = new VideoExport(this, "nonlinear.mp4");
  videoExport.setQuality(85,0);
  videoExport.setFrameRate(60);
  frameRate(60);
  
  
  smooth(8);
  tex = loadShape("448319566.svg");
  tex.scale(2);
  ailu = loadImage("upscale.PNG");
  ailu.resize((int) (ailu.width/1.3), (int) (ailu.height/1.3));
  masker = createGraphics(ailu.width,ailu.height);
  masker.shapeMode(CENTER);
  masker.beginDraw();
  masker.translate(masker.width/2,masker.height/2);
  masker.stroke(255,255,255);
  masker.fill(255,255,255);
  masker.circle(0,0,75);
  masker.endDraw();
  ailu.mask(masker);
  
  imageMode(CENTER);
  rectMode(CENTER);
    
  for (int j = -5; j < 5; j++){
    List<PVector> lineSeg = new ArrayList();
    for (float i = (int) (-0.5*width/scaling.x); i < 0.5*width/scaling.x; i+=lineWidth){
      lineSeg.add(new PVector(i,j));
    }
    planarLinesX.add(lineSeg);
  }
  
  for (int j = -5; j < 5; j++){
    List<PVector> lineSeg = new ArrayList();
    for (float i = (int) (-0.5*height/scaling.x); i < 0.5*height/scaling.x; i+=lineWidth){
      lineSeg.add(new PVector(j,i));
    }
    planarLinesY.add(lineSeg);
  }
  shapeMode(CENTER);
  
  videoExport.startMovie();
}

void draw(){
  background(0);
  translate(width/2,height/2);
  strokeWeight(5);
  
  for (int j = 0; j < planarLinesX.size(); j++){
    List<PVector> lineSeg = planarLinesX.get(j);
    if (j == planarLinesX.size()/2)
      stroke(255,255,255);
    else
       stroke(0,255,255);
    for (int i = 0; i < lineSeg.size()-1; i++){ // horiz lines
      PVector trans1 = applyTransform(lineSeg.get(i));
      PVector trans2 = applyTransform(lineSeg.get(i+1));
      line(scaling.x*trans1.x,scaling.y*trans1.y,scaling.x*trans2.x,scaling.y*trans2.y); 
    }
  }
  
  for (int j = 0; j < planarLinesY.size(); j++){
    List<PVector> lineSeg = planarLinesY.get(j);
    if (j == planarLinesY.size()/2)
      stroke(255,255,255);
    else
       stroke(0,255,255);
    for (int i = 0; i < lineSeg.size()-1; i++){ // vert lines
      PVector trans1 = applyTransform(lineSeg.get(i));
      PVector trans2 = applyTransform(lineSeg.get(i+1));
      line(scaling.x*trans1.x,scaling.y*trans1.y,scaling.x*trans2.x,scaling.y*trans2.y); 
    }
  }
  
  noStroke();
  fill(0,0,0,140);
  rect(30,360+20,tex.width+40,tex.height+50);
  shape(tex,0,360);
  
  stroke(255,165,0);
  fill(255,165,0);
  PVector tr = applyTransform(-1,-2);
  //image(ailu,tr.x,tr.y);
  vector(tr);
  
  if (inc < 60*6) // 6 sec
    c = map2(inc++,0,60*6,1,0,QUADRATIC,EASE_IN_OUT);
  println(c);
  videoExport.saveFrame();
}

PVector applyTransform(float x, float y){
  PVector trans = N(x,y);
  return new PVector(c*(x) + (1-c)*(trans.x),c*y + (1-c)*trans.y); // what if it was x...?
}

PVector N(float x, float y){
  return new PVector(x*x,x*x);
}

PVector applyTransform(PVector v){
  return applyTransform(v.x,v.y);
}

void vector(PVector v) {
  float x2 = v.x;
  float y2 = v.y;
  x2 *= scaling.x;
  y2 *= scaling.y;
  line(0,0, x2, y2);
  pushMatrix();
  translate(x2, y2);
  float a = atan2(-x2, y2);
  rotate(a);
  blendMode(REPLACE);
  beginShape(TRIANGLES);
    vertex(0, 0);
    vertex( -15, -30);
    vertex(15,-30);
  endShape();
  blendMode(BLEND);
  popMatrix();
} 

void keyPressed() {
  if (key == 'q') {
    videoExport.endMovie();
    exit();
  }
}
