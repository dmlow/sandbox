/**
 * FollowTree
 * (c) 2013 Derrick Low
 * 
 * Draws a tree that follows your mouse around.
 */

// constants
int WIDTH = 1200;
int HEIGHT = 800;
int MAX_BRANCHES = 8; // more than 8 and the branch stopper stops branches
int L = 2; // distance metric

// tree vars
float _step = radians(1);
float _theta = radians(90);
Tree tree = new Tree(3, WIDTH/2, HEIGHT/2, _theta);

// other vars
float _trail = 128;
boolean _moveWithMouse = false;

void setup() {
  size(WIDTH, HEIGHT);
  background(0);
  frameRate(120);  
  noCursor();
  smooth();
}

void draw() {
  // fade out the last frame
  fill(128, 192, 192, _trail);
  rect(0, 0, WIDTH, HEIGHT);

  // update the tree
  tree.move();
  tree.rotateTree(_step);
  tree.paint();
}

void keyPressed() {
  if (key == '+' || key == '=') {
    tree.addTrunk();
  }
  if (key == '-') {
    tree.removeTrunk();
  }
  if (key == ' ') {
    incrStep(-degrees(_step));
  }
  if (key == CODED) {
    if (keyCode == LEFT) {    
      incrStep(-1);
    }
    if (keyCode == RIGHT) {
      incrStep(+1);
    }
    if (keyCode == UP) {
      incrTheta(+1);
    }
    if (keyCode == DOWN) {
      incrTheta(-1);
    }
  }
}

void mouseMoved() {
  // follow the mouse
  tree.retarget(mouseX, mouseY);
  
  // get distance to center as ratio to max possible distance 
  float ratio = ratioToCenter(mouseX, mouseY);
  
  // branch angle corresonds to Y
  _theta = (mouseY / HEIGHT) * (2 * PI) - PI;
  tree.setAngle(_theta);
  
  // speed corresponds to distance from center
    _step = ratio * PI / 15;
  // but direction corresponds to X
  if ((mouseX > WIDTH / 2 && mouseY < HEIGHT / 2)
      || (mouseX < WIDTH / 2 && mouseY > HEIGHT / 2)) {
    _step = -_step;
  }
  
  // as does trunk size
  tree.setTrunkSize(cos(max(0, ratio*2))*100);
  
  // and 
  _trail = 128 * (1 - ratio);
}

float ratioToCenter(float x, float y) {
  return distanceToCenter(x,y) / distanceToCenter(0,0);
}

float distanceToCenter(float x, float y) {
  float xx = pow(abs(x - WIDTH / 2), L);
  float yy = pow(abs(y - HEIGHT / 2), L);
  float d = pow(xx + yy, 1.0/L);
  return d;
}

void incrTheta(float theta) {
  _theta = _theta + radians(theta);
  tree.setAngle(_theta);
  println("_theta = PI * " + _theta / PI);
}

void incrStep(float step) {
  _step = min(max(_step + radians(step), -PI/3), PI/3);
  println("_step = PI * " + _step / PI);
}

