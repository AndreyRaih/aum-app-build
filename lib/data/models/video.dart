import 'package:aum_app_build/data/models/preferences.dart';
import 'package:aum_app_build/utils/data.dart';

class VideoPart {
  String id;
  String name;
  String adaptName;
  String block;
  String src;
  int level;
  int captureTime;
  bool isCheck;
  List audioSources;
  VideoPart(data) {
    var utils = DataUtils(data);
    this.id = utils.fromData("id");
    this.name = utils.fromData("name");
    this.adaptName = utils.fromData("adaptName");
    this.block = utils.fromData("block");
    this.src = utils.fromData("src");
    this.audioSources = utils.fromData("audioSources");
    this.level = utils.fromData("level");
    this.isCheck = utils.fromData("isCheck", defaultValue: false);
    this.captureTime = utils.fromData("captureTime", defaultValue: 0);
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
  Duration captureTime;

  AsanaVideoSource(data) {
    var utils = DataUtils(data);
    this.id = utils.fromData("id");
    this.name = utils.fromData("name");
    this.block = utils.fromData("block");
    this.src = utils.fromData("src");
    this.audio = utils.fromData("audio");
    this.isCheck = utils.fromData("isCheck", defaultValue: false);
    this.captureTime = Duration(seconds: utils.fromData("captureTime", defaultValue: 0));
  }

  factory AsanaVideoSource.withPreferences({VideoPart part, PracticePreferences preferences}) {
    Map result = {
      "id": part.id,
      "name": part.name,
      "block": part.block,
      "src": part.src,
      "audio": _getAudioFromList(part.audioSources, preferences),
      "isCheck": part.isCheck,
      "captureTime": part.captureTime
    };
    return AsanaVideoSource(result);
  }
}

String _getAudioFromList(List audio, PracticePreferences preferences) {
  Map _currentAudio;
  switch (preferences.complexity) {
    case 'full':
      _currentAudio = audio.firstWhere((source) => !source["isShort"] && source["voice"] == preferences.voice);
      break;
    case "short":
      _currentAudio = audio.firstWhere((source) => source["isShort"] && source["voice"] == preferences.voice);
      break;
    default:
      _currentAudio = audio.firstWhere((source) => !source["isShort"] && source["voice"] == preferences.voice);
      break;
  }
  return _currentAudio["src"];
}
