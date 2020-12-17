import 'package:aum_app_build/common_bloc/navigator/navigator_event.dart';
import 'package:aum_app_build/common_bloc/navigator_bloc.dart';
import 'package:aum_app_build/common_bloc/user/user_state.dart';
import 'package:aum_app_build/common_bloc/user_bloc.dart';
import 'package:aum_app_build/data/models/video.dart';
import 'package:aum_app_build/data/models/preferences.dart';
import 'package:aum_app_build/views/shared/audio.dart';
import 'package:aum_app_build/views/player/bloc/player_bloc.dart';
import 'package:aum_app_build/views/player/bloc/player_event.dart';
import 'package:aum_app_build/views/player/bloc/player_state.dart';
import 'package:aum_app_build/views/player/components/controlls.dart';
import 'package:aum_app_build/views/player/components/layout.dart';
import 'package:aum_app_build/views/shared/transition.dart';
import 'package:aum_app_build/views/player/components/video.dart';
import 'package:aum_app_build/views/shared/icons.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class PlayerScreen extends StatefulWidget {
  final PracticePreferences preferences;
  final bool onlyCheck;
  final String singleAsanaId;
  const PlayerScreen({Key key, this.singleAsanaId, this.onlyCheck = false, this.preferences}) : super(key: key);

  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final AumAppAudio _backgroundMusic = AumAppAudio();

  @override
  void initState() {
    super.initState();
    _setPlayerMode(context);
    if (widget.preferences != null) {
      // _backgroundMusic.playAudio(widget.preferences.music, volume: 0.1);
    }
  }

  void _setPlayerMode(BuildContext context) {
    List _blocks = (BlocProvider.of<UserBloc>(context).state as UserSuccess).personalSession.userQueue;
    if (widget.onlyCheck) {
      return BlocProvider.of<PlayerBloc>(context).add(GetPlayerCheckQueue(preferences: widget.preferences, blocks: _blocks));
    }
    if (widget.singleAsanaId != null) {
      return BlocProvider.of<PlayerBloc>(context).add(GetPlayerAsana(id: widget.singleAsanaId, blocks: _blocks));
    }
    return BlocProvider.of<PlayerBloc>(context).add(GetPlayerQueue(preferences: widget.preferences, blocks: _blocks));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(builder: (context, state) {
      if (state is PlayerLoadInProgress) {
        return AumTransition(text: 'Few moments, please\nNow we build your practice');
      }
      if (state is PlayerLoadSuccess) {
        AsanaVideoSource _asana = AsanaVideoSource.withPreferences(part: state.asana, preferences: state.preferences);
        int _position = state.asanaPosition + 1;
        int _queueLength = state.asanaQueue.length;
        Widget _currentPart = PlayerVideo(_asana);
        return PlayerLayout(
            key: UniqueKey(),
            contain: _currentPart,
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
              ],
            ),
            top: PlayerAsanaPresentor(
              name: _asana.name,
              position: _position,
              practiceLength: _queueLength,
            ));
      }
      if (state is PlayerExitState) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          if (widget.preferences != null) {
            // _backgroundMusic.stopAudio();
          }
          if (state.routeName != null) {
            BlocProvider.of<NavigatorBloc>(context).add(NavigatorPush(route: state.routeName, arguments: state.arguments));
          } else {
            BlocProvider.of<NavigatorBloc>(context).add(NavigatorPop());
          }
        });
        return Container(color: Colors.white);
      }
      return Container();
    });
  }
}
