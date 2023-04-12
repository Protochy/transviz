

import java.util.*;
import java.util.*;
PImage inputImage;
List<PVector> pts = new ArrayList<>();
List<PVector> orderedPts = new ArrayList<>();
float threshold = 60;
boolean displayPoints = false;

void setup() {
  size(800, 800);
  inputImage = loadImage("Lhu.png");
  detectEdges(inputImage);
}

void orderPoints() {
  if (pts.isEmpty()) {
    return;
  }

  // Select the first point as the starting point
  PVector startPoint = pts.remove(0);
  orderedPts.add(startPoint);
  PVector currentPoint = startPoint;

  while (!pts.isEmpty()) {
    float minDistance = Float.MAX_VALUE;
    PVector closestPoint = null;
    int closestPointIndex = -1;

    // Find the closest unvisited point to the current point
    for (int i = 0; i < pts.size(); i++) {
      PVector point = pts.get(i);
      float distance = dist(currentPoint.x, currentPoint.y, point.x, point.y);

      if (distance < minDistance) {
        minDistance = distance;
        closestPoint = point;
        closestPointIndex = i;
      }
    }

    // Add the closest point to the ordered list and remove it from the unvisited list
    orderedPts.add(closestPoint);
    pts.remove(closestPointIndex);
    currentPoint = closestPoint;
  }
  
  // Add the starting point to the end of the ordered list to form a closed loop
  orderedPts.add(startPoint);
}


void detectEdges(PImage inputImage) {
  inputImage.filter(GRAY);
  PImage edges = createImage(inputImage.width, inputImage.height, ALPHA);

  for (int y = 1; y < inputImage.height - 1; y++) {
    for (int x = 1; x < inputImage.width - 1; x++) {
      if (x % 3 == 0 && y % 3 == 0){
      float gx = (-1 * brightness(inputImage.get(x - 1, y - 1)) + 1 * brightness(inputImage.get(x + 1, y - 1)) +
                  -2 * brightness(inputImage.get(x - 1, y)) + 2 * brightness(inputImage.get(x + 1, y)) +
                  -1 * brightness(inputImage.get(x - 1, y + 1)) + 1 * brightness(inputImage.get(x + 1, y + 1)));

      float gy = (-1 * brightness(inputImage.get(x - 1, y - 1)) - 2 * brightness(inputImage.get(x, y - 1)) - 1 * brightness(inputImage.get(x + 1, y - 1)) +
                  1 * brightness(inputImage.get(x - 1, y + 1)) + 2 * brightness(inputImage.get(x, y + 1)) + 1 * brightness(inputImage.get(x + 1, y + 1)));

      float edge = sqrt(gx * gx + gy * gy);

      if (edge > threshold) {
        edges.set(x, y, color(255));
        pts.add(new PVector(x, y));
      }
    }
    }
  }

  inputImage = edges;
}

double mx = 0;
void draw() {
  image(inputImage, 0, 0);

  if (displayPoints) {
    drawPoints();
    //// if (mx > 900)
      // mx+=0.5;
       //else
       mx += 2;
  }
 
}

void keyPressed() {
  displayPoints = !displayPoints;
  println(pts.size());
  orderPoints();
  println(orderedPts.size());
  
  // Write points to a text file
  PrintWriter output;
  try {
    output = createWriter("points.txt");
    for (PVector p : orderedPts) {
      output.println("[" + p.x + "," + p.y + "]");
    }
    output.flush(); // Make sure all data is written to the file
    output.close(); // Close the file
  } catch (Exception e) {
    println("Error writing to file: " + e.getMessage());
  } 
}

void drawPoints() {
  stroke(0, 255, 0);
  strokeWeight(2);

  for (int i = 0; i < mx - 1 && i < orderedPts.size() - 1; ++i) {
    PVector pt1 = orderedPts.get(i);
    //PVector pt2 = orderedPts.get(i + 1);
    //line(pt1.x, pt1.y, pt2.x, pt2.y);
    point(pt1.x,pt1.y);
  }
}
