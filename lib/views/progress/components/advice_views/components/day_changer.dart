import 'package:aum_app_build/views/ui/palette.dart';
import 'package:aum_app_build/views/ui/typo.dart';
import 'package:flutter/material.dart';

class ProgressAdviceDayChanger extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.grey[300]))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DayChangerTitle(),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: _DayChanger())
          ],
        ));
  }
}

class _DayChangerTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AumText.bold(
      'Choose the day',
      size: 30,
    );
  }
}

class _DayChanger extends StatefulWidget {
  @override
  _DayChangerState createState() => _DayChangerState();
}

class _DayChangerState extends State<_DayChanger> {
  final List<String> days = [
    '1',
    '3',
    '4',
    '5',
    '7',
    '8',
    '13',
    '16',
    '17',
    '21',
  ];
  String _currentDay = '7';

  Widget _renderDayCircle(String day) {
    bool _isCurrent = day == _currentDay;
    return GestureDetector(
        onTap: () => setState(() {
              _currentDay = day;
            }),
        child: Container(
          width: 48,
          height: 48,
          margin: EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _isCurrent ? AumColor.accent : Colors.grey[100]),
          child: Center(
              child: AumText.medium(
            day,
            size: 16,
            color: _isCurrent ? Colors.white : AumColor.text,
          )),
        ));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _days = days.map((day) => _renderDayCircle(day)).toList();
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _days,
        ));
  }
}
