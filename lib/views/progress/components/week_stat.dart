import 'package:aum_app_build/views/shared/card.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/material.dart';

const double _statisticHeight = 105;

class ProgressWeekStat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AumCard(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: SMALL_OFFSET, horizontal: MIDDLE_OFFSET),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_WeekStatTitle(), _WeekStatistic()],
        ),
      ),
    );
  }
}

class _WeekStatTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(bottom: 16), child: AumText.bold('Week', size: 28));
  }
}

class _WeekStatistic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(padding: EdgeInsets.only(right: 40), child: _WeekStatisticSummaries()),
        Expanded(child: _WeekStatisticBars())
      ],
    );
  }
}

class _WeekStatisticSummaries extends StatelessWidget {
  Widget _renderSummary({String label, String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AumText.regular(label, size: 14, color: AumColor.text),
        AumText.bold(value, size: 24, color: AumColor.accent)
      ],
    );
  }

  String _formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Add progress history
    List sessions = [];
    String caloriesTotal = sessions.length > 0
        ? sessions.map((item) => item["cal"]).reduce((total, value) => total + value).toString()
        : '0';
    int timePerWeek =
        sessions.length > 0 ? sessions.map((item) => item["duration"]).reduce((total, value) => total + value) : 0;
    String totalTime = _formatTime(Duration(seconds: timePerWeek));
    return Container(
        height: _statisticHeight,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _renderSummary(label: 'Calories', value: '$caloriesTotal cal'),
            _renderSummary(label: 'Time', value: '$totalTime'),
          ],
        ));
  }
}

class _WeekStatisticBars extends StatelessWidget {
  dynamic _findWeekDate(String date) {
    DateTime _date = DateTime.parse(date);
    DateTime _weekStart = DateTime.now().subtract(Duration(days: 7));
    int diff = _date.difference(_weekStart).inDays;
    return diff > 0 ? 7 - diff : -1;
  }

  List<Widget> _renderBars(List sessions) {
    List _days = [0, 0, 0, 0, 0, 0, 0];
    List _activeDays =
        sessions.map((session) => {"time": session["duration"], "day": _findWeekDate(session["date"])}).toList();
    _activeDays.forEach((day) {
      double percentage = (day["time"] / 3600) * 100;
      int index = 6 - (day["day"] - 1);
      _days[index] = percentage;
    });
    List<Widget> _bars = _days.map((value) {
      return Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          width: 13,
          height: value > 0 ? value : 5,
          margin: EdgeInsets.only(bottom: 4),
          decoration: BoxDecoration(color: AumColor.accent, borderRadius: BorderRadius.circular(12)),
        ),
        AumText.medium(value.floor().toString(), size: 12, color: AumColor.additional),
      ]);
    }).toList();
    return _bars;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Add progress history
    List sessions = [];
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: _renderBars(sessions),
    );
  }
}
