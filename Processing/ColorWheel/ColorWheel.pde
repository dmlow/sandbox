int WIDTH = 200;
int HEIGHT = 200;
int centerX = WIDTH/2;
int centerY = HEIGHT/2;
int radiusX = WIDTH/2;
int radiusY = HEIGHT/2;
int radiusD = int(sqrt(max(radiusX, radiusY) * max(radiusX, radiusY) * 4));
int offset = 0;
int STEP = 10;

void setup() {
  size(WIDTH, HEIGHT);
  background(0);
  colorMode(HSB, 2*PI, 1.0, radiusD);
  frameRate(1);
}

void draw() {
  offset = (offset + STEP) % 360;
  fill(radians(180) + radians(180), 1.0, radiusD);
  rect(0,0,WIDTH,HEIGHT);
  // println(theta);
  // fill(radians(theta), 1, radiusD);
  // drawColorWheel(radians(offset));
}

// draws the color wheel, offset by a given angle 
void drawColorWheel(float offset) {
  pushMatrix();
  translate(centerX, centerY);
  for (int x=-(radiusX); x < (radiusX); ++x) {
    for (int y=-(radiusY); y < (radiusY); ++y) {
      color c = getColor(x, y, offset);
      fill(c);
      stroke(c);
      point(x, y);
    }
  }
  popMatrix();
}

// returns the color for a given pixel
color getColor(int x, int y, float offset) {
  float d = getDistance(x,y);
  float angle = (atan2(y, x) + offset);
  return color(angle % (2*PI), 1.0, radiusD - d);
}

float getDistance(int x, int y) {
  return sqrt(x*x + y*y);
} 
