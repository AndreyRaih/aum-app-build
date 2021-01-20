import 'package:aum_app_build/common_bloc/navigator/navigator_event.dart';
import 'package:aum_app_build/common_bloc/navigator_bloc.dart';
import 'package:aum_app_build/common_bloc/user/user_event.dart';
import 'package:aum_app_build/common_bloc/user/user_state.dart';
import 'package:aum_app_build/common_bloc/user_bloc.dart';
import 'package:aum_app_build/data/constants.dart';
import 'package:aum_app_build/data/models/video.dart';
import 'package:aum_app_build/views/shared/list.dart';
import 'package:aum_app_build/views/shared/title.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    RangeOption _range = _convertRangeToOption(_currentRange);
    BlocProvider.of<UserBloc>(context).add(SaveUserResult(range: _range.value, asanaCount: queue.length));
    BlocProvider.of<NavigatorBloc>(context).add(NavigatorPush(route: DASHBOARD_ROUTE_NAME));
  }

  RangeOption _convertRangeToOption(String range) {
    switch (range) {
      case 'very_bad':
        return RangeOption(value: 1, label: "There's room to improvement");
      case 'bad':
        return RangeOption(value: 2, label: "It can be better");
      case 'neutral':
        return RangeOption(value: 3, label: "It wasn't bad");
      case 'happy':
        return RangeOption(value: 4, label: "I enjoyed it");
      case 'very_happy':
        return RangeOption(value: 5, label: "It was awesome!");
      default:
        return RangeOption(value: null, label: null);
    }
  }

  @override
  Widget build(BuildContext context) {
    RangeOption rateStr = _convertRangeToOption(_currentRange);
    return AumPage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _FeedbackTitle(),
          Padding(
              padding: EdgeInsets.only(top: 24),
              child: Center(
                  child: AumText.bold(
                _currentRange != null ? rateStr.label : 'Choose the rate',
                size: 18,
                color: _currentRange != null ? AumColor.accent : AumColor.additional,
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
          Padding(padding: EdgeInsets.symmetric(vertical: 24), child: _Benefits()),
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
        Padding(padding: EdgeInsets.only(bottom: 8), child: AumText.bold("How're you?", size: 34)),
        AumText.medium(
          'Please, let know us about your experience. It can help us to adjust further content line for you.',
          size: 16,
          color: AumColor.additional,
        )
      ],
    );
  }
}

class _Benefits extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> _benefits = (BlocProvider.of<UserBloc>(context).state as UserSuccess).personalSession.benefits.map((item) => item.toString()).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [AumTitle(text: 'Benefits'), AumList.plain(list: _benefits)],
    );
  }
}

class RangeOption {
  final String label;
  final int value;
  const RangeOption({this.label, this.value});
}
