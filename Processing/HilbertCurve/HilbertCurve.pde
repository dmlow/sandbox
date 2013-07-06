// HilbertCurve.pde
//
// 2013 Derrick Low
// 
// Hilbert Curve animation


// constants & parameters
int kSize = 512; // will always be square
int kMaxLevel = int(log(kSize) / log(2));
int kMinLevel = 5;
int kMatrixSize = int(pow(2, kMaxLevel - kMinLevel));
int kMinSize = 64;
color kBackground = color(255,255,255);
color kStroke = color(0, 0, 255);

int LEFT_CURVE = -1;
int TOP_CURVE = 0;
int RIGHT_CURVE = 1;

// global vars
class hilbertPoint {
  float x, y;
  
  hilbertPoint(float _x, float _y) {
    x = _x;
    y = _y;
  }
}
hilbertPoint[] _points = new hilbertPoint[int(pow(kMatrixSize,2))];
int _pointsIdx;

// entry points
void setup() {
  // show parameters
  println("kSize = " + kSize);
  println("kMaxLevel = " + kMaxLevel);
  println("kMatrixSize = " + kMatrixSize);
  
  // set up
  size(kSize, kSize);
  background(kBackground);
  frameRate(1);
  
  noLoop();
}

void draw() {
  drawRecursiveCurve(kMaxLevel, true);
//  orderQuadrant(1, 0, 0, kMatrixSize-1, kMatrixSize-1);
//  connectPoints();
}

// event handling
void mouseMoved() {
}

// main drawing function
void drawRecursiveCurve(int level, boolean connect) {
  
  float size = pow(2,level);  
  float halfsize = size/2;
  println("size = " + size);

  if (level > kMinLevel) {
    
    pushMatrix();
    translate(halfsize, halfsize);
    rotate(HALF_PI);
    stroke(color(255,0,0));
    drawRecursiveCurve(level - 1, false);
    popMatrix();
    
    pushMatrix();
    translate(halfsize, 0);
    scale(-1,1);
    stroke(color(0,255,0));
    drawRecursiveCurve(level - 1, false);
    popMatrix();
    
    pushMatrix();
    translate(halfsize, 0);
    stroke(color(0,0,255));
    drawRecursiveCurve(level - 1, false);
    popMatrix();
    
    pushMatrix();
    translate(halfsize, halfsize);
    rotate(-HALF_PI);
    scale(-1,1);
    stroke(color(0,192,192));
    drawRecursiveCurve(level - 1, true);
    popMatrix();
    
  } else {
    float left = size * 1/4,
          right = size * 3/4,
          c3 = size;
    
    line( 0, right, left, right);      
    line(left, right, left, left);
    line(left, left, right, left);
    line(right, left, right, right);
    if (connect) {
      line(right, right, c3, right);
    } else {
      line(right, right, right, c3);
    }
    
  }

}


// second method--recursively define the order of points and then connect them

void orderQuadrant(int quadrant, int top, int left, int bottom, int right) {
    println("_pointsIdx = " + _pointsIdx);
    println("quadrant: " + quadrant + ", " +
            "(" + top + "-" + bottom + ", " +
            left + "-" + right + ")");

  if (bottom == top) {
    switch(quadrant) {
      case 1:
      case 2:
        _points[_pointsIdx++] = new hilbertPoint(bottom, left);
        _points[_pointsIdx++] = new hilbertPoint(top, left);
        _points[_pointsIdx++] = new hilbertPoint(top, right);
        _points[_pointsIdx++] = new hilbertPoint(bottom, right);
      break;
      case 3:
        _points[_pointsIdx++] = new hilbertPoint(bottom, left);
        _points[_pointsIdx++] = new hilbertPoint(bottom, right);
        _points[_pointsIdx++] = new hilbertPoint(top, right);
        _points[_pointsIdx++] = new hilbertPoint(top, left);
      break;
      case 4:
        _points[_pointsIdx++] = new hilbertPoint(top, right);
        _points[_pointsIdx++] = new hilbertPoint(top, left);
        _points[_pointsIdx++] = new hilbertPoint(bottom, left);
        _points[_pointsIdx++] = new hilbertPoint(bottom, right);
      break;
    }
  } else {
    int vmiddle = (top + bottom) / 2,
        hmiddle = (left + right) / 2;
    orderQuadrant(3, top, hmiddle+1, vmiddle, right);
    orderQuadrant(2, top, left, vmiddle, hmiddle);
    orderQuadrant(1, vmiddle+1, left, bottom, hmiddle);
    orderQuadrant(4, vmiddle+1, hmiddle+1, bottom, right);    
  }
}

void connectPoints() {
  float ratio = kSize / kMatrixSize;
  if (_pointsIdx == _points.length) {
    stroke(color(0));
    for (int i = 0; i < _pointsIdx-1; i++) {
      println("(" + _points[i].x + ", " + _points[i].y + ") - (" + _points[i+1].x + ", " + _points[i+1].y + ")");
      float x1 = _points[i].x * ratio + ratio / 2,
            y1 = _points[i].y * ratio + ratio / 2,
            x2 = _points[i+1].x * ratio + ratio / 2,
            y2 = _points[i+1].y * ratio + ratio / 2;  
      line(x1, y1, x2, y2);
    }
  }
}
