class LineSegment {
  // fields
  EndPoint[] endPoints = new EndPoint[2];
  private int endPointsIdx;
  boolean complete;
  
  // constructors
  LineSegment() {
    endPointsIdx = 0;
    complete = false;
  }
  
  LineSegment(float x, float y) {
    endPointsIdx = 0;
    complete = false;
    AddPoint(x, y);
  }
  
  LineSegment(EndPoint pt) {
    endPointsIdx = 0;
    complete = false;
    AddPoint(pt);
  }
  
  LineSegment(EndPoint pt1, EndPoint pt2) {
    endPointsIdx = 0;
    complete = false;
    AddPoint(pt1);
    AddPoint(pt2);
  }
  
  // methods
  boolean Intersects(LineSegment other) {
    if (this.Complete() && other.Complete()) {
      float m1 = (endPoints[1].y - endPoints[0].y) / (endPoints[1].x - endPoints[0].x);
      float b1 = m1 * endPoints[0].x - endPoints[0].y;
      
      float m2 = (other.endPoints[1].y - other.endPoints[0].y) / (other.endPoints[1].x - other.endPoints[0].x);
      float b2 = m2 * other.endPoints[0].x - other.endPoints[0].y;
      
      println("m1 = " + m1 + ", m2 = " + m2 + ", m1 - m2 = " + abs(m1 - m2));
      // check if slopes are not equal
      if (abs(m1 - m2) > kTolerance) {
        // in which case, see if the point of intersection is inside both bounding boxes
        float x = -1 * (b2 - b1) / (m1 - m2);
        float y = -1 * ((b2 - b1) / (m1 - m2) * m1 + b1);
        
        // first box
        float minX1 = endPoints[0].x < endPoints[1].x ? endPoints[0].x : endPoints[1].x;
        float maxX1 = endPoints[0].x > endPoints[1].x ? endPoints[0].x : endPoints[1].x;
        float minY1 = endPoints[0].y < endPoints[1].y ? endPoints[0].y : endPoints[1].y;
        float maxY1 = endPoints[0].y > endPoints[1].y ? endPoints[0].y : endPoints[1].y;
        
        // second box
        float minX2 = other.endPoints[0].x < other.endPoints[1].x ? other.endPoints[0].x : other.endPoints[1].x;
        float maxX2 = other.endPoints[0].x > other.endPoints[1].x ? other.endPoints[0].x : other.endPoints[1].x;
        float minY2 = other.endPoints[0].y < other.endPoints[1].y ? other.endPoints[0].y : other.endPoints[1].y;
        float maxY2 = other.endPoints[0].y > other.endPoints[1].y ? other.endPoints[0].y : other.endPoints[1].y;

        println("Checking (" + x + ", " + y + ") " +
                "against (" + minX1 + ", " + minY1 + ")-(" + maxX1 + ", " + maxY1 + ") " +
                "and (" + minX2 + ", " + minY2 + ")-(" + maxX2 + ", " + maxY2 + ") ");
        // if it's inside the bounding boxes, it must also be on both line segments, thus intersection!
        if (// first box
            (x - minX1 > -kTolerance) &&
            (maxX1 - x > -kTolerance) &&
            (y - minY1 > -kTolerance) &&
            (maxY1 - y > -kTolerance) &&
            // second box
            (x - minX2 > -kTolerance) &&
            (maxX2 - x > -kTolerance) &&
            (y - minY2 > -kTolerance) &&
            (maxY2 - y > -kTolerance)) {
          return true;
        }
      }
    }
    
    return false;
  }
    
  boolean Complete() {
    return complete;
  }
  
  void AddPoint(float x, float y) {
    AddPoint(new EndPoint(x, y));
  }
  
  void AddPoint(EndPoint pt) {
    if (!complete) {
      endPoints[endPointsIdx] = pt;
      endPointsIdx += 1;
      complete = (endPointsIdx > 1);
      
      if (complete) {
        Display(false);
      }
    }
  }
    
  void Display(boolean intersecting) {
      if (intersecting) {
        stroke(kIntersectingColor);
      }
      else {
        stroke(kNonIntersectingColor);
      }
      strokeWeight(kSegmentStrokeWeight);
      line(endPoints[0].x, endPoints[0].y, endPoints[1].x, endPoints[1].y);
      
      // redraw the EndPoints
      endPoints[0].Display();
      endPoints[1].Display();
  }
}

