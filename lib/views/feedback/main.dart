import 'package:aum_app_build/common_bloc/navigator/navigator_event.dart';
import 'package:aum_app_build/common_bloc/navigator_bloc.dart';
import 'package:aum_app_build/common_bloc/user/user_event.dart';
import 'package:aum_app_build/common_bloc/user_bloc.dart';
import 'package:aum_app_build/data/models/video.dart';
import 'package:aum_app_build/views/dashboard/bloc/dashboard_bloc.dart';
import 'package:aum_app_build/views/player/bloc/player_bloc.dart';
import 'package:aum_app_build/views/player/bloc/player_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aum_app_build/views/feedback/components/benefits.dart';
import 'package:aum_app_build/views/feedback/components/memories.dart';
import 'package:aum_app_build/views/shared/buttons.dart';
import 'package:aum_app_build/views/shared/page.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:aum_app_build/views/shared/rating.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  String _currentRange;
  List<VideoPart> queue;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    queue = ModalRoute.of(context).settings.arguments;
  }

  void _sendFeedback(context) {
    int _range = _convertRangeToNum(_currentRange);
    BlocProvider.of<UserBloc>(context)
        .add(SaveUserSession(range: _range, asanaCount: queue.length));
    BlocProvider.of<NavigatorBloc>(context)
        .add(NavigatorPush(route: '/dashboard'));
  }

  void _createMemory(String name) {
    BlocProvider.of<NavigatorBloc>(context)
        .add(NavigatorPush(route: '/memory', arguments: name));
  }

  int _convertRangeToNum(String range) {
    switch (range) {
      case 'very_bad':
        return 1;
      case 'bad':
        return 2;
      case 'neutral':
        return 3;
      case 'happy':
        return 4;
      case 'very_happy':
        return 5;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    String rateStr = _currentRange != null
        ? _currentRange[0].toUpperCase() +
            _currentRange.substring(1).toLowerCase().replaceAll('_', ' ')
        : null;
    List<String> _memoriesOptions = queue.map((e) => e.name).toList();
    return AumPage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _FeedbackTitle(),
          Padding(
              padding: EdgeInsets.only(top: 16),
              child: Center(
                  child: AumText.bold(
                _currentRange != null ? rateStr : 'Choose the rate',
                size: 18,
                color: _currentRange != null
                    ? AumColor.accent
                    : AumColor.additional,
              ))),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: AumRating(
                onChanged: (value) {
                  setState(() {
                    _currentRange = value;
                  });
                },
              )),
          /* Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(vertical: 16),
            child: FeedbackMemories(
              options: _memoriesOptions,
              onChange: _createMemory,
            ),
          ), */
          Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: FeedbackBenefits()),
          AumPrimaryButton(
            onPressed: () {
              _sendFeedback(context);
            },
            text: 'See you',
          )
        ],
      ),
    );
  }
}

class _FeedbackTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: AumText.bold("How're you?", size: 34)),
        AumText.medium(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
          size: 16,
          color: AumColor.additional,
        )
      ],
    );
  }
}
