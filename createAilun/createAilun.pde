PImage img;
int wid,hei;
import java.util.stream.*;
void setup(){
  size(339,393);
  img = loadImage("pin.png");
  img.resize(img.width/2,img.height/2);
  wid = img.width;
  hei = img.height;
  println(wid,hei);
  img.loadPixels();
  for (int i = 0; i < wid; ++i){
    for (int j = 0; j < hei; ++j){
      if (color(255,255,255) != img.pixels[i*wid + j])
        img.pixels[i*wid + j] = color(0,0,0);
    }
  }
  img.updatePixels();
  
  
}

import java.util.*;
List<PVector> pts = new ArrayList<>();
void draw(){
  noLoop();
  background(0);
  fill(255,0,0);
 // image(img,0,0);
  for (int i = 1; i < wid-1; ++i){
    for (int j = 1; j < hei-1; ++j){
      color me = img.pixels[i*wid + j];
      color n1 = img.pixels[i*wid + j-1],n2=img.pixels[(i-1)*wid + j],n3=img.pixels[(i+1)*wid + j],n4=img.pixels[i*wid + j+1];
      int v = color(255,255,255);
      if (me == color(0,0,0) && (n1 == v || n2 == v || n3 == v || n4 == 4)){
        pts.add(new PVector(j,i));
      }
      
    }
  }
  

   
    fill(0,0,255);
    for (PVector p: pts){
      circle(p.x,p.y,5);
      println(p);
    }
    println(pts.size());



}
