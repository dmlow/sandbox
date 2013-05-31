/**
 * FollowTree
 * (c) 2013 Derrick Low
 * 
 * Draws a tree that follows your mouse around.
 */

// constants
int WIDTH = 600;
int HEIGHT = 600;
int MAX_BRANCHES = 8;

// global vars
float _step = 0;
float _theta = 0;
Tree tree = new Tree(2, WIDTH/2, HEIGHT/2, _theta);
boolean _moveWithMouse = false;

void setup() {
  size(WIDTH, HEIGHT);
  background(0);
  frameRate(10);  
  smooth();
}

void draw() {
  // fade out the last frame
  fill(128,192,192,48);
  rect(0, 0, WIDTH, HEIGHT);

  // update the tree
  fill(0);
  stroke(0);  
  tree.paint();
  tree.rotateTree(_step);
}

void mousePressed() {
  // let's get some UI in here
  if (keyPressed = true) {
    if (key == CODED) {
      if (keyCode == SHIFT) {
        tree.addTrunk();
      }
      if (keyCode == CONTROL) {
        tree.removeTrunk();
      }
    }
  }
  
}

void keyPressed() {
  if (key == '+' || key == '=') {
    tree.addTrunk();
  }
  if (key == '-') {
    tree.removeTrunk();
  }
  if (key == ' ') {
    setStep(-degrees(_step));
  }
  if (key == CODED) {
    if (keyCode == LEFT) {    
      setStep(-1);
    }
    if (keyCode == RIGHT) {
      setStep(+1);
    }
    if (keyCode == UP) {
      setTheta(+1);
    }
    if (keyCode == DOWN) {
      setTheta(-1);
    }
  }
}

void recenterTree() {
    tree.recenter(mouseX,mouseY);
}

void setTheta(float theta) {
  _theta = _theta + radians(theta);
  tree.setAngle(_theta);
  println("_theta = " + _theta);
}

void setStep(float step) {
  _step = min(max(_step + radians(step), -PI/3), PI/3);
  println("_step = " + _step);
}
/**
 * FollowTree.Tree
 * (c) 2013 Derrick Low
 *
 * Manages the tree.
 */

class Tree {
  float _homeX;
  float _homeY;
  int _nTrunks = 0;
  float _trunkSize = 100;
  float _theta;
  float _offset = 0;
  float _minBranch = _trunkSize;
  
  // constructor
  Tree(int nBranches, float x, float y, float theta) {
    for (int i=0; i < nBranches; ++i) {
      addTrunk();
    }

    setAngle(theta);

    recenter(x,y);
  }    
  
  void rotateTree(float step) {
    _offset += step;
  }
  
  void recenter(float x, float y) {
    _homeX = x;
    _homeY = y;
  }
  
  void setAngle(float theta) {
    _theta = theta;
  }
  
  void addTrunk() {
    if (_nTrunks < MAX_BRANCHES) {
      ++_nTrunks;
      updateMinBranch();
    }
  }
  
  void removeTrunk() {
    if (_nTrunks > 1) {
      --_nTrunks;
      updateMinBranch();
    }
  }
  
  void updateMinBranch() {
    _minBranch = pow(2, _nTrunks-0.5);
    println("_nTrunks = " + _nTrunks + ", _minBranch = " + _minBranch);
  }
  
  void setTrunkSize(float trunkSize) {
    _trunkSize = trunkSize;
  }
  
  void paint() {
    float theta = 2 * PI / _nTrunks;
    
    // draw our trunks
    for (int i=0; i < _nTrunks; ++i) {
      pushMatrix();
        translate(_homeX,_homeY);
        rotate(theta * i + _offset);
        
        stroke(216,32,96);        
        line(0, 0, 0, -_trunkSize);
        branch(_trunkSize, _nTrunks, 0.618);
      popMatrix();
    }
  }
  

  void branch(float r, int n, float scale) {
    // we have to stop somewhere, so set a min r
    if (r > _minBranch) {
      float branchStep = _theta;
      float[] thetas = new float[n];
      for (int i=0; i < n; ++i) {
        thetas[i] = PI + branchStep * (i + 1.5);
      }
      
      pushMatrix();
      translate(0, -r);
      // draw the initial branches
      for (int i=0; i < n; ++i) {
        rotate(thetas[i]);
        stroke(216,32+1/r,96/r/3);        
        line(0,0,0,scale * -r);
        rotate(-thetas[i]);
      }
      // draw the next level of branches
      for (int i=0; i < n; ++i) {
        rotate(thetas[i]);
        branch(scale * r, n, scale);
        rotate(-thetas[i]); 
      }
      popMatrix();
    }
  }
}  

