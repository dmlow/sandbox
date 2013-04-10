float _WIDTH = 800;
float _HEIGHT = 800;
float _RADIUS = 5;
float _SCALE = 20;
float _GOLDEN_ANGLE = 2.39996; // in radians
int _MAX = 1000;

void setup() {
  size((int) _WIDTH, (int) _HEIGHT);
  background(random(256));
  // noStroke();
  // noLoop();
  strokeWeight(1);
}


int offset = 0;
color fillColor = color(random(256),random(256),random(256));

void draw() {
  
  float theta;
  offset++;
  if ((offset % 7) == 0) {
    fillColor = color(random(128)+128,random(64)+32,random(32)+32);
  }
  else if ((offset % 53) == 0) {
    fillColor = color(0,0,0);
  }

  for (int n = 0; n < _MAX; n++) { 
    // get theta
    theta = n * _GOLDEN_ANGLE + radians(offset);
    
    // get cartesian coords
    float x = GetX(n, theta, _SCALE * cos(radians(offset)) + _SCALE);
    float y = GetY(n, theta, _SCALE * sin(radians(offset)) + _SCALE);
    
    // draw the ellipse
    stroke(fillColor);
    fill(fillColor);
//    ellipse(x,y, _RADIUS, _RADIUS);
//    DrawPolygon(x,y,_RADIUS,(int) random(6) + 3,0);
    DrawStar(x, y, _RADIUS, 0.5, (n % 4) + 3, 0); 
  }
  
}

// converts polar coordinates to cartesian coordinates 
// appropriate for the _WIDTH, _HEIGHT specified above
float GetX(int n, float theta, float scale) {
  return _WIDTH / 2 + scale * sqrt(n) * cos(theta);
}

// same as above, but for Y coordinate.
float GetY(int n, float theta, float scale) {
  return _HEIGHT / 2 + scale * sqrt(n) * sin(theta);
}

// draws an n-pointed polygon inside a circle of radius r,
// centered at x,y, rotated by theta
void DrawPolygon(float x, float y, float r, int n, float a) {
  float theta = 2 * PI / n;
  float offset;
  if (n % 2 == 0) {
    offset = a + theta / 2;
  } else {
    offset = a - PI / 2;
  }
  
  // set initial points
  float x1 = x + r * cos(offset);
  float y1 = y + r * sin(offset);
  
  // draw the rest of the points
  for (int i = 0; i <= n; i++) {
    // set next points
    float x2 = x + r * cos(offset + i * theta); 
    float y2 = y + r * sin(offset + i * theta);
    
    line(x1,y1,x2,y2);
    
    x1 = x2;
    y1 = y2;
  }  
}

void DrawStar(float x, float y, float r1, float r2, int n, float a) {
  float theta = 2 * PI / n;
  float offset;
  if (n % 2 == 0) {
    offset = a;
  } else {
    offset = a - PI / 2;
  }
  
  // set initial points
  float x1 = x + r1 * cos(offset);
  float y1 = y + r1 * sin(offset);
  
  // draw the rest of the points
  for (int i = 0; i <= n; i++) {
    // set the inside point
    float x_inner = x + r1 * r2 * cos(offset + (i - 0.5) * theta);
    float y_inner = y + r1 * r2 * sin(offset + (i - 0.5) * theta);
    // set next outside points
    float x2 = x + r1 * cos(offset + i * theta); 
    float y2 = y + r1 * sin(offset + i * theta);
    
    line(x1, y1, x_inner, y_inner);
    line(x_inner, y_inner, x2, y2);
    
    x1 = x2;
    y1 = y2;
  }  
}

