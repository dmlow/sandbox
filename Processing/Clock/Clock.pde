int _hour;
int _minute;
int _second;

Display clock = new Display();

String[] _hourPhrases = {"twelve", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven"};
String[] _minutePhrases = {"", "five ", "ten ", "a quarter ", "twenty ", "twenty-five ", "a half "};
void setup()
{
  textMode(MODEL);
  println("setup");
  _hour = 0;
  _minute = 0;
  _second = 0;
  
  size(600, 600);
  
  frameRate(300);
}

void draw() {
  fill(color(24, 24, 192));
  rect(0,0,600,600);

  printTime();
  clock.UpdateTime(_hour, _minute, _second);
  clock.ShowTime();  
  if (keyPressed) {
    setForward();
  } else {
    tick();
  }
}

void tick() {
  // always increment the seconds
  _second = (_second + 1) % 60;
  
  // increment the minute when we reach 60 seconds
  if (_second == 0) {
    _minute = (_minute + 1) % 60;
    // incremement the hour on 60 minutes
    if (_minute == 0) {
      _hour = (_hour + 1) % 24;
    }
  }
}

void printTime() {
  println(_hour + ":" + _minute + ":" + _second);
}

// event handlers
void setForward() {
  printTime();
  _second = 0;
  _minute = (((_minute + 5) / 5) * 5) % 60;
  printTime();
  if (_minute == 0) {
    _hour = (_hour + 1) % 24;
  }
  printTime();
}
