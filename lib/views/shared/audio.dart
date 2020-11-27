import 'package:sounds/sounds.dart';

class AumAppAudio {
  SoundPlayer player = SoundPlayer.noUI();

  Future playAudio(String uri, {double volume = 0.02}) async {
    Track track = Track.fromURL(uri);
    await player.play(track);
    await player.setVolume(volume);
  }

  Future stopAudio() async {
    await player.release();
  }
}
