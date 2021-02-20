import 'package:aum_app_build/data/constants.dart';
import 'package:aum_app_build/data/models/asana.dart';
import 'package:shared_preferences/shared_preferences.dart';

const AsanaAudioVoice DEFAULT_PREFERENCE_VOICE = AsanaAudioVoice.female;
const bool DEFAULT_PREFERENCE_COMPLEXITY = false;
const String DEFAULT_PREFERENCE_MUSIC = PREFERENCE_MUSIC_DRONE;

class PracticePreferenceVoice {
  String label;
  AsanaAudioVoice value;

  PracticePreferenceVoice(this.label, this.value);

  Map<String, dynamic> toMap() {
    return {"label": label, "value": value};
  }
}

class PracticePreferenceComplexity {
  String label;
  bool isShort;

  PracticePreferenceComplexity(this.label, this.isShort);

  Map<String, dynamic> toMap() {
    return {"label": label, "value": isShort};
  }
}

class PracticePreferenceMusic {
  String label;
  String value;

  PracticePreferenceMusic(this.label, this.value);

  Map<String, dynamic> toMap() {
    return {"label": label, "value": value};
  }
}

class PracticePreferencesDictionaries {
  List<PracticePreferenceVoice> voice = [
    PracticePreferenceVoice("Female", AsanaAudioVoice.female),
    PracticePreferenceVoice("Male", AsanaAudioVoice.male),
  ];

  List<PracticePreferenceComplexity> complexity = [
    PracticePreferenceComplexity("Full explanation", false),
    PracticePreferenceComplexity("Short explanation", true)
  ];

  List<PracticePreferenceMusic> music = [
    PracticePreferenceMusic("Without music", null),
    PracticePreferenceMusic("Drone", PREFERENCE_MUSIC_DRONE)
  ];
}

class PracticePreferences {
  AsanaAudioVoice voice;
  bool complexity;
  String music;
  PracticePreferences({this.voice, this.complexity, this.music});

  factory PracticePreferences.defaultValues() => PracticePreferences(
      voice: DEFAULT_PREFERENCE_VOICE, complexity: DEFAULT_PREFERENCE_COMPLEXITY, music: DEFAULT_PREFERENCE_MUSIC);

  Future<PracticePreferences> restoreValues() async {
    PracticePreferences _resotred = await PracticePreferencesStore().restore();
    this.voice = _resotred.voice;
    this.complexity = _resotred.complexity;
    this.music = _resotred.music;
    return PracticePreferences(voice: _resotred.voice, complexity: _resotred.complexity, music: _resotred.music);
  }

  void update(PracticePreferenceChanges updates) async {
    String _patchedKey = updates.value.keys.toList()[0];
    dynamic _patchedValue = updates.value[_patchedKey];
    PracticePreferencesStore _store = PracticePreferencesStore();
    switch (_patchedKey) {
      case "voice":
        this.voice = _patchedValue;
        if (_patchedValue != DEFAULT_PREFERENCE_VOICE) {
          _store.save(_patchedKey, convertVoiceFromType(_patchedValue));
        }
        break;
      case "complexity":
        this.complexity = _patchedValue;
        if (_patchedValue != DEFAULT_PREFERENCE_COMPLEXITY) {
          _store.save(_patchedKey, convertComplexityFromBool(_patchedValue));
        }
        break;
      case "music":
        this.music = _patchedValue;
        if (_patchedValue != DEFAULT_PREFERENCE_MUSIC) {
          _store.save(_patchedKey, _patchedValue);
        }
        break;
    }
  }

  Map<String, dynamic> toMap() {
    return {"voice": voice, "complexity": complexity, "music": music};
  }
}

class PracticePreferenceChanges {
  Map<String, dynamic> value;
  PracticePreferenceChanges({String key, dynamic value}) {
    this.value = {key: value};
  }
}

class PracticePreferencesStore {
  SharedPreferences instance;

  PracticePreferencesStore();

  Future save(String key, dynamic value) async {
    instance = await SharedPreferences.getInstance();
    instance.setString("aum:preferences:$key", value);
  }

  Future<PracticePreferences> restore() async {
    instance = await SharedPreferences.getInstance();
    String _getPrefByKey(String key, {dynamic defaultValue}) =>
        instance.getString('aum:preferences:$key') != null ? instance.getString('aum:preferences:$key') : defaultValue;
    return PracticePreferences(
        voice: convertVoiceFromString(_getPrefByKey("voice", defaultValue: "female")),
        complexity: convertComplexityFromString(_getPrefByKey("complexity", defaultValue: "full")),
        music: _getPrefByKey("music", defaultValue: DEFAULT_PREFERENCE_MUSIC));
  }

  Future clear(String key, dynamic value) async {
    instance = await SharedPreferences.getInstance();
    instance.clear();
  }
}
