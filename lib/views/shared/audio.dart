import 'package:sounds/sounds.dart';

class AumAppAudio {
  SoundPlayer player = SoundPlayer.noUI();
  Future playAudio(String uri, {double volume = 0.2}) async {
    Track track = Track.fromURL(uri);
    player.setVolume(volume);
    await player.play(track);
  }

  Future stopAudio() async {
    await player.release();
  }
}
