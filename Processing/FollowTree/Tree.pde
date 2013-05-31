/**
 * FollowTree.Tree
 * (c) 2013 Derrick Low
 *
 * Manages the tree.
 */

class Tree {
  // where to put it
  float _homeX;
  float _homeY;
  float _targetX;
  float _targetY;
  
  // what's it look like?
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
    
    _homeX = x;
    _homeY = y;
    retarget(x,y);
  }    
  
  void rotateTree(float step) {
    _offset += step;
  }
  
  void retarget(float x, float y) {
    _targetX = x;
    _targetY = y;
    // println("home: (" + _homeX + "," + _homeY + "), target: (" + _targetX + "," + _targetY + ")"); 
  }
  
  // moves the tree toward the target
  void move() {
    float delX = _targetX - _homeX;
    float delY = _targetY - _homeY;
     
    // only move when the target is sufficiently far away
    if (abs(delX) > 1 || abs(delY) > 1) {
      float stepX = delX / 10;
      float stepY = delY / 10;
      
      _homeX += stepX;
      _homeY += stepY;
    }
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
