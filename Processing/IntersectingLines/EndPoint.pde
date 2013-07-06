class EndPoint {
  // fields
  float x;
  float y;

  // constructors
  EndPoint(float newX, float newY) {
    x = newX;
    y = newY;
    println("Adding point (" + x + ", " + y + ")");

    Display();
  }

  EndPoint(EndPoint pt) {
    x = pt.x;
    y = pt.y;
    println("Adding point (" + pt.x + ", " + pt.y + ")");

    Display();
  }

  // methods
  void Display() {
    fill(kEndPointColor);
    strokeWeight(0);
    ellipse(x, y, kEndPointRadius, kEndPointRadius);
  }
}

