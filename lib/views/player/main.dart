import 'package:aum_app_build/data/models/practice.dart';
import 'package:aum_app_build/views/player/bloc/player_bloc.dart';
import 'package:aum_app_build/views/player/bloc/player_event.dart';
import 'package:aum_app_build/views/player/bloc/player_state.dart';
import 'package:aum_app_build/views/player/components/controlls/main.dart';
import 'package:aum_app_build/views/player/components/controlls/playback.dart';
import 'package:aum_app_build/views/player/components/layout.dart';
import 'package:aum_app_build/views/shared/transition.dart';
import 'package:aum_app_build/views/player/components/video.dart';
import 'package:aum_app_build/views/shared/icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class PlayerScreen extends StatefulWidget {
  final AumPracticePlayerData playerData;
  const PlayerScreen(this.playerData, {Key key}) : super(key: key);

  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  @override
  void initState() {
    super.initState();
    _initPlayer(context);
  }

  void _initPlayer(BuildContext context) {
    return BlocProvider.of<PlayerBloc>(context).add(GetPlayerQueue(widget.playerData));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(builder: (context, state) {
      if (state is PlayerLoadInProgress) {
        return AumTransition(text: 'Few moments, please\nNow we build your practice');
      }
      if (state is PlayerLoadSuccess) {
        return PlayerLayout(
            key: UniqueKey(),
            contain: PlayerContent(state.asanaVideoFragment),
            left: PlayerPlaybackControlls.leftControll(onControllTap: () {
              BlocProvider.of<PlayerBloc>(context).add(GetPlayerPreviousPart());
            }),
            right: PlayerPlaybackControlls.rightControll(onControllTap: () {
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
            top: PlayerAsanaName(
              name: state.asanaFormattedName,
            ),
            bottom: PlayerAsanaTrack(
              position: state.asanaPosition,
              practiceLength: state.queueLength,
            ));
      }
      return Container();
    });
  }
}
