import 'package:aum_app_build/views/ui/palette.dart';
import 'package:aum_app_build/views/ui/typo.dart';
import 'package:flutter/material.dart';

class FeedbackBenefits extends StatelessWidget {
  final List<String> _adivces = [
    '- Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    '- Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    '- Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
  ];
  List<Widget> getWidgets() {
    List<Widget> _adivcesViews = _adivces
        .map((advice) => Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: AumText.medium(
                advice,
                size: 16,
                color: AumColor.additional,
              ),
            ))
        .toList();
    return _adivcesViews;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_BenefitsTitle(), Column(children: getWidgets())],
    );
  }
}

class _BenefitsTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: AumText.bold('Benefits', size: 28));
  }
}
