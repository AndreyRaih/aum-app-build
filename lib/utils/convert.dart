import 'package:aum_app_build/data/models/asana.dart';

// ignore: missing_return
AsanaAudioVoice convertVoiceFromString(String type) {
  switch (type) {
    case "female":
      return AsanaAudioVoice.female;
    case "male":
      return AsanaAudioVoice.male;
  }
}

// ignore: missing_return
String convertVoiceFromType(AsanaAudioVoice type) {
  switch (type) {
    case AsanaAudioVoice.female:
      return "female";
    case AsanaAudioVoice.male:
      return "male";
  }
}

bool convertComplexityFromString(String value) {
  return value == "full";
}

String convertComplexityFromBool(bool value) {
  return value ? "full" : "short";
}
