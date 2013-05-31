// more half tones
// (c) 2013 derrick low

// Parameters
int kSize = 800; // just make squares
int kNumCircles = 40;
int kNumFields = 4;
float kBuffer = 2;
float kDiameter = kSize / kNumCircles - kBuffer;

color kResetColor;

int kFrameRate = 30;
int kLoopTime = 7;
int kNumFrames = kFrameRate * kLoopTime;

// global variables
int frame = 0;
float framepct = 0.0;

// the tables
float[] coordX = new float[kNumCircles];
float[] coordY = new float[kNumCircles];
float[] theta = new float[kNumFields];
float[][][][] d = new float[kNumCircles][kNumCircles][kNumFrames][kNumFields];
color[][][][] c = new color[kNumCircles][kNumCircles][kNumFrames][kNumFields];

void setup() {
  colorMode(RGB, 1);
  kResetColor = color(1, 1.0);

  size(kSize, kSize);
  background(0);
  smooth();
  frameRate(kFrameRate);
  // noLoop();

  generateTables();  
}

void draw() {
  // reset
  fill(kResetColor);
  stroke(kResetColor);
  rect(0, 0, kSize, kSize);
  
  // draw dots
  for (int field = 0; field < kNumFields; field++) {
    // re-orient coordinates
    // draw field
  }
  
  // increment the frame
  frame = (frame + 1) % kNumFrames;
}

void generateTables() {
  print("Generating tables...");

  // coordinates
  for (int i = 0; i < kNumCircles; i++) {
    coordX[i] = i*(kDiameter + kBuffer) + kBuffer / 2.0 + kDiameter / 2.0;
  }
  for (int i = 0; i < kNumCircles; i++) {
    coordY[i] = (kNumCircles - i - 1)*(kDiameter + kBuffer) + kBuffer / 2.0 + kDiameter / 2.0;
  }
  
  // angles
  for (int i = 0; i < kNumFields; i++) {
    theta[i] = i * PI / 2 / kNumFields;
  }
  
  // colors & sizes
  for (int row = 0; row < kNumCircles; row++) {
    for (int col = 0; col < kNumCircles; col++) {
    }
  }
  
  println("Done.");
}

float getValue(int row, int col, int index) {
  return getValue(row, col, 1.0, index); 
}

float getValue(int row, int col, float scale, int index) {
  float z = 1.0;
  
  float a;
  
  // convert (row, col) pair to (x,y) on unit square centered at (0,0) 
  float x = 2 * col / float(kNumCircles) - 1;
  float y = 2 * row / float(kNumCircles) - 1;

  switch(index) {
    case 1:
      break;
    case 2:
      break;
    case 3:
      break;
    case 4:
      break;
  }
  
  return z;
}

void drawField() {
}
