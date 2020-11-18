import 'package:aum_app_build/data/models/preferences.dart';

class VideoPart {
  String id;
  String name;
  String adaptName;
  String block;
  String src;
  int level;
  bool isCheck;
  List audioSources;
  VideoPart(data) {
    this.id = data["id"];
    this.name = data["name"];
    this.adaptName = data["adaptName"];
    this.block = data["block"];
    this.src = data["src"];
    this.audioSources = data["audioSources"];
    this.level = data["level"];
    this.isCheck = data["isCheck"];
  }
}

class AsanaVideoSource {
  String id;
  String name;
  String block;
  String adaptName;
  String src;
  String audio;
  bool isCheck;

  AsanaVideoSource(data) {
    this.id = data["id"];
    this.name = data["name"];
    this.block = data["block"];
    this.adaptName = data["adaptName"];
    this.src = data["src"];
    this.audio = data["audio"];
    this.isCheck = data["isCheck"];
  }

  factory AsanaVideoSource.withPreferences(
      {VideoPart part, PracticePreferences preferences}) {
    Map result = {
      "id": part.id,
      "name": part.name,
      "block": part.block,
      "adaptName": part.adaptName,
      "src": part.src,
      "audio": _getAudioFromList(part.audioSources, preferences),
      'isCheck': part.isCheck
    };
    return AsanaVideoSource(result);
  }
}

String _getAudioFromList(List audio, PracticePreferences preferences) {
  Map _currentAudio;
  switch (preferences.complexity) {
    case 'full':
      _currentAudio = audio.firstWhere((source) =>
          !source["isShort"] && source["voice"] == preferences.voice);
      break;
    case "short":
      _currentAudio = audio.firstWhere((source) =>
          source["isShort"] && source["voice"] == preferences.voice);
      break;
    default:
      _currentAudio = audio.firstWhere((source) =>
          !source["isShort"] && source["voice"] == preferences.voice);
      break;
  }
  return _currentAudio["src"];
}
