float _WIDTH = 800;
float _HEIGHT = 800;
float _GOLDEN_ANGLE = 2.39996; // in radians
int _MAX = 500;
color _BACKGROUND = color(196,16,80);

float centerX = _WIDTH / 2;
float centerY = _HEIGHT / 2;
float maxRadius = sqrt(_WIDTH * _WIDTH / 4+ _HEIGHT * _HEIGHT /4);
float _scale = 10;
float _scaleFactor = 1;
float _radius = 10;

boolean rotate = true;
int _mode = 0;

void setup() {
  size((int) _WIDTH, (int) _HEIGHT);
  background(_BACKGROUND);
  // noStroke();
  // noLoop();
  strokeWeight(1);
  colorMode(HSB);
  noCursor();
  smooth();
  frameRate(30);
}


int offset = 0;
color fillColor = color(240,240,64);

void draw() {
  fill(_BACKGROUND, 64);
  rect(0,0,_HEIGHT,_WIDTH);
  
  float theta;
  if (rotate) {
    offset += 3;
  }
  if ((offset % 11) == 0) {
    // fillColor = color(offset % 256, 192,192);
  }
//  else if ((offset % 7) == 0) {
//    fillColor = color(0,0,0);
//  }

  for (int n = 0; n < _MAX; n++) { 
    // get theta
    theta = n * _GOLDEN_ANGLE + radians(offset);
    
    // get cartesian coords for each point in the sunflower
    float x = GetX(n, theta, _scaleFactor * scale());
    float y = GetY(n, theta, _scaleFactor * scale());
    
    // draw the shapes
    stroke(fillColor);
    fill(0,0);
    switch (_mode % 3) {
      case 0:
        ellipse(x, y, _radius * 2, _radius * 2);
        break;
      case 1:
        DrawPolygon(x, y, _radius, (n % 6) + 3, theta);
        break;
      case 2:
        DrawStar(x, y, _radius, 0.5, (n % 4) + 3, theta);
        break;
    } 
  }
  
}

void mouseMoved() {
  centerX = mouseX;
  centerY = mouseY;
}

void keyPressed() {
  if (key == ' ')
  {
    if (rotate) {
      rotate = false;
    }
    else {
      rotate = true;
    }
  }
  if (key == '+' || key == '=') {
    _mode = (_mode + 1) % 3;
  }
  if (key == '-') {
    _mode = (_mode - 1) % 3;
  }
  
  if (key == '<') {
    _radius *= 0.99;
  }
  if (key == '>') {
    _radius *= 1.01;
  }

  if (key == ',') {
    _scaleFactor *= 0.99;
  }
  if (key == '.') {
    _scaleFactor *= 1.01;
  }
}

float scale() {
  float distance = sqrt( (centerX - _WIDTH/2) * (centerX - _WIDTH/2)
                      +(centerY - _HEIGHT/2) * (centerY - _HEIGHT/2));
  distance = distance / maxRadius * PI/2;
  return (cos(distance) * _scale);
}

// converts polar coordinates to cartesian coordinates 
// appropriate for the _WIDTH, _HEIGHT specified above
float GetX(int n, float theta, float scale) {
  return centerX + scale * sqrt(n) * cos(theta);
}

// same as above, but for Y coordinate.
float GetY(int n, float theta, float scale) {
  return centerY + scale * sqrt(n) * sin(theta);
}

// draws an n-pointed polygon inside a circle of radius r,
// centered at x,y, rotated by a
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

