class PracticePreferencesDictionaries {
  final List<Map<String, dynamic>> time = [
    {"label": "25 min", "value": 25},
    {"label": "45 min", "value": 45},
    {"label": "1 hour", "value": 60},
    {"label": "1 hour 20 min", "value": 80}
  ];

  final List<Map<String, dynamic>> voice = [
    {"label": "Female", "value": "female"},
    {"label": "Male", "value": "male"}
  ];

  final List<Map<String, dynamic>> complexity = [
    {"label": "Full explanation", "value": "full"},
    {"label": "Short explanation", "value": "short"}
  ];

  List<Map<String, dynamic>> counter = [
    {"label": "Timer", "value": "timer"},
    {"label": "Breathe", "value": "breathe"}
  ];

  List<Map<String, dynamic>> music = [
    {"label": "Without music", "value": null},
    {
      "label": "Some from Ambient",
      "value":
          "http://servag.rupsy.ru/media/2/36_-_Lithea-2012/36%20-%20Lithea%20-%2005%20Deluge.mp3"
    }
  ];
}

class PracticePreferences {
  int time;
  String voice;
  String complexity;
  String counter;
  String music;
  PracticePreferences(
      {this.time = 45,
      this.voice = "female",
      this.complexity = "full",
      this.counter = "timer",
      this.music =
          "http://servag.rupsy.ru/media/2/36_-_Lithea-2012/36%20-%20Lithea%20-%2005%20Deluge.mp3"});

  Map<String, dynamic> toMap() {
    return {
      "time": time,
      "voice": voice,
      "complexity": complexity,
      "counter": counter,
      "music": music
    };
  }

  void update(PracticePreferenceValue updates) {
    String _patchedKey = updates.value.keys.toList()[0];
    dynamic _pathcedValue = updates.value[_patchedKey];
    switch (_patchedKey) {
      case "time":
        this.time = _pathcedValue;
        break;
      case "voice":
        this.voice = _pathcedValue;
        break;
      case "complexity":
        this.complexity = _pathcedValue;
        break;
      case "counter":
        this.counter = _pathcedValue;
        break;
      case "music":
        this.music = _pathcedValue;
        break;
    }
  }
}

class PracticePreferenceValue {
  Map<String, dynamic> value;
  PracticePreferenceValue({String key, dynamic value}) {
    this.value = {key: value};
  }
}
