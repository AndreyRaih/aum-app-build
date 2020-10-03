import 'package:sounds/sounds.dart';

class AumAppAudio {
  SoundPlayer player;
  Future playAudio(String uri, {double volume = 0.5}) async {
    player = SoundPlayer.noUI();
    Track track = Track.fromURL(uri);
    player.onStopped = ({wasUser}) => player.release();
    await player.play(track);
    player.setVolume(0.1);
  }

  Future stopAudio() {
    if (player.isPlaying) return player.release();
  }
}
