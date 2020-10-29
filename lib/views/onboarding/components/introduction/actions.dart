import 'package:aum_app_build/views/shared/page.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/material.dart';

class IntroductionActions extends StatefulWidget {
  @override
  _IntroductionActionsState createState() => _IntroductionActionsState();
}

class _IntroductionActionsState extends State<IntroductionActions> {
  int _currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _ActionLink(
          text: 'Skip',
          onTap: () {
            if (_currentStep > 0) {
              setState(() {
                _currentStep--;
              });
            }
          },
        ),
        _ActionIndicators(active: _currentStep),
        _ActionLink(
          text: 'Next',
          onTap: () {
            if (_currentStep < 2) {
              setState(() {
                _currentStep++;
              });
            }
          },
        ),
      ],
    );
  }
}

class _ActionLink extends StatelessWidget {
  final Function onTap;
  final String text;
  _ActionLink({@required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: AumText.bold(
          text.toUpperCase(),
          size: 24,
          color: AumColor.accent,
        ));
  }
}

class _ActionIndicators extends StatelessWidget {
  final int active;
  _ActionIndicators({this.active});
  @override
  Widget build(BuildContext context) {
    List<int> _indicators = [0, 1];
    return Row(
        children: _indicators
            .map((index) => _Indicator(isActive: index == active))
            .toList());
  }
}

class _Indicator extends StatelessWidget {
  double _width = 12;
  double _activeWidth = 28;
  double _height = 12;
  final bool isActive;
  _Indicator({this.isActive = false});
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        margin: EdgeInsets.symmetric(horizontal: 2),
        duration: Duration(milliseconds: 200),
        width: isActive ? _activeWidth : _width,
        height: _height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          color: isActive ? AumColor.accent : Colors.black.withOpacity(0.25),
        ));
  }
}
