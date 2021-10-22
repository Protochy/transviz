PMatrix2D matrix;
PShader glow;

import java.util.*;
List<PMatrix2D> matrices = new ArrayList();

PVector input = new PVector(1,2);

PVector ihat = new PVector(1,0);
PVector jhat = new PVector(0,1);


PVector output = new PVector();

import com.hamoid.*;
VideoExport videoExport;

void setup(){
  
  size(1000,1000,P2D);
  smooth(8);
  frameRate(60); 
  videoExport = new VideoExport(this,"matrix.mp4");
  videoExport.setFrameRate(60);
  matrices.add(new PMatrix2D());

  matrices.add(new PMatrix2D(
-1,1           ,0,
1,1           ,0
));

  PMatrix2D mt = new PMatrix2D(
-1,1           ,0,
1,1           ,0
);
mt.invert();
matrices.add(mt);

matrix = new PMatrix2D();
for (PMatrix2D m: matrices){
  m.apply(matrix);
  matrix = m;
}


  //videoExport.startMovie();
}
long inc = 0;
void draw(){
  //shader(glow);
  background(0);
  translate(width/2,height/2);
  strokeWeight(4);
    stroke(192,192,192,150);
    for (int i = -6; i < 6; i ++){
      float x = i*150;
      line(x,-1000,x,1000);
    }
    for (int j = -6; j < 6; j ++){
      float y = j*150;
      line(-1000,y,1000,y);
    }
    //stroke(255,255,255);
    line(-1000,0,1000,0);
    line(0,-1000,0,1000);
    
  pushMatrix();
    PMatrix2D interpolated = interpolate(matrices.get(index+1));
    applyMatrix(interpolated);
    
    float det = interpolated.determinant();
    float scaleWeight;
    if (abs(det) < 0.75)
       scaleWeight = 5/0.75;
    else
      scaleWeight = abs(5/interpolated.determinant());
      
    strokeWeight(scaleWeight);
    stroke(0,255,255);
    for (int i = -6; i < 6; i ++){
      float x = i*150;
      line(x,-1000,x,1000);
    }
    for (int j = -6; j < 6; j ++){
      float y = j*150;
      line(-1000,y,1000,y);
    }
    stroke(192,192,192,150);
    line(-1000,0,1000,0);
    line(0,-1000,0,1000);
    
  strokeWeight(5);
  
  fill(200,255,0);
  rect(0,0,150,150);
  popMatrix();

  stroke(192,192,192,150);
  //vector(input);
  
  stroke(255,255,255);
  fill(255,255,255);
  interpolated.mult(input,output);
  output.y *= -1;
  vector(output);
  
  stroke(255,165,0);
  fill(255,165,0);
  interpolated.mult(ihat, transformedihat);
  transformedihat.y *= -1;
  
  if (frameCount < 65){
  transformedihat.y += 0.2*sin(frameCount/4f);
  transformedihat.x += 0.2*sin(frameCount/20f);
  } 
  
  vector(transformedihat);
  stroke(255,0,255);
  fill(255,0,255);
  interpolated.mult(jhat, transformedjhat);
  transformedjhat.y *= -1;
  
  if (frameCount > 90 && frameCount < 90+65){
    transformedjhat.x += 0.2*sin((frameCount-90)/4f);
  transformedjhat.y += 0.2*sin((frameCount-90)/20f);
  }
  vector(transformedjhat);
  //println(output);
  rectMode(CENTER);
  fill(0,0,0,150);
  noStroke();
  rect(50,410,850,96);
  rectMode(CORNER);
  textSize(100);
  textAlign(LEFT);
  fill(255,255,0);
  text("Determinant: " + round(-det*100)/100f,-320,440);
  
  if (click)
    if (inc < end)
      inc += 1;
    else if (index + 1 < matrices.size()-1) {
      inc = 0;
      index++;
    }
    
   videoExport.saveFrame();
  
   
}
boolean click = false;
void keyPressed() {
  if (key == 'q') {
    click = true;
  }
  if (key == 'w'){
    videoExport.endMovie();
    exit();
  }
}


PVector transformedihat = new PVector();
PVector transformedjhat = new PVector();
long end = 60*6;
PVector scale = new PVector(150,150);

PMatrix2D interpolate(PMatrix2D m){
  float originalm00 = matrices.get(index).m00, originalm01 = matrices.get(index).m01, originalm10 = matrices.get(index).m10, originalm11 = matrices.get(index).m11;

  return new PMatrix2D(
  map2(inc,0,end,originalm00,m.m00,QUADRATIC,EASE_IN_OUT),map2(inc,0,end,originalm01,m.m01,QUADRATIC,EASE_IN_OUT)                              ,0,
  -map2(inc,0,end,originalm10,m.m10,QUADRATIC,EASE_IN_OUT),-map2(inc,0,end,originalm11,m.m11,QUADRATIC,EASE_IN_OUT)                              ,0
  );
}
int index = 0;
void vector(PVector v) {
  float x2 = v.x;
  float y2 = -v.y;
  x2 *= scale.x;
  y2 *= scale.y;
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
