import 'package:aum_app_build/common_bloc/user/user_state.dart';
import 'package:aum_app_build/common_bloc/user_bloc.dart';
import 'package:aum_app_build/data/models/asana.dart';
import 'package:aum_app_build/data/models/preferences.dart';
import 'package:aum_app_build/views/player/bloc/player_bloc.dart';
import 'package:aum_app_build/views/player/bloc/player_event.dart';
import 'package:aum_app_build/views/player/bloc/player_state.dart';
import 'package:aum_app_build/views/player/components/controlls/main.dart';
import 'package:aum_app_build/views/player/components/controlls/playback.dart';
import 'package:aum_app_build/views/player/components/layout.dart';
import 'package:aum_app_build/views/shared/transition.dart';
import 'package:aum_app_build/views/player/components/content.dart';
import 'package:aum_app_build/views/shared/icons.dart';
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
  @override
  void initState() {
    super.initState();
    _setPlayerMode(context);
  }

  void _setPlayerMode(BuildContext context) {
    List _blocks = (BlocProvider.of<UserBloc>(context).state as UserSuccess).personalSession.userQueue;
    if (widget.onlyCheck) {
      return BlocProvider.of<PlayerBloc>(context)
          .add(GetPlayerCheckQueue(preferences: widget.preferences, blocks: _blocks));
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
        // Define data for views
        AsanaItem _asana = state.asana;
        AsanaVideoFragment _contentSources = state.asanaVideoFragment;
        String _formattedAsanaName = (_asana.name[0].toUpperCase() + _asana.name.substring(1)).replaceAll('_', ' ');
        int _position = state.asanaPosition + 1;
        int _queueLength = state.asanaQueue.length;
        TimerType _timerType = _asana.isCheck ? TimerType.longTimer : TimerType.timer;
        Widget _currentPart = PlayerContent(_asana, _contentSources);

        return PlayerLayout(
            key: UniqueKey(),
            contain: _currentPart,
            left: PlayerPlaybackControlls.leftControll(onControllTap: () {
              BlocProvider.of<PlayerBloc>(context).add(GetPlayerPreviousPart());
            }),
            right: PlayerPlaybackControlls.rightControll(onControllTap: () {
              BlocProvider.of<PlayerBloc>(context).add(GetPlayerNextPart());
            }),
            topRight: PlayerTimer(
              type: _timerType,
            ),
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
            top: PlayerAsanaName(
              name: _formattedAsanaName,
            ),
            bottom: PlayerAsanaTrack(
              position: _position,
              practiceLength: _queueLength,
            ));
      }
      return Container();
    });
  }
}
