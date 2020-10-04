import 'package:aum_app_build/views/shared/icons.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:flutter/material.dart';

class AumRating extends StatefulWidget {
  final bool shortRaiting;
  final Function(String) onChanged;

  AumRating({this.shortRaiting = false, this.onChanged});

  @override
  _AumRatingState createState() => _AumRatingState();
}

class _AumRatingState extends State<AumRating> {
  final List<_AumRaitingOption> _raitingList = [
    _AumRaitingOption(
        value: 'very_bad', icon: AumIcon.very_bad_smile, byShort: false),
    _AumRaitingOption(value: 'bad', icon: AumIcon.bad_smile, byShort: true),
    _AumRaitingOption(
        value: 'neutral', icon: AumIcon.neutral_smile, byShort: true),
    _AumRaitingOption(value: 'happy', icon: AumIcon.happy_smile, byShort: true),
    _AumRaitingOption(
        value: 'very_happy', icon: AumIcon.very_happy_smile, byShort: false),
  ];

  String _currentValue;

  @override
  Widget build(BuildContext context) {
    List<Widget> _renderedIcons = widget.shortRaiting
        ? _raitingList
            .where((item) => item.byShort == true)
            .map((e) => GestureDetector(
                onTap: () {
                  setState(() {
                    _currentValue = e.value;
                  });
                  widget.onChanged(e.value);
                },
                child: Icon(
                  e.icon,
                  size: 50,
                  color: _currentValue == e.value
                      ? AumColor.accent
                      : AumColor.accent.withOpacity(0.5),
                )))
            .toList()
        : _raitingList
            .map((e) => GestureDetector(
                onTap: () {
                  setState(() {
                    _currentValue = e.value;
                  });
                  widget.onChanged(e.value);
                },
                child: Icon(
                  e.icon,
                  size: 50,
                  color: _currentValue == e.value
                      ? AumColor.accent
                      : AumColor.accent.withOpacity(0.5),
                )))
            .toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _renderedIcons,
    );
  }
}

class _AumRaitingOption {
  String value;
  IconData icon;
  bool byShort;
  _AumRaitingOption(
      {@required this.value, @required this.icon, @required this.byShort});
}
