class Fly {
  // swarm animation
  float homeX, homeY;
  float rangeX, rangeY;
  float angle;
  float step;
  
  // color variables
  color bodyColor;
  color wingColor;
   
  // current position
  float currX, currY;
   
  // move animation
  float targetX, targetY;
  boolean atTarget;
   
  // paing variables
  int bodySize;
  int wingSpan;
  float flap;
  float flapStep;
   
  Fly(float x, float y) {
    // init the move variables
    homeX = random(x-SWARM_OFFSET, x+SWARM_OFFSET);
    homeY = random(y-SWARM_OFFSET, y+SWARM_OFFSET);
    newTarget(homeX, homeY);
    
    // init color variables
    colorMode(RGB, 255);
    bodyColor = color(2, 180, 9);
    wingColor = color(180,124,2);
     
    // init the swarm variables
    setSwarm();
     
    // init the paint variables
    bodySize = (int)random(5, 10);
    wingSpan = (int)random(5, 10);
    flap = 0;
    flapStep = (bodySize*1.0/wingSpan)/5;
  }
   
  void paint() {
    pushMatrix();
      translate(currX, currY);
      rotate(angle);
       
      // draw the wings
      stroke(bodyColor);
      line(0, 0, -wingSpan, -sin(flap)*wingSpan);
      line(0, 0, wingSpan, -sin(flap)*wingSpan);
      flap += flapStep;
       
      // draw the body
      fill(wingColor);
      noStroke();
      ellipse(0, 0, bodySize, bodySize);
    popMatrix();
  }
   
  void move() {
    // calculate the distance to the target
    float dX = targetX-homeX;
    float dY = targetY-homeY;
     
    // calculate the current step towards the target
    float stepX = dX/50;
    float stepY = dY/50;
     
    homeX += stepX;
    homeY += stepY;
     
    // if we're close enough to the target...
    if (abs(dX) < 1 && abs(dY) < 1) {
      // ...assume we've reached it
      atTarget = true;
    }
  }
   
  void swarm() {
    // hover around the home position
    currX = int(rangeX*sin(angle)+homeX);
    currY = int(rangeY*cos(angle)+homeY);
    angle += step;
    
    // switch up the pattern of the swarm every so often
    if (random(1) < 0.05) {
      changeSwarm();
    }
  }
  
  void setSwarm() {
    // init the swarm variables
    rangeX = random(20, 50);
    rangeY = random(20, 50);
    angle = 0;
    step = random(-0.1, 0.1);
  }
  
  void changeSwarm() {
    // changes the center and speed of the swarm 
    rangeX = random(20, 50);
    rangeY = random(20, 50);
    homeX = currX + rangeX * sin(angle);
    homeY = currY + rangeY * cos(angle);

    step = random(-0.1, 0.1);
    angle = PI + angle;
  }   
  
  void newTarget(float newX, float newY) {
    // set a new target position for the home
    targetX = random(newX-50, newX+50);
    targetY = random(newY-50, newY+50);
    atTarget = false;
  }
   
  boolean isAtTarget() {
    return atTarget;
  }
}
