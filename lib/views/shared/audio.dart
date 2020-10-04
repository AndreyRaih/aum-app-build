import 'package:sounds/sounds.dart';

class AumAppAudio {
  SoundPlayer player = SoundPlayer.noUI();
  Future playAudio(String uri, {double volume = 0.5}) async {
    Track track = Track.fromURL(uri);
    if (player.isPlaying) await player.release();
    await player.play(track);
    player.setVolume(volume);
  }

  Future stopAudio() {
    return player.release();
  }
}
