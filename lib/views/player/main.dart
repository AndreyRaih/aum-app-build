import 'package:aum_app_build/data/models/asana.dart';
import 'package:aum_app_build/data/models/preferences.dart';
import 'package:aum_app_build/helpers/audio.dart';
import 'package:aum_app_build/views/player/bloc/player_bloc.dart';
import 'package:aum_app_build/views/player/bloc/player_event.dart';
import 'package:aum_app_build/views/player/bloc/player_state.dart';
import 'package:aum_app_build/views/player/components/controlls.dart';
import 'package:aum_app_build/views/player/components/layout.dart';
import 'package:aum_app_build/views/player/components/transition.dart';
import 'package:aum_app_build/views/player/components/video.dart';
import 'package:aum_app_build/views/ui/icons.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class PlayerScreen extends StatelessWidget {
  final AumAppAudio _backgroundMusic = AumAppAudio();

  PlayerScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    PracticePreferences _preferences =
        ModalRoute.of(context).settings.arguments;
    return BlocBuilder<PlayerBloc, PlayerState>(builder: (context, state) {
      if (state is PlayerLoadInProgress) {
        _backgroundMusic.playAudio(_preferences.music, volume: 0.1);
        BlocProvider.of<PlayerBloc>(context)
            .add(GetPlayerQueue(preferences: _preferences));
        return PlayerTransition(
            text: 'Few moments, please\nNow we build your practice');
      }
      if (state is PlayerLoadSuccess) {
        AsanaVideoPart _asana = state.asana;
        String _asanaAudioSrc = state.asana.audio;
        String _name = state.asana.name;
        int _position = state.asanaPosition + 1;
        int _queueLength = state.asanaQueue.length;
        return PlayerLayout(
            contain: PlayerVideo(
              _asana,
              audioSrc: _asanaAudioSrc,
            ),
            left: PlayerMainControlls.leftControll(onControllTap: () {
              BlocProvider.of<PlayerBloc>(context).add(GetPlayerPreviousPart());
            }),
            right: PlayerMainControlls.rightControll(onControllTap: () {
              BlocProvider.of<PlayerBloc>(context).add(GetPlayerNextPart());
            }),
            topRight: PlayerTimer(),
            topLeft: Row(
              children: [
                Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: PlayerControllButton(
                      icon: AumIcon.cancel,
                      onTapControll: () {
                        BlocProvider.of<PlayerBloc>(context).add(PlayerExit());
                      },
                    )),
                // PlayerControllButton(icon: AumIcon.audion_controll)
              ],
            ),
            top: PlayerAsanaPresentor(
              name: _name,
              position: _position,
              practiceLength: _queueLength,
            ));
      }
      if (state is PlayerExitState) {
        _backgroundMusic.stopAudio();
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.pushNamed(context, state.routeName);
        });
        return Container(color: Colors.white);
      }
    });
  }
}
