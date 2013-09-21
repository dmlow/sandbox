class Display {
  int kItIsIdx = 0,
      kAIdx = 1,
      kFiveMinutesIdx = 2,
      kTenMinutesIdx = 3,
      kQuarterIdx = 4,
      kHalfIdx = 5,
      kMinutesIdx = 6,
      kOneIdx = 7,
      kTwoIdx = 8,
      kThreeIdx = 9,
      kFourIdx = 10,
      kFiveIdx = 11,
      kSixIdx = 12,
      kSevenIdx = 13,
      kEightIdx = 14,
      kNineIdx = 15,
      kTenIdx = 16,
      kElevenIdx = 17,
      kMidnightIdx = 18,
      kNoonIdx = 19,
      kOClockIdx = 20,
      kExactlyIdx = 21,
      kPastIdx = 22,
      kTilIdx = 23,
      kTwentyMinutesIdx = 24;
  int kNumLights = 25;


  Phrase[] _phrases = new Phrase[kNumLights];
  Boolean[] _switches = new Boolean[kNumLights];

  // Constructors
  public Display() {
    _switches = new Boolean[kNumLights];
    _phrases = new Phrase[kNumLights];
    println(_switches.length + ", " + _phrases.length + ", " + kNumLights);
    
    
    UpdateTime(0, 0, 0);
    AddPhrases();
  }
  
  // Public Methods
  public void ShowTime() {
    // text("IT IS A TEN QUARTER HALF\nTWENTY FIVE MINUTES TIL\nPAST ONE TWO THREE FOUR\nFIVE SIX SEVEN EIGHT NINE\nTEN ELEVEN MIDNIGHT\nNOON O'CLOCK EXACTLY", 10, 500);
    SwitchPhrases(_switches);
    ShowPhrases();
  }
  
  public void UpdateTime(int hours, int minutes, int seconds) {    
    _switches = parseTime(hours, minutes, seconds);
  }
  
  // Private Methods
  private void AddPhrases() {
    println("Adding Phrases...");

    _phrases[kItIsIdx] = new Phrase("IT IS", 10, 60);
    _phrases[kAIdx] = new Phrase("A", 125, 60);
    _phrases[kQuarterIdx] = new Phrase("QUARTER", 170, 60);
    _phrases[kHalfIdx] = new Phrase("HALF", 400, 60);
    
    _phrases[kTenMinutesIdx] = new Phrase("TEN", 10, 120);
    _phrases[kTwentyMinutesIdx] = new Phrase("TWENTY", 160, 120);
    _phrases[kFiveMinutesIdx] = new Phrase("FIVE", 405, 120);
    

    _phrases[kMinutesIdx] = new Phrase("MINUTES", 10, 180);
    _phrases[kTilIdx] = new Phrase("TO", 270, 180);
    _phrases[kPastIdx] = new Phrase("PAST", 390, 180);

    _phrases[kOneIdx] = new Phrase("ONE", 10, 240);
    _phrases[kTwoIdx] = new Phrase("TWO", 110, 240);
    _phrases[kThreeIdx] = new Phrase("THREE", 220, 240);
    _phrases[kFourIdx] = new Phrase("FOUR", 380, 240);
    
    _phrases[kFiveIdx] = new Phrase("FIVE", 10, 300);
    _phrases[kSixIdx] = new Phrase("SIX", 120, 300);
    _phrases[kSevenIdx] = new Phrase("SEVEN", 200, 300);
    _phrases[kEightIdx] = new Phrase("EIGHT", 360, 300);

    _phrases[kNineIdx] = new Phrase("NINE", 10, 360);
    _phrases[kTenIdx] = new Phrase("TEN", 180, 360);
    _phrases[kElevenIdx] = new Phrase("ELEVEN", 330, 360);

    _phrases[kMidnightIdx] = new Phrase("MIDNIGHT", 10, 420);
    _phrases[kNoonIdx] = new Phrase("NOON", 320, 420);

    _phrases[kOClockIdx] = new Phrase("O'CLOCK", 10, 480);
    _phrases[kExactlyIdx] = new Phrase("EXACTLY", 260, 480);
    println("Hour phrases added.");
  }
  
  private void SwitchPhrases(Boolean[] switches) {
    if (switches.length == kNumLights) {
      for (int i = 0; i < kNumLights; i++) {
        _phrases[i].Set(switches[i]);
      }
    }
  }
  
  private void ShowPhrases() {
    for (int i = 0; i < kNumLights; i++) {
      _phrases[i].ShowPhrase();
    }
  }
  
  private Boolean[] parseTime(int hours, int minutes, int seconds) {
    Boolean[] switches = new Boolean[kNumLights];
    int roundedMinutes = (((minutes) % 60) / 5) * 5;
    println(roundedMinutes);
    int displayHours = hours;

    for (int i = 0; i < kNumLights; i++) {
      switches[i] = false;
    }    
    
    // It Is is always lit
    switches[kItIsIdx] = true;
    
    // minutes
    if (roundedMinutes == 0) {
      // on the dot
      switches[kExactlyIdx] = true;
    } else if (roundedMinutes <= 30) {
      // first half ("past")
      switches[kPastIdx] = true;
      switch(roundedMinutes) {
        case 5:
          switches[kFiveMinutesIdx] = true;
          break;
        case 10:
          switches[kTenMinutesIdx] = true;
          break;
        case 15:
          switches[kAIdx] = true;
          switches[kQuarterIdx] = true;
          break;
        case 20:
          switches[kTwentyMinutesIdx] = true;
          break;
        case 25:
          switches[kTwentyMinutesIdx] = true;
          switches[kFiveMinutesIdx] = true;
          break;
        case 30:
          switches[kAIdx] = true;
          switches[kHalfIdx] = true;
          break;
        default:
          break;
      }
    } else {
      switches[kTilIdx] = true;
      displayHours = (displayHours + 1) % 24;
      switch(roundedMinutes) {
        case 35:
          switches[kTwentyMinutesIdx] = true;
          switches[kFiveMinutesIdx] = true;
          break;
        case 40:
          switches[kTwentyMinutesIdx] = true;
          break;
        case 45:
          switches[kAIdx] = true;
          switches[kQuarterIdx] = true;
          break;
        case 50:
          switches[kTenMinutesIdx] = true;
          break;
        case 55:
          switches[kFiveMinutesIdx] = true;
          break;
        default:
          break;
      }
    }
    
    // hours
    if (displayHours == 0) {
      switches[kMidnightIdx] = true;
    } else if (displayHours == 12) {
      switches[kNoonIdx] = true;
    } else {
      switches[kOClockIdx] = true;
      switch(displayHours % 12) {
        case 1:
          switches[kOneIdx] = true;
          break;
        case 2:
          switches[kTwoIdx] = true;
          break;
        case 3:
          switches[kThreeIdx] = true;
          break;
        case 4:
          switches[kFourIdx] = true;
          break;
        case 5:
          switches[kFiveIdx] = true;
          break;
        case 6:
          switches[kSixIdx] = true;
          break;
        case 7:
          switches[kSevenIdx] = true;
          break;
        case 8:
          switches[kEightIdx] = true;
          break;
        case 9:
          switches[kNineIdx] = true;
          break;
        case 10:
          switches[kTenIdx] = true;
          break;
        case 11:
          switches[kElevenIdx] = true;
          break;
        default:
          break;
      }
    }
    
    return switches;
  }
}
