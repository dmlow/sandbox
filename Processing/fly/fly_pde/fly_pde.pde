import processing.opengl.*;
 
/**
 * Flies
 * by Elie Zananiri
 * ACAD Workshop, Apr 5 2008
 * http://www.silentlycrashing.net/p5/
 */
  
int SWARM_OFFSET = 50;
int MAX_FLIES = 500;
int numFlies = 0;
Fly[] flies = new Fly[MAX_FLIES];
 
void setup() {
  //size(screen.width, screen.height, OPENGL);
  size(800, 600);
  smooth();
  strokeWeight(2);
  noCursor();
  //for (int i=0; i < MAX_FLIES; i++)
    addFly();
}
 
void draw() {
  fill(0, 150);
  rect(0, 0, width, height);
   
  for (int i=0; i < numFlies; i++) {
    if (!flies[i].isAtTarget()) {
      flies[i].move();
    }
       
    flies[i].swarm();
    flies[i].paint();
  }
}
 
void mousePressed() {
  addFly();
}
 
void mouseMoved() {
  for (int i=0; i < numFlies; i++) {
    flies[i].newTarget(mouseX, mouseY);
  }
}
 
void addFly() {
  if (numFlies < MAX_FLIES) {
    flies[numFlies] = new Fly(random(width), random(height));
    numFlies++;
  }
}
