import 'package:aum_app_build/common_bloc/navigator/navigator_event.dart';
import 'package:aum_app_build/common_bloc/navigator_bloc.dart';
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
  String _currentRate;

  @override
  Widget build(BuildContext context) {
    String rateStr = _currentRate != null
        ? _currentRate[0].toUpperCase() +
            _currentRate.substring(1).toLowerCase().replaceAll('_', ' ')
        : null;
    return AumPage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _FeedbackTitle(),
          Padding(
              padding: EdgeInsets.only(top: 16),
              child: Center(
                  child: AumText.bold(
                _currentRate != null ? rateStr : 'Choose the rate',
                size: 18,
                color: _currentRate != null
                    ? AumColor.accent
                    : AumColor.additional,
              ))),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: AumRating(
                onChanged: (value) {
                  setState(() {
                    _currentRate = value;
                  });
                },
              )),
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
                border: Border.symmetric(
                    vertical: BorderSide(width: 1, color: Colors.grey[300]))),
            child: FeedbackMemories(),
          ),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: FeedbackBenefits()),
          AumPrimaryButton(
            onPressed: () {
              BlocProvider.of<NavigatorBloc>(context)
                  .add(NavigatorPush(route: '/'));
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
