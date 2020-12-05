import 'package:aum_app_build/views/shared/input.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/material.dart';

class IntroductionUserStep extends StatelessWidget {
  final Function(Map) onUpdate;
  IntroductionUserStep({this.onUpdate});

  Map _formatDataToUpdates(String value) => value != '' ? {"name": value} : null;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(padding: EdgeInsets.only(bottom: 16), child: _BodyDataFormDescription()),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Container(
              width: 250,
              child: AumInput(
                  isCentered: true,
                  placeholder: 'Enter your name',
                  onInput: (value) {
                    Map _updates = _formatDataToUpdates(value);
                    onUpdate(_updates);
                  }),
            ))
      ],
    );
  }
}

class _BodyDataFormDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AumText.bold(
          'Hello',
          size: 34,
          align: TextAlign.center,
        ),
        AumText.medium(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
          size: 16,
          align: TextAlign.center,
          color: AumColor.additional,
        )
      ],
    );
  }
}
