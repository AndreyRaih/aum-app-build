import 'package:aum_app_build/common_bloc/navigator/navigator_event.dart';
import 'package:aum_app_build/common_bloc/navigator_bloc.dart';
import 'package:aum_app_build/data/models/asana.dart';
import 'package:aum_app_build/data/models/preferences.dart';
import 'package:aum_app_build/views/shared/audio.dart';
import 'package:aum_app_build/views/player/bloc/player_bloc.dart';
import 'package:aum_app_build/views/player/bloc/player_event.dart';
import 'package:aum_app_build/views/player/bloc/player_state.dart';
import 'package:aum_app_build/views/player/components/controlls.dart';
import 'package:aum_app_build/views/player/components/layout.dart';
import 'package:aum_app_build/views/player/components/transition.dart';
import 'package:aum_app_build/views/player/components/video.dart';
import 'package:aum_app_build/views/shared/icons.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class PlayerScreen extends StatefulWidget {
  PlayerScreen({Key key}) : super(key: key);

  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final AumAppAudio _backgroundMusic = AumAppAudio();
  final RouteObserver _routeObserver = RouteObserver();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    PracticePreferences _preferences =
        ModalRoute.of(context).settings.arguments;
    BlocProvider.of<PlayerBloc>(context)
        .add(GetPlayerQueue(preferences: _preferences));
    _backgroundMusic.playAudio(_preferences.music, volume: 0.1);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(builder: (context, state) {
      if (state is PlayerLoadInProgress) {
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
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _backgroundMusic.stopAudio();
          BlocProvider.of<NavigatorBloc>(context)
              .add(NavigatorPush(route: state.routeName));
        });
        return Container(color: Colors.white);
      }
    });
  }
}
