PMatrix2D matrix;
PShader glow;
import java.util.List;
import java.lang.*;

import java.util.*;

List<PMatrix2D> matrices = new ArrayList();
List<PShape> maTex = new ArrayList();

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

  matrices.add(new PMatrix2D(
-1,2           ,0,
1,1           ,0
));

/*PMatrix2D inv = new PMatrix2D(matrices.get(0).m11,-matrices.get(0).m01,          matrices.get(0).m02,
                                   -matrices.get(0).m10,matrices.get(0).m00,           matrices.get(0).m12);
inv.scale(1/matrices.get(0).determinant());
matrices.add(inv); */

matrices.add(new PMatrix2D(
1,0           ,0,
1,1           ,0
));

matrices.add(new PMatrix2D(
3,-2           ,0,
0,1           ,0
));

matrices.add(new PMatrix2D(
-1/3f,0           ,0,
0,1/3f           ,0
));


matrix = new PMatrix2D();
for (PMatrix2D m: matrices){
  maTex.add(createMatrixTex(m));
  m.apply(matrix);
  matrix = m;
}


  //videoExport.startMovie();
}

PShape createMatrixTex(PMatrix2D m){
  return createTex(color(255,0,0),
String.format("\\[\\begin{bmatrix} %s & %s \\\\ %s & %s \\end{bmatrix}\\]",formatEntry(m.m00),formatEntry(m.m01),formatEntry(m.m10),formatEntry(m.m11)),this);
}

String formatEntry(float n){
  if (((int) n) == n)
    return String.valueOf((int) n);
  else
    return convertDecimalToFraction(n);
}

static private String convertDecimalToFraction(double x){
    if (x < 0){
        return "-" + convertDecimalToFraction(-x);
    }
    double tolerance = 1.0E-6;
    double h1=1; double h2=0;
    double k1=0; double k2=1;
    double b = x;
    do {
        double a = Math.floor(b);
        double aux = h1; h1 = a*h1+h2; h2 = aux;
        aux = k1; k1 = a*k1+k2; k2 = aux;
        b = 1/(b-a);
    } while (Math.abs(x-h1/k1) > x*tolerance);
    return String.format("\\frac{%d}{%d}",(int) h1,(int) k1);
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
  PMatrix2D interpolated;
    if (matrices.size() == 1)
      interpolated = new PMatrix2D(matrices.get(0).m00,matrices.get(0).m01,          matrices.get(0).m02,
                                   -matrices.get(0).m10,-matrices.get(0).m11,           matrices.get(0).m12);
    else
      interpolated = interpolate(matrices.get(index+1));
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
  //rect(0,0,150,150);
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

  
  vector(transformedihat);
  stroke(255,0,255);
  fill(255,0,255);
  interpolated.mult(jhat, transformedjhat);
  transformedjhat.y *= -1;

  vector(transformedjhat);
  
  
  //println(output);
  rectMode(CENTER);
  fill(0,0,0,150);
  noStroke();
  //rect(50,410,850,96);
  rectMode(CORNER);
  textSize(100);
  textAlign(LEFT);
  fill(255,255,0);
 // text("Determinant: " + round(-det*100)/100f,-320,440);
 float widthSum = 0;  
 //shapeMode(CENTER);
  for (int i = 0; i <= index+1; i++){
    circle(250-widthSum,160,30);
    shape(maTex.get(i),250-widthSum,160);
    if (i != index+1)
      widthSum += maTex.get(i+1).getWidth() + 20;
    //println(maTex.get(i+1).width);
  }
  
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
