void setup(){
  size(800,800);
  background(0);
}

import java.util.*;
List<PVector> pts = new ArrayList<>();
void draw(){
   // translate(width/2,height/2);
}

void mouseDragged() {
  circle(mouseX,mouseY,4);
  pts.add(new PVector(mouseX-width/2,mouseY-height/2));
}

void keyPressed(){
  translate(width/2,height/2);
  strokeWeight(5);
  stroke(0,255,0);
  for (int i = 0; i < pts.size()-1; i++){
    PVector p = pts.get(i);
    PVector p1 = pts.get(i+1);
    line(p.x,p.y,p1.x,p1.y);
    println(p);
   
  }
  println(pts.size());
  }
