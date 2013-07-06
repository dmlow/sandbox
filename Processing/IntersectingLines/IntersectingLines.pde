// intersecting lines
// let's the user create pairs of lines segments, which we then 
// draw and determine if they intersect. 

int kWidth = 500;
int kHeight = 500;

float kTolerance = .01;

float kEndPointRadius = 3;
color kEndPointColor = color(255, 0, 0);
float kSegmentStrokeWeight = 2;
color kNonIntersectingColor = color(255, 255, 0);
color kIntersectingColor = color(0, 255, 0);

LineSegment _currentLS = new LineSegment();
LinePair _currentPair = new LinePair();
int _pointIdx;

void setup() {
  // drawing parameters
  size(kWidth, kHeight);
  background(0);
  ellipseMode(RADIUS);
  loop();
  frameRate(30);
  
  // variables
  _pointIdx = 0;
}

void draw() {
  stroke(0, 2);
  fill(0, 2);
  rect(0,0,kWidth,kHeight);
}

void mouseClicked() {
  if (_pointIdx != 0) {
    _currentPair.AddPoint(mouseX, mouseY);
    _pointIdx = (_pointIdx + 1) % 4;
  } else {
    _currentPair = new LinePair(mouseX, mouseY);
    _pointIdx++;
  }
}
