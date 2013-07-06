
class LinePair {
  // fields
  private LineSegment[] _segment = new LineSegment[2];
  
  // constructors
  LinePair() {
    _segment[0] = new LineSegment();
    _segment[1] = new LineSegment();
  }
  
  LinePair(EndPoint pt) {
    _segment[0] = new LineSegment();
    _segment[1] = new LineSegment();

    AddPoint(pt);
  }
  
  LinePair(float x, float y) {
    _segment[0] = new LineSegment();
    _segment[1] = new LineSegment();

    AddPoint(new EndPoint(x,y));
  }
  
  // methods
  boolean Intersects() {
    if (_segment[0].complete && _segment[1].complete) {
      return _segment[0].Intersects(_segment[1]);
    }
    
    return false;
  }
  
  void AddPoint(float x, float y) {
    AddPoint(new EndPoint(x, y));
  }
  
  void AddPoint(EndPoint pt) {
    // first add to segment 1
    if (!_segment[0].complete) {
      _segment[0].AddPoint(pt);
    }
    
    // now try the next line
    else if (!_segment[1].complete) {
      _segment[1].AddPoint(pt);
    }
    
    if (Intersects()) {
      Redraw();
    }
  }
  
  void Redraw() {
    println("redrawing!");
    boolean intersects = Intersects();
    _segment[0].Display(intersects);
    _segment[1].Display(intersects);
  }
}



