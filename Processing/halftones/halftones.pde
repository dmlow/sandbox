// halftones
// inspired by the Coyote Clean Up cover art on 100% Silk 
// (http://www.listentosilk.com/wp-content/uploads/2013/05/COYOTE_CLEAN_UP_2HOT2WAIT_Cover_edit.jpg)
//
// (c) 2013 Derrick Low 

// Parameters
int kSize = 800; // just make squares
int kNumCircles = 40;
float kBuffer = 2;
float kDiameter = kSize / kNumCircles - kBuffer;
color kResetColor;
int kFrameRate = 30;
int kLoopTime = 7;
int kNumFrames = kFrameRate * kLoopTime;

// global variables
float[] cx = new float[kNumCircles];
float[] cy = new float[kNumCircles];
float r1, r2;
color col1, col2;
int frame = 0;
float framepct = 0.0;

float[][][][] d = new float[kNumCircles][kNumCircles][kNumFrames][2];
color[][][][] c = new color[kNumCircles][kNumCircles][kNumFrames][2];

void setup() {
  colorMode(RGB, 1);
  kResetColor = color(1, 1.0);

  size(kSize, kSize);
  background(0);
  smooth();
  frameRate(kFrameRate);
  // noLoop();

  for (int i = 0; i < kNumCircles; i++) {
    cx[i] = i*(kDiameter + kBuffer) + kBuffer / 2.0 + kDiameter / 2.0;
  }
  for (int i = 0; i < kNumCircles; i++) {
    cy[i] = (kNumCircles - i - 1)*(kDiameter + kBuffer) + kBuffer / 2.0 + kDiameter / 2.0;
  }
  
  createMap();
  
}

void createMap() {
  print("Generating map...");
  float d0, d1;
  float r = 0, 
        g = 0, 
        b = 0;
  float framepct = 0.0;
  
  for (int frame = 0; frame < kNumFrames; frame++) {
    framepct = float(frame) / float(kNumFrames);
    framepct = -1 * pow(2*framepct - 1, 2) + 1;
    for (int row = 0; row < kNumCircles; row++) {
      for (int col = 0; col < kNumCircles; col++) {
        // first circle size
        d0 = val(row + frame, col + frame, 3, framepct); //  * val(row, col, 1, framepct);
        d[row][col][frame][0] = min(kDiameter, d0 * kDiameter);

        // second circle size  
        d1 = (1 - val(row, kNumCircles - col, 3, framepct));
        d[row][col][frame][1] = min(kDiameter, d0 * d1 * kDiameter);
        
        // first circle color
        r = 0.9 * val(row, col, 2);
        g = 0.5 * val(row, col, 2);
        b = 0.1 * val(row, col, 3, 0.7);
        c[row][col][frame][0] = color(r, g, b);

        // second circle color
        r = val(row + frame, col, 1);
        g = val(row, col + frame, 1);
        b = 0;
        c[row][col][frame][1] = color(r, g, b);
      }
    }
  }
  
  println("Done.");
}

void draw() {
  // clear frame
  fill(kResetColor);
  stroke(kResetColor);
  rect(0, 0, kSize, kSize);

  // draw grid
  // for (int row = kNumCircles - 1; row > -1; row--) {
  for (int row = 0; row < kNumCircles; row++) {
    for (int col = 0; col < kNumCircles; col++) {
      // first circle
      r1 = d[row][col][frame][0];
      col1 = c[row][col][frame][0];
      fill(col1);
      stroke(col1);
      ellipse(cx[col], cy[row], r1, r1);

      // second circle
      r2 = d[row][col][frame][1];
      col2 = c[row][col][frame][1];
      fill(col2);
      stroke(col2);
      ellipse(cx[col], cy[row], r2, r2);
    }
  }

  // update frame
  frame = (frame + 1) % kNumFrames;
}

float val(int row, int col, int index) {
  return val(row, col, index, 0.5);
}

float val(int row, int col, int index, float scale) {
  // default to 1
  float z = 1.0;
  
  float a;
  
  // convert (row, col) pair to (x,y) on unit square centered at (0,0) 
  float x = 2 * col / float(kNumCircles) - 1;
  float y = 2 * row / float(kNumCircles) - 1;

  switch(index) {
  case 1:
    // saddle
    z = pow(x, 2) + pow(y, 2);
    break;
  case 2:
    // cone
    a = sqrt(x * x + y * y) / 0.708;
    z = sqrt(x*x + y*y) / 0.708 * pow(a, scale);  
    break;
  case 3:
    // parabola on x-y plane
    a = abs(y - x * x * x);
    z = ((a < scale)) ? (a / scale) : 0.9;
    break;
  case 4:
    // same as 3, but for x^3
    a = abs(y - x * x * x * x);
    z = ((a < scale)) ? (a / scale) : 0.9;
    break;
  }

  return max(min(z, 1), 0);
}

float getr(int row, int col, int index) {
  float diameter = 1.0;

  switch(index) {
  case 1:
    // diameter = pow(sqrt((kNumCircles / 2 - row) * (kNumCircles / 2 - row) / float(kNumCircles * kNumCircles) + row * (kNumCircles - col) / float(kNumCircles * kNumCircles)), 0.7) *  kDiameter;
    diameter = kDiameter * val(row, col, 3, 0.5) * val(row, col, 2);
    break;
  case 2:
    // diameter = pow(sqrt((kNumCircles / 2 - col) * (kNumCircles / 2 - col) + (kNumCircles - col) * (kNumCircles - col)) / sqrt(kNumCircles * kNumCircles / 2), 3);
    // diameter = diameter * pow(getr(row, col, 1), 0.7);
    diameter = (1 - val(row, kNumCircles - col, 3, 0.6)) * getr(row, col, 1);
    break;
  }

  return min(diameter, kDiameter);
}

color getcol(int row, int col, int index) {
  float r = 1;
  float g = 1;
  float b = 1;
  
  color returnColor = color(0);
  switch(index) {
  case 1:
    // returnColor = color(1.0, 0.8, 0.5 * pow(row / float(kNumCircles), 3));
    r = 0.9 * val(row, col, 2);
    g = 0.5 * val(row, col, 2);
    b = 0.1 * val(row, col, 3, 0.7);
    returnColor = color(r, g, b);
    break;
  case 2:
    // returnColor = color(0.9, 0.7 * pow((row) / float(kNumCircles), 2), 0.2 * pow((kNumCircles - col) / float(kNumCircles), 7));
    r = val(row, col, 1);
    g = val(row, col, 1);
    b = 0;
    returnColor = color(r, g, b);
    break;
  }
  return returnColor;
}

