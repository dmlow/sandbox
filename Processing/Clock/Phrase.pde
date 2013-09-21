color kDefaultColor = color(255, 255, 255);
float kDefaultOnAlpha = 255; 
float kDefaultOffAlpha = 32;  
float kDefaultTextSize = 48;

class Phrase {
  String _phrase;
  float _x;
  float _y;
  Boolean _on;
  color _color;
  
  // constructor
  public Phrase(String phrase, float x, float y) {
    _phrase = phrase;
    _x = x;
    _y = y;
    _color = kDefaultColor;
  }
  
  public Phrase(String phrase, float x, float y, color textColor) {
    _phrase = phrase;
    _x = x;
    _y = y;
    _color = textColor;
  }
  
  public void ShowPhrase() {
    float alpha = kDefaultOffAlpha;
    if (_on) {
      alpha = kDefaultOnAlpha;
    }
    textSize(kDefaultTextSize);
    fill(_color, alpha);
    text(_phrase, _x, _y);
  }
  
  public void Set(Boolean value) {
      _on = value;
  }
  
  public Boolean Toggle() {
    _on = !_on;
    ShowPhrase();
    
    return _on;
  }
}
