import 'package:aum_app_build/data/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String DEFAULT_PREFERENCE_VOICE = "female";
const String DEFAULT_PREFERENCE_COMPLEXITY = "full";
const String DEFAULT_PREFERENCE_MUSIC = PREFERENCE_MUSIC_DRONE;

class PracticePreferencesDictionaries {
  final List<Map<String, dynamic>> voice = [
    {"label": "Female", "value": "female"},
    {"label": "Male", "value": "male"}
  ];

  final List<Map<String, dynamic>> complexity = [
    {"label": "Full explanation", "value": "full"},
    {"label": "Short explanation", "value": "short"}
  ];

  List<Map<String, dynamic>> music = [
    {"label": "Without music", "value": null},
    {"label": "Drone", "value": PREFERENCE_MUSIC_DRONE}
  ];
}

class PracticePreferences {
  String voice;
  String complexity;
  String music;
  PracticePreferences({this.voice, this.complexity, this.music});

  factory PracticePreferences.defaultValues() =>
      PracticePreferences(voice: DEFAULT_PREFERENCE_VOICE, complexity: DEFAULT_PREFERENCE_COMPLEXITY, music: DEFAULT_PREFERENCE_MUSIC);

  Future<PracticePreferences> restoreValues() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String _getPrefByKey(String key, {dynamic defaultValue}) =>
        _preferences.getString('aum:preferences:$key') != null ? _preferences.getString('aum:preferences:$key') : defaultValue;
    String restoredVoice = _getPrefByKey("voice", defaultValue: DEFAULT_PREFERENCE_VOICE);
    String restoredComplexity = _getPrefByKey("complexity", defaultValue: DEFAULT_PREFERENCE_COMPLEXITY);
    String restoredMusic = _getPrefByKey("music", defaultValue: DEFAULT_PREFERENCE_MUSIC);
    print('restoredVoice: $restoredVoice, restoredComplexity: $restoredComplexity, restoredMusic: $restoredMusic');
    return PracticePreferences(voice: restoredVoice, complexity: restoredComplexity, music: restoredMusic);
  }

  Map<String, dynamic> toMap() {
    return {"voice": voice, "complexity": complexity, "music": music};
  }

  void update(PracticePreferenceValue updates) async {
    String _patchedKey = updates.value.keys.toList()[0];
    dynamic _patchedValue = updates.value[_patchedKey];
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    void _saveValue(String key, dynamic value) => _preferences.setString("aum:preferences:$key", value);
    switch (_patchedKey) {
      case "voice":
        this.voice = _patchedValue;
        if (_patchedValue != DEFAULT_PREFERENCE_VOICE) {
          _saveValue(_patchedKey, _patchedValue);
        }
        break;
      case "complexity":
        this.complexity = _patchedValue;
        if (_patchedValue != DEFAULT_PREFERENCE_COMPLEXITY) {
          _saveValue(_patchedKey, _patchedValue);
        }
        break;
      case "music":
        this.music = _patchedValue;
        if (_patchedValue != DEFAULT_PREFERENCE_MUSIC) {
          _saveValue(_patchedKey, _patchedValue);
        }
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
