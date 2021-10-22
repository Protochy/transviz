import java.util.*;

List<PMatrix3D> matrices = new ArrayList();
long inc = 0;
boolean click = false;
import com.hamoid.*;

import peasy.*;

PeasyCam cam;
VideoExport videoExport;



void setup() {

  fullScreen(P3D);
   frameRate(60); 
  videoExport = new VideoExport(this,"matrix.mp4");
  videoExport.setFrameRate(60);
  
  stroke(255);

  strokeWeight(2);
  matrices.add(new PMatrix3D());
  matrices.add(new PMatrix3D(
  1,-1,0                        ,0,
  1,-1,1                        ,0,
  0,0,1                       ,0,
                              0,0,0,1
  ));

  cam = new PeasyCam(this,800);

  //cam.setMinimumDistance(50);

  //cam.setMaximumDistance(500);
  videoExport.startMovie();
}

int index = 0;



void draw() {

  lights();

  shapeMode(CENTER);

 

  background(0);
      stroke(192,192,192,192);
  for (int i = 0; i<7; i++) {



      line( 0, 0, 100*i, 0, -600, 100*i );

      line( 0, -100*i, 0, 0, -100*i, 600 );


      line( 0, -100*i, 0, 600, -100*i, 0 );

      line( 100*i, 0, 0, 100*i, -600, 0  );


      line( 0, 0, 100*i,  600, 0, 100*i );

      line( 100*i, 0, 0,  100*i, 0, 600  );

    }

  pushMatrix();

    PMatrix3D interpolated = interpolate(matrices.get(index+1));
   // println(interpolated.m10);
    applyMatrix(interpolated);

    strokeWeight(3);

    stroke(255,255,255);

    for (int i = 0; i<7; i++) {

      stroke(255,255,255);

      line( 0, 0, 100*i, 0, -600, 100*i );

      line( 0, -100*i, 0, 0, -100*i, 600 );

     

      stroke(0,255,255);

      line( 0, -100*i, 0, 600, -100*i, 0 );

      line( 100*i, 0, 0, 100*i, -600, 0  );

     

      stroke(255,255,255);

      line( 0, 0, 100*i,  600, 0, 100*i );

      line( 100*i, 0, 0,  100*i, 0, 600  );

    }

    stroke(255,0,0);

    line(0,0,0,600,0,0);

    stroke(0,255,0);

    line(0,0,0,0,-600,0);

    stroke(0,0,255);

    line(0,0,0,0,0,600);

   

    noStroke();

    

   

    pushMatrix();
    hint(DISABLE_DEPTH_TEST);

      translate(50,-50,50);
      fill(255,0,255,160);
      box(100,100,100);

    popMatrix();

   hint(ENABLE_DEPTH_TEST);

    stroke(255,255,0);

    strokeWeight(7);
     fill(255,255,0);

    vector(new PVector(4,2,2),new PVector(0,30,60)); // first try it on the xyplane
    
    
   
    //noFill();
    stroke(255,0,0);
    fill(255,0,0);
    vector(new PVector(1,0,0), new PVector(0,20,25));
   
    stroke(0,255,0);
    fill(0,255,0);
    vector(new PVector(0,1,0),new PVector(0,20,25));
   
    stroke(0,0,255);
    fill(0,0,255);
    vector(new PVector(0,0,1),new PVector(0,20,25));
   

  popMatrix();

 pushMatrix();
  textSize(90);
  noLights();
  fill(255, 0,0);
  rotateY(PI/2);
  rotateZ(3/2f * PI);
 textAlign(LEFT);
  text("Determinant: " + round(interpolated.determinant()*100)/100f,-60,-200,50);
  popMatrix();

 if (inc < end && click)
    inc++;
  else if (index + 1 < matrices.size()-1) {
    inc = 0;
    index++;
  }
  ///println(inc);
  videoExport.saveFrame();
}



long end = 60*7;

PMatrix3D interpolate(PMatrix3D m){

  float originalm00 = matrices.get(index).m00, originalm01 = matrices.get(index).m01, originalm10 = matrices.get(index).m10, originalm11 = matrices.get(index).m11;

  float originalm02 = matrices.get(index).m02, originalm12 = matrices.get(index).m12, originalm20 = matrices.get(index).m20, originalm21 = matrices.get(index).m21, originalm22 = matrices.get(index).m22;

  //println(originalm10,m.m10);
  
  return new PMatrix3D(

  map2(inc,0,end,originalm00,m.m00,QUADRATIC,EASE_IN_OUT),map2(inc,0,end,originalm01,m.m01,QUADRATIC,EASE_IN_OUT),map2(inc,0,end,originalm02,m.m02,QUADRATIC,EASE_IN_OUT), 0,

  map2(inc,0,end,originalm10,m.m10,QUADRATIC,EASE_IN_OUT),map2(inc,0,end,originalm11,m.m11,QUADRATIC,EASE_IN_OUT),map2(inc,0,end,originalm12,m.m12,QUADRATIC,EASE_IN_OUT), 0,

  map2(inc,0,end,originalm20,m.m20,QUADRATIC,EASE_IN_OUT),map2(inc,0,end,originalm21,m.m21,QUADRATIC,EASE_IN_OUT),map2(inc,0,end,originalm22,m.m22,QUADRATIC,EASE_IN_OUT),0,

  0,0,0,1

  );

}



PVector scale = new PVector(100,100,100);

void vector(PVector v, PVector size) {

  float x2 = v.x;

  float y2 = -v.y;

  float z2 = v.z;

  x2 *= scale.x;

  y2 *= scale.y;

  z2 *= scale.z;

  line(0,0,0, x2, y2,z2);

  pushMatrix();

  translate(x2, y2,z2);
 
  rotateZ(PI/2 - atan2(-y2,x2));
  rotateX(-atan2(z2,x2));

  blendMode(REPLACE);

  cone(size.x,size.y,size.z,10);

  blendMode(BLEND);

  popMatrix();
}





void cone(float bottom, float top, float h, int sides)

    {


      //stroke(255,255,255,100);

      //noStroke();

      //noFill();

      pushMatrix();

     

      translate(0,h/2,0);

     

      float angle;

      float[] x = new float[sides+1];

      float[] z = new float[sides+1];

     

      float[] x2 = new float[sides+1];

      float[] z2 = new float[sides+1];

     

      //get the x and z position on a circle for all the sides

      for(int i=0; i < x.length; i++){

        angle = TWO_PI / (sides) * i;

        x[i] = sin(angle) * bottom;

        z[i] = cos(angle) * bottom;

      }

     

      for(int i=0; i < x.length; i++){

        angle = TWO_PI / (sides) * i;

        x2[i] = sin(angle) * top;

        z2[i] = cos(angle) * top;

      }

     

      //draw the bottom of the cylinder

      beginShape(TRIANGLE_FAN);

     

      vertex(0,   -h/2,    0);

     

      for(int i=0; i < x.length; i++){

        vertex(x[i], -h/2, z[i]);

      }

     

      endShape();

     

      //draw the center of the cylinder

      beginShape(QUAD_STRIP);

     

      for(int i=0; i < x.length; i++){

        vertex(x[i], -h/2, z[i]);

        vertex(x2[i], h/2, z2[i]);

      }

     

      endShape();

     

      //draw the top of the cylinder

     /* beginShape(TRIANGLE_FAN);

     

      vertex(0,   h/2,    0);

     

      for(int i=0; i < x.length; i++){

        vertex(x2[i], h/2, z2[i]);

      }

     

      endShape(); */

     

      popMatrix();

    }
    
    void keyPressed(){
      if (key == 'q') 
        click = true;
      if (key == 'w'){
    videoExport.endMovie();
    exit();
  }
    }
