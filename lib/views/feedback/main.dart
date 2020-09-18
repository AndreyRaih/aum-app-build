import 'package:aum_app_build/views/ui/buttons.dart';
import 'package:aum_app_build/views/ui/page.dart';
import 'package:aum_app_build/views/ui/palette.dart';
import 'package:aum_app_build/views/ui/typo.dart';
import 'package:flutter/material.dart';

class FeedbackScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AumPage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _FeedBackTitle(),
          AumPrimaryButton(
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
            text: 'See you',
          )
        ],
      ),
    );
  }
}

class _FeedBackTitle extends StatelessWidget {
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
